# Development Containers

## Prerequisites

1. Git working with your github credentials
2. A working docker environement

## Docker auth for ghcr.io

> [!NOTE]
> If you already have a token with `read:packages` rights (like for npm), you can reuse it here instead of creating a new one.

1. Create a classic token on [Github](https://github.com/settings/tokens). With the `read:packages` rights.
2. Run the query below in your terminal to gain access to our Package registry from docker.

```shell
export CR_PAT=YOUR_TOKEN
echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin
```

## Going further

### Dotfiles

If you are using vscode, you can make use of the so called [Dotfiles](https://code.visualstudio.com/docs/devcontainers/containers#_personalizing-with-dotfile-repositories).

Go to your VS Code's User Settings in json and add your repository as follow:

```json
{
  ...
  "dotfiles.repository": "your-github-id/your-dotfiles-repo",
  "dotfiles.targetPath": "~/dotfiles",
  "dotfiles.installCommand": "install.sh"
}
```

This will the dotfiles to customize as you want your devcontainer environment.

> [!CAUTION]
> Never EVER commit credentials in your repository!!

### Stow

Stow will create symlink of all the files and directory to the destination.
This comes handy when you want to replicate your dotfiles structure into
your devcontainer.

Example of install.sh:

```bash
stow --target "$HOME" --dir home .
```

This will symlink in your `$HOME` all the files in the `home/` directory of your
repository.
