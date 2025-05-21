# the-lua-programming-language

This project gives a short overview to the caveats and specialites of the lua programming language.
It was conducted as part of the PCP lectures @ HSLU in spring semester 25.

## Setup

This section gives a short overview on how to get up and running with this projects.
The _Requirements_ reflect the versions this project was developed and tested on.

**Versions higher or lower than documented may work or not work**

### Lua Code Snippets

_Requirements_

- lua 5.2.4 or higher (https://luabinaries.sourceforge.net/download.html)

Run lua snippets:

```bash
cd snippets
lua <snippet-name>.lua
```

### Slides

_Requirements_

- node v22.14.0 or higher (https://nodejs.org/en/download)
- yarn 1.22.22 or higher (https://classic.yarnpkg.com/lang/en/docs/install/#windows-stable)
- slidev 51.6.0 (via package.json)
- lua-http v0.4 (via luarocks)

Install needed dependencies (on first use only):

```bash
cd slidev
yarn install
```

Run the slidev server:

```bash
cd slidev
yarn run dev
```

To directly run code snippets in the slides via monaco-run, start the lua-server

```bash
cd slidev/setup
luarocks install http
lua lua_server.lua
```

Slides are served on http://localhost:3030

### Report

_Requirements_

- pdfTeX 3.141592653-2.6-1.40.26 or higher (https://www.tug.org/interest.html#free)

Generate the pdf file locally:

```bash
make -C report
```

### NixOS

If you're using NixOS there is a [shell.nix](shell.nix) provided, which includes all needed tools in a dev-shell, that can be started running `use nix` in the terminal.
