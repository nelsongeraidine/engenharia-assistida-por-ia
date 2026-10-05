# Product

<!-- impeccable:product-schema 1 -->

Data de Atualização: 05-10-2026_Versão 1.20

## Platform

web

## Users
Recrutadores e gestores contratando para vaga fixa, com foco no mercado de São Paulo. Chegam pela página vindos do LinkedIn ou de um link compartilhado, avaliando em poucos minutos se o candidato merece uma conversa.
Sucesso: o recrutador chama Nelson no LinkedIn para uma entrevista.

## Product Purpose
Landing page pessoal de Nelson Goulart Geraidine, engenheiro de telecomunicações com mais de 30 anos de experiência, que demonstra na prática o que engenharia assistida por IA com método entrega.
Existe para transformar uma afirmação ("sei usar IA com método") em evidência verificável: a própria página.

## Positioning
Não é "sei usar IA": é engenharia aplicada à IA. Especificação escrita antes do código, premissas declaradas, falhas previstas, cada comportamento descrito antes da primeira linha. A página é a prova, não a promessa: um arquivo, zero frameworks, fallback em tudo.
Trinta anos de telecom dão a disciplina; a IA dá a velocidade.

## Operating Context
- O recrutador lê no computador do trabalho ou no celular, com pouco tempo e sem som.
- Canal de conversão único: LinkedIn (https://www.linkedin.com/in/nelsonggeraidine). Instagram (https://www.instagram.com/nelsonggeraidine/) é secundário e não compete com o LinkedIn.
- Rótulo de localização: "SÃO PAULO · SP" (mercado-alvo). Nelson reside em Ribeirão Preto; não afirmar residência em São Paulo.

## Capabilities and Constraints
- Áreas de atuação confirmadas para comunicar: engenharia assistida por IA (páginas, automações, apps internos a partir de especificação) e **análise de dados**.
- Análise de dados entra sem tirar a essência da página: a mensagem central continua sendo método e engenharia, não um catálogo de ferramentas.
- Não listar ferramentas pelo nome sem confirmação do Nelson.
- Técnicas: um único `index.html` estático, sem frameworks nem build; código em https://github.com/nelsongeraidine/engenharia-assistida-por-ia, deploy via Vercel. Restrições completas em [CLAUDE.md](CLAUDE.md) e [PRD.md](PRD.md).

## Brand Commitments
- Nome público: Nelson Goulart Geraidine (marca na nav: NELSON GERAIDINE).
- Título profissional: engenheiro de telecomunicações; "mais de 30 anos" é o único dado de tempo de carreira confirmado.
- Voz: português do Brasil, direta, técnica sem jargão gratuito, sem hype de IA, sem bajulação. Sem travessão; sem emoji.
- Metáfora central: o martim-pescador (espera, lê a água, mergulha uma vez). Vídeo e conceito original de thinkingods.com, uso autorizado, crédito obrigatório no rodapé.

## Evidence on Hand
- A própria página e o PRD que a especificou são a única prova pública (PRD versionado no repositório do projeto).
- Não há cases, clientes, números de resultado nem depoimentos publicáveis. **Nenhum deles pode ser inventado** em versões futuras.
- Ativos: `hero.mp4` (1280×720, 8 s, autorizado). `og.jpg` (1200×627, prévia para LinkedIn) criada a partir do último quadro do vídeo.
- Faixa de estatísticas usa apenas fatos verificáveis do próprio projeto: 6 cenários de falha tratados no código e decisões registradas no PRD.

## Product Principles
1. A prova vem antes da afirmação: só se diz o que a página demonstra.
2. Nada inventado: todo número, nome ou resultado precisa de fonte confirmada pelo Nelson.
3. Um caminho de conversão: tudo leva ao LinkedIn; o resto é apoio.
4. Robustez é parte da mensagem: a página precisa abrir bem mesmo quando algo falha.
5. Tempo do recrutador é escasso: a tese tem que ser entendida no primeiro viewport.

## Accessibility & Inclusion
- `prefers-reduced-motion` respeitado (salta para o último quadro, sem transições).
- A página nunca fica em branco: conteúdo visível sem JS e com vídeo bloqueado.
- Sem áudio (testado e retirado a pedido do Nelson).
