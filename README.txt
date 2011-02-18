Build instructions
==================

Linux 2006-04-27
----------------
Build our copy of expat on the same host before building xmlrpc-epi.

$ tar xvzf xmlrpc-epi-0.51
$ cd xmlrpc-epi-0.51
$ patch -p1 < ../remove_iconv.patch
$ patch -p1 < ../rename_queue.patch
$ ./configure --disable-shared --prefix=/tmp/xmlrpc-epi

Now, post configure, prep the tree to use our expat, not theirs:
$ patch -p1 < ../excise_expat.patch
$ rm -rf expat
$ mkdir expat
$ cp $FOO expat
    Where $FOO is either
        /tmp/expat/include/* -- if you built expat recently
    or  ../../expat-1.95.8/src/lib/expat*.h -- if you haven't
    in this later case you'll need to have CVS gotten the expat
    lib, and expanded it's src.tar.gz file there

Finally, build:
$ make
$ make install
cOSX10.4u.sdk
Then, copy the headers and libs into the branch where you need 'em
$ cp /tmp/xmlrpc-epi/include -> linden/include/xmlrpc-epi
$ cp /tmp/xmlrpc-epi/lib/libxmlrpc.a -> linden/<platform>/lib_release
$ cp /tmp/xmlrpc-epi/lib/libxmlrpc.a -> linden/<platform>/lib_debug



Mac
---
same as Linux build, but change the make step to be:

on PPC:
$ make CFLAGS='-g -O2 -isysroot /Developer/SDKs/MacOSX10.3.9.sdk'

on i386:
$ make CFLAGS='-g -O2 -isysroot /Developer/SDKs/MacOSX10.4u.sdk'


Windows
-------
Build our copy of expat on the same host before building xmlrpc-epi.

$ tar xvzf xmlrpc-epi-0.51
$ cd xmlrpc-epi-0.51
$ patch -p1 < ../remove_iconv.patch
$ patch -p1 < ../excise_expat.patch
$ rm -rf expat
$ mkdir expat
$ cp $FOO expat
    Where $FOO is either
        /tmp/expat/include/* -- if you built expat recently
    or  ../../expat-1.95.8/src/lib/expat*.h -- if you haven't
    in this later case you'll need to have CVS gotten the expat
    lib, and expanded it's src.tar.gz file there

Copy over the Visual Studio files:
$ cp ../src/xmlrpcepi.* .

Open the xmlrpcepi.sln file and build






The Expat Patch
---------------
This is what the patch file accomplishes:
* Look for SUBDIRS in the generated xmlrpc-epi/Makefile and cut expat
and samples out of the SUBDIRS line.

* In src/Makefile change the INCLUDES line from:
INCLUDES = -I../liblm -I../expat/xmltok -I../expat/xmlparse -I/usr/local/ssl/include 
to
INCLUDES = -I../liblm -I../expat -I/usr/local/ssl/include 

* In src/Makefile delete the lines:
libxmlrpc_la_LIBADD = ../expat/xmltok/libexpat_tok.la ../expat/xmlparse/libexpat_parse.la
libxmlrpc_la_DEPENDENCIES =  ../expat/xmltok/libexpat_tok.la \
../expat/xmlparse/libexpat_parse.la

* In src/xml_element.c and src/xmlrpc.c change the include of
xmlparse.h to expat.h
