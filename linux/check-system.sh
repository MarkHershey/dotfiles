#!/usr/bin/env bash

next() {
    printf "%-70s\n" "-" | sed 's/\s/-/g'
}

check_internet_connection() {
    if ping -c 1 google.com &> /dev/null; then
        return 1
    else
        return 0
    fi
}

get_human_readable_uptime() {
    local uptime_seconds
    uptime_seconds=$(cut -d " " -f 1 /proc/uptime)
    uptime_seconds=${uptime_seconds%.*}  # Convert to integer
    
    local seconds=$((uptime_seconds % 60))
    local minutes=$((uptime_seconds / 60 % 60))
    local hours=$((uptime_seconds / 3600 % 24))
    local days=$((uptime_seconds / 86400))
    
    local uptime_string=""
    
    if [ "$days" -gt 0 ]; then
        uptime_string+="${days}d "
    fi
    
    if [ "$hours" -gt 0 ]; then
        uptime_string+="${hours}h "
    fi
    
    if [ "$minutes" -gt 0 ]; then
        uptime_string+="${minutes}m "
    fi
    
    uptime_string+="${seconds}s"
    
    echo "$uptime_string"
}

get_timezone() {
    local timezone
    if [ -f /etc/timezone ]; then
        timezone=$(cat /etc/timezone)
    elif [ -h /etc/localtime ]; then
        timezone=$(readlink /etc/localtime | sed 's|.*/zoneinfo/||')
    else
        timezone=$(date +%Z)
    fi
    echo "$timezone"
}

case $(uname) in
    'Darwin') 
        OS='macOS'
        ;;
    'Linux')
        OS='Linux'
        # get system information
        kernel_version=$( uname -r )
        distro=$( echo $(grep '^NAME=' /etc/*-release | cut -d'=' -f2 | tr -d '"')  $(grep '^VERSION=' /etc/*-release | cut -d'=' -f2 | tr -d '"') )
        timezone=$( get_timezone )
        timestamp=$( date +"%Y-%m-%d %T" )
        cpu_name=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo | sed 's/^[ \t]*//;s/[ \t]*$//' )
        cpu_cores=$( awk -F: '/processor/ {core++} END {print core}' /proc/cpuinfo )
        arch=$( uname -m )
        total_mem=$( free -g | awk '/^Mem:/ {print $2}' )
        available_mem=$( free -g | awk '/^Mem:/ {print $7}' )
        total_space=$( df -h --total | grep 'total' | awk '{print $2}' )
        free_space=$( df -h --total | grep 'total' | awk '{print $4}' )
        num_users=$( awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l )
        all_users=$( awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | tr '\n' ' ' )
        online_users=$( who | awk '{print $1}' | sort -u | tr '\n' ' ' )
        sudo_users=$( grep -Po '^sudo.+:\K.*$' /etc/group | tr ',' ' ' )
        # check if nvidia-smi is installed
        if [ -x "$(command -v nvidia-smi)" ]; then
            gpu_name=$( nvidia-smi --query-gpu=name --format=csv,noheader | uniq )
            gpu_count=$( nvidia-smi --query-gpu=count --format=csv,noheader | uniq )
            # get gpu memory total in GB (rounded)
            gpu_mem=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits | awk '{sum += $1} END {printf "%.0f\n", sum/1024}')
            gpu_driver=$( nvidia-smi --query-gpu=driver_version --format=csv,noheader | uniq )
        fi
        # get system uptime
        uptime=$( get_human_readable_uptime )
        ;;
    'FreeBSD')
        OS='FreeBSD'
        ;;
    'WindowsNT')
        OS='Windows'
        ;;
    'SunOS')
        OS='Solaris'
        ;;
    'AIX')
        OS='IBM AIX'
        ;;
    *)
        echo "Aborting: System not identified"
        exit 1
        ;;
esac

export TERM=xterm-256color

echo "System Type       : ${OS}"

if [[ $OS == 'Linux' ]]; then
    echo "System Uptime     : ${uptime}"
    echo "Linux Kernel      : ${kernel_version}"
    echo "Linux Distro      : ${distro}"
    next
    echo "CPU Model         : ${cpu_name}"
    echo "CPU Cores/Threads : ${cpu_cores}"
    echo "CPU Architecture  : ${arch}"
    echo "Total Memory      : ${total_mem}G"
    echo "Available Memory  : ${available_mem}G"
    echo "Total Storage     : ${total_space}"
    echo "Available Storage : ${free_space}"
    next
    echo "Number of Users   : ${num_users}"
    echo "All Users         : ${all_users}"
    echo "Online Users      : ${online_users}"
    echo "Previleged Users  : ${sudo_users}"
    next
    if [[ -x "$(command -v nvidia-smi)" ]]; then
        echo "GPU Model         : ${gpu_name} (x${gpu_count})"
        echo "GPU Memory        : ${gpu_mem} GB (Total)"
        echo "GPU Driver        : ${gpu_driver}"
        next
    fi

    echo "Machine Timezone  : ${timezone}"
    echo "Machine Time Now  : ${timestamp}"
    if check_internet_connection; then
        echo "Internet Access   : Not Connected"
    else
        echo "Internet Access   : Connected"
    fi
fi