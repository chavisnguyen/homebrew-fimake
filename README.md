# homebrew-fimake

Homebrew tap for [Fimake](https://github.com/chavisnguyen/FiMake) — an MCP server that lets AI agents read and edit your Figma documents (design-to-code, AI UI edits, no Figma AI subscription needed).

```bash
brew tap chavisnguyen/fimake
brew install fimake
fimake --version
```

Then point your MCP client at the installed binary (`command: /opt/homebrew/bin/fimake`, `env: TRANSPORT=stdio, PORT=10101`) and sideload the matching `fimake-plugin.zip` from [FiMake Releases](https://github.com/chavisnguyen/FiMake/releases) in Figma (*Plugins > Development > Import plugin from manifest*).

Upgrade:

```bash
brew update && brew upgrade fimake
```

The formula is bumped automatically on every FiMake Release — do not edit `Formula/fimake.rb` by hand.
