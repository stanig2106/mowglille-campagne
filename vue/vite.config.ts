// Plugins
import vue from '@vitejs/plugin-vue'
import vuetify, {transformAssetUrls} from 'vite-plugin-vuetify'
import ViteFonts from 'unplugin-fonts/vite'
import {VitePWA} from 'vite-plugin-pwa'
import {terser} from 'rollup-plugin-terser'
import obfuscator from 'rollup-plugin-obfuscator';


import fs from 'fs'

// Utilities
import {defineConfig} from 'vite'
import {fileURLToPath, URL} from 'node:url'

// https://vitejs.dev/config/
export default defineConfig({
  build: {
    chunkSizeWarningLimit: 1200,
    rollupOptions: {
      plugins: [

        terser({
          compress: {
            drop_console: ["log"],
          }
        }) as any,
      ],
      output: {
        manualChunks(id, api) {
          if (id.includes('node_modules/p5'))
            return 'p5';
          if (id.includes('node_modules/simple-keyboard'))
            return 'simple-keyboard';
          if (id.includes('node_modules/qrious'))
            return 'qrious';
          if (id.includes('node_modules'))
            return 'vendor';
          return "bundle"
        }
      }
    }
  },
  plugins: [
    VitePWA({
      workbox: {
        maximumFileSizeToCacheInBytes: 10_000_000, // 10MB
        globPatterns: [
          "**/*"
        ],
        globDirectory: 'dist/',
      }
    }),
    vue({
      template: {transformAssetUrls},
    }),
    // https://github.com/vuetifyjs/vuetify-loader/tree/master/packages/vite-plugin#readme
    vuetify({
      autoImport: true,
    }),
    ViteFonts({
      google: {
        families: [
          {
            name: 'Roboto',
            styles: 'wght@100;300;400;500;700;900',
          },
        ],
      },
    }),
  ],
  define: {
    'process.env': {
      DEV: process.env.NODE_ENV !== 'production',
    }
  },
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
    },
    extensions: ['.js', '.json', '.jsx', '.mjs', '.ts', '.tsx', '.vue'],
  },
  server: {
    port: 3005,
  },
})
