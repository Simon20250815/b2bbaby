/// <reference path="../.astro/types.d.ts" />
interface ImportMetaEnv {
  readonly DIRECTUS_URL: string;
}

interface ImportMeta {
  readonly env: ImportMetaEnv;
}
