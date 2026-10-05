# CLAUDE.md · Um Mergulho

Data de Atualização: 05-10-2026_Versão 1.80

## Visão geral
Landing page pessoal de Nelson Goulart Geraidine (engenheiro de telecomunicações) que prova, com a própria página,
o que engenharia assistida por IA com método entrega: um arquivo, zero frameworks, comportamento especificado antes do código.
Hero com vídeo de martim-pescador; a interface se revela quando o pássaro pousa.

## Arquitetura em uma página
- Arquivos principais: `index.html` (entregável), `CLAUDE.md` (regras), `PRD.md` (especificação).
- `index.html`: todo CSS e JS inline, sem build, sem libs JS. Única dependência externa aprovada: Google Fonts
  (Instrument Serif, Manrope, JetBrains Mono).
- Ativos justificados: `hero.mp4` (vídeo auto-hospedado, mesma origem, para a leitura de cor via canvas funcionar;
  autorizado pelo thinkingods, ver PRD D2); `visualizar.bat` (pedido do Nelson: abre a página por HTTP
  local com um clique; o servidor Node vive dentro do próprio .bat); `PRODUCT.md` (pedido do Nelson via
  `/impeccable init`: público, posicionamento e provas para o Impeccable); `.gitignore` (mantém fora do repositório
  o histórico local do Impeccable e restos de teste); após o deploy, `og.jpg` (1200×627).
- Ordem no arquivo: `<head>` (meta, og, bloco `TODO APÓS PUBLICAR`, fontes, `<style>` com tokens em `:root`)
  → hero → `#notas` → faixa de estatísticas → `#contato` → `<script>`.
- Breakpoints: hero empilhado em `max-width:1200px` ou `max-aspect-ratio:13/9`; celular em `≤900px`;
  alvos de toque de 44 px em `≤900px` ou `pointer:coarse`.
- `<script>` começa com `CONFIG` (comentário `PREENCHER DEPOIS`) e `REVEAL_AT`; depois: amostragem de cor,
  coreografia do hero, fallbacks de revelação, miniaturas em canvas, replay, IntersectionObserver.
- Regra de ouro: o hero nunca fica em branco (revelação idempotente por pouso, `ended`, `error`,
  `play()` rejeitado, timeout de 9 s; `prefers-reduced-motion` respeitado).

## Escopo do projeto
Fonte de verdade: @PRD.md (especificação e decisões) e @PRODUCT.md (público e posicionamento).
Não inventar números, nomes nem resultados além dos que estão no PRD. Decisões novas entram na seção 7 do PRD;
pendências de publicação ficam na seção 11.

## Regras de comportamento
1. Antes de qualquer mudança não trivial (que toque mais de um arquivo ou mude comportamento existente),
   propor um plano antes de executar.
2. Nunca adicionar bibliotecas externas, CDNs ou pacotes sem consultar o Nelson antes.
3. Comentários em português. Comentários explicam o "porquê" do código, não o "o quê".
4. Antes de criar arquivo novo além dos três principais, justificar por que ele precisa existir.
5. Se um pedido de feature conflitar com o PRD.md, avisar antes de implementar.
6. Toda atualização no projeto fica documentada com data e versão, no formato
   `Data de Atualização: DD-MM-YYYY_Versão X.XX`, no topo do arquivo alterado e no histórico do PRD.md.
   Manter CLAUDE.md e PRD.md sempre atualizados junto com o código.

## Convenções de código
- `<html lang="pt-BR">`; todo texto visível em português do Brasil, literal ao PRD.
- CSS: classes em kebab-case (`.hero-word`, `.note-card`); estados com prefixo `is-` (`.is-revealed`);
  revelação com `.rv` + variável `--d` para escalonamento.
- Cores só via tokens em `:root`; nenhum hex solto fora deles. Easing padrão `cubic-bezier(.2,.7,.1,1)`.
- JS: `const`/`let`, camelCase, constantes de configuração em MAIÚSCULAS (`REVEAL_AT`); sem dependências.
- Toda leitura de pixel (`getImageData`) em try/catch com fallback nos valores do CSS.
- Links externos sempre com `target="_blank" rel="noopener"`.
- `og:url` e `og:image` em HTML estático, comentadas no bloco `TODO APÓS PUBLICAR`; nunca geradas por JS.
- Textos visíveis sem travessão, sem emoji, sem roxo, sem gradientes genéricos.
- Indentação de 2 espaços; UTF-8 sem BOM.

## Como rodar
- Duplo clique em `visualizar.bat`: sobe servidor em `http://localhost:8080` (Node, com suporte a Range) e abre
  o navegador. Sem Node, cai para Python (o REPETIR pode falhar sem Range). Não usar `file://`.
- Testar: 360, 390, 768, 1024, 1180×740 e 1440 px; reduced motion (DevTools > Rendering); vídeo bloqueado
  (DevTools > Network > Block request URL).
- Repositório: https://github.com/nelsongeraidine/engenharia-assistida-por-ia (branch `main`). Deploy: Vercel como site estático, sem comando de build.
- Avaliação de design: `/impeccable critique index.html` (última nota 20/28, antes das correções v1.60 e v1.70).
- Pasta sob sync do OneDrive: evitar escrita concorrente no mesmo arquivo.
