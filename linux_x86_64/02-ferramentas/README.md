# Ferramentas para Assembly x86_64

Esta pasta descreve as ferramentas essenciais para montar, linkar e depurar Assembly no Linux.

## O que esta pasta cobre
- `assembler.md` — assembler e sintaxes suportadas
- `linker.md` — linkagem de objetos e criação de executáveis
- `debugger.md` — uso de `gdb` para inspeção e análise

## Abordagem
Mostre um fluxo claro de desenvolvimento: escrever Assembly, gerar `.o`, linkar e depurar. Cada arquivo foca em comandos, opções úteis e casos de uso práticos.

## Como usar
1. Leia `assembler.md` para escolher o assembler certo.
2. Consulte `linker.md` para construir executáveis corretamente.
3. Use `debugger.md` para aprender a depuração com `gdb`.
4. Veja `../images/tools.svg` para entender visualmente o fluxo de ferramentas.

## Dicas importantes
- Use `nasm` ou `gas` conforme a sintaxe escolhida.
- Linke sempre com a arquitetura x86_64 e verifique símbolos globais.
- Depure com atenção aos valores de registradores e ao layout da pilha.
