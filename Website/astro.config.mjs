import { defineConfig } from "astro/config";
import sitemap from "@astrojs/sitemap";

export default defineConfig({
  site: "https://colgante.pl",
  integrations: [sitemap()],
  output: "static",
  trailingSlash: "never",
  build: {
    format: "directory",
  },
  vite: {
    server: {
      fs: {
        allow: [".."],
      },
    },
  },
});
