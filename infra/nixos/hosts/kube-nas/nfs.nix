# Edit this configuration file to manage nfs server.

{ config, pkgs, ... }:

{
  # Enable NFS server
  # https://nixos.wiki/wiki/NFS

  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /export             192.168.1.20(rw,fsid=0,no_subtree_check)
    /export/data        192.168.1.20(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=1000,anongid=100)
    /export/home/nils   192.168.1.20(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=1000,anongid=100,dir_mode=0770,file_mode=0660)
                        192.168.1.10(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=1001,anongid=100,dir_mode=0770,file_mode=0660)
    /export/home/jasmin 192.168.1.20(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=1000,anongid=100,dir_mode=0770,file_mode=0660)
                        192.168.1.10(rw,async,no_wdelay,nohide,no_subtree_check,insecure,all_squash,insecure_locks,sec=sys,anonuid=1001,anongid=100,dir_mode=0770,file_mode=0660)
  '';
}
