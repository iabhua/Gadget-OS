################################################################################
#
# aprx
#
################################################################################

APRX_VERSION = 2.9.0
APRX_SOURCE = aprx-${APRX_VERSION}.tar.gz
APRX_SITE = http://thelifeofkenneth.com/aprx/release
APRX_INSTALL_STAGING = NO
APRX_INSTALL_TARGET = YES
APRX_CONF_OPTS = --prefix=/usr/local \
        CC="$(TARGET_CC)"
APRX_DEPENDENCIES = 

#define APRX_CONFIGURE_CMDS
#    configure --prefix=/usr/local
#endef

#define APRX_BUILD_CMDS
#    pwd
#    cd aprx-${APRX_VERSION}
#    configure --prefix=/usr/local
#    make
#endef

#define APRX_INSTALL_STAGING_CMDS
#endef

#define APRX_INSTALL_TARGET_CMDS
#    make install
#endef

$(eval $(autotools-package))
#$(eval $(generic-package))
