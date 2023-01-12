# Copyright (C) 2012 Nils Schneider <nils at nilsschneider.net>
# This is free software, licensed under the Apache 2.0 license.

include $(TOPDIR)/rules.mk

PKG_NAME:=gluon-setup-mode
PKG_VERSION:=1

include ../gluon.mk

define Package/gluon-setup-mode
  TITLE:=Our setup mode has dhcp client on setup_ifname (WAN), and 203.0.113.1/24 on lan_ifname (LAN)
  DEPENDS:=+gluon-core +gluon-lock-password +ubus +dnsmasq
endef

define Package/gluon-setup-mode/description
	Mode to perform basic setup in a connected way (i. e. with Internet access)
endef

init_links := \
	K89log \
	K98boot \
	K99umount \
	S00sysfixtime \
	S10boot \
	S10gluon-core-reconfigure \
	S10system \
	S11sysctl \
	S12log \
	S95done

define Package/gluon-setup-mode/install
	$(Gluon/Build/Install)

	$(LN) S20network $(1)/lib/gluon/setup-mode/rc.d/K90network

	for link in $(init_links); do \
		$(LN) "/etc/init.d/$$$${link:3}" "$(1)/lib/gluon/setup-mode/rc.d/$$$${link}"; \
	done
endef

$(eval $(call BuildPackageGluon,gluon-setup-mode))
