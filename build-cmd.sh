#!/bin/bash

cd "$(dirname "$0")"

# turn on verbose debugging output for parabuild logs.
set -x
# make errors fatal
set -e

XMLRPCEPI_VERSION="0.54.2"
XMLRPCEPI_SOURCE_DIR="xmlrpc-epi"

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

[ -f "$stage"/packages/include/expat/expat.h ] || fail "You haven't installed the expat package yet."

echo "${XMLRPCEPI_VERSION}" > "${stage}/VERSION.txt"

pushd "$XMLRPCEPI_SOURCE_DIR"
    case "$AUTOBUILD_PLATFORM" in
        "windows")
            load_vsvars
            
            build_sln "xmlrpcepi.sln" "Debug" "Win32" "xmlrpcepi"
            build_sln "xmlrpcepi.sln" "Release" "Win32" "xmlrpcepi"
            mkdir -p "$stage/lib/debug"
            mkdir -p "$stage/lib/release"
            cp "Debug/xmlrpcepi.lib" \
                "$stage/lib/debug/xmlrpc-epid.lib"
            cp "Release/xmlrpcepi.lib" \
                "$stage/lib/release/xmlrpc-epi.lib"
            mkdir -p "$stage/include/xmlrpc-epi"
            copy_headers "$stage/include/xmlrpc-epi"
        ;;
        "windows64")
            load_vsvars
            
            build_sln "xmlrpcepi.sln" "Debug" "x64" "xmlrpcepi"
            build_sln "xmlrpcepi.sln" "Release" "x64" "xmlrpcepi"
            mkdir -p "$stage/lib/debug"
            mkdir -p "$stage/lib/release"
            cp "x64/Debug/xmlrpcepi.lib" \
                "$stage/lib/debug/xmlrpc-epid.lib"
            cp "x64/Release/xmlrpcepi.lib" \
                "$stage/lib/release/xmlrpc-epi.lib"
            mkdir -p "$stage/include/xmlrpc-epi"
            copy_headers "$stage/include/xmlrpc-epi"
        ;;
        "darwin")
            opts='-arch i386 -arch x86_64 -iwithsysroot /Developer/SDKs/MacOSX10.11.sdk -mmacosx-version-min=10.9'
            CFLAGS="$opts" CXXFLAGS="$opts" LDFLAGS="$opts" \
                ./configure --with-pic --prefix="$stage" \
                --with-expat=no \
                --with-expat-lib="$stage/packages/lib/release/libexpat.a" \
                --with-expat-inc="$stage/packages/include/expat"
            make
            make install
            mkdir -p "$stage/include/xmlrpc-epi"
            mv "$stage/include/"*.h "$stage/include/xmlrpc-epi/"
            mkdir -p "$stage/lib/release"
            mv "$stage/lib/"*.a "$stage/lib/release"
            mv "$stage/lib/"*.dylib "$stage/lib/release"
            rm "$stage/lib/"*.la
            # The expat build manages to get these paths right automatically,
            # but this one doesn't; whatever, just update the paths here:
            install_name_tool -id "@executable_path/../Resources/libxmlrpc-epi.0.dylib" "$stage/lib/release/libxmlrpc-epi.0.dylib"
			install_name_tool -change "/usr/lib/libexpat.1.dylib" "@executable_path/../Resources/libexpat.1.dylib" "$stage/lib/release/libxmlrpc-epi.0.dylib"
        ;;
        "linux")
            # Default target to 32-bit
            opts="${TARGET_OPTS:--m32}"
            JOBS=`cat /proc/cpuinfo | grep processor | wc -l`
            HARDENED="-fstack-protector -D_FORTIFY_SOURCE=2"

            CFLAGS="$opts -Og -g -I$stage/packages/include/expat" \
            CXXFLAGS="$opts -Og -g -I$stage/packages/include/expat" \
            LDFLAGS="$opts -L$stage/packages/lib/debug" \
            ./configure --with-pic --prefix="\${AUTOBUILD_PACKAGES_DIR}" --includedir="\${prefix}/include/xmlrpc-epi" --libdir="\${prefix}/lib/debug"
            make -j$JOBS
            make install DESTDIR="$stage"
            make distclean

            CFLAGS="$opts -O3 -g -I$stage/packages/include/expat" \
            CXXFLAGS="$opts -O3 -g -I$stage/packages/include/expat" \
            LDFLAGS="$opts -L$stage/packages/lib/release" \
            ./configure --with-pic --prefix="\${AUTOBUILD_PACKAGES_DIR}" --includedir="\${prefix}/include/xmlrpc-epi" --libdir="\${prefix}/lib/release"
            make -j$JOBS
            make install DESTDIR="$stage"
            make distclean
        ;;
        "linux64")
            # Default target to 64-bit
            opts="${TARGET_OPTS:--m64}"
            JOBS=`cat /proc/cpuinfo | grep processor | wc -l`
            HARDENED="-fstack-protector -D_FORTIFY_SOURCE=2"

            CFLAGS="$opts -Og -g -I$stage/packages/include/expat" \
            CXXFLAGS="$opts -Og -g -I$stage/packages/include/expat" \
            LDFLAGS="$opts -L$stage/packages/lib/debug" \
            ./configure --with-pic --prefix="\${AUTOBUILD_PACKAGES_DIR}" --includedir="\${prefix}/include/xmlrpc-epi" --libdir="\${prefix}/lib/debug"
            make -j$JOBS
            make install DESTDIR="$stage"
            make distclean

            CFLAGS="$opts -O3 -g $HARDENED -I$stage/packages/include/expat" \
            CXXFLAGS="$opts -O3 -g $HARDENED -I$stage/packages/include/expat" \
            LDFLAGS="$opts -L$stage/packages/lib/release" \
            ./configure --with-pic --prefix="\${AUTOBUILD_PACKAGES_DIR}" --includedir="\${prefix}/include/xmlrpc-epi" --libdir="\${prefix}/lib/release"
            make -j$JOBS
            make install DESTDIR="$stage"
            make distclean
        ;;
    esac
    mkdir -p "$stage/LICENSES"
    cp "COPYING" "$stage/LICENSES/xmlrpc-epi.txt"
popd

pass

