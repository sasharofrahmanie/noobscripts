#!/bin/bash

# colors
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
LPURP='\033[1;35m'
NC='\033[0m'

# initial scan
printf "${LPURP}======================================================================================\n${NC}"
printf "${YELLOW}[+] Doing initial scan...\n${NC}"
sudo nmap -sC -sV -Pn --open -oN initial-scan.nmap $1 -vv
printf "${GREEN}[*] Initial scan Done. Onto the next!!\n${NC}"
printf "${LPURP}======================================================================================\n${NC}"

# all ports scan
printf "${YELLOW}[+] Doing all ports scan...\n${NC}"
sudo nmap -p- -Pn --open -oN all-ports.nmap $1 -vv
printf "${GREEN}[*] All ports scan Done. Onto the next!!\n${NC}"
printf "${LPURP}======================================================================================\n${NC}"

# udp top 100 scan
printf "${YELLOW}[+] Doing udp top 100 scan...\n${NC}"
sudo nmap -sU --top-ports 100 -Pn --open -oN udp-scan.nmap $1 -vv
printf "${GREEN}[*] udp top 100 scan Done. Onto the next!!\n${NC}"
printf "${LPURP}======================================================================================\n${NC}"

# scanning all open ports with defaul script
printf "${YELLOW}[+] Doing all open ports scan with defaul script...\n${NC}"
sudo nmap -p $(cat all-ports.nmap | grep open | grep tcp | awk -F'/' '{print $1}' | tr '\n' ',' | sed 's/.$//') -Pn --open -sC -sV -oN open-all-script.nmap $1 -vv
printf "${GREEN}[*] all open ports scan with defaul script Done. The script has finished!!\n${NC}"
printf "${LPURP}======================================================================================\n${NC}"