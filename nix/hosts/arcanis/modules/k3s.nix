{...}: {
  boot.kernelModules = ["br_netfilter" "overlay"];

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
    "net.bridge.bridge-nf-call-iptables" = 1;
    "net.bridge.bridge-nf-call-ip6tables" = 1;
  };

  services.k3s.enable = true;
  services.k3s.role = "server";
  systemd.tmpfiles.rules = [
    "d /home/samantha/.kube 0750 samantha users -"
  ];

  services.k3s.extraFlags = toString [
    "--write-kubeconfig=/home/samantha/.kube/config"
    "--write-kubeconfig-mode=0644"
    "--disable=traefik"
  ];
}
