#PROG_VERSION = $(shell git describe --tags)
PROG_VERSION = 0.1
PROG_NAME = bezier
PROG_DIRS = ./

LIBS = sdl2

CFLAGS = -std=gnu11 -Wall -Wextra -Wpedantic -Winit-self -Wshadow \
	-Wcast-qual -Wstrict-prototypes -Wmissing-prototypes \
	$(shell pkg-config --cflags $(LIBS)) \
	-DPROG_VERSION=\"${PROG_VERSION}\" -DPROG_NAME=\"${PROG_NAME}\" \
	-MMD -MP

LDFLAGS = -Wl,--as-needed
LDLIBS = $(shell pkg-config --libs $(LIBS))

SRCS = $(wildcard $(addsuffix *.c, ${PROG_DIRS}))
OBJS = $(SRCS:.c=.o)
DEPS = $(SRCS:.c=.d)
BINARY = $(PROG_NAME)

INSTALL = install -m755

PREFIX = /usr/local

DEBUG ?= 0
ifeq ($(DEBUG), 1)
	CFLAGS  += -Og -g
else
	CFLAGS  += -O2 -DNDEBUG
	LDFLAGS += -O2
endif

all: $(BINARY)

$(BINARY): $(OBJS)
	$(call FLD, $^, $@)

install: $(BINARY)
	$(call QINSTALL, $(^))$(INSTALL) $^ $(DESTDIR)$(PREFIX)/bin

uninstall:
	$(RM) $(DESTDIR)$(PREFIX)/bin/$(BINARY)

TAGS:
	etags *.{c,h}

tags:
	ctags -R .

cscope: cscope.out

cscope.out: $(SRCS)
	cscope -b -e -q -R

CLEAN_OBJS = $(shell find . -type f -name "*.o")
CLEAN_DEPS = $(shell find . -type f -name "*.d")

clean:
	$(call QCLEAN, binary) $(RM) $(BINARY)
	$(call QCLEAN, objects) $(RM) $(CLEAN_OBJS)
	$(call QCLEAN, depfiles) $(RM) $(CLEAN_DEPS)
	$(call QCLEAN, tags) $(RM) tags TAGS
	$(call QCLEAN, cscope) $(RM) cscope.in.out cscope.out cscope.po.out

-include quiet.mk
-include $(DEPS)

.PHONY: all install uninstall clean cscope
