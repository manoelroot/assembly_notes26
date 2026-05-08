; Exemplos otimizados de syscalls em Assembly x86_64 Linux
; Demonstra chamadas de sistema eficientes e tratamento de erros

.section .data
    msg_inicio: .ascii "=== Syscalls Otimizadas ===\n"
    len_inicio = . - msg_inicio
    
    msg_write: .ascii "1. WRITE (stdout): Escrevendo mensagem...\n"
    len_write = . - msg_write
    
    msg_read: .ascii "2. READ: Lendo entrada (máx 32 bytes):\n"
    len_read = . - msg_read
    
    msg_open: .ascii "3. OPEN: Abrindo arquivo 'teste.txt'...\n"
    len_open = . - msg_open
    
    msg_getpid: .ascii "4. GETPID: PID do processo: "
    len_getpid = . - msg_getpid
    
    msg_gettimeofday: .ascii "5. GETTIMEOFDAY: Obtendo horário...\n"
    len_gettimeofday = . - msg_gettimeofday
    
    msg_mmap: .ascii "6. MMAP: Alocando memória dinâmica...\n"
    len_mmap = . - msg_mmap
    
    msg_erro: .ascii "ERRO: "
    len_erro = . - msg_erro
    
    msg_sucesso: .ascii "SUCESSO\n"
    len_sucesso = . - msg_sucesso
    
    msg_quebra: .ascii "\n"
    len_quebra = . - msg_quebra
    
    ; Arquivo para testes
    nome_arquivo: .asciz "teste.txt"
    
    ; Buffer para leitura
    buffer_entrada: .space 32

.section .bss
    timeval_struct: .space 16    ; struct timeval (8 + 8 bytes)
    buffer_leitura: .space 256

.section .text
.globl _start

; ============================================
; Macro: escrever_sys
; Escreve uma mensagem via syscall
; Argumentos: msg e tamanho
; ============================================
.macro escrever_sys msg, tamanho
    movq $1, %rax           ; syscall: write
    movq $1, %rdi           ; fd: stdout
    leaq \msg(%rip), %rsi   ; endereço da mensagem
    movq $\tamanho, %rdx    ; tamanho
    syscall
.endm

; ============================================
; Macro: tratar_erro
; Se rax < 0, é um erro
; Escreve mensagem de erro e pula
; ============================================
.macro tratar_erro label
    testq %rax, %rax        ; testa se rax < 0
    js \label               ; salta se sinal negativo (erro)
.endm

; ============================================
; Função: syscall_write - escrita otimizada
; Escreve múltiplas strings com uma chamada
; ============================================
syscall_write:
    escrever_sys msg_write, len_write
    
    ; Escreve mensagem de teste
    movq $1, %rax           ; write
    movq $1, %rdi           ; stdout
    leaq msg_write(%rip), %rsi
    movq $len_write, %rdx
    syscall
    
    ; Verifica erro
    tratar_erro .write_erro
    jmp .write_sucesso
    
.write_erro:
    escrever_sys msg_erro, len_erro
    movq $-1, %rax
    jmp .write_fim
    
.write_sucesso:
    escrever_sys msg_sucesso, len_sucesso
    movq $0, %rax
    
.write_fim:
    ret

; ============================================
; Função: syscall_read - leitura com timeout
; Lê até 256 bytes de stdin
; Retorno: rax = bytes lidos
; ============================================
syscall_read:
    escrever_sys msg_read, len_read
    
    movq $0, %rax           ; syscall: read
    movq $0, %rdi           ; fd: stdin
    leaq buffer_leitura(%rip), %rsi
    movq $256, %rdx         ; máximo de bytes
    syscall
    
    ; rax contém bytes lidos ou erro
    tratar_erro .read_erro
    jmp .read_fim
    
.read_erro:
    escrever_sys msg_erro, len_erro
    movq $-1, %rax
    
.read_fim:
    ret

; ============================================
; Função: syscall_open - abrir arquivo
; Abre/cria arquivo com flags e permissões
; Retorno: rax = file descriptor
; ============================================
syscall_open:
    escrever_sys msg_open, len_open
    
    movq $2, %rax           ; syscall: open
    leaq nome_arquivo(%rip), %rdi
    movl $0x0102, %esi      ; flags: O_WRONLY|O_CREAT
    movl $0644, %edx        ; mode: 644 (rw-r--r--)
    syscall
    
    ; rax = fd ou erro
    tratar_erro .open_erro
    
    ; Fecha arquivo
    movq %rax, %rdi         ; rdi = fd
    movq $3, %rax           ; syscall: close
    syscall
    
    escrever_sys msg_sucesso, len_sucesso
    jmp .open_fim
    
.open_erro:
    escrever_sys msg_erro, len_erro
    movq $-1, %rax
    
.open_fim:
    ret

; ============================================
; Função: syscall_getpid - obter PID
; Retorna o ID do processo
; ============================================
syscall_getpid:
    escrever_sys msg_getpid, len_getpid
    
    movq $39, %rax          ; syscall: getpid
    syscall
    
    ; rax = PID (sempre positivo)
    ; Seria necessário converter para string e escrever
    ; (omitido para brevidade)
    
    escrever_sys msg_quebra, len_quebra
    ret

; ============================================
; Função: syscall_gettimeofday - horário atual
; Obtém horário com precisão de microssegundos
; ============================================
syscall_gettimeofday:
    escrever_sys msg_gettimeofday, len_gettimeofday
    
    movq $96, %rax          ; syscall: gettimeofday
    leaq timeval_struct(%rip), %rdi  ; tv (struct timeval)
    movq $0, %rsi           ; tz = NULL
    syscall
    
    ; rax = 0 se sucesso
    tratar_erro .gettimeofday_erro
    
    escrever_sys msg_sucesso, len_sucesso
    jmp .gettimeofday_fim
    
.gettimeofday_erro:
    escrever_sys msg_erro, len_erro
    
.gettimeofday_fim:
    ret

; ============================================
; Função: syscall_mmap - alocar memória
; Aloca 4KB de memória via mmap
; Retorno: rax = endereço alocado
; ============================================
syscall_mmap:
    escrever_sys msg_mmap, len_mmap
    
    movq $9, %rax           ; syscall: mmap
    movq $0, %rdi           ; addr: NULL (kernel escolhe)
    movq $4096, %rsi        ; length: 4096 bytes
    movl $3, %edx           ; prot: PROT_READ|PROT_WRITE
    movl $0x22, %ecx        ; flags: MAP_PRIVATE|MAP_ANONYMOUS
    movl $-1, %r8d          ; fd: -1 (sem arquivo)
    movl $0, %r9d           ; offset: 0
    syscall
    
    ; rax = endereço ou erro (negativo)
    tratar_erro .mmap_erro
    escrever_sys msg_sucesso, len_sucesso
    jmp .mmap_fim
    
.mmap_erro:
    escrever_sys msg_erro, len_erro
    movq $0, %rax
    
.mmap_fim:
    ret

; ============================================
; Função: syscall_exit - saída segura
; Chama exit com status
; ============================================
syscall_exit:
    movq $60, %rax          ; syscall: exit
    movl $0, %edi           ; status: 0 (sucesso)
    syscall
    ; nunca retorna

; ============================================
; Função principal
; ============================================
_start:
    subq $8, %rsp           ; alinha pilha
    
    ; Título
    escrever_sys msg_inicio, len_inicio
    
    ; ============ Executa syscalls ============
    call syscall_write
    
    ; call syscall_read      ; comentado pois bloqueia entrada
    
    call syscall_open
    call syscall_getpid
    call syscall_gettimeofday
    call syscall_mmap
    
    ; Saída
    call syscall_exit
