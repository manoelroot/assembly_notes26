# Assembler

- `nasm` e `yasm` para sintaxe Intel
- `gas` (GNU Assembler) para sintaxe AT&T e também Intel com `.intel_syntax`
- Como montar um arquivo `.asm` para `.o`
- Exemplos de comandos:
  - `nasm -f elf64 programa.asm -o programa.o`
  - `as --64 programa.s -o programa.o`
