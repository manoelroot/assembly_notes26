# Regras Gerais para Assembly x86_64

- Faça comentários claros para cada bloco de código e cada syscall.
- Use nomes de etiquetas descritivas e consistentes, como `loop_inicio`, `saida_erro`, `fim_programa`.
- Mantenha o código dividido em seções `.text`, `.data` e `.bss`.
- Prefira registrar valores em registradores sempre que possível antes de usar memória.
- Alinhe a pilha a 16 bytes antes de chamadas de função e syscalls.
- Salve e restaure registradores preservados (`rbx`, `rbp`, `r12`–`r15`) em funções.
- Evite instruções que dependam de estados indefinidos, como dividir por zero.
- Verifique sempre o valor de retorno de syscalls e trate erros.
- Use `.intel_syntax noprefix` ou AT&T claramente em cada arquivo, mas não misture os dois dentro do mesmo trecho.
- Teste cada rotina em um ambiente Linux x86_64 para confirmar o comportamento real.
