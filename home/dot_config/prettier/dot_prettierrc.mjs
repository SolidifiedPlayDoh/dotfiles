/**
 * @see https://prettier.io/docs/configuration
 * @type {import("prettier").Config}
 */
const config = {
  printWidth: 80,
  tabWidth: 2,
  useTabs: false,
  semi: true,
  quoteProps: 'as-needed',
  trailingComma: 'es5',
  singleQuote: true,
  bracketSpacing: true,
  arrowParens: 'always',
  proseWrap: 'preserve',
  endOfLine: 'lf',
  plugins: ['prettier-plugin-toml'],
  overrides: [
    {
      files: ['*.json', '*.jsonc'],
      options: {
        singleQuote: false,
        trailingComma: 'none',
      },
    },
    {
      files: ['*.py'],
      options: {
        tabWidth: 4,
      },
    },
  ],
};

export default config;
