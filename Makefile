# $Id: Makefile,v 1.8 2003/08/23 16:24:17 ranma Exp $

prefix = /usr/local
exec_prefix = ${prefix}

bindir = ${exec_prefix}/bin

CFLAGS := -Wall -Wstrict-prototypes -Os -fomit-frame-pointer
LDFLAGS := -lm

SRCS := gbsplay.c

.PHONY: all distclean clean install dist
all: gbsplay

# determine the object files

OBJS := $(patsubst %.c,%.o,$(filter %.c,$(SRCS)))

# include the dependency files

%.d: %.c
	./depend.sh $< $(CFLAGS) > $@

include $(OBJS:.o=.d)

distclean: clean
	find -regex ".*\.d" -exec rm -f "{}" \;

clean:
	find -regex ".*\.\([aos]\|so\)" -exec rm -f "{}" \;
	find -name "*~" -exec rm -f "{}" \;
	rm -rf ./gbsplay

install: all
	install -d $(bindir)
	install -m 755 gbsplay $(bindir)/gbsplay

dist:	distclean
	install -d ./gbsplay
	install -m 644 *.c ./gbsplay/
	install -m 644 Makefile ./gbsplay/
	install -m 755 depend.sh ./gbsplay/
	tar -c gbsplay/ -vzf ../gbsplay.tar.gz
	rm -rf ./gbsplay

gbsplay: gbsplay.o 
	$(CC) $(LDFLAGS) -o $@ $<

.SUFFIXES: .i .s

.c.i:
	$(CC) -E $(CFLAGS) -o $@ $<
.c.s:
	$(CC) -S $(CFLAGS) -fverbose-asm -o $@ $<
