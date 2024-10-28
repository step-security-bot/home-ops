# Edit this configuration file to manage nfs server.

{ config, pkgs, ... }:

{
  # Enable NFS server
  # https://nixos.wiki/wiki/NFS

  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /export/home/nils       192.168.1.20(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=1000,anongid=100) 192.168.1.10(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=1001,anongid=100) 192.168.1.12(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=1001,anongid=100)
    /export/home/jasmin     192.168.1.20(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=1000,anongid=100) 192.168.1.10(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=1001,anongid=100) 192.168.1.12(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=1001,anongid=100)
    /export/backup/nils     192.168.1.20(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=1000,anongid=100) 192.168.1.10(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=1001,anongid=100) 192.168.1.12(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=1001,anongid=100)
    /export/backup/jasmin   192.168.1.20(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=1000,anongid=100) 192.168.1.10(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=1001,anongid=100) 192.168.1.12(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=1001,anongid=100)
    /export/data/csi        192.168.1.51(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=1004,anongid=100) 192.168.1.52(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=1004,anongid=100) 192.168.1.53(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=1004,anongid=100) 192.168.1.54(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=1004,anongid=100) 192.168.1.55(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=1004,anongid=100)
    /export/data/downloads  192.168.1.10(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=65534,anongid=65534) 192.168.1.11(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=65534,anongid=65534) 192.168.1.12(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=65534,anongid=65534) 192.168.1.51(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=65534,anongid=65534) 192.168.1.52(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=65534,anongid=65534) 192.168.1.53(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=65534,anongid=65534) 192.168.1.54(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=65534,anongid=65534) 192.168.1.55(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=65534,anongid=65534)
  '';
}
