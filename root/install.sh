#!/bin/ash -x

opkg update
opkg remove wpad-basic-mbedtls
opkg install wpad-mbedtls
# wget .../usteer-ng_1.0.0-r1_powerpc_8548.ipk
#opkg install /root/usteer-ng_1.0.0-r1_powerpc_8548.ipk
#opkg install --nodeps luci-app-usteer
#opkg install git
/etc/init.d/odhcpd stop
/etc/init.d/odhcpd disable
