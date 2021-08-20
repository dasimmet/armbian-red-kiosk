#!/usr/bin/env bash

main(){
POSITIONAL=()
URL="http://localhost:1880/ui"
while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    -l|--lib)
      LIBPATH="$2"
      shift # past argument
      shift # past value
      ;;
    -u|--url)
      URL="$2"
      shift # past argument
      shift # past value
      ;;
    --default)
      DEFAULT=YES
      shift # past argument
      ;;
    *)    # unknown option
      POSITIONAL+=("$1") # save it in an array for later
      shift # past argument
      ;;
  esac
done

# set -- "${POSITIONAL[@]}" # restore positional parameters

if [[ $(type -t my_"${POSITIONAL[@]}") == function ]]; then
    my_"${POSITIONAL[@]}"
else
    echo "Invalid command"
fi
}

my_install_nodeps(){
    set -x
    echo $URL
    npm install
    install -m 644 src/Xwrapper.config /etc/X11/Xwrapper.config
    my_envsubst src/kiosk.sh /bin/kiosk.sh
    chmod 755 /bin/kiosk.sh
    install -m 644 src/kiosk.service /etc/systemd/system/kiosk.service
    my_envsubst src/nodered.service /etc/systemd/system/nodered.service
    useradd -m kiosk-user
    systemctl daemon-reload
    systemctl enable kiosk.service nodered.service
    systemctl restart kiosk.service nodered.service
    set +x
}
my_deps(){
    apt-get install xorg xserver-xorg-legacy openbox chromium-browser git unclutter
}
my_install(){
    my_deps
    my_install_nodeps
}

my_envsubst(){
local SRC="$1"
local DST="$2"
eval "cat <<EOF
$(< $SRC)
EOF
" 1> $DST
}

main "$@"
