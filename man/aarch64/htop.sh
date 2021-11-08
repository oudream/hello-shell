
# save htop output to file
# https://archlinux.pkgs.org/rolling/archlinux-community-aarch64/
echo q | htop -p 788 | aha --black --line-fix > htop`date +"%Y-%m-%d-%H-%M-%S"`.html