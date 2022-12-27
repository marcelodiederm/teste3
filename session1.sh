#!/bin/sh
count=1000
for i in $(seq $count); do
    function screenIsLocked { [ "$(/usr/libexec/PlistBuddy -c "print :IOConsoleUsers:0:CGSSessionScreenIsLocked" /dev/stdin 2>/dev/null <<< "$(ioreg -n Root -d1 -a)")" = "true" ] && return 0 || return 1; }
    function screenIsUnlocked { [ "$(/usr/libexec/PlistBuddy -c "print :IOConsoleUsers:0:CGSSessionScreenIsLocked" /dev/stdin 2>/dev/null <<< "$(ioreg -n Root -d1 -a)")" != "true" ] && return 0 || return 1; }
    if screenIsLocked; then
        echo "`date` - `whoami` - Computer `hostname` - Screen locked"
    fi
    
    if screenIsUnlocked; then
        echo "`date` - `whoami` - Computer `hostname` - Screen unlocked"
    fi
    sleep 1
done