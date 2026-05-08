# Exemplos Otimizados de Assembly x86_64 Linux

## Visão Geral

Esta pasta contém exemplos práticos e otimizados de código Assembly x86_64 para Linux, seguindo as convenções, regras e estruturas documentadas no projeto.

## Arquivos

### 1. `programa_principal.asm`
**Descrição:** Programa principal completo com funções otimizadas

**Características:**
- Implementa função `multiplicar(a, b)` com otimizações
- Implementa função `escrever_numero()` com conversão de inteiros
- Implementa função `calcular_somatorio()` com fórmula otimizada (n*(n+1)/2)
- Demonstra convenção System V x86_64
- Pilha alinhada a 16 bytes
- Registradores preservados corretamente
- Tratamento de retorno de funções

**Otimizações:**
- Uso de `shrq $1` em vez de `divq` para divisão por 2 (mais rápido)
- Fórmula matemática em vez de loop para somatório
- Minimiza acessos a memória
- Uso eficiente de registradores

**Como compilar:**
```bash
as -o programa_principal.o programa_principal.asm
ld -o programa_principal programa_principal.o
./programa_principal
```

---

### 2. `loops_otimizados.asm`
**Descrição:** Padrões de loop otimizados em Assembly

**Padrões incluídos:**
- **FOR Loop:** Contagem regressiva com acumulação
- **WHILE Loop:** Busca em array com condição no início
- **DO-WHILE Loop:** Cálculo de potência com execução garantida
- **NESTED Loops:** Processamento de matriz 2D com loops aninhados

**Características:**
- Usa instruções eficientes (`cmpl`, `jns`, `jge`)
- Minimiza instruções por iteração
- Demonstra diferentes padrões de controle de fluxo
- Exemplos práticos de algoritmos comuns

**Otimizações:**
- Evita multiplicações usando endereçamento indexado
- Usa `jns` (jump if not signed) para loops de contagem decrescente
- Minimiza comparações e desvios

**Como compilar:**
```bash
as -o loops_otimizados.o loops_otimizados.asm
ld -o loops_otimizados loops_otimizados.o
./loops_otimizados
```

---

### 3. `manipulacao_bits_otimizada.asm`
**Descrição:** Operações bitwise otimizadas

**Funções implementadas:**
- `set_bit()` — ativa um bit em uma posição
- `clear_bit()` — desativa um bit
- `toggle_bit()` — inverte um bit (0→1, 1→0)
- `check_bit()` — verifica se um bit está ativo
- `count_bits()` — conta bits ativados (Algoritmo Brian Kernighan)
- `reverse_bits()` — inverte a ordem dos bits
- `rotate_left()` — rotaciona bits para esquerda (instrução `rol`)
- `rotate_right()` — rotaciona bits para direita (instrução `ror`)

**Características:**
- Usa instruções nativas de bit (`rol`, `ror`, `shl`, `shr`)
- Algoritmo eficiente para contagem de bits
- Evita loops desnecessários

**Otimizações:**
- Instruções `rol`/`ror` são mais rápidas que equivalentes com múltiplas operações
- `shift` é mais rápido que `divide`
- Minimiza dependências de dados

**Como compilar:**
```bash
as -o manipulacao_bits_otimizada.o manipulacao_bits_otimizada.asm
ld -o manipulacao_bits_otimizada manipulacao_bits_otimizada.o
./manipulacao_bits_otimizada
```

---

### 4. `syscalls_otimizadas.asm`
**Descrição:** Chamadas de sistema eficientes com tratamento de erros

**Syscalls demonstradas:**
- `write` — saída para stdout
- `read` — leitura de stdin
- `open` — abrir/criar arquivo
- `getpid` — obter ID do processo
- `gettimeofday` — obter horário atual
- `mmap` — alocar memória dinâmica
- `exit` — sair do programa

**Características:**
- Tratamento de erros com macro `tratar_erro`
- Uso correto de registradores conforme ABI x86_64
- Argumentos em posição correta (rdi, rsi, rdx, rcx, r8, r9)
- 4º argumento de syscall em r10 (não rcx)
- Verificação de retorno com sinal negativo

**Otimizações:**
- Macros reduzem duplicação de código
- Tratamento de erros eficiente
- Minimiza operações antes de syscall

**Como compilar:**
```bash
as -o syscalls_otimizadas.o syscalls_otimizadas.asm
ld -o syscalls_otimizadas syscalls_otimizadas.o
./syscalls_otimizadas
```

---

### 5. `estruturas_dados_otimizadas.asm`
**Descrição:** Estruturas de dados em Assembly com organização otimizada

**Estruturas implementadas:**
- **Array:** Vetores de inteiros e bytes com acesso direto
- **String:** Strings terminadas em null (C-style)
- **Struct:** Estruturas alinhadas em memória
- **Linked List:** Lista ligada com nós
- **Stack (Pilha):** Operações push/pop
- **Queue (Fila):** Operações enqueue/dequeue

**Funções:**
- `processar_array()` — itera e soma elementos
- `comprimento_string()` — calcula tamanho da string
- `comparar_strings()` — compara duas strings
- `acessar_struct()` — acessa campos de estrutura
- `percorrer_lista_ligada()` — itera lista e soma valores
- `push_pilha()` / `pop_pilha()` — operações de pilha
- `enqueue_fila()` / `dequeue_fila()` — operações de fila

**Características:**
- Layout de memória bem definido
- Alinhamento apropriado (8 bytes para 64-bit)
- Endereçamento eficiente

**Otimizações:**
- Uso de endereçamento indexado (`array(,%ecx,8)`)
- Evita multiplicações implícitas
- Acesso de campo por offset fixo

**Como compilar:**
```bash
as -o estruturas_dados_otimizadas.o estruturas_dados_otimizadas.asm
ld -o estruturas_dados_otimizadas estruturas_dados_otimizadas.o
./estruturas_dados_otimizadas
```

---

## Otimizações Gerais Aplicadas

### 1. **Escolha de Instruções Eficientes**
- `shl`/`shr` para multiplicação/divisão por potências de 2
- `rol`/`ror` para rotação de bits
- `lea` para cálculos de endereços
- Evita `mul`/`div` quando possível

### 2. **Utilização Eficiente de Registradores**
- Mantém dados em registradores em vez de memória
- Evita spill desnecessário
- Respeita convenção System V

### 3. **Minimização de Acessos a Memória**
- Cache-conscious: acesso sequencial quando possível
- Dados em `.data` alinhados
- Usa registradores para loops

### 4. **Alinhamento de Pilha**
- Pilha alinhada a 16 bytes antes de `call`
- Evita penalties de misalignment
- Segurança para SIMD futura

### 5. **Tratamento de Erros**
- Verificação de retorno de syscalls
- Macros para reduzir duplicação
- Fluxo claro de erro/sucesso

### 6. **Clareza e Manutenibilidade**
- Comentários explicativos
- Nomes de etiquetas descritivos
- Separação clara de seções
- Documentação de funções

---

## Convenções Seguidas

Todos os exemplos seguem as regras documentadas em:
- `docs/regras.md` — regras gerais
- `docs/convencoes.md` — convenções System V
- `docs/tipos.md` — tipos de dados e registradores
- `linux_x86_64/04-arquitetura/` — arquitetura e modelo de execução

---

## Como Testar

1. **Compilar com GAS (GNU as):**
   ```bash
   as -o arquivo.o arquivo.asm
   ld -o arquivo arquivo.o
   ./arquivo
   ```

2. **Compilar com NASM (alternativa):**
   ```bash
   nasm -f elf64 arquivo.asm -o arquivo.o
   ld -o arquivo arquivo.o
   ./arquivo
   ```

3. **Debugar com GDB:**
   ```bash
   as -o arquivo.o arquivo.asm
   ld -o arquivo arquivo.o
   gdb ./arquivo
   (gdb) run
   (gdb) layout asm
   (gdb) ni  # next instruction
   (gdb) info registers
   ```

---

## Lições Importantes

1. **Sempre alinhe a pilha** a 16 bytes antes de chamadas
2. **Salve registradores preservados** em funções
3. **Verifique retorno de syscalls** para erros
4. **Use instruções nativas** para operações especializadas
5. **Minimize acessos a memória** - use registradores
6. **Prefira shift a divide** para potências de 2
7. **Documente seu código** com comentários claros

---

## Próximos Passos

- Implemente variações otimizadas destes exemplos
- Meça performance com `perf`
- Use `objdump` para desassembly e análise
- Experimente com diferentes flags de otimização
- Combine com C para obter máxima performance

---

## Referências

- x86-64 ABI: https://refspecs.linuxfoundation.org/elf/x86_64-abi-0.99.pdf
- Intel Manual: https://www.intel.com/content/www/us/en/develop/articles/intel-sdm.html
- System V AMD64 ABI: Sistema usado em Linux
