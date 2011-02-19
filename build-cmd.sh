#!/bin/bash

cd "$(dirname "$0")"

# turn on verbose debugging output for parabuild logs.
set -x
# make errors fatal
set -e

XMLRPCEPI_VERSION="0.54.1"
XMLRPCEPI_SOURCE_DIR="xmlrpc-epi-$XMLRPCEPI_VERSION"

if [ -z "$AUTOBUILD" ] ; then 
    fail
fi

if [ "$OSTYPE" = "cygwin" ] ; then
    export AUTOBUILD="$(cygpath -u $AUTOBUILD)"
fi

# load autbuild provided shell functions and variables
set +x
eval "$("$AUTOBUILD" source_environment)"
set -x

copy_headers ()
{
    cp src/base64.h $1
    cp src/encodings.h $1
    cp src/queue.h $1
    cp src/simplestring.h $1
    cp src/xml_element.h $1
    cp src/xmlrpc.h $1
    cp src/xmlrpc_introspection.h $1
    cp src/xml_to_xmlrpc.h $1
}

stage="$(pwd)/stage"
pushd "$XMLRPCEPI_SOURCE_DIR"
    case "$AUTOBUILD_PLATFORM" in
        "windows")
            load_vsvars
            
            build_sln "xmlrpcepi.sln" "Debug|Win32" "xmlrpcepi"
            build_sln "xmlrpcepi.sln" "Release|Win32" "xmlrpcepi"
            mkdir -p "$stage/lib/debug"
            mkdir -p "$stage/lib/release"
            cp "Debug/xmlrpcepi.lib" \
                "$stage/lib/debug/xmlrpc-epid.lib"
            cp "Release/xmlrpcepi.lib" \
                "$stage/lib/release/xmlrpc-epi.lib"
            mkdir -p "$stage/include/xmlrpc-epi"
            copy_headers "$stage/include/xmlrpc-epi"
        ;;
        "darwin")
            opts='-arch i386 -iwithsysroot /Developer/SDKs/MacOSX10.5.sdk'
            CFLAGS="$opts" CXXFLAGS="$opts" ./configure --prefix="$stage" \
                --with-expat=yes \
                --with-expat-lib="$stage/packages/lib/release/libexpat.dylib" \
                --with-expat-inc="$stage/packages/include/expat"
            make
            make install
            mkdir -p "$stage/include/xmlrpc-epi"
            mv "$stage/include/"*.h "$stage/include/xmlrpc-epi/"
            mkdir -p "$stage/lib/release"
            mv "$stage/lib/*.a" "$stage/lib/release"
            mv "$stage/lib/*.dylib" "$stage/lib/release"
        ;;
        "linux")
            opts='-m32'
            CFLAGS="$opts" CXXFLAGS="$opts" ./configure --prefix="$stage" \
                --with-expat=yes \
                --with-expat-lib="$stage/packages/lib/release/libexpat.so" \
                --with-expat-inc="$stage/packages/include/expat"
            make
            make install
            mkdir -p "$stage/include/xmlrpc-epi"
            mv "$stage/include/"*.h "$stage/include/xmlrpc-epi/"
        ;;
    esac
    mkdir -p "$stage/LICENSES"
    cp "COPYING" "$stage/LICENSES/xmlrpc-epi.txt"
popd

pass

