return function()
  local neotest = require("neotest")

  neotest.setup({
    adapters = {
      require("neotest-go"),
      require("neotest-jest")({
        jestCommand = "npm test --",
        jestConfigFile = "jest.config.js",
        env = { CI = true },
        cwd = function()
          return vim.fn.getcwd()
        end,
      }),
    },
    summary = {
      open = "botright vsplit | vertical resize 50",
    },
    output = {
      open_on_run = true,
    },
    quickfix = {
      open = false,
    },
  })
end
