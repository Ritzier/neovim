local opt = {
  cmd = { "gopls", "remore=auto" },
  settings = {
    gopls = {
      usePlaceHolder = true,
      analyses = {
        nilness = true,
        shadow = true,
        unusedparms = true,
        unuserwrites = true,
      }
    }
  }
}

return opt
