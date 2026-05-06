# Sistema de Chamadas do Linux

- Chamadas de sistema via `syscall`
- Registradores usados: `rax` para número da syscall, `rdi`, `rsi`, `rdx`, `r10`, `r8`, `r9` para argumentos
- Retorno: valor em `rax`
- Exemplo: `write`, `exit`, `open`, `read`, `close`
