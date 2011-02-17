#!/bin/bash
#
# build.bash

ORIGINAL_DIR=$PWD
PROJECT="xmlrpc-epi"
VERSION="0.51"
SOURCE_DIR="$PROJECT-$VERSION"

# verify that $PKG_INSTALL_DIR is defined
if [ -z $PKG_INSTALL_DIR ]; then
	echo "\$PKG_INSTALL_DIR was not defined"
	exit 1
fi

# verify the install directories are properly setup
echo "installing $PROJECT-$VERSION ..."
if [ ! -d $PKG_INSTALL_DIR ]; then
	echo "\$PKG_INSTALL_DIR = $PKG_INSTALL_DIR does not exist.  Creating directory..."
	mkdir -p $PKG_INSTALL_DIR
	if [ ! -d $PKG_INSTALL_DIR ]; then
		echo "unable to create \$PKG_INSTALL_DIR = $PKG_INSTALL_DIR"
		exit 1
	fi
fi

# configure
cd $SOURCE_DIR
echo "configuring $PROJECT-$VERSION ..."
# this project doesn't use the 'make install' paradigm, so no --prefix=
./configure --prefix=$PKG_INSTALL_DIR

# verify that expat was built and installed first
EXPAT_INCLUDE_DIR=$PKG_INSTALL_DIR/include
if [ ! -f $EXPAT_INCLUDE_DIR/expat.h ]; then
	echo "could not find $EXPAT_INCLUDE_DIR/expat.h -- expat must be built and installed before xmlrpc-epi"
	exit 1
fi

# also after configure, prep the tree to use our expat.h, not theirs
#
# NOTE the README instructions aren't clear on this step, and fail if
# you actually follow them as given.  After talking to MarkL I gather
# that we're really just supposed to force whatever headers we're using
# for expat onto the xmlrpc project, so we just copy them over.
cd $SOURCE_DIR
echo "copying expat headers over from $EXPAT_INCLUDE_DIR..."
cp -v $EXPAT_INCLUDE_DIR/expat*.h src

# build
cd $SOURCE_DIR
make

# install
make install

if [ ! -z $CURRENT_LINDEN_SANDBOX ]; then
	# verify the sandbox
	if [ ! -d $CURRENT_LINDEN_SANDBOX ]; then
		echo "error: unable to find \$CURRENT_LINDEN_SANDBOX $CURRENT_LINDEN_SANDBOX"
		exit 1
	fi

	# compute the sandbox install dir
	DUMP_MACHINE=`gcc -dumpmachine`
	ARCH=`echo $DUMP_MACHINE | sed 's/-.*$//'`
	if [ $ARCH = "i486" ]; then
		# i486, i686... same thing
		ARCH="i686"
	fi
	PLATFORM=`echo $DUMP_MACHINE | sed 's/^[a-zA-Z0-9_]*-//' | sed 's/-.*$//'`
	SANDBOX_INSTALL_DIR=$CURRENT_LINDEN_SANDBOX/libraries/$ARCH-$PLATFORM

	# make sure the target directories exist
	if [ ! -d $SANDBOX_INSTALL_DIR/lib_release ]; then
		mkdir -p $SANDBOX_INSTALL_DIR/lib_release
	fi
	if [ ! -d $SANDBOX_INSTALL_DIR/lib_release_client ]; then
		mkdir -p $SANDBOX_INSTALL_DIR/lib_release_client
	fi

	# copy libs
	# NOTE -- we rename the lib: libxmlrpc.a --> libmxlprc-epi.a
	cd $SOURCE_DIR
	cp -v $PKG_INSTALL_DIR/lib/libxmlrpc.a $SANDBOX_INSTALL_DIR/lib_release/libxmlrpc-epi.a
	cp -v $PKG_INSTALL_DIR/lib/libxmlrpc.a $SANDBOX_INSTALL_DIR/lib_release_client/libxmlrpc-epi.a

	# copy headers
	HEADER_DIR=$CURRENT_LINDEN_SANDBOX/libraries/include/$PROJECT
	if [ -d $HEADER_DIR ]; then
		rm -rf $HEADER_DIR
	fi
	mkdir -p $HEADER_DIR
	# we don't need ALL the headers, so we only copy the ones we need
	cp -v src/base64.h $HEADER_DIR
	cp -v src/encodings.h $HEADER_DIR
	cp -v src/queue.h $HEADER_DIR
	cp -v src/simplestring.h $HEADER_DIR
	cp -v src/xml_element.h $HEADER_DIR
	cp -v src/xmlrpc.h $HEADER_DIR
	cp -v src/xmlrpc_introspection.h $HEADER_DIR
	cp -v src/xml_to_xmlrpc.h $HEADER_DIR
else
	echo "$PROJECT-$VERSION: \$CURRENT_LINDEN_SANDBOX not defined -- files not copied"
fi
