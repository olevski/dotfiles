return {
  {
    "catppuccin/nvim",
    opts = {
      color_overrides = {
        -- The stuff below makes it so that the mocha background is just black
        mocha = {
          base = "#000000",
        },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
