@echo off
rem Data de Atualizacao: 05-10-2026_Versao 1.00
rem Abre a pagina servida por HTTP local. Nao usa file:// porque ali a leitura de cor do video
rem cai no fallback e o comportamento difere do site publicado.
rem Prioridade: Node (servidor embutido abaixo, com suporte a Range para o replay do video funcionar),
rem depois Python (sem Range: o botao REPETIR pode nao reiniciar o video).
setlocal
cd /d "%~dp0"
set "PORT=8080"

where node >nul 2>nul
if %errorlevel%==0 (
  echo Servidor Node em http://localhost:%PORT%/  ^(feche esta janela para parar^)
  node -e "const s=require('fs').readFileSync(process.argv[1],'utf8');eval(s.slice(s.lastIndexOf('/*SERVIDOR*/')))" "%~f0"
  goto :fim
)

where python >nul 2>nul
if %errorlevel%==0 (
  echo Node nao encontrado; usando Python em http://localhost:%PORT%/
  start "" cmd /c "timeout /t 2 >nul & start http://localhost:%PORT%/"
  python -m http.server %PORT% --bind 127.0.0.1
  goto :fim
)

echo Nem Node nem Python encontrados. Abrindo o arquivo direto (a cor do fundo usara o valor fixo do CSS).
start "" "%~dp0index.html"

:fim
pause
endlocal
goto :eof

/*SERVIDOR*/
// Servidor estatico minimo: so le arquivos desta pasta e responde Range, que o Chrome exige para buscar posicao no video
const http = require('http');
const fs = require('fs');
const path = require('path');
const { exec } = require('child_process');

const raiz = process.cwd();
const tipos = {
  '.html': 'text/html; charset=utf-8',
  '.mp4': 'video/mp4',
  '.jpg': 'image/jpeg',
  '.png': 'image/png',
  '.svg': 'image/svg+xml',
  '.md': 'text/markdown; charset=utf-8',
};
let porta = Number(process.env.PORT) || 8080;

const servidor = http.createServer((req, res) => {
  let caminho;
  try {
    caminho = decodeURIComponent(new URL(req.url, 'http://local').pathname);
  } catch (err) {
    res.writeHead(400); return res.end();
  }
  if (caminho.endsWith('/')) caminho += 'index.html';
  const arquivo = path.join(raiz, caminho);
  // Impede sair da pasta do projeto com ../
  if (!arquivo.startsWith(raiz)) { res.writeHead(403); return res.end(); }

  fs.stat(arquivo, (err, info) => {
    if (err || !info.isFile()) { res.writeHead(404); return res.end('404'); }
    const tipo = tipos[path.extname(arquivo).toLowerCase()] || 'application/octet-stream';
    const base = { 'Content-Type': tipo, 'Accept-Ranges': 'bytes', 'Cache-Control': 'no-store' };
    const m = /bytes=(\d*)-(\d*)/.exec(req.headers.range || '');
    if (!m) {
      res.writeHead(200, { ...base, 'Content-Length': info.size });
      return fs.createReadStream(arquivo).pipe(res);
    }
    let ini = m[1] === '' ? info.size - Number(m[2]) : Number(m[1]);
    let fim = m[1] !== '' && m[2] !== '' ? Number(m[2]) : info.size - 1;
    ini = Math.max(0, ini);
    fim = Math.min(fim, info.size - 1);
    if (ini > fim) {
      res.writeHead(416, { 'Content-Range': `bytes */${info.size}` });
      return res.end();
    }
    res.writeHead(206, { ...base, 'Content-Length': fim - ini + 1, 'Content-Range': `bytes ${ini}-${fim}/${info.size}` });
    fs.createReadStream(arquivo, { start: ini, end: fim }).pipe(res);
  });
});

servidor.on('error', (err) => {
  // Porta ocupada (outra janela aberta): tenta a seguinte em vez de falhar
  if (err.code === 'EADDRINUSE' && porta < 8100) { porta += 1; servidor.listen(porta, '127.0.0.1'); }
  else { console.error(err.message); process.exit(1); }
});
servidor.on('listening', () => {
  const url = `http://localhost:${porta}/`;
  console.log(`Pronto: ${url}`);
  // SEM_NAVEGADOR=1 permite testar o servidor sem abrir janela
  if (!process.env.SEM_NAVEGADOR) exec(`start "" ${url}`);
});
servidor.listen(porta, '127.0.0.1');
