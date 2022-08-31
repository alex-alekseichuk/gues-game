
EXE=.exe
CC=gcc
CFLAGS=
MFLAGS=`gnustep-config --objc-flags` -I/GNUstep/System/Library/Headers
LIBS=-lgnustep-base -lobjc -L/GNUstep/System/Library/Libraries
MSRC=GuesGame.m
CSRC=lapi.c lbaselib.c ldblib.c ldo.c lfunc.c linit.c llex.c lmem.c lobject.c loslib.c lstate.c lstrlib.c ltablib.c lundump.c lzio.c lauxlib.c lcode.c ldebug.c ldump.c lgc.c liolib.c lmathlib.c loadlib.c lopcodes.c lparser.c lstring.c ltable.c ltm.c lvm.c print.c
OBJS=GuesGame.o lapi.o lbaselib.o ldblib.o ldo.o lfunc.o linit.o llex.o lmem.o lobject.o loslib.o lstate.o lstrlib.o ltablib.o lundump.o lzio.o lauxlib.o lcode.o ldebug.o ldump.o lgc.o liolib.o lmathlib.o loadlib.o lopcodes.o lparser.o lstring.o ltable.o ltm.o lvm.o print.o

.SUFFIXES: .o .m .c
.m.o:
	$(CC) -c $(MFLAGS) $<
.c.o:
	$(CC) -c $(CFLAGS) $<

GnuGame$(EXE): $(OBJS)
	$(CC) -o GnuGame$(EXE) $(OBJS) $(LIBS)

all: GnuGame$(EXE)

	


	

