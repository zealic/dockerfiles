LEDE_VERSION=17.01.1
LEDE_URL=http://downloads.lede-project.org/releases/$(LEDE_VERSION)/targets/x86/generic/lede-$(LEDE_VERSION)-x86-generic-combined-ext4.img.gz
LEDE_FILENAME=lede-$(LEDE_VERSION)-x86.ova

OPENWRT_VERSION=15.05.1
OPENWRT_URL=http://downloads.openwrt.org/chaos_calmer/$(OPENWRT_VERSION)/x86/generic/openwrt-$(OPENWRT_VERSION)-x86-generic-combined-ext4.img.gz
OPENWRT_FILENAME=openwrt-$(OPENWRT_VERSION)-x86.ova


lede:
	@docker run -it --rm=true -v \
		${PWD}:/build zealic/openwrt-vm-builder build:ova \
		--name lede --output /build/$(LEDE_FILENAME) \
		'${LEDE_URL}'

openwrt:
	@docker run -it --rm=true -v \
		${PWD}:/build zealic/openwrt-vm-builder build:ova \
		--name openwrt --output /build/$(OPENWRT_FILENAME) \
		'${OPENWRT_URL}'
