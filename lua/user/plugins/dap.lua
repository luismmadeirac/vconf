return function()
  local dap = require("dap")
  local dapui = require("dapui")

  dapui.setup({
    floating = {
      border = "single",
    },
  })

  dap.listeners.after.event_initialized["user_dapui"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["user_dapui"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["user_dapui"] = function()
    dapui.close()
  end

  dap.adapters.go = {
    type = "server",
    port = "${port}",
    executable = {
      command = "dlv",
      args = { "dap", "-l", "127.0.0.1:${port}" },
    },
  }

  dap.configurations.go = {
    {
      type = "go",
      name = "Debug file",
      request = "launch",
      program = "${file}",
    },
    {
      type = "go",
      name = "Debug package",
      request = "launch",
      program = "${workspaceFolder}",
    },
    {
      type = "go",
      name = "Debug test",
      request = "launch",
      mode = "test",
      program = "${file}",
    },
  }

  dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = "js-debug-adapter",
      args = { "${port}" },
    },
  }

  local node_filetypes = {
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
  }

  for _, filetype in ipairs(node_filetypes) do
    dap.configurations[filetype] = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch current file",
        cwd = "${workspaceFolder}",
        program = "${file}",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach to process",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
    }
  end
end
