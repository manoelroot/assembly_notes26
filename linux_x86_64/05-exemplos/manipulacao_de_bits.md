# Manipulação de bits

- Operações bit a bit: `shl`, `shr`, `sal`, `sar`, `rol`, `ror`
- Máscaras e testes com `and`, `or`, `xor`, `test`
- Exemplo: testar um bit específico

    movq $value, %rax
    movq $1, %rcx
    shl %cl, %rax
    test %rax, %rax
