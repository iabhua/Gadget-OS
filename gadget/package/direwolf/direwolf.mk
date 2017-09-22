################################################################################
#
# Direwolf
#
################################################################################

DIREWOLF_VERSION = d9233dd82784392053930496925084b1fe885906
DIREWOLF_SITE = $(call github,nytowl,direwolf,$(DIREWOLF_VERSION))
DIREWOLF_INSTALL_STAGING = NO
DIREWOLF_INSTALL_TARGET = YES
DIREWOLF_CONF_OPTS = \
        CC="$(TARGET_CC)"               \
        enable_gpsd="$(STAGING_DIR)/usr/include/gps.h"       \
        CFLAGS="$(TARGET_CFLAGS) -I $(@D)/geotranz -pthread -DENABLE_GPSD -DUSE_ALSA"         \
        HOSTCFLAGS="$(TARGET_CFLAGS) -I $(@D)/geotranz -pthread -DENABLE_GPSD -DUSE_ALSA"       \
        LDSHARED="$(TARGET_CC) -shared -lm -pthread -lrt -lgps" \
        LDFLAGS="$(TARGET_LDFLAGS) -L $(STAGING_DIR)/usr/lib -lm -pthread -lrt -lgps -lasound" \
        HOSTLDFLAGS="-lm -pthread -lrt"
DIREWOLF_DEPENDENCIES = alsa-lib gpsd

define DIREWOLF_BUILD_CMDS
  $(MAKE) $(DIREWOLF_CONF_OPTS) -C $(@D) all
  $(MAKE) $(DIREWOLF_CONF_OPTS) -C $(@D) tocalls-symbols
endef

define DIREWOLF_INSTALL_STAGING_CMDS
    $(INSTALL) -D -m 0755 $(@D)/direwolf $(STAGING_DIR)/usr/bin
    $(INSTALL) -D -m 0755 $(@D)/direwolf.conf $(STAGING_DIR)/etc/
    $(INSTALL) -D -m 0644 $(@D)/tocalls.txt $(STAGING_DIR)/usr/share/direwolf/tocalls.txt
    $(INSTALL) -D -m 0644 $(@D)/symbols-new.txt $(STAGING_DIR)/usr/share/direwolf/symbols-new.txt
    $(INSTALL) -D -m 0644 $(@D)/symbolsX.txt $(STAGING_DIR)/usr/share/direwolf/symbolsX.txt
endef

define DIREWOLF_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/direwolf $(TARGET_DIR)/usr/bin
    $(INSTALL) -D -m 0755 $(@D)/direwolf.conf $(TARGET_DIR)/etc/
    $(INSTALL) -D -m 0644 $(@D)/tocalls.txt $(TARGET_DIR)/usr/share/direwolf/tocalls.txt
    $(INSTALL) -D -m 0644 $(@D)/symbols-new.txt $(TARGET_DIR)/usr/share/direwolf/symbols-new.txt
    $(INSTALL) -D -m 0644 $(@D)/symbolsX.txt $(TARGET_DIR)/usr/share/direwolf/symbolsX.txt
endef

$(eval $(generic-package))
