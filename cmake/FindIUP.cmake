# Copyright (C) 2012 LuaDist.
# Created by Peter Kapec <kapecp@gmail.com>
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
#	Note:
#		Searching headers and libraries is very simple and is NOT as powerful as scripts
#		distributed with CMake, because LuaDist defines directories to search for.
#		Everyone is encouraged to contact the author with improvements. Maybe this file
#		becomes part of CMake distribution sometimes.

# - Find IUP
# Find the native IUP headers and libraries.
#
# IUP_INCLUDE_DIRS	- where to find iup.h.
# IUP_LIBRARIES	- List of libraries when using iup.
# IUP_FOUND	- True if IUP found.

# Look for the header file.
FIND_PATH( IUP_INCLUDE_DIR NAMES iup.h )

# Look for the library.
FIND_LIBRARY( IUP_LIBRARY NAMES iup)
FIND_LIBRARY( IUPGL_LIBRARY NAMES iupgl)
FIND_LIBRARY( IUPOLE_LIBRARY NAMES iupole)
FIND_LIBRARY( IUPCONTROLS_LIBRARY NAMES iupcontrols)
FIND_LIBRARY( IUPPPLOT_LIBRARY NAMES iup_pplot)
FIND_LIBRARY( IUPMGLPLOT_LIBRARY NAMES iup_mglplot)
FIND_LIBRARY( IUPIMGLIB_LIBRARY NAMES iupimglib)
FIND_LIBRARY( IUPWEB_LIBRARY NAMES iupweb)
FIND_LIBRARY( IUPTUIO_LIBRARY NAMES iuptuio)

FIND_LIBRARY( IUP_LIBRARY_LUA NAMES iuplua )

FIND_LIBRARY( IUPIM_LIBRARY NAMES iupim)
FIND_LIBRARY( IUPCD_LIBRARY NAMES iupcd)

# Handle the QUIETLY and REQUIRED arguments and set IUP_FOUND to TRUE if all listed variables are TRUE.
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(IUP DEFAULT_MSG IUP_LIBRARY IUP_INCLUDE_DIR)

# Copy the results to the output variables.
IF(IUP_FOUND)
	SET(IUP_LIBRARIES ${IUP_LIBRARY})
	SET(IUP_INCLUDE_DIRS ${IUP_INCLUDE_DIR})
ENDIF(IUP_FOUND)

MARK_AS_ADVANCED(IUP_INCLUDE_DIRS IUP_LIBRARIES)
