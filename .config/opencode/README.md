# Symlinking Dotfiles for OpenCode

To symlink your dotfiles for OpenCode, follow these instructions:

1. Make sure your source dotfiles are located in:
   - `~/dotfiles/.config/opencode/agents`
   - `~/dotfiles/.config/opencode/commands`

2. Symlink these directories into your user configuration:

   ```bash
   cd ~
   ln -s ../../dotfiles/.config/opencode/agents .config/opencode/agents
   ln -s ../../dotfiles/.config/opencode/commands .config/opencode/commands
   ln -s ../../dotfiles/.config/opencode/opencode.json .config/opencode/opencode.json
   ```

   (If your setup is different, adjust the relative paths accordingly.)

3. After symlinking, verify they are set up:

   ```bash
   ls -l .config/opencode
   ```
   You should see lines similar to:
   ```
   agents -> ../../dotfiles/.config/opencode/agents
   commands -> ../../dotfiles/.config/opencode/commands
   ```

This will ensure OpenCode uses your custom agents and commands from your dotfiles configuration.
