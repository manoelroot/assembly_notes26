# Observações e Armadilhas em Assembly x86_64

## Armadilhas comuns
- Não ajustar a pilha para 16 bytes antes de `call`.
- Usar `rsp` como registrador temporário e esquecer de restaurá-lo.
- Perder de vista quais registradores são preservados pela ABI.
- Misturar sintaxe AT&T e Intel no mesmo arquivo.
- Esquecer o `syscall` após preparar `rax` e os argumentos.

## Observações de depuração
- `gdb` pode mostrar valores de registradores com `info registers`.
- Use `x/s`, `x/xb` e `x/gx` para inspecionar memória e strings.
- Se o programa travar, verifique primeiro `rsp`, `rbp` e `rip`.
- Debugue por etapas: primeiro verifique a pilha, depois os argumentos e finalmente a syscall.

## Observações de performance
- Prefira registradores e evite acessos desnecessários à memória.
- Use `lea` em vez de `mov` + `add` para cálculos de endereço.
- Evite dependências de dados que causem stalls no pipeline.

## Observações de compatibilidade
- O código deve ser testado em Linux x86_64, pois o Windows usa outra ABI e syscalls diferentes.
- Use `readelf` e `objdump` para verificar o binário e as seções.
- Para interoperar com C, siga as convenções System V estritamente.
