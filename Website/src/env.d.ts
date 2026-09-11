/// <reference types="astro/client" />

interface ImportMetaEnv {
  readonly PUBLIC_NEWSLETTER_FORM_ACTION?: string;
  readonly PUBLIC_NEWSLETTER_EMAIL_FIELD?: string;
  readonly PUBLIC_NEWSLETTER_NAME_FIELD?: string;
}

interface ImportMeta {
  readonly env: ImportMetaEnv;
}
