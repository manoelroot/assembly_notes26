# Exemplos de loops

- Loop simples com `jmp` e `cmp`
- Loop controlado por contador com `dec`/`jnz`
- Uso de `rep` para operações em bloco

Exemplo básico:

    movq $10, %rcx
loop_start:
    # corpo do loop
    dec %rcx
    jnz loop_start
