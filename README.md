# shell-tools
Shell tools for Linux automation (CentOS and Raspbian primary)


## Verifications and one-liners

### Find Raspbian changed files
`dpkg --verify` -> `dpkg --verify | awk '{print $3;}' | xargs dpkg -S` - for configs

### Compare directories 
#### for same names
`find /spool2d/files/archive/Video/ -maxdepth 1 -printf '%P\0' | xargs -0 -I % -n 1 bash -c '[ -f "%" -o -d "%" ] && echo -e "\n%" && ls -l "%" "/spool2d/files/archive/Video/%"'`
#### and move to dups if any found
`find /spool2d/files/archive/Video/ -maxdepth 1 -printf '%P\0' | xargs -0 -I % -n 1 bash -c '[ -f "%" -o -d "%" ] &&  mv -v "/spool2d/files/archive/Video/%" "/spool2d/files/archive/Video/dups/"'`
#### Check first level did not containing somethis missed
find /spool2d/files/archive/Video/dups -maxdepth 1 -printf '%P\0' | xargs -0 -I % -n 1 bash -c '[ -f "%" -o -d "%" ] || echo "%"'
#### Find something new in subdirectories
find /spool2d/files/archive/Video/dups -printf '%P\0' | xargs -0 -I % -n 1 bash -c '[ -f "%" -o -d "%" ] || echo "%"'
