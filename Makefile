
include $(TOPDIR)/rules.mk

PKG_NAME:=test-cross-compiler
PKG_RELEASE:=1

PKG_MAINTAINER:=Manibalan V <manibalan.v@zilogic.com>

include $(INCLUDE_DIR)/package.mk

define Package/test-cross-compiler
	SECTION:=zilogic
	CATEGORY:=test
	SUBMENU:=Testing
	TITLE:=For testing
endef

define Package/test-cross-compiler/description
	This is for testing purpose.
endef

define Build/Prepare
	patch -p0 -i hello_change.patch hello.c
endef

define Build/Compile
	$(TARGET_CC) $(TARGET_CPPFLAGS) -o $(PKG_BUILD_DIR)/hello hello.c
endef

define Package/test-cross-compiler/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/hello $(1)/usr/hello
endef

$(eval $(call BuildPackage,test-cross-compiler))
