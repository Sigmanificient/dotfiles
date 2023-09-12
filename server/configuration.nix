{ ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.cleanTmpDir = true;
  zramSwap.enable = true;
  networking.hostName = "SigServer";

  networking.domain = "";

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKVVrEl8ssTf4GcObE4MVlKRlzI3Ok7NX3unSv+TPrLG edhyjox@gmail.com''
    ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMEIMRXQMnaP08FgRGXEpgX9oDADom5h+xjAnEgLNCXF clement2104.boillot@gmail.com''
  ];
}

