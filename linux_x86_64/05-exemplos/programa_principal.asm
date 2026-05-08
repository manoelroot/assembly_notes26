; Programa principal otimizado em Assembly x86_64 Linux
; Demonstra uso de funções, pilha alinhada e convenções System V
; Compile: as -o programa_principal.o programa_principal.asm
; Link: ld -o programa_principal programa_principal.o
; Execute: ./programa_principal

.section .data
    msg_inicio: .ascii "=== Programa Principal Otimizado ===\n"
    len_inicio = . - msg_inicio
    
    msg_valor: .ascii "Resultado: "
    len_valor = . - msg_valor
    
    msg_quebra: .ascii "\n"
    len_quebra = . - msg_quebra

.section .bss
    resultado: .space 8

.section .text
.globl _start

; ============================================
; Função: multiplicar(a, b) -> resultado
; Argumentos: rdi=a, rsi=b
; Retorno: rax=resultado
; Registradores preservados: rbx, rbp, r12-r15
; ============================================
multiplicar:
    ; rdi = primeiro número
    ; rsi = segundo número
    ; resultado em rax
    movq $0, %rax           ; inicializa resultado = 0
    testq %rsi, %rsi        ; testa se rsi == 0
    jz .mult_fim            ; se zero, retorna
    
    ; Otimização: usa shift para multiplicação por 2
    movq %rdi, %rax         ; rax = rdi
    cmpq $1, %rsi           ; compara rsi com 1
    je .mult_fim            ; se rsi == 1, retorna rdi em rax
    
    decq %rsi               ; rsi = rsi - 1
.mult_loop:
    addq %rdi, %rax         ; rax = rax + rdi (multiplicação por adição)
    decq %rsi               ; rsi = rsi - 1
    jnz .mult_loop          ; repete se rsi != 0
    
.mult_fim:
    ret

; ============================================
; Função: escrever_numero(número)
; Argumento: rdi = número de 64 bits
; Converte número para string e escreve
; ============================================
escrever_numero:
    push %rbp
    movq %rsp, %rbp
    sub $32, %rsp           ; aloca espaço para buffer local
    
    movq %rdi, %rax         ; move número para rax
    movq %rsp, %rdi         ; rdi aponta para buffer na pilha
    movq $0, %rcx           ; contador de dígitos
    movq $10, %rbx          ; divisor = 10
    
    ; Extrai dígitos (ordem reversa)
.num_loop:
    xorl %edx, %edx         ; edx = 0 (limpa para divisão)
    divq %rbx               ; rax:rdx = rax / rbx (quociente em rax, resto em rdx)
    addq $48, %rdx          ; converte resto para ASCII (0-9 -> '0'-'9')
    movb %dl, (%rdi, %rcx)  ; armazena dígito no buffer
    incq %rcx               ; próxima posição no buffer
    
    testq %rax, %rax        ; testa se quociente == 0
    jnz .num_loop           ; continua se não
    
    ; Escreve "Resultado: "
    movq $1, %rax           ; syscall: write
    movq $1, %rdi           ; stdout
    leaq msg_valor(%rip), %rsi
    movq $len_valor, %rdx
    syscall
    
    ; Escreve dígitos em ordem reversa
    movq %rbp, %rsi         ; rsi aponta para pilha
    subq $32, %rsi          ; ajusta para o buffer
    movq %rcx, %rdx         ; rdx = número de dígitos
    
.num_reverse:
    decq %rcx
    jl .num_write_done
    movzbl (%rsi, %rcx), %eax
    movb %al, (%rdi)        ; reconstrói buffer em ordem
    incq %rdi
    jmp .num_reverse
    
.num_write_done:
    movq $1, %rax           ; write
    movq $1, %rdi           ; stdout
    leaq msg_quebra(%rip), %rsi
    movq $len_quebra, %rdx
    syscall
    
    add $32, %rsp
    pop %rbp
    ret

; ============================================
; Função: calcular_somatorio(n) -> resultado
; Calcula 1 + 2 + 3 + ... + n
; Argumento: rdi = n
; Retorno: rax = soma
; Otimizado: usa fórmula n*(n+1)/2
; ============================================
calcular_somatorio:
    movq %rdi, %rax         ; rax = n
    movq %rdi, %rbx         ; rbx = n
    incq %rbx               ; rbx = n + 1
    imulq %rbx, %rax        ; rax = n * (n + 1)
    shrq $1, %rax           ; rax = rax / 2 (shift é mais rápido que div)
    ret

; ============================================
; Função principal
; ============================================
_start:
    ; Alinha pilha a 16 bytes (0 para passar em call)
    subq $8, %rsp
    
    ; Escreve mensagem inicial
    movq $1, %rax           ; syscall: write
    movq $1, %rdi           ; file descriptor: stdout
    leaq msg_inicio(%rip), %rsi
    movq $len_inicio, %rdx
    syscall
    
    ; ============ Teste 1: Multiplicação ============
    movq $7, %rdi           ; primeiro argumento = 7
    movq $8, %rsi           ; segundo argumento = 8
    call multiplicar        ; chama multiplicar(7, 8)
    
    ; rax contém resultado (56)
    movq %rax, %rdi         ; passa resultado para escrever
    call escrever_numero    ; escreve o resultado
    
    ; ============ Teste 2: Somatório ============
    movq $100, %rdi         ; calcula 1+2+...+100
    call calcular_somatorio ; chama calcular_somatorio(100)
    
    ; rax contém resultado (5050)
    movq %rax, %rdi
    call escrever_numero    ; escreve o resultado
    
    ; ============ Saída ============
    movq $60, %rax          ; syscall: exit
    xorl %rdi, %rdi         ; status 0 (sucesso)
    syscall
