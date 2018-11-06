
CFLAGS=-Wall -g -O0 -ansi -pedantic

SRCS=$(wildcard *.c)

all: sheerdns sheerdnshash sheerdns.ps

OBJECTS=$(SRCS:.c=.o)

sheerdns: $(OBJECTS)
	gcc -o sheerdns $(OBJECTS)

sheerdnshash: hash.c
	gcc $(CFLAGS) -o sheerdnshash hash.c -DSTANDALONE -Wall

.c.o: $(SRCS)
	gcc $(CFLAGS) -c $<

clean:
	rm -f sheerdns sheerdnshash *.o

distclean: clean
	rm -f core *~ sheerdns.ps *.diss

sheerdns.ps:
	groff -Tps -mandoc sheerdns.8 > sheerdns.ps

install: all
	install -dm0755 $(DESTDIR)/usr/{sbin,share/man/man8}
	install -m0755 sheerdnshash sheerdns $(DESTDIR)/usr/sbin/
	install -m0644 sheerdns.8 $(DESTDIR)/usr/share/man/man8/
