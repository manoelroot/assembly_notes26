# Linker

- `ld` para linkar objetos x86_64
- Como gerar executáveis a partir de arquivos `.o`
- Exemplos:
  - `ld programa.o -o programa`
  - `gcc -nostartfiles programa.o -o programa`
- Flags úteis: `-dynamic-linker`, `-lc`, `-e _start`
