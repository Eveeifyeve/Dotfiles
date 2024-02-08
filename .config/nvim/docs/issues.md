









# Fzf-native Architecture Issue on macOS Apple Sillcon.

If you're experiencing issues with the Fuzzy finder on macOS, you can try the following steps to resolve it:

1. Navigate to the `telescope-fzf-native.nvim` directory in your Neovim configuration:


```bash
 cd ~/.local/share/nvim/lazy/telescope-fzf-native.nvim    
```

2. Run the following commands to clean and rebuild the project:

```bash
cmake clean & cmake
```


This should resolve the Fuzzy finder issue. If the problem persists, please open a github issue.
