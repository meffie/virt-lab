# Copyright (c) 2019 Sine Nomine Associates

PACKAGE=virt
BINDIR=$(HOME)/.local/bin
DATADIR=$(HOME)

help:
	@echo "usage: make <target>"
	@echo "  install        install virt-lab"

install:
	git submodule init
	git submodule update
	install -d $(DATADIR)/$(PACKAGE)
	install -d $(DATADIR)/$(PACKAGE)/scripts
	install -d $(DATADIR)/$(PACKAGE)/playbooks
	install scripts/* $(DATADIR)/$(PACKAGE)/scripts
	install playbooks/* $(DATADIR)/$(PACKAGE)/playbooks
	install -d $(BINDIR)
	install virt-lab $(BINDIR)
	install kvm-install-vm/kvm-install-vm $(BINDIR)
	test -f $(HOME)/virt-lab.cfg || cp virt-lab.cfg.example $(HOME)/virt-lab.cfg

install-kvm:
	ansible-galaxy install -r kvm/requirements.yaml
	ansible-playbook kvm/kvm.yaml