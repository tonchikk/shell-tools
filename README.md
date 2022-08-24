# shell-tools
Shell tools for Linux automation (CentOS and Raspbian primary)


## Verifications and one-liners

### Find Raspbian changed files
`dpkg --verify` -> `dpkg --verify | awk '{print $3;}' | xargs dpkg -S` - for configs
