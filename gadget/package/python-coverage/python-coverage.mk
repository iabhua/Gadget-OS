################################################################################
#
# python-coverage
#
############################################################################

PYTHON_COVERAGE_VERSION = 4.4.1
PYTHON_COVERAGE_SOURCE = coverage-$(PYTHON_COVERAGE_VERSION).tar.gz
PYTHON_COVERAGE_SITE = https://github.com/nedbat/coveragepy/archive
PYTHON_COVERAGE_SITE_METHOD = https
PYTHON_COVERAGE_LICENSE = APACHE
PYTHON_COVERAGE_LICENSE_FILES = LICENSE
PYTHON_COVERAGE_DEPENDENCIES =
PYTHON_COVERAGE_SETUP_TYPE = setuptools

$(eval $(python-package))
