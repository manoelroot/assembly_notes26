; Estruturas de dados otimizadas em Assembly x86_64 Linux
; Demonstra arrays, strings, estruturas e organização de memória eficiente

.section .data
    msg_titulo: .ascii "=== Estruturas de Dados Otimizadas ===\n"
    len_titulo = . - msg_titulo
    
    msg_array: .ascii "1. ARRAY: "
    len_array = . - msg_array
    
    msg_string: .ascii "2. STRING: "
    len_string = . - msg_string
    
    msg_struct: .ascii "3. STRUCT: "
    len_struct = . - msg_struct
    
    msg_lista: .ascii "4. LINKED LIST: "
    len_lista = . - msg_lista
    
    msg_pilha: .ascii "5. PILHA (STACK): "
    len_pilha = . - msg_pilha
    
    msg_fila: .ascii "6. FILA (QUEUE): "
    len_fila = . - msg_fila
    
    msg_quebra: .ascii "\n"
    len_quebra = . - msg_quebra
    
    ; ========== Array de inteiros de 64 bits ==========
    array_int64:
        .quad 10, 20, 30, 40, 50, 60, 70, 80, 90, 100
    len_array_int64 = (. - array_int64) / 8
    
    ; ========== Array de bytes (vetor de caracteres) ==========
    array_byte:
        .byte 65, 66, 67, 68, 69  ; ABCDE
        .byte 70, 71, 72, 73, 74  ; FGHIJ
    len_array_byte = . - array_byte
    
    ; ========== String terminada em null (C-style) ==========
    string1: .asciz "Hello, Assembly!"
    string2: .asciz "Otimização de Dados"
    string_vazia: .asciz ""
    
    ; ========== Struct: Pessoa ==========
    ; Layout em memória (alinhado a 8 bytes para 64-bit):
    ; +0:  nome (8 bytes - ponteiro)
    ; +8:  idade (4 bytes - int32)
    ; +12: altura (4 bytes - float32, ou int para simplificar)
    ; +16: salario (8 bytes - float64, ou int para simplificar)
    struct_pessoa1:
        .quad nome_pessoa1      ; nome (ponteiro)
        .long 30                ; idade
        .long 180               ; altura em cm
        .quad 5000              ; salário em centavos
    
    struct_pessoa2:
        .quad nome_pessoa2
        .long 25
        .long 170
        .quad 4500
    
    nome_pessoa1: .asciz "Alice"
    nome_pessoa2: .asciz "Bob"
    
    ; ========== Nó de lista ligada ==========
    ; Struct Node:
    ; +0: valor (8 bytes - int64)
    ; +8: próximo (8 bytes - ponteiro para próximo nó)
    node1:
        .quad 100               ; valor
        .quad node2             ; próximo
    
    node2:
        .quad 200
        .quad node3
    
    node3:
        .quad 300
        .quad 0                 ; NULL - fim da lista
    
    ; ========== Vetor de estruturas ==========
    ; Array de 5 nós
    array_nodes:
        .quad 1000, 0           ; node[0]: valor=1000, próx=NULL (será preenchido)
        .quad 2000, 0
        .quad 3000, 0
        .quad 4000, 0
        .quad 5000, 0           ; node[4]: último nó
    
    len_array_nodes = 5

.section .bss
    ; Buffer para operações com strings
    buffer_string: .space 256
    
    ; Pilha simples (stack)
    ; Apontadores: sp_top (top), sp_base (base)
    pilha_buffer: .space 256   ; espaço para até 32 qwords
    
    ; Fila simples (queue)
    ; Apontadores: q_head (início), q_tail (fim)
    fila_buffer: .space 256

.section .text
.globl _start

; ============================================
; Macro: escrever_sys
; ============================================
.macro escrever_sys msg, tamanho
    movq $1, %rax
    movq $1, %rdi
    leaq \msg(%rip), %rsi
    movq $\tamanho, %rdx
    syscall
.endm

; ============================================
; Função: processar_array - soma elementos
; Retorna: rax = soma de todos os elementos
; ============================================
processar_array:
    xorl %eax, %eax         ; eax = 0 (soma)
    xorl %ecx, %ecx         ; ecx = 0 (índice)
    
.array_loop:
    cmpl $len_array_int64, %ecx
    jge .array_fim
    
    movq array_int64(,%rcx,8), %rbx  ; rbx = array[índice]
    addq %rbx, %rax         ; soma += rbx
    incl %ecx               ; índice++
    jmp .array_loop
    
.array_fim:
    ret

; ============================================
; Função: comprimento_string - calcula tamanho
; Argumento: rdi = endereço da string
; Retorno: rax = comprimento (sem null terminator)
; ============================================
comprimento_string:
    xorl %eax, %eax         ; eax = 0 (contador)
    
.str_loop:
    movb (%rdi, %rax), %cl  ; cl = caractere atual
    testb %cl, %cl          ; testa se null
    jz .str_fim             ; sai se null
    incl %eax               ; contador++
    jmp .str_loop
    
.str_fim:
    ret

; ============================================
; Função: comparar_strings - compara duas strings
; Argumentos: rdi = str1, rsi = str2
; Retorno: rax = 0 se iguais, 1 se diferentes
; ============================================
comparar_strings:
    xorl %eax, %eax         ; rax = 0
    
.cmp_loop:
    movb (%rdi), %cl        ; cl = *str1
    movb (%rsi), %dl        ; dl = *str2
    cmpb %dl, %cl           ; compara
    jne .cmp_diferente      ; salta se diferente
    
    testb %cl, %cl          ; testa se fim de string
    jz .cmp_igual           ; salta se fim
    
    incq %rdi               ; str1++
    incq %rsi               ; str2++
    jmp .cmp_loop
    
.cmp_igual:
    xorl %eax, %eax         ; rax = 0 (iguais)
    ret
    
.cmp_diferente:
    movl $1, %eax           ; rax = 1 (diferentes)
    ret

; ============================================
; Função: acessar_struct - acessa campo de struct
; Retorna um campo da estrutura
; ============================================
acessar_struct:
    ; rdi = endereço da struct pessoa
    ; retorna: rax = idade
    movl 8(%rdi), %eax      ; eax = idade (offset +8, 4 bytes)
    ret

; ============================================
; Função: percorrer_lista_ligada - soma valores
; Retorna: rax = soma de todos os nós
; ============================================
percorrer_lista_ligada:
    xorl %eax, %eax         ; eax = 0 (soma)
    leaq node1(%rip), %rdi  ; rdi = primeiro nó
    
.lista_loop:
    testq %rdi, %rdi        ; testa se nó é NULL
    jz .lista_fim           ; sai se NULL
    
    movq (%rdi), %rbx       ; rbx = valor do nó
    addq %rbx, %rax         ; soma += valor
    movq 8(%rdi), %rdi      ; rdi = próximo nó
    jmp .lista_loop
    
.lista_fim:
    ret

; ============================================
; Função: push_pilha - empilha um valor
; Argumentos: rdi = endereço da pilha, rsi = valor
; Retorno: rax = new top pointer
; ============================================
push_pilha:
    movq %rsi, (%rdi)       ; *pilha = valor
    addq $8, %rdi           ; incrementa ponteiro
    movq %rdi, %rax         ; retorna novo top
    ret

; ============================================
; Função: pop_pilha - desempilha um valor
; Argumentos: rdi = endereço da pilha
; Retorno: rax = valor desempilhado
; ============================================
pop_pilha:
    subq $8, %rdi           ; decrementa ponteiro
    movq (%rdi), %rax       ; rax = *pilha
    ret

; ============================================
; Função: enqueue_fila - insere na fila
; Argumentos: rdi = endereço da fila, rsi = valor
; ============================================
enqueue_fila:
    movq %rsi, (%rdi)       ; *fila = valor
    addq $8, %rdi           ; incrementa tail
    movq %rdi, %rax
    ret

; ============================================
; Função: dequeue_fila - remove da fila
; Argumentos: rdi = endereço da fila
; Retorno: rax = primeiro valor
; ============================================
dequeue_fila:
    movq (%rdi), %rax       ; rax = *fila
    addq $8, %rdi           ; incrementa head
    ret

; ============================================
; Função principal - demonstrações
; ============================================
_start:
    subq $8, %rsp
    
    ; Título
    escrever_sys msg_titulo, len_titulo
    
    ; ============ ARRAY ============
    escrever_sys msg_array, len_array
    call processar_array
    ; (escrita de resultado omitida)
    escrever_sys msg_quebra, len_quebra
    
    ; ============ STRING ============
    escrever_sys msg_string, len_string
    leaq string1(%rip), %rdi
    call comprimento_string
    ; (escrita de resultado omitida)
    escrever_sys msg_quebra, len_quebra
    
    ; ============ STRUCT ============
    escrever_sys msg_struct, len_struct
    leaq struct_pessoa1(%rip), %rdi
    call acessar_struct
    ; (escrita de resultado omitida)
    escrever_sys msg_quebra, len_quebra
    
    ; ============ LISTA LIGADA ============
    escrever_sys msg_lista, len_lista
    call percorrer_lista_ligada
    ; (escrita de resultado omitida)
    escrever_sys msg_quebra, len_quebra
    
    ; ============ PILHA ============
    escrever_sys msg_pilha, len_pilha
    leaq pilha_buffer(%rip), %rdi
    movq $100, %rsi
    call push_pilha
    movq $200, %rsi
    call push_pilha
    escrever_sys msg_quebra, len_quebra
    
    ; ============ FILA ============
    escrever_sys msg_fila, len_fila
    leaq fila_buffer(%rip), %rdi
    movq $1000, %rsi
    call enqueue_fila
    movq $2000, %rsi
    call enqueue_fila
    escrever_sys msg_quebra, len_quebra
    
    ; Saída
    movq $60, %rax
    xorl %rdi, %rdi
    syscall
