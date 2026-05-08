# Tópicos avançados

Esta pasta reúne conteúdos para aprofundamento em performance, paralelismo e segurança em Assembly x86_64.

## O que você encontra aqui
- `otimizacao.md` — técnicas para código mais rápido e eficiente.
- `otimizacao_tecnicas_aplicadas.md` — análise detalhada das otimizações implementadas nos exemplos práticos.
- `simd.md` — uso de SSE/AVX para processamento vetorial.
- `multithreading.md` — criação de threads, sincronização e memória compartilhada.
- `seguranca.md` — práticas para evitar vulnerabilidades e exploits.

## Abordagem
Mostre como evoluir de um código funcional para um código otimizado e seguro. Explique efeitos de performance e cuidados especiais para Assembly avançado.

## Como usar
1. Leia `otimizacao.md` para melhorar eficiência.
2. Estude `otimizacao_tecnicas_aplicadas.md` para ver como otimizações foram aplicadas em código real.
3. Explore os exemplos otimizados em `../05-exemplos/` (programa_principal.asm, loops_otimizados.asm, etc.).
4. Estude `simd.md` ao trabalhar com dados vetoriais.
5. Consulte `multithreading.md` para programação concorrente.
6. Veja `seguranca.md` para proteger rotinas críticas.
7. Use `../images/advanced.svg` para um panorama visual das áreas avançadas.

## Dicas importantes
- Otimize apenas depois de validar correção.
- Prefira instruções vetoriais para operações em massa.
- Cuidado com sincronização e condições de corrida.
- Proteja entradas e limites para evitar buffer overflow.
