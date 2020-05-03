#!/bin/bash
set -e

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
l_low=75
l_mid=150
l_high=225
ipmitool -H $host -U $username -P $password sensor thres FAN1 lower $l_low $l_mid $l_high
ipmitool -H $host -U $username -P $password sensor thres FAN1 lower $l_low $l_mid $l_high
ipmitool -H $host -U $username -P $password sensor thres FAN2 lower $l_low $l_mid $l_high
ipmitool -H $host -U $username -P $password sensor thres FAN3 lower $l_low $l_mid $l_high
ipmitool -H $host -U $username -P $password sensor thres FAN4 lower $l_low $l_mid $l_high
ipmitool -H $host -U $username -P $password sensor thres FAN5 lower $l_low $l_mid $l_high
ipmitool -H $host -U $username -P $password sensor thres FAN6 lower $l_low $l_mid $l_high
ipmitool -H $host -U $username -P $password sensor thres FANA lower $l_low $l_mid $l_high
ipmitool -H $host -U $username -P $password sensor thres FANB lower $l_low $l_mid $l_high

# Set fan speed mode
# Input : NetFn 0x30 
# Cmd 0x45 
# Data1 Get/Set -> [0/1] 
# Data2 Fan Speed Mode, standard/full/optimal -> [0/1/2] // for Set only
# https://www.supermicro.com/support/faqs/faq.cfm?faq=13877
ipmitool -H $host -U $username -P $password raw 0x30 0x45 1 2

# Print info
ipmitool -H $host -U $username -P $password sensor

