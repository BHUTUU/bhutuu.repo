#!/usr/bin/env bash
CWD=$(pwd)
var1="$1"
var2="$2"
var3="$3"
#<<<-----colors----->>>#
S0="\033[1;30m" B0="\033[1;40m"
S1="\033[1;31m" B1="\033[1;41m"
S2="\033[1;32m" B2="\033[1;42m"
S3="\033[1;33m" B3="\033[1;43m"
S4="\033[1;34m" B4="\033[1;44m"
S5="\033[1;35m" B5="\033[1;45m"
S6="\033[1;36m" B6="\033[1;46m"
S7="\033[1;37m" B7="\033[1;47m"
R0="\033[00m"   R1="\033[1;00m"
#<---x--->#
addrepo() {
  apt install gnupg -yq --silent
  if [[ ! -d "$PREFIX/etc/apt/sources.list.d" ]]; then
    mkdir -p $PREFIX/etc/apt/sources.list.d
  fi
cat <<- CONF > $PREFIX/etc/apt/sources.list.d/bhutuu.repo.list
deb [trusted=yes] https://bhutuu.github.io/bhutuu.repo/ bhutuu main
CONF
  rm -rf bhutuu.key* > /dev/null 2>&1
  wget -q https://raw.githubusercontent.com/BHUTUU/bhutuu.repo/main/bhutuu.key
  apt-key add bhutuu.key
  apt-get update -yq --silent
  cp -r $PREFIX/etc/apt/trusted.gpg $PREFIX/etc/apt/trusted.gpg.d >/dev/null 2>&1
  printf "\n${S2}BHUTUU APT REPOSITORY IS SUCCESSFULLY ADDED${R0}\n"
  printf "\n\n${S6}just run '${B1}apt install PROGRAM_NAME${R1}${S6}' to install a valid program!${R0}\n"
}
rmrepo() {
  rm -rf $PREFIX/etc/apt/sources.list.d/bhutuu.repo.list > /dev/null 2>&1
  printf "\n${S2}BHUTUU APT REPOSITORY IS REMOVED FROM YOUR DEVICE${R0}\n"
}
helprepo() {
  echo -e "
  USAGE:
        -i    --install      to install bhutuu.repo in you Device.

        -r    --remove       to remove bhutuu.repo from your Device.
  "
}
main() {
  if [[ $var1 == '-i' || $var1 == '--install' ]]; then
    if [[ ! -f "$PREFIX/etc/apt/sources.list.d/bhutuu.repo.list" ]]; then
      addrepo
    else
      printf "\n${S2}[${S1}!${S2}]${S4} BHUTUU APT REPOSITORY IS ALREADY ADDED!${R0}\n"
      printf "\n\n${S6}just run '${B1}apt install PROGRAM_NAME${R1}${S6}' to install a valid program!${R0}\n"
    fi
    if [[ ! -z "${var2}" ]]; then
      apt install "${var2}" -y
    fi
  elif [[ $var1 == '-r' || $var1 == '--remove' ]]; then
    rmrepo
  else
    helprepo
  fi
}
main
