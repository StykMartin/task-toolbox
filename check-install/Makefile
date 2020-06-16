# SPDX-License-Identifier: GPL-2.0+

export TEST=/bkr/check-install-no-rhts
export TESTVERSION=1.0

include /usr/share/rhts/lib/rhts-make.include

BUILT_FILES=
FILES=$(METADATA) sysinfo.sh runtest.sh

.PHONY: run
run:
	./runtest.sh

$(METADATA):
	@echo "Name:         $(TEST)" >$(METADATA)
	@echo "Path:         $(TEST_DIR)" >>$(METADATA)
	@echo "TestVersion:  $(TESTVERSION)" >>$(METADATA)
	@echo "License:      GPL-2" >>$(METADATA)
	@echo "Description:  Checks the installation that was done, reports system info" >>$(METADATA)
	@echo "TestTime:     10m" >>$(METADATA)
	rhts-lint $(METADATA)

