# Sintaxe de Assembly x86_64

![Syntax](https://img.shields.io/badge/syntax-AT%26T--Intel-blue)

Esta pasta mostra como escrever código Assembly corretamente, com foco em sintaxe, registradores e diretivas.

## O que você encontra aqui
- `registradores.md` — usos, convenções, bugs frequentes e FAQ.
- `instrucoes.md` — instruções comuns, controle de fluxo e exemplos.
- `diretivas.md` — definição de seções, dados, alinhamento e extern.

## Abordagem
Explique regras de sintaxe e traduza conceitos concretos para exemplos. Esta pasta é o núcleo para escrever código legível e portátil entre `gas` e `nasm`.

## Como usar
1. Leia `registradores.md` para entender onde armazenar valores.
2. Estude `instrucoes.md` para construir lógica e controles de fluxo.
3. Veja `diretivas.md` para estruturar dados e seções corretamente.
4. Abra `../images/syntax.svg` para comparar visualmente AT&T e Intel.

## Dicas importantes
- Mantenha o estilo de sintaxe consistente em cada arquivo.
- Use `lea` para cálculos de endereço e `mov` para mover valores.
- Alinhe dados e pilha para evitar problemas de execução.
- Prefira comentários claros para cada instrução.
