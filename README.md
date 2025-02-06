<div align="center">

# Grosse Patate

##### Burn less calories when coding

[![Lua](https://img.shields.io/badge/Lua-blue.svg?style=for-the-badge&logo=lua)](http://www.lua.org)
[![Neovim](https://img.shields.io/badge/Neovim%200.8+-green.svg?style=for-the-badge&logo=neovim)](https://neovim.io)
[![NodeJS](https://img.shields.io/badge/node.js-339933?style=for-the-badge&logo=Node.js&logoColor=white)](https://nodejs.org)

<img alt="Grosse Patate" src="./assets/icon.png" />

</div>

## Installation

- install using `lazy.nvim`:

```lua
{
  "ArielBenichou/grosse-patate.nvim",
  dependencies = {
    "jose-elias-alvarez/null-ls.nvim",
  },
  build = "cd engine && npm install",
  config = function()
    require("grosse-patate").setup()
  end,
}
```
