# Chamadas de sistema em Assembly

- `syscall` em x86_64
- Argumentos: `rdi`, `rsi`, `rdx`, `r10`, `r8`, `r9`
- Saída de `write`, leitura com `read`, abertura de arquivo com `open`

Exemplo `write`:

    movq $1, %rax
    movq $1, %rdi
    leaq msg(%rip), %rsi
    movq $len, %rdx
    syscall
