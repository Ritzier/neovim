local opt = {
  single_file = true,
  args = {
    "--background-index",
    "--pch-storage=memory",
    "--clang-tidy",
    "--suggest-missing-includes",
  }
}

return opt
