VERSION := $(shell git describe --tags 2>/dev/null)
VERSION ?= v0.0

BINARY := bezier
SRCS := $(wildcard ./*.c)
LIBS := sdl2

CFLAGS := -std=gnu11 -Wall -Wextra -Wpedantic -Winit-self -Wshadow \
	  -Wcast-qual -Wstrict-prototypes -Wmissing-prototypes \
	  $(shell pkg-config --cflags $(LIBS)) \
	  -DVERSION=\"${VERSION}\" -MMD -MP
LDFLAGS := -Wl,--as-needed
LDLIBS := $(shell pkg-config --libs $(LIBS))

INSTALL := install -m755

PREFIX := /usr/local

DEBUG ?= 0
ifeq ($(DEBUG), 1)
	CFLAGS  += -Og -g
else
	CFLAGS  += -O2 -DNDEBUG
	LDFLAGS += -O2
endif

all: $(BINARY)
$(BINARY): $(SRCS:.c=.o)
	$(LINK.o) $^ $(LOADLIBES) $(LDLIBS) -o $@

install: $(BINARY)
	$(INSTALL) $^ $(DESTDIR)$(PREFIX)/bin
uninstall:
	$(RM) $(DESTDIR)$(PREFIX)/bin/$(BINARY)

TAGS:
	etags *.{c,h}
tags:
	ctags -R .

cscope: cscope.out
cscope.out: $(SRCS)
	cscope -b -e -q -R

clean:
	$(RM) $(BINARY) tags TAGS cscope.in.out cscope.out cscope.po.out
	find . -type f -name "*.[od]" -delete

-include $(SRCS:.c=.d)

.PHONY: all install uninstall clean cscope
