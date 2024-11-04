{ pkgs, ... }:

{
  plugins.cmp = {
    enable = true;
    autoEnableSources = true;
    settings = {
      sources = [
        { name = "nvim_lsp"; }
        { name = "nvim_lsp_signature_help"; }
        { name = "nvim_lsp_document_symbol"; }
        { name = "luasnip"; }
        { name = "path"; }
        { name = "buffer"; }
        { name = "cmdline"; }
        { name = "spell"; }
        { name = "dictionary"; }
        { name = "treesitter"; }
      ];
      mapping = {
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-e>" = "cmp.mapping.close()";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
      };
    };
  };
  plugins.cmp-buffer.enable = true;
  plugins.cmp-nvim-lsp.enable = true;
  plugins.cmp-path.enable = true;
  plugins.cmp_luasnip.enable = true;
}
