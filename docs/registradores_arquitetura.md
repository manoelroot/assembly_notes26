# Registradores e Arquitetura x86_64

## Registradores gerais x86_64

| Registrador | Uso principal | Observações |
|---|---|---|
| `rax` | Retorno de função, syscalls | Volátil; também usado para multiplicação/divisão. |
| `rbx` | Variáveis de longo prazo | Preservado entre chamadas. |
| `rcx` | Contadores e 4º argumento C | Volátil; usado por `loop` e instruções de string. |
| `rdx` | 3º argumento C, I/O | Volátil; usado em `mul`/`div`. |
| `rsi` | 2º argumento C, fonte de dados | Volátil. |
| `rdi` | 1º argumento C, destino inicial | Volátil. |
| `rbp` | Frame pointer | Preservado; pode ser omitido em código otimizado. |
| `rsp` | Stack pointer | Preservado; deve ser alinhado. |
| `r8`–`r15` | Temporários e argumentos extras | `r12`–`r15` são preservados. |
| `rip` | Instruction pointer | Controle de fluxo; não pode ser escrito diretamente. |
| `rflags` | Flags de condição | Usado por comparações e saltos condicionais. |

## Registradores de segmento
- `cs`, `ds`, `es`, `ss` — presença reduzida em modo 64 bits.
- `fs`, `gs` — usados para acesso a thread-local storage e estruturas do kernel.

## Modelo de memória x86_64
- O processo usa endereçamento virtual de 64 bits.
- Segmentos principais: `.text`, `.data`, `.bss`, heap e stack.
- A pilha cresce para baixo: `rsp` diminui quando dados são empurrados.
- Use `rip`-relative addressing para código position-independent.

## Arquitetura básica e fluxos
- Código em `.text` é executado pelo processador.
- Dados inicializados em `.data`; dados não inicializados em `.bss`.
- Heap é alocado dinamicamente em tempo de execução.
- Stack mantém frames de função, parâmetros e valores de retorno.

## Chamadas de sistema (syscall)
- Número da syscall em `rax`.
- Argumentos em `rdi`, `rsi`, `rdx`, `r10`, `r8`, `r9`.
- Retorno em `rax`.
- Em caso de erro, `rax` recebe valor negativo.

## Observações de arquitetura
- Em x86_64 Linux, `rsp` deve ser mantido alinhado a 16 bytes antes de `call`.
- `rip`-relative addressing facilita código carregável em qualquer lugar.
- Registradores preservados devem ser restaurados para evitar corrupção de estado.
- Use `rbp` se precisar de um frame pointer estável; caso contrário, `rsp` pode ser suficiente.
- Prefira `movq` para mover valores de 64 bits e evite truncamentos indesejados.

## Dicas rápidas
- Separe valores temporários em `r8`–`r15` quando o conjunto de registradores tradicionais estiver ocupado.
- Leve em conta que `rax`, `rcx`, `rdx` são usados internamente por várias instruções.
- Em instruções de string e repetição, `rcx`, `rdi` e `rsi` são frequentemente usados juntos.
- Para interoperabilidade com C, siga a ABI System V estritamente.
