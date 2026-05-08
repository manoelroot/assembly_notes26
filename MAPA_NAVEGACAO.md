# 🗺️ Mapa de Navegação - Exemplos Otimizados

---

## 🎯 Por Onde Começar?

### ⏱️ Tenho 5 minutos
👉 Leia: [RESUMO_EXECUTIVO.md](RESUMO_EXECUTIVO.md)

### ⏱️ Tenho 15 minutos
👉 Leia: [GUIA_RAPIDO_EXEMPLOS_OTIMIZADOS.md](GUIA_RAPIDO_EXEMPLOS_OTIMIZADOS.md)
👉 Compile: `cd linux_x86_64/05-exemplos/ && as -o programa_principal.o programa_principal.asm && ld -o programa_principal programa_principal.o && ./programa_principal`

### ⏱️ Tenho 1 hora
👉 Leia: [INDICE_EXEMPLOS_OTIMIZADOS.md](INDICE_EXEMPLOS_OTIMIZADOS.md)
👉 Estude: `linux_x86_64/05-exemplos/README_OTIMIZADOS.md`

### ⏱️ Tenho tempo (aprendizado completo)
👉 Siga: Roteiro Completo (veja abaixo)

---

## 📁 Estrutura do Projeto

```
📦 assembly_notes26/
├── 📄 RESUMO_EXECUTIVO.md                 ← Comece aqui (5 min)
├── 📄 GUIA_RAPIDO_EXEMPLOS_OTIMIZADOS.md  ← Guia prático (15 min)
├── 📄 INDICE_EXEMPLOS_OTIMIZADOS.md       ← Índice completo (referência)
│
├── 📁 linux_x86_64/
│   ├── 📁 05-exemplos/  ← **EXEMPLOS OTIMIZADOS AQUI**
│   │   ├── ✨ programa_principal.asm
│   │   ├── ✨ loops_otimizados.asm
│   │   ├── ✨ manipulacao_bits_otimizada.asm
│   │   ├── ✨ syscalls_otimizadas.asm
│   │   ├── ✨ estruturas_dados_otimizadas.asm
│   │   ├── 📄 README_OTIMIZADOS.md
│   │   └── 📄 hello_world.asm (original)
│   │
│   └── 📁 06-avancado/
│       ├── 📄 otimizacao_tecnicas_aplicadas.md ← Análise profunda
│       └── 📄 README.md (atualizado)
│
└── 📁 docs/
    ├── 📄 regras.md
    ├── 📄 convencoes.md
    ├── 📄 tipos.md
    └── ...
```

---

## 🚀 Roteiros de Aprendizado

### 🟢 Iniciante (2-3 horas)

```
1. Leia RESUMO_EXECUTIVO.md
2. Leia GUIA_RAPIDO_EXEMPLOS_OTIMIZADOS.md
3. Estude programa_principal.asm
   └─ Entenda multiplicação otimizada
   └─ Veja fórmula de somatório
4. Execute loops_otimizados.asm
   └─ Compreenda FOR/WHILE/DO-WHILE
5. Leia README_OTIMIZADOS.md
```

### 🟡 Intermediário (5-6 horas)

```
1. Comece Iniciante ↑
2. Estude manipulacao_bits_otimizada.asm
   └─ Entenda operações bitwise
   └─ Veja ROL/ROR vs manual
3. Estude syscalls_otimizadas.asm
   └─ Aprenda syscall setup
   └─ Veja tratamento de erros
4. Estude estruturas_dados_otimizadas.asm
   └─ Trabalhe com arrays
   └─ Implemente estruturas
5. Leia otimizacao_tecnicas_aplicadas.md
```

### 🔴 Avançado (1+ dia)

```
1. Comece Intermediário ↑
2. Debug com gdb
   └─ gdb ./programa_principal
   └─ step through instructions
3. Meça performance
   └─ perf stat ./programa_principal
4. Implemente variações próprias
5. Combine com C
6. Explore SIMD (próximo)
```

---

## 🎯 O Que Você Vai Aprender

### Programação Assembly
- [ ] Convenção System V x86_64
- [ ] Preservação de registradores
- [ ] Alinhamento de pilha
- [ ] Funções e retorno

### Otimizações
- [ ] Shift vs Multiply/Divide
- [ ] Instruções nativas (ROL, ROR, LEA)
- [ ] Algoritmos eficientes
- [ ] Minimização de memory access

### Estruturas
- [ ] Arrays e indexação
- [ ] Strings (C-style)
- [ ] Structs alinhadas
- [ ] Listas, Pilhas, Filas

### Syscalls
- [ ] read/write
- [ ] open/close
- [ ] getpid, gettimeofday
- [ ] mmap, exit

---

## 🔍 Busca Rápida por Tópico

| Tópico | Arquivo | Seção |
|--------|---------|-------|
| **Começar** | GUIA_RAPIDO_EXEMPLOS_OTIMIZADOS.md | Completo |
| **Multiplicação** | programa_principal.asm | função `multiplicar()` |
| **Somatório** | programa_principal.asm | função `calcular_somatorio()` |
| **FOR Loop** | loops_otimizados.asm | `loop_for:` |
| **WHILE Loop** | loops_otimizados.asm | `loop_while:` |
| **DO-WHILE** | loops_otimizados.asm | `loop_do_while:` |
| **NESTED** | loops_otimizados.asm | `loop_nested:` |
| **Set Bit** | manipulacao_bits_otimizada.asm | `set_bit:` |
| **Rotate** | manipulacao_bits_otimizada.asm | `rotate_left:` / `rotate_right:` |
| **Count Bits** | manipulacao_bits_otimizada.asm | `count_bits:` |
| **Syscall Write** | syscalls_otimizadas.asm | `syscall_write:` |
| **Syscall Open** | syscalls_otimizadas.asm | `syscall_open:` |
| **Array** | estruturas_dados_otimizadas.asm | `processar_array:` |
| **String** | estruturas_dados_otimizadas.asm | `comprimento_string:` |
| **Struct** | estruturas_dados_otimizadas.asm | `acessar_struct:` |
| **Linked List** | estruturas_dados_otimizadas.asm | `percorrer_lista_ligada:` |
| **Stack** | estruturas_dados_otimizadas.asm | `push_pilha:` / `pop_pilha:` |
| **Queue** | estruturas_dados_otimizadas.asm | `enqueue_fila:` / `dequeue_fila:` |

---

## 🛠️ Compilar & Executar

### Compilar Um Exemplo
```bash
cd linux_x86_64/05-exemplos/
as -o ARQUIVO.o ARQUIVO.asm
ld -o ARQUIVO ARQUIVO.o
./ARQUIVO
```

### Debug com GDB
```bash
as -o ARQUIVO.o ARQUIVO.asm
ld -o ARQUIVO ARQUIVO.o
gdb ./ARQUIVO
(gdb) layout asm
(gdb) run
(gdb) ni                # próxima instrução
(gdb) info registers    # mostrar registradores
```

### Analisar Performance
```bash
perf stat ./ARQUIVO
perf record ./ARQUIVO
perf report
```

---

## 📊 Arquivos por Tipo

### Código Assembly (5 arquivos)
- `programa_principal.asm` — Funções básicas (150 linhas)
- `loops_otimizados.asm` — Padrões de loop (200 linhas)
- `manipulacao_bits_otimizada.asm` — Operações bitwise (250 linhas)
- `syscalls_otimizadas.asm` — Chamadas de sistema (220 linhas)
- `estruturas_dados_otimizadas.asm` — Estruturas (280 linhas)

### Documentação (3 arquivos)
- `README_OTIMIZADOS.md` — Guia dos exemplos (300 linhas)
- `otimizacao_tecnicas_aplicadas.md` — Análise técnica (400 linhas)
- `GUIA_RAPIDO_EXEMPLOS_OTIMIZADOS.md` — Quick start (250 linhas)

### Índices & Navegação (4 arquivos)
- `INDICE_EXEMPLOS_OTIMIZADOS.md` — Índice completo
- `RESUMO_EXECUTIVO.md` — Sumário executivo
- `MAPA_NAVEGACAO.md` — Este arquivo
- `README_OTIMIZADOS.md` — Guia específico

---

## 💡 Dicas de Uso

### Para Iniciantes
1. Comece com `GUIA_RAPIDO_EXEMPLOS_OTIMIZADOS.md`
2. Execute `programa_principal.asm` primeiro
3. Leia comentários do código
4. Aumente complexidade gradualmente

### Para Intermediários
1. Estude cada padrão de loop
2. Modifique valores e recompile
3. Use gdb para step-through
4. Leia análise técnica

### Para Especialistas
1. Meça performance real com perf
2. Implemente variações SIMD
3. Otimize para CPU específica
4. Combine com C/C++

---

## ✅ Checklist de Progresso

Marque conforme você avança:

- [ ] Leu RESUMO_EXECUTIVO.md
- [ ] Leu GUIA_RAPIDO_EXEMPLOS_OTIMIZADOS.md
- [ ] Compilou programa_principal.asm
- [ ] Compilou loops_otimizados.asm
- [ ] Compilou manipulacao_bits_otimizada.asm
- [ ] Compilou syscalls_otimizadas.asm
- [ ] Compilou estruturas_dados_otimizadas.asm
- [ ] Leu README_OTIMIZADOS.md
- [ ] Leu otimizacao_tecnicas_aplicadas.md
- [ ] Debugou com gdb
- [ ] Mediu performance com perf
- [ ] Implementou uma variação própria

---

## 🎓 Conceitos-Chave

### Convenção System V x86_64
```
Argumentos:  rdi, rsi, rdx, rcx, r8, r9
Retorno:     rax
Preservar:   rbx, rbp, r12-r15
Voláteis:    rax, rcx, rdx, rsi, rdi, r8-r11
```

### Ganhos de Performance (Típicos)
```
Somatório:      10-100x com fórmula
Divisão:        40-80x com shift
Rotação:        8x com ROL/ROR nativa
Count Bits:     5-10x com Kernighan
Array Access:   2-3x com indexação
```

### Ciclos de Instrução (Approximate)
```
ALU op:         1 ciclo
Memory load:    4 ciclos (L1 cache)
Branch miss:    10-15 ciclos
DIV (64-bit):   10-40 ciclos
ROL/ROR:        1 ciclo
```

---

## 🔗 Links Úteis

- [RESUMO_EXECUTIVO.md](RESUMO_EXECUTIVO.md) — O que foi criado
- [GUIA_RAPIDO_EXEMPLOS_OTIMIZADOS.md](GUIA_RAPIDO_EXEMPLOS_OTIMIZADOS.md) — Como começar
- [INDICE_EXEMPLOS_OTIMIZADOS.md](INDICE_EXEMPLOS_OTIMIZADOS.md) — Índice detalhado
- [linux_x86_64/05-exemplos/README_OTIMIZADOS.md](linux_x86_64/05-exemplos/README_OTIMIZADOS.md) — Documentação técnica
- [linux_x86_64/06-avancado/otimizacao_tecnicas_aplicadas.md](linux_x86_64/06-avancado/otimizacao_tecnicas_aplicadas.md) — Análise profunda

---

## 📞 Suporte

### Se algo não compilar:
1. Verifique sintaxe: `as --version`
2. Veja erros: `as -o arquivo.o arquivo.asm 2>&1 | head -20`
3. Use objdump: `objdump -d arquivo.o`

### Se algo não funcionar:
1. Debug com gdb: `gdb ./arquivo`
2. Check registers: `info registers`
3. Step through: `ni` (next instruction)

### Para otimizar mais:
1. Perfil: `perf stat ./arquivo`
2. Record: `perf record ./arquivo`
3. Report: `perf report`

---

## 🎉 Próximos Passos

1. **Imediato:** Compile todos os exemplos
2. **Curto Prazo:** Implemente uma variação própria
3. **Médio Prazo:** Meça e otimize performance
4. **Longo Prazo:** Combine com SIMD/C/Multithreading

---

**Última Atualização:** 8 de maio de 2026  
**Status:** ✅ Pronto para Uso  
**Versão:** 1.0
