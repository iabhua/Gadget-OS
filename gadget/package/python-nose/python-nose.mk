################################################################################
#
# python-nose
#
############################################################################

PYTHON_NOSE_VERSION = 1.3.7
PYTHON_NOSE_SOURCE = release_$(PYTHON_NOSE_VERSION).tar.gz
PYTHON_NOSE_SITE = https://github.com/nose-devs/nose/archive
PYTHON_NOSE_SITE_METHOD = https
PYTHON_NOSE_LICENSE = NONE
PYTHON_NOSE_LICENSE_FILES = README
PYTHON_NOSE_DEPENDENCIES =
PYTHON_NOSE_SETUP_TYPE = setuptools

$(eval $(python-package))
