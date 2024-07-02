#!/bin/sh
if [ ! -f /velocity/velocity*.jar ]; then
    cd /velocity && python3 ./getvelocity.py | xargs -I{} wget {}
fi
cd /usr/src/app
java -Xms256M -Xmx256M -XX:+UseG1GC -XX:G1HeapRegionSize=4M -XX:+UnlockExperimentalVMOptions -XX:+ParallelRefProcEnabled -XX:+AlwaysPreTouch -XX:MaxInlineLevel=15 -jar /velocity/velocity*.jar


