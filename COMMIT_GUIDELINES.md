# Guia de Convenção de Commits

Este arquivo descreve um padrão de mensagens de commit para manter o histórico claro e organizado.

## Formato de mensagem

Use mensagens no formato:

```text
<tipo>(<escopo>): <descrição curta>

<descrição longa opcional>
```

### Tipos sugeridos
- `feat` — nova funcionalidade ou conteúdo adicionado
- `fix` — correção de erros ou ajustes
- `docs` — alterações na documentação
- `style` — formatação, estilo, comentários, sem alteração de funcionalidade
- `refactor` — reorganização ou melhoria do conteúdo sem mudar o comportamento
- `chore` — tarefas de manutenção, configuração ou arquivos de suporte

### Escopos possíveis
- `readme`
- `linux_x86_64`
- `docs`
- `sources`
- `diagrams`
- `images`
- `commit`

### Exemplos
- `docs(readme): add main project overview and repo structure`
- `feat(sources): add learning resources and recommended tools`
- `fix(diagrams): correct mermaid diagram syntax`
- `chore: add gitignore and commit guidelines`

## Fluxo de trabalho recomendado

1. Crie uma branch específica para a tarefa:
   - `feature/add-resources`
   - `fix/push-structure`
   - `docs/commit-guidelines`
2. Faça alterações e valide o conteúdo.
3. Adicione os arquivos alterados:
   - `git add .`
4. Faça commit com uma mensagem clara e padronizada:
   - `git commit -m "docs(readme): add main project overview and repo structure"`
5. Faça push para o branch remoto:
   - `git push origin <branch>`
6. Abra um pull request ou revise o branch antes de mesclar.

## Dicas de commit
- Mantenha a descrição curta e objetiva.
- Use o corpo do commit para detalhar mudanças maiores.
- Agrupe alterações relacionadas no mesmo commit.
- Evite commits muito grandes; prefira pequenos commits iterativos.
