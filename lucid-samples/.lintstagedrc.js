module.exports = {
  '*.{css}': 'stylelint',
  '*.{js,jsx,json,tsx}': 'eslint',
  '*.{ts,tsx}': () => 'yarn check-types',
};
