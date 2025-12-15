git clone https://github.com/openwrt/openwrt.git
cd openwrt
git switch -d v24.10.4
./scripts/feeds update -a
./scripts/feeds install -a
mkdir -p package/network/services/
cd package/network/services/
git clone https://github.com/NilsRo/usteer-ng
cd ../../..
./scripts/feeds update mypackages
./scripts/feeds install -a -p mypackages
make menuconfig
# target-system: Freescale MCP85xx
# subtarget: p1020
# target profile: Extreme Networks WS-AP3825i
# network/wireless/usteer-ng: ENABLE
make toolchain/install
make package/usteer-ng/compile
ls -l bin/packages/powerpc_8548/mypackages/usteer-ng_1.0.0-r1_powerpc_8548.ipk
