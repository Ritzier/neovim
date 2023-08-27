return function()
  require("overseer").setup({
    strategy = {
      "toggleterm",
      use_shell = false,
      direction = "float",
      highlights = nil,
      auto_scroll = nil,
      close_on_exit = false,
      open_on_start = true,
      hidden = false,
    },

    templates = { "plugins.overseer.templates" },

    auto_detect_success_color = true,

    dap = true,

    task_list = {
      default_detail = 1,
      max_width = { 100, 0.2 },
      min_width = { 40, 0.1 },
      width = nil,
      separator = "────────────────────────────────────────",
      direction = "left",
      bindings = {
        ["?"] = "showhelp",
        ["<cr>"] = "runaction",
        ["<c-e>"] = "edit",
        ["o"] = "open",
        ["<c-v>"] = "openvsplit",
        ["<c-s>"] = "opensplit",
        ["<c-f>"] = "openfloat",
        ["<c-q>"] = "openquickfix",
        ["p"] = "togglepreview",
        ["<c-l>"] = "increasedetail",
        ["<c-h>"] = "decreasedetail",
        ["l"] = "increasealldetail",
        ["h"] = "decreasealldetail",
        ["["] = "decreasewidth",
        ["]"] = "increasewidth",
        ["{"] = "prevtask",
        ["}"] = "nexttask",
      },
    },

    action = {},

    form = {
      border = "rounded",
      zindex = 40,
      min_width = 80,
      max_width = 0.9,
      width = nil,
      min_height = 10,
      max_height = 0.9,
      height = nil,
      win_opts = {
        winblend = 10,
      },
    },

    task_launcher = {
      bindings = {
        i = {
          ["<c-s>"] = "submit",
          ["<c-c>"] = "cancel",
        },
        n = {
          ["<cr>"] = "submit",
          ["<c-s>"] = "submit",
          ["q"] = "cancel",
          ["?"] = "showhelp",
        },
      },
    },

    task_editor = {
      -- set keymap to false to remove default behavior
      -- you can add custom keymaps here as well (anything vim.keymap.set accepts)
      bindings = {
        i = {
          ["<cr>"] = "nextorsubmit",
          ["<c-s>"] = "submit",
          ["<tab>"] = "next",
          ["<s-tab>"] = "prev",
          ["<c-c>"] = "cancel",
        },
        n = {
          ["<cr>"] = "nextorsubmit",
          ["<c-s>"] = "submit",
          ["<tab>"] = "next",
          ["<s-tab>"] = "prev",
          ["q"] = "cancel",
          ["?"] = "showhelp",
        },
      },
    },

    -- configure the floating window used for confirmation prompts
    confirm = {
      border = "rounded",
      zindex = 40,
      -- dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      -- min_x and max_x can be a single value or a list of mixed integer/float types.
      min_width = 20,
      max_width = 0.5,
      width = nil,
      min_height = 6,
      max_height = 0.9,
      height = nil,
      -- set any window options here (e.g. winhighlight)
      win_opts = {
        winblend = 10,
      },
    },

    -- configuration for task floating windows
    task_win = {
      -- how much space to leave around the floating window
      padding = 2,
      border = "rounded",
      -- set any window options here (e.g. winhighlight)
      win_opts = {
        winblend = 10,
      },
    },

    -- aliases for bundles of components. redefine the builtins, or create your own.
    component_aliases = {
      -- most tasks are initialized with the default components
      default = {
        { "display_duration", detail_level = 2 },
        "on_output_summarize",
        "on_exit_set_status",
        "on_complete_notify",
        "on_complete_dispose",
      },
      -- tasks from tasks.json use these components
      default_vscode = {
        "default",
        "on_result_diagnostics",
        "on_result_diagnostics_quickfix",
      },
    },

    bundles = {
      save_task_opts = {
        bundleable = true,
      },
    },

    preload_components = {},
    -- controls when the parameter prompt is shown when running a template
    --   always    show when template has any params
    --   missing   show when template has any params not explicitly passed in
    --   allow     only show when a required param is missing
    --   avoid     only show when a required param with no default value is missing
    --   never     never show prompt (error if required param missing)
    default_template_prompt = "allow",
    template_timeout = 3000,
    template_cache_threshold = 100,

    log = {
      {
        type = "echo",
        level = vim.log.levels.warn,
      },
      {
        type = "file",
        filename = "overseer.log",
        level = vim.log.levels.warn,
      },
    },

  })
end
