import * as esbuild from 'esbuild'

await esbuild.build({
    entryPoints: ['app.jsx'],
    bundle: true,
    minify: true,
    sourcemap: true,
    outfile: 'out.js',
})