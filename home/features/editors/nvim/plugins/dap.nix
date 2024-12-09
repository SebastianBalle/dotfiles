{ pkgs, ... }:

{
  plugins.dap = {
    enable = true;
    adapters = { };
    signs = {
      dapBreakpoint = {
        text = "●";
        texthl = "DapBreakpoint";
      };
      dapBreakpointCondition = {
        text = "●";
        texthl = "DapBreakpointCondition";
      };
      dapLogPoint = {
        text = "◆";
        texthl = "DapLogPoint";
      };
    };
    extensions = {
      dap-go = { enable = true; };
      dap-ui = { enable = true; };
      dap-virtual-text = { enable = true; };
    };
  };
}
