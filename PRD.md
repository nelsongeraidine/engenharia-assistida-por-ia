# PRD · Um Mergulho

Data de Atualização: 05-10-2026_Versão 2.00

| Campo | Valor |
|---|---|
| Autor | Nelson Goulart Geraidine, engenheiro de telecomunicações |
| Status | Implementado e testado (v1.70); aguardando deploy |
| Repositório | https://github.com/nelsongeraidine/engenharia-assistida-por-ia |
| Data | 2026-10-05 |
| Entregável | `index.html` único, autocontido |
| Deploy previsto | GitHub + Vercel |

## 1. Objetivo
Demonstrar, com a própria página como prova, o que engenharia assistida por IA com método entrega: um arquivo, zero frameworks, cada comportamento especificado antes do código. Público principal: recrutadores e gestores contratando para vaga fixa, foco em São Paulo (CTA: conversa no LinkedIn). Detalhes em [PRODUCT.md](PRODUCT.md).

**Critério de sucesso:** a página abre e revela a interface em qualquer cenário de falha, reproduz fielmente a especificação visual em desktop e mobile e não contém nenhum dado que não esteja neste documento.

## 2. Fora de escopo
Formulário de contato, analytics, CMS, múltiplas páginas, i18n, modo escuro alternativo.

## 3. Fatos verificados (2026-10-05)
- Vídeo `https://thinkingods.com/demos/kingfisher-hero/hero.mp4`: HTTP 200, `video/mp4`, 1,41 MB, 1280×720, 24 fps, **8,0 s**, servido via Cloudflare com **`Access-Control-Allow-Origin: *`** e `Accept-Ranges: bytes`.
- `REVEAL_AT = 4.3` cabe na duração (pouso a ~54% do vídeo). Conferido quadro a quadro: em 4,3 s o pássaro já pousou, com as asas fechadas.

## 4. Especificação funcional

### 4.1 Head
- `<title>` e `og:title`: `Um Mergulho · Nelson Goulart Geraidine`
- `meta description` e `og:description`: `Engenharia assistida por IA na prática, por Nelson Goulart Geraidine, engenheiro de telecomunicações: uma página, um arquivo, zero frameworks.`
- `og:type`: `website`
- Bloco de comentário HTML `TODO APÓS PUBLICAR` contendo, estáticas: `og:url` = `https://SEU-PROJETO.vercel.app/`, `og:image` = `https://SEU-PROJETO.vercel.app/og.jpg` (absoluta, 1200×627).
- Google Fonts: Instrument Serif (400, 400 itálico), Manrope (400 a 700), JetBrains Mono (400, 500), com `display=swap` e `preconnect`.

### 4.2 Configuração (topo do `<script>`)
```js
// PREENCHER DEPOIS
const CONFIG = { iteracoes: null, urlPrompt: null };
```
| Campo | null | Com valor |
|---|---|---|
| `urlPrompt` | link "Ver o prompt ↗" não é renderizado nem deixa espaço | link aponta para a URL (externo) |
| `iteracoes` | 3º item da faixa: rótulo `ESPECIFICAÇÃO`, valor `1 documento` | rótulo `ITERAÇÕES`, valor = número |

### 4.3 Hero (100svh, overflow hidden)
**Vídeo:** `<video src="hero.mp4" muted playsinline preload="auto">` (arquivo auto-hospedado na raiz do projeto, mesma origem; decisão D1), absoluto, `object-fit: cover`, **sem loop** (último quadro permanece). Decorativo (`aria-hidden`).

**Palavra fantasma:** "Engenharia" com "ia" em itálico, `white-space: nowrap`, Instrument Serif, `clamp(90px, 17vw, 300px)`, centralizada, `top: 13vh`, cor `--ghost` (#929C8D sobre #B6C3B0; v1.10, antes #ADBAA7), `mix-blend-mode: darken`, `mask-image: linear-gradient(180deg,#000 0%,#000 50%,rgba(0,0,0,.35) 70%,transparent 90%)` (com prefixo `-webkit-`; v1.10, antes 38/62/86%). Decorativa (`aria-hidden`). Sem máscara quadro a quadro, sem alfa.

**Amostragem de cor em runtime:** no `loadeddata`, desenhar 1 px do vídeo em (94% x, 12% y) num canvas 1×1, ler o pixel, gravar em `--bg`; `--ghost` = cor × 0,80 (v1.10, antes 0,955). Try/catch com fallback nos valores do CSS. (Ver decisão D1.)

**Overlay de legibilidade:** gradiente esquerda→direita de `--bg` a 70% até transparente em 38%, mais gradiente inferior até `--bg` a 55%.

**Nav:** marca de pássaro em dois tons + `NELSON GERAIDINE` (700, tracking .22em) à esquerda; `NOTAS · CONTATO` em mono ao centro (âncoras `#notas`, `#contato`); pílula escura `LINKEDIN` à direita → `https://www.linkedin.com/in/nelsonggeraidine`.

**Bloco de texto (esquerda):** centralizado verticalmente, deslocado ~76 px para baixo, `max-width: 470px`.
- Eyebrow mono com fio de 28 px: `UM MERGULHO · IA COM MÉTODO`
- h1 serifada `clamp(44px,5vw,76px)`, line-height .95: `Vibe coding voa. Engenharia pousa.` ("pousa" itálico, teal)
- Lede 15 px: `Engenheiro de telecomunicações há mais de 30 anos, uso IA para construir páginas, automações, apps internos e análises de dados a partir de especificação escrita. Esta página é a prova: um arquivo, zero frameworks, cada comportamento descrito antes da primeira linha de código.`
- CTA pílula, gradiente laranja, seta em círculo: `Conversar no LinkedIn` → perfil
- Link sublinhado `Ver o prompt ↗` (regido por `CONFIG.urlPrompt`)

**Agrupamento (direita), `min(400px,34vw)`:**
- Chips mono com fio fino: `HTML · CSS · JS · SEM BUILD`
- Dois cards escuros lado a lado, o segundo rebaixado 18 px:

| | Card 1 | Card 2 |
|---|---|---|
| Cabeçalho | `ESPECIFICAÇÃO / 01` | `ROBUSTEZ / 02` |
| Legenda | `Valores exatos` | `Fallback em tudo` |
| Número (serifada) | `1 arquivo` | `0 frameworks` |
| `data-crop` | `0.555,0.335,0.22` (cabeça) | `0.43,0.60,0.24` (asa) |

Cada card: miniatura quadrada em `<canvas>`, legenda sobre gradiente inferior. (Os três pontos saíram na v1.70: não carregavam significado e pesavam junto com o CTA.) Miniatura = `drawImage` do vídeo com recorte fracionário, em fade sobre placeholder radial teal/laranja, desenhada no pouso. (Ver decisões D4 e D5.)

**Faixa inferior:** `ESPÉCIE 01` (mono) + *Alcedo atthis* (serifada itálica) à esquerda; `SÃO PAULO · SP` ao centro; à direita, pílula fosca `REPETIR` (remove `.is-revealed`, oculta miniaturas, reinicia vídeo).

### 4.4 Coreografia
- `const REVEAL_AT = 4.3;` No `timeupdate`, `currentTime >= REVEAL_AT` → `.is-revealed` no hero.
- Classe `.rv`: `opacity: 0`, `translateY(18px)`, `blur(6px)`; transição .9s, easing `cubic-bezier(.2,.7,.1,1)`, atraso `calc(var(--d) * 90ms)`.
- Ordem `--d`: nav 0, eyebrow 1, h1 2, lede 3, botões 4, chips 5, card 1 6, card 2 7, faixa inferior 8.
- Nada tipográfico se move antes do pouso. **Exceção (v1.60, ≤900 px):** eyebrow e h1 ficam visíveis desde o início, para o celular não ficar 4,3 s com a tela vazia (D16).

### 4.5 Robustez do hero
Revelar (idempotente) também em: `ended`, `error` (no `<video>` e no `<source>`/rede), `play()` rejeitado, timeout rígido de 9 s. Se `readyState >= 2` quando o script rodar, iniciar imediatamente. `prefers-reduced-motion`: saltar para o último quadro e revelar sem transições. Replay deve rearmar flag, timeout e miniaturas.

### 4.6 Seção Notas (`id="notas"`)
- Fundo: gradiente de `--bg` para `--paper` nos primeiros 220 px, fio fino no topo.
- Cabeçalho em duas colunas: kicker mono `02 NOTAS DE CAMPO · POR QUE UM MARTIM-PESCADOR` ("02" laranja); h2 serifada `clamp(40px,5.2vw,78px)`: `Ele espera, lê a água e pousa em um único movimento limpo`; parágrafo 16 px: `Vibe coding sem estrutura é bater asa até dar certo. Com estrutura, quase todo o trabalho acontece antes: entender o processo, declarar premissas, prever falhas. É assim que construo páginas, automações, apps internos e análises de dados.`
- Bento grid `1.35fr 1fr 1fr`, gap 16 px. Layout: N01 coluna 1, linhas 1–2; N02 col 2; N03 col 3; N04 cols 2–3 na linha 2.

| Nota | Tema | Estilo | Texto | Extra |
|---|---|---|---|---|
| 01 | RESTRIÇÃO | escura, 2 linhas | `O bico do martim-pescador entra na água quase sem respingo. Engenheiros japoneses copiaram essa forma no nariz do Shinkansen para reduzir o estrondo na saída dos túneis. No prompt vale o mesmo: valores exatos (cores, tempos, medidas) no lugar de adjetivos.` | arco SVG `POLEIRO` → `ENTRADA` via `stroke-dashoffset` |
| 02 | ESTRUTURA | clara | `O azul da pena não é pigmento: é a microestrutura que espalha a luz. A qualidade do resultado também não vem do modelo de IA, vem da estrutura do que foi pedido.` | 3 chips de amostra de cor |
| 03 | PROTEÇÃO | clara | `No mergulho, uma membrana cobre o olho no instante do impacto. Código gerado precisa da mesma proteção: se o vídeo falha, se a fonte falha, se o navegador bloqueia, a página abre mesmo assim.` | nenhum |
| 04 | ESPERA | clara, 2 colunas | `Ele passa a maior parte do tempo parado, lendo a água. O trabalho de verdade acontece antes do prompt: premissas declaradas, critério de sucesso e casos de falha previstos. O código é só o mergulho.` | olho/alvo SVG |

Índice de cada nota: `NOTA 0X · TEMA` (mono). Cards claros: `rgba(255,255,255,.45)`, fio fino, raio 22 px.

**Faixa escura de estatísticas** (4 itens, divisores tênues):
1. `FALHAS PREVISTAS` / `6 cenários` + seis segmentos que acendem em sequência (v1.70). Os seis, todos tratados no código: vídeo bloqueado, vídeo travado (timeout 9 s), `play()` recusado, sem JavaScript, leitura de cor bloqueada (file:// ou sem CORS), fonte indisponível (fallbacks).
2. `DECISÕES` / `Registradas` + círculo sólido ao lado de tracejado (v1.70; antes `FRAMEWORKS` / `Zero`, que repetia o card do hero)
3. regido por `CONFIG.iteracoes` + barra teal → cobalto com brilho que passa duas vezes ao entrar na tela (v1.70; antes em loop infinito)
4. `ENTREGA` / `Um mergulho` (itálico laranja) + curva que se desenha

### 4.7 Contato (`id="contato"`)
Frase serifada: `O que vale para uma página vale para a automação que a sua empresa ainda faz à mão.` CTA laranja `Conversar no LinkedIn` → perfil; ao lado, link sublinhado secundário com glifo do Instagram (SVG inline monocromático, cor do texto) + `Instagram ↗` → `https://www.instagram.com/nelsonggeraidine/` (v1.10; ícone v1.20). Linha mono: `VÍDEO E CONCEITO ORIGINAL: THINKINGODS.COM` → `https://thinkingods.com/`.

### 4.8 Revelação por rolagem
IntersectionObserver, threshold .18, fade + subida de 28 px com atrasos escalonados; arcos, régua e curva animam ao entrar na viewport.

## 5. Design
**Tokens (`:root`):** `--bg:#B6C3B0` `--paper:#E3E8DE` `--ink:#10201F` `--ink-2:#2E3D3A` `--ink-3:#4E5E58` `--line:rgba(16,32,31,.14)` `--ghost:#929C8D` `--orange:#E8732A` `--orange-2:#F3A15E` `--teal:#0E7C86` `--panel:#0F1D1C` `--panel-2:#172A28`. Texto sobre fundo claro (v1.60): `--teal-ink:#0A5F67` ("pousa", 4,1:1) e `--orange-ink:#934012` ("02" do kicker, 4,9:1). Contorno de foco em `--ink` (9,3:1). A definir: `--cobalt` (D7).

**Tipografia:** Instrument Serif para títulos; Manrope para corpo e botões; JetBrains Mono para rótulos em maiúsculas de 9–11 px, tracking .14–.2em. Fallbacks reais: serif `"Iowan Old Style", "Palatino Linotype", Georgia, serif`; sans `"Segoe UI", system-ui, -apple-system, Roboto, sans-serif`; mono `ui-monospace, "Cascadia Mono", Consolas, monospace`.

**Linguagem:** fios finos, espaço em branco generoso, cards escuros com raio 18–26 px e sombras profundas e suaves, botões em pílula. Sem roxo, sem gradientes genéricos, sem emoji.

## 6. Responsivo

**Hero empilhado (≤1200 px ou proporção ≤13:9, v1.50):** vídeo nos 62svh superiores, interface embaixo; de 901 a 1200 px, texto (até 520 px) e cards lado a lado.

**≤900 px:** rótulos em mono com no mínimo 11 px.

**Toque (≤900 px ou `pointer: coarse`, v1.70):** links e botões com área mínima de 44 px.

**Demais regras ≤900 px:**
- Nav: ocultar links, manter pílula LINKEDIN.
- Palavra fantasma: 22vw.
- Hero vira coluna flex, texto e cards abaixo do pássaro (~46svh de padding superior); segundo card sem deslocamento; overlay vira gradiente de `--bg` de baixo para cima.
- Notas em 1 coluna; estatísticas 2×2.
- Sem rolagem horizontal; margem lateral 16 px.

## 7. Registro de decisões

Todas resolvidas, exceto as pendências de publicação (seção 11).

| # | Tema | Problema | Recomendação |
|---|---|---|---|
| D1 | CORS × amostragem de cor | Sem `crossorigin`, vídeo de outra origem sempre bloqueia a leitura do canvas, mesmo com o servidor enviando CORS (e ele envia `ACAO: *`). | **RESOLVIDO (opção A):** `hero.mp4` auto-hospedado na raiz do projeto, mesma origem; sem atributo `crossorigin`; amostragem funciona em produção (em `file://` continua caindo no fallback, por isso o teste é via HTTP). |
| D2 | Direitos do vídeo | Auto-hospedar copia um ativo de terceiro para o seu projeto. | **RESOLVIDO (05-10-2026):** Nelson confirmou a autorização. Vídeo auto-hospedado liberado para deploy; crédito no rodapé mantido. |
| D3 | Hero mobile | `100svh` + `overflow: hidden` com 46svh de padding + texto + cards excede a altura em telas de 360–390 px; o conteúdo seria cortado. | **RESOLVIDO:** no ≤900 px, `height:auto` + `min-height:100svh`; vídeo ocupa os 62svh superiores. Hero medido: ~1180 px em 360/390 px, nada cortado. |
| D4 | Semântica de `data-crop` | "size" é fração de quê? 0,22 da largura = 282 px; da altura = 158 px. | **RESOLVIDO (conferido no quadro final):** x e y são o **centro** do recorte; size é fração da **largura** (0,22 → 282 px; 0,24 → 307 px). Enquadra cabeça e asa. |
| D5 | Momento do desenho das miniaturas | Desenhar só no pouso (4,3 s) pega o quadro do pouso, não o final; em revelação por erro/timeout não há quadro. | **RESOLVIDO:** desenha no pouso e redesenha no `ended`; nunca desenha antes de `REVEAL_AT` (quadro sem pássaro); sem quadro, fica o placeholder. |
| D6 | Contraste | "pousa" em teal sobre sage: ~2,7:1 (abaixo de 3:1 para texto grande). Cor do texto do CTA laranja não especificada (branco sobre #E8732A ≈ 2,9:1). | **RESOLVIDO:** texto do CTA em `--ink`; "pousa" em `--teal-ink` #0A5F67 (v1.60, 4,1:1). |
| D7 | Cobalto | Cor não existe nos tokens. | **RESOLVIDO:** token `--cobalt:#2F4FA2`. |
| D8 | *Alcedo atthis* + "SÃO PAULO · SP" | *Alcedo atthis* não ocorre nas Américas; lado a lado, sugere que a espécie é de SP. | **RESOLVIDO:** manter `SÃO PAULO · SP` (mercado-alvo de trabalho; Nelson reside em Ribeirão Preto) e manter a espécie; rótulos em posições separadas (esquerda e centro), conforme layout. |
| D9 | Cards no mobile | Não especificado se ficam lado a lado em 360 px (~160 px cada). | **RESOLVIDO (revisto no teste):** lado a lado em todas as larguras; em 360 px cabem com fonte reduzida (≤400 px). Empilhar gerava miniaturas enormes. |
| D10 | Favicon | Não especificado. | **RESOLVIDO:** marca de pássaro em SVG data URI no `<head>`. |
| D11 | Lede sobre o pássaro (desktop) | Com as medidas da spec (texto em `max-width:470px` a partir da margem e vídeo em `cover`), em 1440×900 o fim das linhas do lede cruza a asa e o galho; o véu de 70% → 0 em 38% quase não atua nessa faixa. | **RESOLVIDO (v1.30, opção b):** lede com `max-width:400px` no desktop (sem limite no ≤900 px). Em 1440×900 só a ponta do galho encosta na última linha. |
| D12 | Legibilidade da palavra fantasma | Com 0,955 a palavra quase não era percebida. | **RESOLVIDO (v1.10):** fator 0,80 + parte opaca da máscara até 50%. Pássaro continua na frente; em voo, as asas cinzentas podem mostrar a palavra de leve. |
| D13 | Instagram | Pedido do Nelson. | **RESOLVIDO (v1.10):** link secundário na seção Contato, sem competir com o CTA do LinkedIn. Perfil não verificável sem login. |
| D14 | Som | Pedido do Nelson. | **REMOVIDO (v1.20):** testado em v1.10/v1.11 (opt-in sintetizado via Web Audio); Nelson não aprovou o resultado e pediu a retirada. Página sem áudio. |
| D15 | Telas de 901 a ~1200 px (ex.: 1024×768, iPad deitado) | Proporção mais quadrada que o vídeo: o `cover` corta as laterais e o pássaro fica sob o texto e encosta nos chips. Anterior ao D11. | **RESOLVIDO (v1.50):** hero empilhado quando `max-width:1200px` ou `max-aspect-ratio:13/9`; entre 901 e 1200 px texto e cards ficam lado a lado embaixo do pássaro. Testado em 1024×768, 1180×740, 1280×900 (empilhado), 1440×790 e 1920×960 (inalterado), 390×844. |
| D16 | Celular: 4,3 s de tela vazia e CTA na beira da tela (critique de 05-10-2026) | Regra da spec impedia texto antes do pouso. | **RESOLVIDO (v1.60, aprovado pelo Nelson):** no ≤900 px, eyebrow e h1 visíveis desde o início; vídeo 56svh e texto a partir de 40svh. CTA termina em 705/844 px (390) e 712/800 px (360). |
| D17 | Linha de papel/cargo junto ao título (critique) | Recrutador não vê que vaga Nelson busca. | **DECIDIDO:** não adicionar; o hero fica como está. |

## 8. Riscos técnicos menores
- `timeupdate` dispara a ~4 Hz: até ~250 ms de atraso na revelação. Aceitável; alternativa: `requestVideoFrameCallback` com fallback.
- Vídeo 1280×720 em `cover` fica ampliado em telas grandes e as miniaturas (~158 px de origem) ficam suaves em DPR 2.
- Timeout de 9 s pode revelar com o pássaro ainda em voo em conexão lenta (comportamento desejado: nunca em branco).
- Sem JS: elementos `.rv` ficariam invisíveis. Mitigado com `<noscript><style>` que força o estado visível (evita um segundo `<script>` antes do CONFIG).
- `mix-blend-mode` exige que palavra e vídeo compartilhem o mesmo contexto de empilhamento (nada de `isolation`/`transform` no wrapper da palavra que o isole do vídeo).

## 9. Critérios de aceitação
1. Um único `index.html`, sem build, sem libs JS; abre servido por HTTP e por Vercel.
2. Todo texto visível idêntico ao PRD; nenhum número ou nome extra.
3. Pássaro aparece na frente da palavra fantasma via `darken`; metade inferior da palavra dissolvida.
4. Nenhum elemento tipográfico se move antes de `REVEAL_AT`; ordem de revelação conforme 4.4. Exceção no ≤900 px: eyebrow e h1 visíveis desde o início (D16).
5. Hero revela em: vídeo normal, URL quebrada, `play()` rejeitado, reduced motion, 9 s de timeout.
6. `CONFIG.urlPrompt = null` não deixa link nem espaço; com valor, link funciona. `CONFIG.iteracoes` alterna rótulo e valor.
7. Miniaturas mostram cabeça e asa do pássaro; placeholder quando não houver quadro.
8. Replay repete a coreografia completa.
9. og:url/og:image estáticas e comentadas no bloco `TODO APÓS PUBLICAR`.
10. 360, 390, 768, 1024, 1180×740, 1280×900, 1440 e 1920 px sem rolagem horizontal; hero empilhado e layout ≤900 px conforme seção 6. No celular: rótulos ≥11 px e alvos de toque ≥44 px.
11. Todos os links externos com `target="_blank" rel="noopener"`.
12. Console sem erros não tratados.
13. Entrega final informa `REVEAL_AT`, como alterá-lo e as linhas de CONFIG e do bloco TODO.

## 10. Avaliação de design
- `/impeccable critique` em 05-10-2026 (v1.50): **20/28** (heurísticas 7, 9 e 10 n/a). Histórico local em `.impeccable/critique/` (fora do git).
- Correções aplicadas em v1.60 e v1.70. Detector final: 1 achado (Instrument Serif, fonte fixada pela spec).

## 11. Pendências de publicação
1. ~~Criar `og.jpg` (1200×627)~~ **Feito (v1.90):** último quadro do vídeo, palavra "Engenharia" atrás do pássaro, título e "Nelson Goulart Geraidine · Engenheiro de telecomunicações".
2. Fazer o deploy na Vercel a partir do repositório.
3. Trocar `SEU-PROJETO` pela URL real e descomentar as metas do bloco `TODO APÓS PUBLICAR`.
4. Opcional: preencher `CONFIG.iteracoes` e `CONFIG.urlPrompt` (por exemplo, apontando para este PRD no GitHub).

## 12. Histórico de versões
| Versão | Data | Alteração |
|---|---|---|
| 0.01 | 05-10-2026 | Criação do PRD a partir do prompt original; verificação do vídeo; decisões D1 a D10 levantadas. |
| 0.02 | 05-10-2026 | CLAUDE.md reestruturado com regras de comportamento e versionamento; histórico adicionado ao PRD. |
| 0.03 | 05-10-2026 | D1 resolvido (vídeo auto-hospedado); D2 pendente de autorização; D8 resolvido (manter SÃO PAULO · SP). Novo arquivo previsto: `hero.mp4`. |
| 1.00 | 05-10-2026 | Implementação do `index.html`; `hero.mp4` baixado; `visualizar.bat` criado a pedido. D3 a D7, D9, D10 resolvidos; D11 aberto. Testes: desktop 1440, mobile 390/360, vídeo bloqueado, vídeo travado (9,2 s), `play()` rejeitado, reduced motion, CONFIG nulo e preenchido, replay. |
| 1.10 | 05-10-2026 | Palavra fantasma mais escura (0,80) e máscara opaca até 50%; link do Instagram no Contato; botão SOM com Web Audio sintetizado; ajustes da faixa inferior no mobile. |
| 1.11 | 05-10-2026 | Correção do som inaudível: ambiente movido para a banda que alto-falantes pequenos reproduzem (+12 dB audíveis) e gota de confirmação ao ligar o SOM. |
| 1.20 | 05-10-2026 | Som removido por completo (botão, código e estilos). Glifo do Instagram adicionado ao link do Contato. |
| 1.30 | 05-10-2026 | D2 resolvido (autorização confirmada pelo Nelson). D11 resolvido: lede com 400 px no desktop. D15 aberto (telas de 901 a ~1200 px). |
| 1.40 | 05-10-2026 | `PRODUCT.md` criado via `/impeccable init`: público principal = recrutadores; análise de dados confirmada como área de atuação (sem mudar a essência da página); nenhuma prova publicável além da própria página. |
| 1.50 | 05-10-2026 | Lede passa a citar "análises de dados" (aprovado pelo Nelson). D15 resolvido via `/impeccable adapt`: novo breakpoint do hero empilhado. |
| 1.60 | 05-10-2026 | Correções do `/impeccable critique` (nota 20/28): contraste de "pousa", do "02" e do contorno de foco; celular sem tela vazia e CTA mais alto (D16). Linha de papel recusada (D17). |
| 1.70 | 05-10-2026 | Sequência pós-critique (`distill`, `typeset`, `adapt`, ajustes menores, `polish`): cards sem os três pontos e com sombra menor; faixa de estatísticas vira prova do método (FALHAS PREVISTAS · 6 cenários; DECISÕES · Registradas), aprovado pelo Nelson; rótulos ≥11 px e alvos de toque ≥44 px no celular; "análises de dados" no parágrafo das Notas; brilho da barra sem loop; régua trocada por segmentos (sem animar largura). |
| 1.80 | 05-10-2026 | Documentação revisada para o estado atual (status, decisões, critérios, avaliação, pendências de publicação). Projeto versionado em https://github.com/nelsongeraidine/engenharia-assistida-por-ia. |
| 1.90 | 05-10-2026 | `og.jpg` criada (1200×627) a partir do último quadro do vídeo, no mesmo estilo do hero. |
| 2.00 | 05-10-2026 | `README.md` criado para apresentar o repositório no GitHub (o truque do blend, os 6 cenários de falha, estrutura, como rodar, publicação, créditos). |
