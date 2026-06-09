import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'Mac Frontend Developer Setup',
  description:
    'Modular Bash scripts that bootstrap a macOS development environment — Node.js, TypeScript, React Native, databases, productivity apps and more.',

  // Served at https://allanasp.github.io/Setup-Developer-Mac/
  base: '/Setup-Developer-Mac/',

  cleanUrls: true,
  lastUpdated: true,
  ignoreDeadLinks: true,

  head: [
    ['meta', { name: 'theme-color', content: '#bd93f9' }],
    ['meta', { property: 'og:type', content: 'website' }],
    ['meta', { property: 'og:title', content: 'Mac Frontend Developer Setup' }],
    [
      'meta',
      {
        property: 'og:description',
        content:
          'Modular Bash scripts that bootstrap a macOS development environment.',
      },
    ],
  ],

  themeConfig: {
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Start Here', link: '/start-here' },
      {
        text: 'Reference',
        items: [
          { text: 'Script Guide', link: '/script-guide' },
          { text: 'Tools Guide', link: '/tools-guide' },
          { text: 'Setup Checker', link: '/setup-checker' },
          { text: 'Post-Installation', link: '/post-installation' },
        ],
      },
      { text: 'Credits', link: '/credits' },
    ],

    sidebar: [
      {
        text: 'Getting Started',
        collapsed: false,
        items: [
          { text: 'Start Here', link: '/start-here' },
          { text: 'Post-Installation', link: '/post-installation' },
        ],
      },
      {
        text: 'Reference',
        collapsed: false,
        items: [
          { text: 'Script Guide', link: '/script-guide' },
          { text: 'Tools Guide', link: '/tools-guide' },
          { text: 'Setup Checker', link: '/setup-checker' },
        ],
      },
      {
        text: 'About',
        collapsed: false,
        items: [{ text: 'Credits & Attribution', link: '/credits' }],
      },
    ],

    socialLinks: [
      {
        icon: 'github',
        link: 'https://github.com/allanasp/Setup-Developer-Mac',
      },
    ],

    editLink: {
      pattern:
        'https://github.com/allanasp/Setup-Developer-Mac/edit/main/docs/:path',
      text: 'Edit this page on GitHub',
    },

    search: {
      provider: 'local',
    },

    footer: {
      message: 'Released under the MIT License.',
      copyright: 'Made with ❤️ for the developer community',
    },
  },
})
