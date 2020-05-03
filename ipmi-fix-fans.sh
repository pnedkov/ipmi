#!/bin/bash
set -e

# Thresholds
t_low=75   # 75
t_mid=150  # 225
t_high=225 # 300

# Check if ipmitool is installed
command -v ipmitool > /dev/null || { echo "ERROR: ipmitool not found!"; exit 1; }

# Input
echo -n "IPMI host: "
read host
echo -n "IPMI username: "
read username
echo -n "IPMI password: "
read -s password

# Print info
ipmitool -H $host -U $username -P $password sensor

# Set fans thresholds
for i in {1..6} A B; do
    ipmitool -H $host -U $username -P $password sensor thres FAN$i lower $t_low $t_mid $t_high
done

# Set fan speed mode
# Input : NetFn 0x30 
# Cmd 0x45 
# Data1 Get/Set -> [0/1] 
# Data2 Fan Speed Mode, standard/full/optimal -> [0/1/2] // for Set only
# https://www.supermicro.com/support/faqs/faq.cfm?faq=13877
ipmitool -H $host -U $username -P $password raw 0x30 0x45 1 2

# Print info
ipmitool -H $host -U $username -P $password sensor

