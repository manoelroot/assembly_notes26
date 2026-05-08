# Exemplos de Assembly

Esta pasta agrega exemplos práticos de Assembly x86_64 e casos de uso comuns.

## O que você encontra aqui

### Exemplos Fundamentais
- `hello_world.asm` — exemplo completo de programa com syscall `write` e `exit`.
- `loops.md` — padrões de loop e controle de fluxo.
- `chamadas_sistema.md` — exemplos de chamadas de sistema Linux.
- `manipulacao_de_bits.md` — operações bitwise e máscaras.

### Exemplos Otimizados (Código Completo)
- `programa_principal.asm` — programa principal com funções otimizadas (multiplicação, somatório, escrita de números).
- `loops_otimizados.asm` — padrões de loop FOR, WHILE, DO-WHILE e NESTED otimizados com exemplos práticos.
- `manipulacao_bits_otimizada.asm` — operações bitwise otimizadas (set, clear, toggle, check, count, reverse, rotate).
- `syscalls_otimizadas.asm` — chamadas de sistema com tratamento de erros (write, read, open, getpid, gettimeofday, mmap, exit).
- `estruturas_dados_otimizadas.asm` — estruturas de dados (arrays, strings, structs, linked lists, pilha, fila) com operações eficientes.
- `README_OTIMIZADOS.md` — documentação detalhada de todas as otimizações e como compilar/executar.

## Abordagem
Demonstre padrões úteis com código real e explique quando usá-los. Esta pasta é ideal para traduzir teoria em prática com exemplos claros.

## Como usar

### Fundamentos
1. Abra `hello_world.asm` para ver um programa completo.
2. Use `loops.md` para aprender iteração em Assembly.
3. Consulte `chamadas_sistema.md` para interação com o kernel.
4. Estude `manipulacao_de_bits.md` para operações em nível de bit.
5. Veja `../images/examples.svg` para um resumo visual das categorias de exemplo.

### Exemplos Otimizados
1. Comece com `programa_principal.asm` — exemplo completo com funções.
2. Estude `loops_otimizados.asm` — aprenda padrões eficientes de loop.
3. Veja `manipulacao_bits_otimizada.asm` — operações bitwise avançadas.
4. Explore `syscalls_otimizadas.asm` — chamadas de sistema robustas.
5. Use `estruturas_dados_otimizadas.asm` — estruturas bem organizadas.
6. Leia `README_OTIMIZADOS.md` para documentação detalhada, técnicas e como compilar.

## Dicas importantes
- Comece com exemplos pequenos e expanda gradualmente.
- Teste cada exemplo em um ambiente Linux x86_64.
- Use comentários para documentar cada operação e facilitar revisão.

## Dicas de Otimização
- **Escolha instruções eficientes:** use `shl`/`shr` em vez de `mul`/`div` para potências de 2.
- **Minimize acessos a memória:** mantenha dados em registradores quando possível.
- **Alinhe a pilha:** sempre a 16 bytes antes de `call`.
- **Use instruções nativas:** `rol`, `ror`, `lea` para operações especializadas.
- **Trate erros:** verifique sempre o retorno de syscalls.
- **Analise com ferramentas:** use `perf`, `objdump` e `gdb` para validar otimizações.
