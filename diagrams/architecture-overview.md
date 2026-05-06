# Visão de arquitetura e fluxo de syscall

Este documento usa Mermaid para explicar visualmente o modelo de processo e o fluxo de chamadas de sistema.

## Layout de memória do processo

```mermaid
flowchart TB
    subgraph Processo Linux x86_64
      TXT[.text<br/>código executável]
      DATA[.data<br/>dados inicializados]
      BSS[.bss<br/>dados não inicializados]
      HEAP[Heap<br/>alocação dinâmica]
      STACK[Pilha<br/>frames de função]
    end

    TXT --> DATA
    DATA --> BSS
    BSS --> HEAP
    HEAP --> STACK

    classDef seg fill:#f3f4f6,stroke:#8b5cf6,color:#111827;
    class TXT,DATA,BSS,HEAP,STACK seg;
```

## Fluxo de chamada de sistema

```mermaid
flowchart LR
    A[Assembly do usuário] --> B[Preparar registradores]
    B --> C[syscall]
    C --> D[Núcleo do Linux]
    D --> E[Serviço de kernel]
    E --> F[Retorno ao usuário]

    B ---|rax = número| C
    B ---|rdi, rsi, rdx...| C
    D ---|valores, erros| F
```

## Notas úteis
- A pilha cresce para baixo em x86_64 (`rsp` decrementa).
- `rip` sempre aponta para a próxima instrução.
- Em syscalls Linux, o quarto argumento usa `r10`, o quinto usa `r8` e o sexto usa `r9`.
- Use esses diagramas como referência visual ao estudar `04-arquitetura/`.
