{ ... }:
{
  enable = true;

  enableCompletion = true;
  enableVteIntegration = true;

  shellAliases = {
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";

    ls = "ls --color=auto";
    ll = "ls -l";

    dodo = "shutdown now";

    bashrcExtra = builtins.readFile ./../../.bashrc;
  };
}
