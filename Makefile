# Copyright (c) 2019 Sine Nomine Associates

PACKAGE=virt
BINDIR=$(HOME)/.local/bin
DATADIR=$(HOME)

.PHONY: help update install install-kvm

help:
	@echo "usage: make <target>"
	@echo "  update          update git submodules"
	@echo "  install         install virt-lab"
	@echo "  install-kvm     run playbook to install kvm"
	@echo "  lint            lint checks"

update:
	git submodule init
	git submodule update

lint:
	yamllint playbooks/*.yaml
	pylint --rcfile=.pylintrc  virt-lab
	pylint3 --rcfile=.pylint3rc virt-lab

install: update
	install -d $(DATADIR)/$(PACKAGE)
	install -d $(DATADIR)/$(PACKAGE)/scripts
	install scripts/* $(DATADIR)/$(PACKAGE)/scripts
	install -d $(DATADIR)/$(PACKAGE)/playbooks
	install -m 644 playbooks/* $(DATADIR)/$(PACKAGE)/playbooks
	install -d $(BINDIR)
	install virt-lab $(BINDIR)
	install kvm-install-vm/kvm-install-vm $(BINDIR)
	test -f $(HOME)/virt-lab.cfg || cp virt-lab.cfg.example $(HOME)/virt-lab.cfg

install-kvm:
	ansible-galaxy install -r kvm/requirements.yaml
	ansible-playbook kvm/kvm.yaml
