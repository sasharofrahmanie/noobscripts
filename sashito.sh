#!/bin/bash

# colors
BANNER="\e[91m"
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
LPURP='\033[1;36m'
NC='\033[0m'

printf "\n${BANNER}███████╗ █████╗ ███████╗██╗  ██╗██╗████████╗ ██████╗ 
██╔════╝██╔══██╗██╔════╝██║  ██║██║╚══██╔══╝██╔═══██╗
███████╗███████║███████╗███████║██║   ██║   ██║   ██║
╚════██║██╔══██║╚════██║██╔══██║██║   ██║   ██║   ██║
███████║██║  ██║███████║██║  ██║██║   ██║   ╚██████╔╝
╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝   ╚═╝    ╚═════╝ 
                                                     \n${NC}"

if [ "$#" -eq 0 ]; then
	echo "Usage: ${0} [options] [target (IP/Domain/File)]"
	echo -e "-s\tsingle target (eg. ${0} -s [192.168.0.1/example.com])"
	echo -e "-f\tmultiple targets in file (eg. ${0} -f targets.txt)"
fi

while getopts "hs:f:" opt; do
	case $opt in
		h)
			echo "Usage: ${0} [options] [target (IP/Domain/File)]"
			echo -e "-s\tsingle target (eg. ${0} -s [192.168.0.1/example.com])"
			echo -e "-f\tmultiple targets in file (eg. ${0} -f targets.txt)"
			;;
		s)
			# single target
			st=${OPTARG}

			# all ports scan
			printf "${YELLOW}[*] Doing all ports scan...\n${NC}"
			sudo nmap -p- -Pn --open --min-rate 10000 -oN "$(pwd)/${st}_full.nmap" ${st} -vv
			printf "${GREEN}[+] All ports scan Done. Saved output to $(pwd)/${st}_full.nmap. Onto the next!!\n${NC}"
			printf "${LPURP}======================================================================================\n${NC}"

			# udp top 100 scan
			printf "${YELLOW}[*] Doing udp top 100 scan...\n${NC}"
			sudo nmap -sU --top-ports 100 --min-rate 10000 -Pn -oN "$(pwd)/${st}_udp.nmap" ${st} -vv
			printf "${GREEN}[+] udp top 100 scan Done.  Saved output to $(pwd)/${st}_udp.nmap. Onto the next!!\n${NC}"
			printf "${LPURP}======================================================================================\n${NC}"

			# script scan on found ports
			printf "${YELLOW}[*] Doing all open ports scan with defaul scripts...\n${NC}"
			sudo nmap -p $(cat "$(pwd)/${st}_full.nmap" | grep open | grep tcp | awk -F'/' '{print $1}' | tr '\n' ',' | sed 's/.$//') -Pn --open -sC -sV -oN "$(pwd)/${st}_scripts.nmap" ${st} -vv
			printf "${GREEN}[+] all open ports scan with defaul script Done. Saved output to $(pwd)/${st}_scripts.nmap\n${NC}"
			;;
		f)
			file=${OPTARG}
			for tf in $(cat "${file}")
			do
				# all ports scan
				printf "${YELLOW}[*] Doing all ports scan on ${tf}...\n${NC}"
				sudo nmap -p- -Pn --open --min-rate 10000 -oN "$(pwd)/${tf}_full.nmap" ${tf} -vv
				printf "${GREEN}[+] All ports scan Done. Saved output to $(pwd)/${tf}_full.nmap. Onto the next!!\n${NC}"
				printf "${LPURP}======================================================================================\n${NC}"

				# udp top 100 scan
				printf "${YELLOW}[*] Doing udp top 100 scan on ${tf}...\n${NC}"
				sudo nmap -sU --top-ports 100 --min-rate 10000 -Pn -oN "$(pwd)/${tf}_udp.nmap" ${tf} -vv
				printf "${GREEN}[+] udp top 100 scan Done.  Saved output to $(pwd)/${tf}_udp.nmap. Onto the next!!\n${NC}"
				printf "${LPURP}======================================================================================\n${NC}"

				# script scan on found ports
				printf "${YELLOW}[*] Doing all open ports scan with defaul scripts on ${tf}...\n${NC}"
				sudo nmap -p $(cat "$(pwd)/${tf}_full.nmap" | grep open | grep tcp | awk -F'/' '{print $1}' | tr '\n' ',' | sed 's/.$//') -Pn --open -sC -sV -oN "$(pwd)/${tf}_scripts.nmap" ${tf} -vv
				printf "${GREEN}[+] all open ports scan with defaul script Done. Saved output to $(pwd)/${tf}_scripts.nmap\n${NC}"
			done
			;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			echo "Use -h for help menu"
			exit 1
			;;
	esac
done