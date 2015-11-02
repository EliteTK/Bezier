SUFFIXES:

Q =
QCC =
QLD =
QCCLD =
QCLEAN =
QINSTALL =

ifneq ($(VERBOSE), 1)
	Q = @
	QCC = @printf ' CC      %s\n' $@;
	QLD = @printf ' LD      %s\n' $@;
	QCCLD = @printf ' CCLD    %s\n' $@;
	QCLEAN = @printf ' CLEAN   %s\n' $1;
	QINSTALL = @printf ' INSTALL %s\n' $1;
endif

FCC = $(QCC)$(COMPILE.c) $(OUTPUT_OPTION) $1
FLD = $(QLD)$(LINK.o) $1 $(LOADLIBES) $(LDLIBS) -o $2
FCCLD = $(QCCLD)$(LINK.c) $1 $(LOADLIBES) $(LDLIBS) -o $2

%.o: %.c
	$(call FCC, $<)

%: %.c
	$(call FCCLD, $<, $@)

%: %.o
	$(call FLD, $<, $@)
