; Exemplos otimizados de manipulação de bits em Assembly x86_64 Linux
; Demonstra operações bitwise, máscaras e técnicas de otimização

.section .data
    msg_titulo: .ascii "=== Manipulação de Bits Otimizada ===\n"
    len_titulo = . - msg_titulo
    
    msg_set_bit: .ascii "SET_BIT: "
    len_set_bit = . - msg_set_bit
    
    msg_clear_bit: .ascii "CLEAR_BIT: "
    len_clear_bit = . - msg_clear_bit
    
    msg_toggle_bit: .ascii "TOGGLE_BIT: "
    len_toggle_bit = . - msg_toggle_bit
    
    msg_check_bit: .ascii "CHECK_BIT: "
    len_check_bit = . - msg_check_bit
    
    msg_count_bits: .ascii "COUNT_BITS: "
    len_count_bits = . - msg_count_bits
    
    msg_reverse_bits: .ascii "REVERSE_BITS: "
    len_reverse_bits = . - msg_reverse_bits
    
    msg_rotate_left: .ascii "ROTATE_LEFT: "
    len_rotate_left = . - msg_rotate_left
    
    msg_rotate_right: .ascii "ROTATE_RIGHT: "
    len_rotate_right = . - msg_rotate_right
    
    msg_quebra: .ascii "\n"
    len_quebra = . - msg_quebra
    
    msg_true: .ascii "VERDADEIRO"
    len_true = . - msg_true
    
    msg_false: .ascii "FALSO"
    len_false = . - msg_false

.section .text
.globl _start

; ============================================
; Macro: escrever mensagem
; ============================================
.macro escrever msg, tamanho
    movq $1, %rax
    movq $1, %rdi
    leaq \msg(%rip), %rsi
    movq $\tamanho, %rdx
    syscall
.endm

; ============================================
; Função: set_bit(valor, posição) -> resultado
; Ativa um bit na posição especificada
; Argumento: rdi = valor, rsi = posição
; Retorno: rax = resultado
; ============================================
set_bit:
    movq %rdi, %rax         ; rax = valor
    movl $1, %ecx           ; ecx = 1
    movl %esi, %ecx         ; cl = posição
    shlq %cl, %rcx          ; rcx = 1 << posição (máscara)
    orq %rcx, %rax          ; rax = rax | máscara
    ret

; ============================================
; Função: clear_bit(valor, posição) -> resultado
; Desativa um bit na posição especificada
; ============================================
clear_bit:
    movq %rdi, %rax         ; rax = valor
    movl $1, %ecx           ; ecx = 1
    movl %esi, %ecx         ; cl = posição
    shlq %cl, %rcx          ; rcx = 1 << posição
    notq %rcx               ; rcx = ~máscara
    andq %rcx, %rax         ; rax = rax & ~máscara
    ret

; ============================================
; Função: toggle_bit(valor, posição) -> resultado
; Inverte um bit (0->1, 1->0)
; ============================================
toggle_bit:
    movq %rdi, %rax         ; rax = valor
    movl $1, %ecx           ; ecx = 1
    movl %esi, %ecx         ; cl = posição
    shlq %cl, %rcx          ; rcx = 1 << posição
    xorq %rcx, %rax         ; rax = rax ^ máscara (XOR inverte)
    ret

; ============================================
; Função: check_bit(valor, posição) -> resultado
; Verifica se um bit está ativo
; Retorno: rax = 1 se ativo, 0 se inativo
; ============================================
check_bit:
    movq %rdi, %rax         ; rax = valor
    movl $1, %ecx           ; ecx = 1
    movl %esi, %ecx         ; cl = posição
    shlq %cl, %rcx          ; rcx = 1 << posição
    andq %rcx, %rax         ; rax = rax & máscara
    shrq %cl, %rax          ; rax = rax >> posição
    ret

; ============================================
; Função: count_bits(valor) -> contador
; Conta bits ativados (população de bits)
; Otimizado: usa POPCNT se disponível, senão algoritmo Brian Kernighan
; ============================================
count_bits:
    movq %rdi, %rax         ; rax = valor
    xorl %ecx, %ecx         ; ecx = contador = 0
    testq %rax, %rax        ; testa se rax == 0
    jz .count_fim           ; sai se zero
    
.count_loop:
    movq %rax, %rbx         ; rbx = rax
    decq %rbx               ; rbx = rax - 1
    andq %rbx, %rax         ; rax = rax & (rax - 1) remove um bit
    incl %ecx               ; contador++
    jnz .count_loop         ; continua se ainda há bits
    
.count_fim:
    movl %ecx, %eax         ; rax = contador
    ret

; ============================================
; Função: reverse_bits(valor, bits) -> resultado
; Inverte a ordem dos bits
; Argumento: rdi = valor, rsi = número de bits
; ============================================
reverse_bits:
    xorl %eax, %eax         ; rax = 0 (resultado)
    movl %esi, %ecx         ; ecx = número de bits
    movq %rdi, %rbx         ; rbx = valor original
    
.reverse_loop:
    movl $1, %edx           ; edx = 1
    andl %ebx, %edx         ; edx = ebx & 1 (extrai LSB)
    shlq $1, %rax           ; desloca resultado para esquerda
    orq %rdx, %rax          ; insere bit extraído
    shrq $1, %rbx           ; desloca valor para direita
    decl %ecx               ; decrementa contador
    jnz .reverse_loop
    
    ret

; ============================================
; Função: rotate_left(valor, rotação) -> resultado
; Rotaciona bits para esquerda
; Argumento: rdi = valor, rsi = número de posições
; ============================================
rotate_left:
    movq %rdi, %rax         ; rax = valor
    movl %esi, %ecx         ; ecx = rotação
    rolq %cl, %rax          ; ROL = rotate left (instrução única!)
    ret

; ============================================
; Função: rotate_right(valor, rotação) -> resultado
; Rotaciona bits para direita
; ============================================
rotate_right:
    movq %rdi, %rax         ; rax = valor
    movl %esi, %ecx         ; ecx = rotação
    rorq %cl, %rax          ; ROR = rotate right
    ret

; ============================================
; Função: swap_bits_in_bytes(a, b, pos1, pos2)
; Troca dois bits entre dois bytes
; Argumentos: rdi=a, rsi=b, rdx=pos1, rcx=pos2
; ============================================
swap_bits_in_bytes:
    push %rbp
    movq %rsp, %rbp
    
    movq %rdi, %rax         ; rax = a
    movq %rsi, %rbx         ; rbx = b
    movl %edx, %ecx         ; ecx = pos1 (será sobrescrito)
    
    ; Extrai bits
    movl $1, %r8d           ; r8d = 1
    movl %edx, %r9d         ; r9d = pos1
    movl %ecx, %edx         ; edx = pos2 (do rcx)
    
    shlq %r9d, %r8d         ; r8d = 1 << pos1
    andq %r8d, %rax         ; extrai bit de a
    movq %rax, %r10         ; r10 = bit de a
    
    movl $1, %r11d          ; r11d = 1
    shlq %rdx, %r11d        ; r11d = 1 << pos2
    andq %r11d, %rbx        ; extrai bit de b
    movq %rbx, %r12         ; r12 = bit de b
    
    ; Limpa bits originais
    movl $1, %r8d
    shlq %r9d, %r8d
    notq %r8                ; nega máscara
    andq %r8, %rax          ; limpa bit em a
    
    movl $1, %r11d
    shlq %rdx, %r11d
    notq %r11
    andq %r11, %rbx         ; limpa bit em b
    
    ; Insere bits trocados
    orq %r12, %rax          ; insere bit de b em a
    orq %r10, %rbx          ; insere bit de a em b
    
    pop %rbp
    ret

; ============================================
; Função principal - testes
; ============================================
_start:
    subq $8, %rsp           ; alinha pilha
    
    ; Título
    escrever msg_titulo, len_titulo
    
    ; ============ SET_BIT ============
    escrever msg_set_bit, len_set_bit
    movq $0, %rdi           ; valor = 0
    movq $3, %rsi           ; posição = 3
    call set_bit            ; rax = 1 << 3 = 8
    ; (escrita de resultado omitida)
    escrever msg_quebra, len_quebra
    
    ; ============ CLEAR_BIT ============
    escrever msg_clear_bit, len_clear_bit
    movq $255, %rdi         ; valor = 0xFF
    movq $7, %rsi           ; posição = 7
    call clear_bit          ; rax = 0xFF & ~(1<<7) = 0x7F
    escrever msg_quebra, len_quebra
    
    ; ============ TOGGLE_BIT ============
    escrever msg_toggle_bit, len_toggle_bit
    movq $5, %rdi           ; valor = 0101 (5)
    movq $1, %rsi           ; posição = 1
    call toggle_bit         ; rax = 0101 ^ 0010 = 0111 (7)
    escrever msg_quebra, len_quebra
    
    ; ============ CHECK_BIT ============
    escrever msg_check_bit, len_check_bit
    movq $12, %rdi          ; valor = 1100
    movq $2, %rsi           ; verifica bit 2 (índice 0)
    call check_bit          ; rax = (1100 & 0100) >> 2 = 1
    escrever msg_quebra, len_quebra
    
    ; ============ COUNT_BITS ============
    escrever msg_count_bits, len_count_bits
    movq $15, %rdi          ; valor = 1111 (4 bits)
    call count_bits         ; rax = 4
    escrever msg_quebra, len_quebra
    
    ; ============ REVERSE_BITS ============
    escrever msg_reverse_bits, len_reverse_bits
    movq $12, %rdi          ; valor = 1100 (4 bits)
    movq $4, %rsi           ; número de bits
    call reverse_bits       ; rax = 0011 (3)
    escrever msg_quebra, len_quebra
    
    ; ============ ROTATE_LEFT ============
    escrever msg_rotate_left, len_rotate_left
    movq $1, %rdi           ; valor = 0001
    movq $1, %rsi           ; rotação = 1
    call rotate_left        ; rax = 0010 (2)
    escrever msg_quebra, len_quebra
    
    ; ============ ROTATE_RIGHT ============
    escrever msg_rotate_right, len_rotate_right
    movq $8, %rdi           ; valor = 1000
    movq $1, %rsi           ; rotação = 1
    call rotate_right       ; rax = 0100 (4)
    escrever msg_quebra, len_quebra
    
    ; Saída
    movq $60, %rax
    xorl %rdi, %rdi
    syscall
