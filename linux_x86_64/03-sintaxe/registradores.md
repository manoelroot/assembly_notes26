# Registradores x86_64

> Entender os registradores é essencial para escrever Assembly confiável e eficiente. Aqui está tudo o que você precisa saber sobre usos, dicas, armadilhas e dúvidas frequentes.

## Visão geral

| Registrador | Categoria | Uso típico | Preservação ABI |
|---|---|---|---|
| `rax` | Geral | Retorno de função, syscall, acumulação | Volátil |
| `rbx` | Geral | Variáveis de longa duração | Preservado |
| `rcx` | Geral | Contadores de loop, 4º argumento C | Volátil |
| `rdx` | Geral | 3º argumento C, operações de I/O | Volátil |
| `rsi` | Geral | 2º argumento C, fonte de dados | Volátil |
| `rdi` | Geral | 1º argumento C, destino de string | Volátil |
| `rbp` | Base | Frame pointer quando usado | Preservado |
| `rsp` | Pilha | Stack pointer | Preservado (ajustado) |
| `r8`–`r15` | Registros estendidos | 5º-6º argumento C e temporários | `r12`–`r15` preservados |
| `rip` | Instrução | Contém endereço da próxima instrução | N/A |
| `rflags` | Flags | Condições de comparação e controle de fluxo | N/A |

## Uso e casos de uso

### Parâmetros e retorno de função
- `rdi`, `rsi`, `rdx`, `rcx`, `r8`, `r9` são os primeiros seis parâmetros em chamadas System V.
- `rax` retorna valores inteiros e também recebe o número de syscall antes de `syscall`.
- Para funções com mais de seis argumentos, crie um bloco de pilha.

### Exemplo de chamada simples

```asm
movq $1, %rax      # syscall write
movq $1, %rdi      # stdout
leaq msg(%rip), %rsi
movq $len, %rdx
syscall
```

### Rotinas de loop e contagem
- Use `rcx` como contador em loops `loop`, `rep`, `dec`/`jnz`.
- Prefira `rdi`/`rsi` para iteradores de string ou buffers.

## Dicas práticas

- Use `lea` para cálculo de endereços em vez de `mov` + `add`.
- Mantenha valores temporários em registradores em vez de empurrar para a pilha.
- Ao chamar funções, salve registradores callee-saved (`rbx`, `rbp`, `r12`–`r15`) se precisar deles após a chamada.
- Em código de syscall direto, não sobrescreva `rax` antes de executar `syscall`.

## Bugs frequentes

- **Stack alignment quebrado**: não ajustar `rsp` em múltiplos de 16 antes de `call` causa falhas em dependências de ABI.
- **Não preservar `rbx`/`rbp`**: rotinas que alteram registradores preservados sem restaurar podem corromper o código chamador.
- **Uso errado de `rcx` em syscalls**: lembre-se que em chamadas de sistema Linux, o 4º argumento vai para `r10`, não `rcx`.
- **Misturar sintaxe**: em AT&T escreva `%rax`, em Intel use `rax`; confundir este estilo leva a erros de compilação.

## Perguntas frequentes

### Quando usar `rbp`?
Use `rbp` quando precisar de um frame pointer estável para acessar variáveis locais e parâmetros. Em rotinas simples, `rbp` pode ser omitido e você pode usar `rsp` diretamente para otimização.

### Qual a diferença entre `rax` e `eax`?
`rax` é o registrador completo de 64 bits. `eax` refere-se aos 32 bits inferiores de `rax`, `ax` aos 16 bits inferiores e `al`/`ah` aos 8 bits.

### Posso usar `rsp` como registrador temporário?
Não. `rsp` sempre aponta para o topo da pilha. Alterá-lo sem restaurar corretamente causa corrupção de pilha.

### Quando devo usar `r8`–`r15`?
Use-os para valores temporários, 5º/6º argumentos de função e quando precisar de mais registradores além dos oito tradicionais.

## Dicas de depuração

- `info registers` no `gdb` mostra valores atuais.
- `x/10gx $rsp` ajuda a inspecionar frames de pilha.
- Se uma função falhar ao retornar, verifique `rbp` e `rsp` primeiro.

## Referência rápida

- `rax` — retorno/syscall
- `rbx` — preservado, uso longo prazo
- `rcx` — contador, rotinas de string, temporário
- `rdx` — 3º argumento, I/O, multiplicação/divisão
- `rsi`/`rdi` — fontes e destinos de dados
- `rbp` — frame pointer
- `rsp` — stack pointer
- `rip` — instruction pointer
- `rflags` — sinalização de comparação
