# Convenções de Assembly x86_64

## Convenções de chamada (System V)
- Argumentos: `rdi`, `rsi`, `rdx`, `rcx`, `r8`, `r9`
- Valor de retorno: `rax`
- Registradores preservados: `rbx`, `rbp`, `r12`, `r13`, `r14`, `r15`
- Registradores voláteis: `rax`, `rcx`, `rdx`, `rsi`, `rdi`, `r8`, `r9`, `r10`, `r11`
- `rsp` deve estar alinhado a 16 bytes antes de `call`

## Convenções de seções
- Código: `.text`
- Dados inicializados: `.data`
- Dados não inicializados: `.bss`
- Símbolos globais: `global _start` / `global main`
- Entradas externas: `extern printf` / `extern write`

## Convenções de estilo
- Use comentários `;` ou `#` conforme o assembler.
- Separe blocos de código com linhas vazias para legibilidade.
- Use labels finais com `ret` ou `syscall` bem definidos.
- Prefira `movq` para operações de 64 bits em x86_64.
- Evite usar `rax` para dados de longo prazo se outro registrador está disponível.

## Observações especiais
- Em Linux x86_64, o 4º argumento de syscall vai em `r10`, não em `rcx`.
- O 5º argumento vai em `r8`, o 6º em `r9`.
- Chamadas a funções C devem preservar a pilha e os registradores conforme a ABI.
- Use `leaq` para calcular endereços relativos a `rip` sempre que possível.
