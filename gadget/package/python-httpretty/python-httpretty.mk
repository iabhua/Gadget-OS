################################################################################
#
# python-httpretty
#
############################################################################

PYTHON_HTTPRETTY_VERSION = 0.8.14
PYTHON_HTTPRETTY_SOURCE = $(PYTHON_HTTPRETTY_VERSION).tar.gz
PYTHON_HTTPRETTY_SITE = https://github.com/gabrielfalcao/HTTPretty/archive
PYTHON_HTTPRETTY_SITE_METHOD = https
PYTHON_HTTPRETTY_LICENSE = ASIS
PYTHON_HTTPRETTY_LICENSE_FILES = COPYING
PYTHON_HTTPRETTY_DEPENDENCIES = 
PYTHON_HTTPRETTY_SETUP_TYPE = setuptools

$(eval $(python-package))
