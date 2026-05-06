; Hello world em Assembly x86_64 Linux (AT&T)
.section .data
msg:
  .ascii "Hello, world!\n"
len = . - msg

.section .text
.globl _start
_start:
  movq $1, %rax        # syscall: write
  movq $1, %rdi        # file descriptor: stdout
  leaq msg(%rip), %rsi # endereço da string
  movq $len, %rdx      # tamanho
  syscall

  movq $60, %rax       # syscall: exit
  xorl %rdi, %rdi      # status 0
  syscall
