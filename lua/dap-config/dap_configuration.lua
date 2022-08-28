local function setup(languages)
  for _, lang in ipairs(languages) do
    require("dap-config.server." .. lang)
  end
end

return setup
