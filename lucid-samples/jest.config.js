module.exports = {
  moduleNameMapper: {
    '^@/(.*)$': '<rootDir>/src/$1',
  },
 transform: {
    "^.+\\.(ts|tsx|js)$": "ts-jest"
 },
  testMatch: ['<rootDir>/src/**/*.spec.{js,jsx,ts,tsx}'],
  collectCoverage: true,
  coverageDirectory: './coverage',
  collectCoverageFrom: [
    'src/**/*.{js,jsx,ts,tsx}',
  ],
  globals: {
    'ts-jest': {
      isolatedModules: true,
      useESM: true,
    },
  },
  extensionsToTreatAsEsm: [".ts"],
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
    },
  },
};
