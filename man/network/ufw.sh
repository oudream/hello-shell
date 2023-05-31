ufw status
ufw allow 80
ufw allow 8080
ufw allow 6379
ufw allow 7000
ufw allow 6022
ufw allow 6590
ufw allow 6591
ufw allow 6122
ufw allow 6510
ufw allow 6511
ufw allow 6222
ufw allow 6520
ufw allow 6521
ufw allow 6322
ufw allow 6530
ufw allow 6531
ufw allow 6422
ufw allow 6540
ufw allow 6541
ufw allow 6522
ufw allow 6550
ufw allow 6551
ufw allow 6622
ufw allow 6560
ufw allow 6561
ufw allow 6722
ufw allow 6570
ufw allow 6571
ufw allow 3389
ufw reload

6022,6590,6591,6122,6510,6511,6222,6520,6521,6322,6530,6531
3389,6422,6522,6540,6541,6550,6551,6622,6560,6561,6722,6570,6571

ufw allow 22
ufw allow 6015
ufw reload

#Usage: ufw COMMAND
#
#Commands:
# enable                          enables the firewall
# disable                         disables the firewall
# default ARG                     set default policy
# logging LEVEL                   set logging to LEVEL
# allow ARGS                      add allow rule
# deny ARGS                       add deny rule
# reject ARGS                     add reject rule
# limit ARGS                      add limit rule
# delete RULE|NUM                 delete RULE
# insert NUM RULE                 insert RULE at NUM
# route RULE                      add route RULE
# route delete RULE|NUM           delete route RULE
# route insert NUM RULE           insert route RULE at NUM
# reload                          reload firewall
# reset                           reset firewall
# status                          show firewall status
# status numbered                 show firewall status as numbered list of RULES
# status verbose                  show verbose firewall status
# show ARG                        show firewall report
# version                         display version information
#
#Application profile commands:
# app list                        list application profiles
# app info PROFILE                show information on PROFILE
# app update PROFILE              update PROFILE
# app default ARG                 set default application policy
