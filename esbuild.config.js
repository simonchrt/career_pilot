const path = require('path');
const watch = process.argv.includes('--watch');

const esbuildOptions = {
  entryPoints: ['app/javascript/application.js'],
  bundle: true,
  sourcemap: true,
  outdir: path.join(process.cwd(), 'app/assets/builds'),
  absWorkingDir: path.join(process.cwd()),
  publicPath: '/assets',
  loader: {
    '.js': 'jsx',
    '.jsx': 'jsx'
  },
  watch: watch && {
    onRebuild(error) {
      if (error) console.error('[watch] build failed:', error);
      else console.log('[watch] build succeeded');
    },
  },
};

require('esbuild').build(esbuildOptions).catch(() => process.exit(1));
