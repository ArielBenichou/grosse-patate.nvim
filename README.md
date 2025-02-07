<div align="center">

# Grosse Patate

##### Burn less calories when coding

[![Lua](https://img.shields.io/badge/Lua-blue.svg?style=for-the-badge&logo=lua)](http://www.lua.org)
[![Neovim](https://img.shields.io/badge/Neovim%200.8+-green.svg?style=for-the-badge&logo=neovim)](https://neovim.io)
[![NodeJS](https://img.shields.io/badge/node.js-339933?style=for-the-badge&logo=Node.js&logoColor=white)](https://nodejs.org)

<img alt="Grosse Patate" src="./assets/icon.png" />

</div>

## Overview

Grosse Patate is a lightweight Neovim plugin here to make your coding experience more enjoyable. Built with Lua and backed by NodeJS and Null LS, it takes care of those repetitive tasks so you can focus on what you love. Whether you're tidying up code or squashing errors, Grosse Patate has got you covered.


## Features

**Utility Scripts:**
  - **swap-ternary.ts:** Easily swap the branches of ternary expressions to quickly adjust conditional logic.
  - **wrap-try-catch.ts:** Automatically wrap code blocks in try-catch statements for improved error handling.

## Installation

### Prerequisites

- [Neovim 0.8+](https://neovim.io)
- [Lua](http://www.lua.org)
- [NodeJS](https://nodejs.org)

### Using `lazy.nvim`

Add the following snippet to your Neovim configuration to install Grosse Patate:

```lua
{
  "ArielBenichou/grosse-patate.nvim",
  dependencies = {
    "jose-elias-alvarez/null-ls.nvim",
  },
  build = "cd engine && npm install && npm run build",
  config = function()
    require("grosse-patate").setup()
  end,
}

