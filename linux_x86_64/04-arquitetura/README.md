# Arquitetura e Modelo de Execução

![Architecture](https://img.shields.io/badge/diagramas-inclu%C3%ADdos-blue)

Esta pasta explica como o Linux organiza um processo x86_64, com foco em memória, pilha, syscalls e ELF.

## O que você encontra aqui
- `memoria.md` — layout de memória, segmentos e organização de processos.
- `pilha.md` — frames de pilha, alinhamento e convenções de acesso.
- `convencoes_de_chamada.md` — ABI System V x86_64 e preservação de registradores.
- `sistema_de_chamadas.md` — preparar `syscall`, argumentos e retorno.
- `elf.md` — estrutura ELF, cabeçalhos e carregamento de binários.

## Abordagem
Mostre como estruturar código de baixo nível com base no modelo de execução do Linux. Explique como cada parte do sistema interage com Assembly e quais pontos devem ser observados antes de montar um programa.

## Como usar
1. Leia `memoria.md` para entender os segmentos de processo.
2. Estude `pilha.md` para evitar problemas de alinhamento.
3. Veja `convencoes_de_chamada.md` e `sistema_de_chamadas.md` para chamadas corretas.
4. Consulte `elf.md` para saber como os binários são carregados.
5. Use `../diagrams/architecture-overview.md` e `../images/architecture.svg` para apoio visual.

## Dicas importantes
- Pilha alinhada a 16 bytes evita falhas em chamadas de função.
- Use endereços relativos a `rip` para código position-independent.
- Salve registradores preservados corretamente em funções.
- Separe `.text`, `.data` e `.bss` para clareza e correção.

## Erros comuns
- Não alinhar a pilha antes de `call`.
- Usar `rbp` sem restaurar o valor original.
- Misturar seções `.text` e `.data` incorretamente.
