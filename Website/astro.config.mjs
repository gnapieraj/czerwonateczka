import { defineConfig } from "astro/config";
import sitemap from "@astrojs/sitemap";

export default defineConfig({
  site: "https://colgante.pl",
  integrations: [sitemap()],
  output: "static",
  trailingSlash: "always",
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
