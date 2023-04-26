#!/usr/bin/env bash

clear
echo " ██████╗  █████╗ ████████╗ █████╗ ███████╗████████╗ █████╗ ██╗  ██╗ "
echo " ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██╔════╝╚══██╔══╝██╔══██╗╚██╗██╔╝ "
echo " ██║  ██║███████║   ██║   ███████║███████╗   ██║   ███████║ ╚███╔╝  "
echo " ██║  ██║██╔══██║   ██║   ██╔══██║╚════██║   ██║   ██╔══██║ ██╔██╗  "
echo " ██████╔╝██║  ██║   ██║   ██║  ██║███████║   ██║   ██║  ██║██╔╝ ██╗ "
echo " ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ "
echo ""

echo -n 'Starting a Cassandra cluster ...'; 
timeout 120 bash -c 'until cqlsh -e "describe cluster" >/dev/null 2>&1; do sleep 2; echo -n "."; done'; 
echo ' DONE!'
echo "Cassandra successfully started."

echo ""



      
