#!/bin/bash
HOME="/home/container"
HOMEA="$HOME/linux/.apt"
STAR1="$HOMEA/lib:$HOMEA/usr/lib:$HOMEA/var/lib:$HOMEA/usr/lib/x86_64-linux-gnu:$HOMEA/lib/x86_64-linux-gnu:$HOMEA/lib:$HOMEA/usr/lib/sudo"
STAR2="$HOMEA/usr/include/x86_64-linux-gnu:$HOMEA/usr/include/x86_64-linux-gnu/bits:$HOMEA/usr/include/x86_64-linux-gnu/gnu"
STAR3="$HOMEA/usr/share/lintian/overrides/:$HOMEA/usr/src/glibc/debian/:$HOMEA/usr/src/glibc/debian/debhelper.in:$HOMEA/usr/lib/mono"
STAR4="$HOMEA/usr/src/glibc/debian/control.in:$HOMEA/usr/lib/x86_64-linux-gnu/libcanberra-0.30:$HOMEA/usr/lib/x86_64-linux-gnu/libgtk2.0-0"
STAR5="$HOMEA/usr/lib/x86_64-linux-gnu/gtk-2.0/modules:$HOMEA/usr/lib/x86_64-linux-gnu/gtk-2.0/2.10.0/immodules:$HOMEA/usr/lib/x86_64-linux-gnu/gtk-2.0/2.10.0/printbackends"
STAR6="$HOMEA/usr/lib/x86_64-linux-gnu/samba/:$HOMEA/usr/lib/x86_64-linux-gnu/pulseaudio:$HOMEA/usr/lib/x86_64-linux-gnu/blas:$HOMEA/usr/lib/x86_64-linux-gnu/blis-serial"
STAR7="$HOMEA/usr/lib/x86_64-linux-gnu/blis-openmp:$HOMEA/usr/lib/x86_64-linux-gnu/atlas:$HOMEA/usr/lib/x86_64-linux-gnu/tracker-miners-2.0:$HOMEA/usr/lib/x86_64-linux-gnu/tracker-2.0:$HOMEA/usr/lib/x86_64-linux-gnu/lapack:$HOMEA/usr/lib/x86_64-linux-gnu/gedit"
STARALL="$STAR1:$STAR2:$STAR3:$STAR4:$STAR5:$STAR6:$STAR7"
export LD_LIBRARY_PATH=$STARALL
export PATH="/bin:/usr/bin:/usr/local/bin:/sbin:$HOMEA/bin:$HOMEA/usr/bin:$HOMEA/sbin:$HOMEA/usr/sbin:$HOMEA/etc/init.d:$PATH"
export BUILD_DIR=$HOMEA

bold=$(echo -en "\e[1m")
nc=$(echo -en "\e[0m")
lightblue=$(echo -en "\e[94m")
lightgreen=$(echo -en "\e[92m")

echo "
${bold}${lightgreen}========================================================================
${bold}${lightgreen}
${bold}${lightgreen}
${bold}${lightblue} _________  ________  ________      
${bold}${lightblue}|\___   ___\\   ____\|\   ___  \    
${bold}${lightblue}\|___ \  \_\ \  \___|\ \  \\ \  \   
${bold}${lightblue}     \ \  \ \ \  \    \ \  \\ \  \  
${bold}${lightblue}      \ \  \ \ \  \____\ \  \\ \  \ 
${bold}${lightblue}       \ \__\ \ \_______\ \__\\ \__\
${bold}${lightblue}        \|__|  \|_______|\|__| \|__|
${bold}${lightgreen}
${bold}${lightgreen}
${bold}${lightgreen}========================================================================
"

echo "${nc}"

# Display container information
internal_ip=$(hostname -I | awk '{print $1}')
public_ip=$(curl -s ifconfig.me)
location=$(curl -s https://ipapi.co/json/ | jq -r '.city, .region, .country_name')

echo "${bold}${lightblue}Container Information${nc}"
echo "Internal IP: $internal_ip"
echo "Public IP: $public_ip"
echo "Location: $location"
echo ""

# Display rules
echo "${bold}${lightblue}Usage Rules:${nc}"
echo "Please adhere to the following guidelines when using this container:"
echo "- No illegal activities are allowed, including but not limited to:"
echo "  - DDoS attacks or any kind of network disruption."
echo "  - Cryptomining, including mining for Bitcoin, Ethereum, or any other cryptocurrency."
echo "  - Distribution or creation of malware, viruses, or exploits."
echo "  - Unauthorized access to systems, hacking, or penetration testing without permission."
echo "  - Hosting illegal content, such as copyrighted material, without proper rights."
echo "  - Spamming, phishing, or other forms of abusive behavior."
echo ""
echo "Failure to follow these rules will result in termination of your access."
echo ""

if [[ -f "./install.lock" ]]; then
    echo "${bold}${lightgreen}==> Installation already done. Skipping to start proot environment.${nc}"
    function runcmd1 {
        printf "${bold}${lightgreen}root${nc}@${lightblue}debian${nc}:~ "
        read -r cmdtorun
        ./libraries/proot -S . /bin/bash -c "$cmdtorun"
        runcmd
    }
    function runcmd {
        printf "${bold}${lightgreen}root${nc}@${lightblue}debian${nc}:~ "
        read -r cmdtorun
        ./libraries/proot -S . /bin/bash -c "$cmdtorun"
        runcmd1
    }
    runcmd
else
    echo "Downloading and installing required files..."
    curl -sSLo ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
    echo -ne '#                   (5%)\r'
    curl -sSLo files.zip https://github.com/RealTriassic/Ptero-VM-JAR/releases/download/latest/files.zip
    echo -ne '##                  (10%)\r'
    curl -sSLo unzip https://raw.githubusercontent.com/afnan007a/Ptero-vm/main/unzip
    echo -ne '####                (20%)\r'
    curl -sSLo gotty https://raw.githubusercontent.com/afnan007a/Replit-Vm/main/gotty
    echo -ne '#####               (25%)\r'
    chmod +x unzip >/dev/null 2>err.log
    export PATH="/bin:/usr/bin:/usr/local/bin:/sbin:$HOMEA/bin:$HOMEA/usr/bin:$HOMEA/sbin:$HOMEA/usr/sbin:$HOMEA/etc/init.d:$PATH"
    ./unzip ngrok.zip >/dev/null 2>err.log
    echo -ne '######               (30%)\r'
    ./unzip files.zip >/dev/null 2>err.log
    echo -ne '#######              (35%)\r'
    ./unzip root.zip >/dev/null 2>err.log
    tar -xf root.tar.gz >/dev/null 2>err.log
    echo -ne '########             (40%)\r'
    chmod +x ./libraries/proot >/dev/null 2>err.log
    echo -ne '#########            (45%)\r'
    chmod +x ngrok >/dev/null 2>err.log
    echo -ne '##########           (50%)\r'
    chmod +x gotty >/dev/null 2>err.log
    echo -ne '###########          (55%)\r'
    rm -rf files.zip >/dev/null 2>err.log
    rm -rf root.zip >/dev/null 2>err.log
    rm -rf root.tar.gz >/dev/null 2>err.log
    rm -rf ngrok.zip >/dev/null 2>err.log
    echo -ne '############         (60%)\r'

    cmds=("mv gotty /usr/bin/" "mv unzip /usr/bin/" "mv ngrok /usr/bin/" "apt-get update" "apt-get -y upgrade" "apt-get -y install sudo curl wget hwloc htop nano neofetch python3-pip nodejs speedtest-cli" "curl -o /bin/systemctl https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py")

    for cmd in "${cmds[@]}"; do
        ./libraries/proot -S . /bin/bash -c "$cmd >/dev/null 2>err.log"
    done
    echo -ne '####################(100%)\r'
    echo -ne '\n'

    # Create install.lock to prevent reinstallation
    touch install.lock

    echo "
${bold}${lightgreen}========================================================================
${bold}${lightgreen}
${bold}${lightgreen}
${bold}${lightblue} _________  ________  ________      
${bold}${lightblue}|\___   ___\\   ____\|\   ___  \    
${bold}${lightblue}\|___ \  \_\ \  \___|\ \  \\ \  \   
${bold}${lightblue}     \ \  \ \ \  \    \ \  \\ \  \  
${bold}${lightblue}      \ \  \ \ \  \____\ \  \\ \  \ 
${bold}${lightblue}       \ \__\ \ \_______\ \__\\ \__\
${bold}${lightblue}        \|__|  \|_______|\|__| \|__|
${bold}${lightgreen}
${bold}${lightgreen}
${bold}${lightgreen}========================================================================
"
    runcmd
fi
