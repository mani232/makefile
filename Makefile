
include $(TOPDIR)/rules.mk

PKG_NAME:=test-cross-compiler
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/mani232/tryout/
PKG_MIRROR_HASH:=7079b652758f3c0ab2426a6368deebbec7640d68
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_SOURCE_VERSION)
PKG_SOURCE:=$(PKG_SOURCE_SUBDIR).tar.xz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_SOURCE_SUBDIR)
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
	$(Build/Prepare/Default)
	patch -p0 -i patchs/hello_change.patch $(PKG_BUILD_DIR)/hello.c
endef

define Build/Compile
	$(TARGET_CC) $(TARGET_CPPFLAGS) -o $(PKG_BUILD_DIR)/hello $(PKG_BUILD_DIR)/hello.c
endef

define Package/test-cross-compiler/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/hello $(1)/usr/hello
endef

$(eval $(call BuildPackage,test-cross-compiler))
