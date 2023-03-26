# Scripts i wrote poorly that i called them noob
## lazy_nmap.sh
### Doing nmap scan the way i wanted!!

**Note!!!**
- If you have nmap installed, you good.
- Only take 1 IP address/domain as the input. I might rewrite to accept multiple IPs/domains later in the future (we'll see).

Usage:
```bash
$ ./lazy_nmap.sh [IP_ADDRESS/Domain]
```

## sashito.sh
### Just like `lazy_nmap.sh` but this one is better (i guess)

This script only requires Nmap. So if you already have Nmap installed then you're good!

What it does?
1. Scan for all ports
2. Scan for top 100 udp ports
3. Scan all found (tcp) ports with default scripts

Usage:
```bash
$ ./sashito.sh -h

███████╗ █████╗ ███████╗██╗  ██╗██╗████████╗ ██████╗
██╔════╝██╔══██╗██╔════╝██║  ██║██║╚══██╔══╝██╔═══██╗
███████╗███████║███████╗███████║██║   ██║   ██║   ██║
╚════██║██╔══██║╚════██║██╔══██║██║   ██║   ██║   ██║
███████║██║  ██║███████║██║  ██║██║   ██║   ╚██████╔╝
╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝   ╚═╝    ╚═════╝

Usage: ./sashito.sh [options] [target (IP/Domain/File)]
-s      single target (eg. ./sashito.sh -s [192.168.0.1/example.com])
-f      multiple targets in file (eg. ./sashito.sh -f targets.txt)
```

Example:
```bash
# single target
$ ./sashito.sh -s 10.10.10.100

# multiple targets (from file)
$ ./sashito.sh -f targets.txt
```

Alternatively, you can move the script to `/usr/local/bin` to make your job much more easier!
```bash
$ chmod +x sashito.sh
$ mv sashito.sh /usr/local/bin/sashito
```
