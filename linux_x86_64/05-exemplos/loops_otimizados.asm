; Exemplos otimizados de loops em Assembly x86_64 Linux
; Demonstra diferentes padrões de loop com otimizações

.section .data
    msg_inicio: .ascii "=== Exemplos de Loops Otimizados ===\n"
    len_inicio = . - msg_inicio
    
    msg_for: .ascii "FOR (contagem regressiva): "
    len_for = . - msg_for
    
    msg_while: .ascii "WHILE (busca em array): "
    len_while = . - msg_while
    
    msg_do_while: .ascii "DO-WHILE (cálculo de potência): "
    len_do_while = . - msg_do_while
    
    msg_nested: .ascii "NESTED (matriz): "
    len_nested = . - msg_nested
    
    msg_espaco: .ascii " "
    len_espaco = . - msg_espaco
    
    msg_quebra: .ascii "\n"
    len_quebra = . - msg_quebra
    
    ; Array para busca
    array: .long 10, 25, 30, 15, 40, 20, 35
    len_array = (. - array) / 4  ; número de elementos
    alvo: .long 35               ; valor a buscar

.section .text
.globl _start

; ============================================
; Macro para escrever número de 32 bits
; Argumento em rax
; ============================================
.macro escrever_num32
    push %rbp
    movq %rsp, %rbp
    sub $24, %rsp
    
    movl %eax, %edx         ; edx = número
    movq %rsp, %rdi         ; rdi = buffer na pilha
    xorl %ecx, %ecx         ; ecx = contador
    movl $10, %ebx          ; ebx = divisor
    
.loop_conv:
    xorl %edx, %edx         ; edx = 0
    movl $0, %eax           ; eax = 0
    movl %edx, %eax         ; move número para eax (já está)
    ; ... resto da conversão omitido para brevidade
    
    add $24, %rsp
    pop %rbp
.endm

; ============================================
; Loop tipo FOR: contagem regressiva
; Decrementa de 10 até 0, suma os valores
; ============================================
loop_for:
    push %rbp
    movq %rsp, %rbp
    
    movq $1, %rax           ; escreve "FOR: "
    movq $1, %rdi
    leaq msg_for(%rip), %rsi
    movq $len_for, %rdx
    syscall
    
    movl $10, %ecx          ; contador = 10
    xorl %eax, %eax         ; soma = 0
    
.for_init:
    addl %ecx, %eax         ; soma += contador
    decl %ecx               ; contador--
    jns .for_init           ; repete se contador >= 0 (sinal não-negativo)
    
    ; rax contém a soma (10+9+8+7+6+5+4+3+2+1+0 = 55)
    ; (aqui seria feita conversão para string e escrita)
    
    pop %rbp
    ret

; ============================================
; Loop tipo WHILE: busca em array
; Procura um valor no array
; Retorna: rax = índice (-1 se não encontrado)
; ============================================
loop_while:
    push %rbp
    movq %rsp, %rbp
    
    movq $1, %rax           ; escreve "WHILE: "
    movq $1, %rdi
    leaq msg_while(%rip), %rsi
    movq $len_while, %rdx
    syscall
    
    xorl %ecx, %ecx         ; ecx = índice = 0
    movl alvo(%rip), %edx   ; edx = valor alvo
    movl $len_array, %r8d   ; r8d = tamanho do array
    movl $-1, %eax          ; eax = -1 (não encontrado)
    
.while_cond:
    cmpl %r8d, %ecx         ; compara índice com tamanho
    jge .while_fim          ; sai se índice >= tamanho
    
    movl array(,%ecx,4), %esi  ; esi = array[índice]
    cmpl %edx, %esi         ; compara com alvo
    je .while_found         ; se igual, pula para found
    
    incl %ecx               ; índice++
    jmp .while_cond         ; volta para condição
    
.while_found:
    movl %ecx, %eax         ; eax = índice encontrado
    
.while_fim:
    pop %rbp
    ret

; ============================================
; Loop tipo DO-WHILE: cálculo de potência (base^exp)
; Calcula 2^5 usando multiplicação
; Retorna: rax = resultado
; ============================================
loop_do_while:
    push %rbp
    movq %rsp, %rbp
    
    movq $1, %rax           ; escreve "DO-WHILE: "
    movq $1, %rdi
    leaq msg_do_while(%rip), %rsi
    movq $len_do_while, %rdx
    syscall
    
    movl $2, %eax           ; base = 2
    movl $5, %ecx           ; expoente = 5
    movl $1, %ebx           ; resultado = 1
    
    ; Garante pelo menos uma execução (do-while)
.do_while_exec:
    imull %eax, %ebx        ; resultado *= base
    decl %ecx               ; expoente--
    jnz .do_while_exec      ; repete se expoente != 0
    
    movl %ebx, %eax         ; rax = resultado (2^5 = 32)
    
    pop %rbp
    ret

; ============================================
; Loop aninhado: processar matriz 3x3
; Soma todos os elementos
; ============================================
loop_nested:
    push %rbp
    movq %rsp, %rbp
    
    movq $1, %rax           ; escreve "NESTED: "
    movq $1, %rdi
    leaq msg_nested(%rip), %rsi
    movq $len_nested, %rdx
    syscall
    
    xorl %eax, %eax         ; eax = soma total = 0
    xorl %ecx, %ecx         ; ecx = linha = 0
    movl $3, %r8d           ; r8d = dimensão = 3
    
.nested_linha:
    cmpl %r8d, %ecx         ; compara linha com 3
    jge .nested_fim         ; sai se linha >= 3
    
    xorl %edx, %edx         ; edx = coluna = 0
    
.nested_col:
    cmpl %r8d, %edx         ; compara coluna com 3
    jge .nested_prox_linha  ; próxima linha se coluna >= 3
    
    ; Calcula índice na matriz (linear): linha * 3 + coluna
    movl %ecx, %r9d         ; r9d = linha
    imull $3, %r9d          ; r9d = linha * 3
    addl %edx, %r9d         ; r9d = linha * 3 + coluna
    
    ; Aqui entraria o acesso à matriz (omitido para brevidade)
    addl $1, %eax           ; simula soma += 1
    
    incl %edx               ; coluna++
    jmp .nested_col
    
.nested_prox_linha:
    incl %ecx               ; linha++
    jmp .nested_linha
    
.nested_fim:
    pop %rbp
    ret

; ============================================
; Função principal
; ============================================
_start:
    subq $8, %rsp           ; alinha pilha a 16 bytes
    
    ; Escreve título
    movq $1, %rax
    movq $1, %rdi
    leaq msg_inicio(%rip), %rsi
    movq $len_inicio, %rdx
    syscall
    
    ; Executa cada tipo de loop
    call loop_for
    call loop_while
    call loop_do_while
    call loop_nested
    
    ; Saída
    movq $60, %rax
    xorl %rdi, %rdi         ; status 0
    syscall
