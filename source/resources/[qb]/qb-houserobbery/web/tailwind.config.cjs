/** @type {import('tailwindcss').Config} */
const config = {
  content: ["./src/**/*.{html,js,svelte,ts}"],
  theme: {
    extend: {
      fontFamily: {
        'bebas-neue': ["Bebas Neue, 'cursive'"]
      }
    },
  },

  plugins: [],
};

module.exports = config;
