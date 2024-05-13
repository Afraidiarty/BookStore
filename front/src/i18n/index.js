import { createI18n } from "vue-i18n";
import en from "./en.json";
import ua from "./ua.json";

const defaultLocale = "en";
const fallbackLocale = "ua";

export default createI18n({
  locale: defaultLocale,
  fallbackLocale: fallbackLocale,
  messages: { en, ua },
  legacy: false,
  globalInjection: true,
});
