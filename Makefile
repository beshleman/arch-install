QEMU_OPTS := -m 4096 -enable-kvm -serial mon:stdio -smp 4
QEMU_OPTS += -nic user

ARCH_URL ?= https://mirrors.edge.kernel.org/archlinux/iso/2020.05.01/archlinux-2020.05.01-x86_64.iso
ARCH_ISO := $(shell basename $(ARCH_URL))

.PHONY: install
install: disk.qcow2
	qemu-system-x86_64 -cdrom $(ARCH_ISO) -hda $< $(QEMU_OPTS) -boot d 

.PHONY: run
run: disk.qcow2
	qemu-system-x86_64 -hda $< $(QEMU_OPTS)

%.qcow2:
	qemu-img create -f qcow $@ 50G

.PHONY: fetch
fetch: $(ARCH_ISO)

$(ARCH_ISO):
	wget $(ARCH_URL)
