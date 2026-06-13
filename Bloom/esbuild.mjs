import * as esbuild from "esbuild";

await esbuild.build({
  entryPoints: ["app.jsx", "app.css"],
  bundle: true,
  minify: true,
  sourcemap: true,
  outdir: "out",
});
