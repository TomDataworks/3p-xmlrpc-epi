# Copyright (C) 2014 Cinder Roxley, All rights reserved.

cmake_minimum_required(VERSION 2.8.4)
project(xmlrpc_epi)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

set(SOURCE_FILES
    src/base64.c
    src/encodings.c
    src/queue.c
    src/simplestring.c
    src/system_methods.c
    src/xml_element.c
    src/xml_to_dandarpc.c
    src/xml_to_soap.c
    src/xml_to_xmlrpc.c
    src/xmlrpc.c
    src/xmlrpc_introspection.c
    )

set(HEADER_FILES
    src/base64.h
    src/encodings.h
    src/queue.h
    src/simplestring.h
    src/system_methods_private.h
    src/xml_element.h
    src/xml_to_dandarpc.h
    src/xml_to_soap.h
    src/xml_to_xmlrpc.h
    src/xmlrpc.h
    src/xmlrpc_introspection.h
    src/xmlrpc_introspection_private.h
    src/xmlrpc_private.h)

add_executable(xmlrpc_epi ${SOURCE_FILES})
