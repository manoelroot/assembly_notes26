# Tipos em Assembly x86_64

## Tamanhos de dados
- `byte` — 8 bits
- `word` — 16 bits
- `dword` — 32 bits
- `qword` — 64 bits

## Registradores e aliases
- `rax`, `rbx`, `rcx`, `rdx` — 64 bits completos
- Partes inferiores: `eax`, `ax`, `al`, `ah`
- `rsi`, `rdi`, `rbp`, `rsp` — 64 bits de uso comum
- `r8`–`r15` — registradores estendidos de 64 bits

## Tipos de operandos
- Imediato: `$0x10`, `10`
- Registrador: `%rax`, `rax`
- Memória: `(%rax)`, `-16(%rbp)`, `msg(%rip)`
- Endereço: `leaq` calcula endereço sem carregar valor

## Diretivas de dados
- `db` — define byte(s)
- `dw` — define word(s)
- `dd` — define dword(s)
- `dq` — define qword(s)
- `resb` — reserva bytes
- `resq` — reserva qwords

## Observações sobre tipos
- Use `dq` para ponteiros e valores de 64 bits.
- Também é comum usar `dd` para inteiros de 32 bits em código misto com C.
- Em x86_64, ponteiros e endereços usam 64 bits.
- A instrução `mov` escolhe o tamanho pelo operando: `movb`, `movw`, `movl`, `movq`.
- Evite conversões implícitas que corrompam dados de 64 bits.
