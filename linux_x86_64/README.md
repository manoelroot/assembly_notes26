# Notas de Assembly x86_64 Linux

![Linux](https://img.shields.io/badge/OS-Linux-green)
![x86_64](https://img.shields.io/badge/ISA-x86__64-blue)
![Format](https://img.shields.io/badge/format-Markdown-orange)
![Documentation](https://img.shields.io/badge/documentation-complete-yellow)

Este repositório organiza anotações completas para Assembly x86_64 no Linux, com conteúdo teórico, prático, diagramas e imagens explicativas.

## Estrutura do projeto
- `01-introducao/` — visão geral, conceitos e como começar com Assembly.
- `02-ferramentas/` — ferramentas de montagem, linkagem e depuração.
- `03-sintaxe/` — sintaxe Assembly, registradores, diretivas e convenções.
- `04-arquitetura/` — modelo de memória, pilha, chamadas de sistema e ELF.
- `05-exemplos/` — exemplos práticos e padrões comuns.
- `06-avancado/` — otimização, SIMD, multithreading e segurança.
- `07-regras/` — regras, tipos, convenções, observações e explicação de registradores/arquitetura.
- `08-recursos/` — recursos de aprendizado, ferramentas e extensões úteis.
- `diagrams/` — diagramas Mermaid para visualização rápida.
- `images/` — ilustrações SVG explicativas para cada seção.

## Abordagem
Cada seção contém um `README.md` com:
- descrição do objetivo da pasta
- arquivos principais e tópicos abordados
- dicas de uso e casos reais
- links para diagramas e imagens explicativas

## Como começar
1. Leia `01-introducao/README.md` para entender os fundamentos.
2. Estude `03-sintaxe/` para aprender a escrever código.
3. Use `04-arquitetura/` para saber como o Linux executa Assembly.
4. Pratique com `05-exemplos/` e avance para `06-avancado/`.
5. Abra `diagrams/` e `images/` para apoio visual.

## Recomendações rápidas
- Use imagens e diagramas para fixar o fluxo de memória e syscalls.
- Sempre confirme convenções ABI antes de escrever funções.
- Teste pequenos exemplos antes de otimizações avançadas.
- Mantenha cada tópico em uma pasta separada para melhor organização.
