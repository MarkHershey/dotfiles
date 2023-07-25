#!/usr/bin/env bash

next() {
    printf "%-70s\n" "-" | sed 's/\s/-/g'
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
        cpu_name=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo | sed 's/^[ \t]*//;s/[ \t]*$//' )
        cpu_cores=$( awk -F: '/processor/ {core++} END {print core}' /proc/cpuinfo )
        arch=$( uname -m )
        total_mem=$( free -g | awk '/^Mem:/ {print $2}' )
        free_mem=$( free -g | awk '/^Mem:/ {print $4}' )
        total_space=$( df -h --total | grep 'total' | awk '{print $2}' )
        free_space=$( df -h --total | grep 'total' | awk '{print $4}' )
        num_users=$( awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l )
        all_users=$( awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | tr '\n' ' ' )
        online_users=$( who | awk '{print $1}' | sort -u | tr '\n' ' ' )
        # check if nvidia-smi is installed
        if [ -x "$(command -v nvidia-smi)" ]; then
            gpu_name=$( nvidia-smi --query-gpu=name --format=csv,noheader | uniq )
            gpu_count=$( nvidia-smi --query-gpu=count --format=csv,noheader | uniq )
            # get gpu memory total in GB (rounded)
            gpu_mem=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits | awk '{sum += $1} END {printf "%.0f\n", sum/1024}')
            gpu_driver=$( nvidia-smi --query-gpu=driver_version --format=csv,noheader | uniq )
        fi
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

echo "System Identified : ${OS}"

if [[ $OS == 'Linux' ]]; then
    echo "Kernel Version    : ${kernel_version}"
    next
    echo "Linux Distro      : ${distro}"
    echo "CPU Model         : ${cpu_name}"
    echo "CPU Cores         : ${cpu_cores}"
    echo "CPU Architecture  : ${arch}"
    echo "Total Memory      : ${total_mem}G"
    echo "Available Memory  : ${free_mem}G"
    echo "Total Storage     : ${total_space}"
    echo "Available Storage : ${free_space}"
    next
    echo "Number of Users   : ${num_users}"
    echo "All Users         : ${all_users}"
    echo "Online Users      : ${online_users}"
    next
    if [[ -x "$(command -v nvidia-smi)" ]]; then
        echo "GPU Model         : ${gpu_name} (x${gpu_count})"
        echo "GPU Memory        : ${gpu_mem} GB (Total)"
        echo "GPU Driver        : ${gpu_driver}"
        next
    fi
fi