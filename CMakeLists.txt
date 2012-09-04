# Copyright (C) 2011-2012 LuaDist.
# Created by Peter Kapec
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

PROJECT(iup C CXX)
CMAKE_MINIMUM_REQUIRED(VERSION 2.6)
INCLUDE(cmake/dist.cmake)
INCLUDE( lua )

# find moduless
	FIND_PACKAGE(OpenGL)
	FIND_PACKAGE(GLUT)

	FIND_PACKAGE(Lua)

	find_package(IM REQUIRED)
	find_package(CD REQUIRED)
	find_package(IUP REQUIRED)

	INCLUDE_DIRECTORIES (${IUP_INCLUDE_DIRS} ${CD_INCLUDE_DIRS} ${IM_INCLUDE_DIRS})

############################################################################################

# install Lua modules
	install_lua_module(iupx examples/Lua/misc/modules/iupx.lua)
	install_lua_module(iupxpplot examples/Lua/misc/modules/iupxpplot.lua)

# install Lua examples from 'misc' folder

	# !!! renamed timer1.lua to timer1.wlua
	# 2DO: install readme.txt ???
	# 2DO: rename *.wlua to *.lua ???
	file(GLOB LUA_EXAMPLES_MISC examples/Lua/misc/*.wlua)
	install_example( ${LUA_EXAMPLES_MISC} INTO misc )

# install Lua examples

	# 2DO: what is indent.lua  ??? (not installed currently)
	file(GLOB LUA_EXAMPLES examples/Lua/*.wlua)
	install_example( ${LUA_EXAMPLES} )

# build LED examples

	# dial example app
	ADD_EXECUTABLE(dial_led examples/LED/dial.c)
	TARGET_LINK_LIBRARIES(dial_led ${IUPCONTROLS_LIBRARY} ${IUP_LIBRARY})

	# filedlg example app
	ADD_EXECUTABLE(filedlg_led examples/LED/filedlg.c)
	TARGET_LINK_LIBRARIES(filedlg_led ${IUP_LIBRARY})

	# gauge example app
	ADD_EXECUTABLE(gauge_led examples/LED/gauge.c)
	TARGET_LINK_LIBRARIES(gauge_led ${IUPCD_LIBRARY} ${IUPCONTROLS_LIBRARY} ${IUP_LIBRARY} ${CD_LIBRARY} )

	# matrix example app
	ADD_EXECUTABLE(matrix_led examples/LED/matrix.c)
	TARGET_LINK_LIBRARIES(matrix_led ${IUPCD_LIBRARY} ${IUPCONTROLS_LIBRARY} ${IUP_LIBRARY} ${CD_LIBRARY} )

	# tabs example app
	ADD_EXECUTABLE(tabs_led examples/LED/tabs.c)
	TARGET_LINK_LIBRARIES(tabs_led ${IUPCONTROLS_LIBRARY} ${IUP_LIBRARY})

	# toggle example app
	ADD_EXECUTABLE(toggle_led examples/LED/toggle.c)
	TARGET_LINK_LIBRARIES(toggle_led ${IUP_LIBRARY})

	INSTALL(TARGETS dial_led filedlg_led gauge_led matrix_led tabs_led toggle_led
			DESTINATION ${INSTALL_EXAMPLE}
			COMPONENT Example)

	FILE(GLOB LED_EXAMPLES "examples/LED/*.led")
	install_example( ${LED_EXAMPLES} INTO LED )

# build C examples

	# examples using IUP lib
	FILE(GLOB C_EXAMPLES "examples/C/iup/*.c")
	FOREACH(x ${C_EXAMPLES})
		get_filename_component(X_NAME ${x} NAME_WE) # name without extension
		ADD_EXECUTABLE(${X_NAME} ${x})
		TARGET_LINK_LIBRARIES(${X_NAME} ${IUP_LIBRARY})
		INSTALL(TARGETS ${X_NAME} DESTINATION ${INSTALL_EXAMPLE} COMPONENT Example)
	ENDFOREACH(x)

	# examples using IUP, IUPCONTROLS lib
	FILE(GLOB C_EXAMPLES "examples/C/iupcontrols/*.c")
	FOREACH(x ${C_EXAMPLES2})
		get_filename_component(X_NAME ${x} NAME_WE) # name without extension
		ADD_EXECUTABLE(${X_NAME} ${x})
		TARGET_LINK_LIBRARIES(${X_NAME} ${IUPCONTROLS_LIBRARY} ${IUP_LIBRARY})
		INSTALL(TARGETS ${X_NAME} DESTINATION ${INSTALL_EXAMPLE} COMPONENT Example)
	ENDFOREACH(x)

	# examples using other libs

		# canvas1.c example app
		ADD_EXECUTABLE(canvas1 examples/C/canvas1.c)
		TARGET_LINK_LIBRARIES(canvas1 ${CD_LIBRARY} ${IUPTUIO_LIBRARY} ${IUPCD_LIBRARY} ${IUP_LIBRARY})

		# canvas2.c example app
		ADD_EXECUTABLE(canvas2 examples/C/canvas2.c)
		TARGET_LINK_LIBRARIES(canvas2 ${CD_LIBRARY} ${IUPCD_LIBRARY} ${IUPTUIO_LIBRARY} ${IUP_LIBRARY})

		# canvas3.c example app
		ADD_EXECUTABLE(canvas3 examples/C/canvas3.c)
		TARGET_LINK_LIBRARIES(canvas3 ${IUPCD_LIBRARY} ${IUP_LIBRARY} ${CD_LIBRARY})

		# cells_checkboard.c example app
		ADD_EXECUTABLE(cells_checkboard examples/C/cells_checkboard.c)
		TARGET_LINK_LIBRARIES(cells_checkboard ${CD_LIBRARY} ${IUPCONTROLS_LIBRARY} ${IUP_LIBRARY})

		# cells_degrade.c example app
		ADD_EXECUTABLE(cells_degrade examples/C/cells_degrade.c)
		TARGET_LINK_LIBRARIES(cells_degrade ${CD_LIBRARY} ${IUPCONTROLS_LIBRARY} ${IUP_LIBRARY})

		# cells_numbering.c example app
		ADD_EXECUTABLE(cells_numbering examples/C/cells_numbering.c)
		TARGET_LINK_LIBRARIES(cells_numbering ${CD_LIBRARY} ${IUPCONTROLS_LIBRARY} ${IUP_LIBRARY})

		# colorbar example app
		if (CD_LIBRARY AND IUPCD_LIBRARY)
			ADD_EXECUTABLE(colorbar examples/C/colorbar.c)
			TARGET_LINK_LIBRARIES(colorbar ${CD_LIBRARY} ${IUPCONTROLS_LIBRARY} ${IUP_LIBRARY} ${IUPCD_LIBRARY})
		endif()

		IF(OPENGL_FOUND)
			INCLUDE_DIRECTORIES(${OPENGL_INCLUDE_DIR})

			# glcanvas.c example app
			ADD_EXECUTABLE(glcanvas examples/C/gl/glcanvas.c)
			TARGET_LINK_LIBRARIES(glcanvas ${IUPGL_LIBRARY} ${IUP_LIBRARY} ${OPENGL_LIBRARIES})

			# glcanvas_touch_modelview.c example app
			ADD_EXECUTABLE(glcanvas_touch_modelview examples/C/gl/glcanvas_touch_modelview.c)
			TARGET_LINK_LIBRARIES(glcanvas_touch_modelview ${IUPIM_LIBRARY} ${IUPTUIO_LIBRARY} ${IUPGL_LIBRARY} ${IUP_LIBRARY}  ${OPENGL_LIBRARIES})

			# glcanvas_touch_projection.c example app
			ADD_EXECUTABLE(glcanvas_touch_projection examples/C/gl/glcanvas_touch_projection.c)
			TARGET_LINK_LIBRARIES(glcanvas_touch_projection ${IUPIM_LIBRARY} ${IUPTUIO_LIBRARY} ${IUPGL_LIBRARY} ${IUP_LIBRARY}  ${OPENGL_LIBRARIES})

			INSTALL(TARGETS glcanvas glcanvas_touch_modelview glcanvas_touch_projection DESTINATION ${INSTALL_EXAMPLE} COMPONENT Example)

			# opengl3D.c example app	-- needed "GL/" fix
			IF (OPENGL_GLU_FOUND AND GLUT_FOUND)
				INCLUDE_DIRECTORIES(${GLUT_INCLUDE_DIR})

				ADD_EXECUTABLE(opengl3D examples/C/gl/opengl3D.c)
				TARGET_LINK_LIBRARIES(opengl3D ${IUPGL_LIBRARY} ${IUP_LIBRARY} ${GLUT_LIBRARIES} ${OPENGL_LIBRARIES})

				INSTALL(TARGETS opengl3D DESTINATION ${INSTALL_EXAMPLE} COMPONENT Example)
			ENDIF()
		ENDIF()

		# scrollbar.c	 example app
		ADD_EXECUTABLE(scrollbar examples/C/scrollbar)
		TARGET_LINK_LIBRARIES(scrollbar ${IUPCD_LIBRARY} ${CD_LIBRARY} ${IUP_LIBRARY})

		# webbrowser.c  example app
		IF(IUPWEB_LIBRARY)
			ADD_EXECUTABLE(webbrowser examples/C/webbrowser.c)
			TARGET_LINK_LIBRARIES(webbrowser ${IUPWEB_LIBRARY} ${IUP_LIBRARY})
			INSTALL(TARGETS webbrowser DESTINATION ${INSTALL_EXAMPLE} COMPONENT Example)
		ENDIF()

		#TODO: ole_browser.cpp example app
		IF(MSVC)
			ADD_EXECUTABLE(ole_browser examples/C/ole_browser.cpp)
			TARGET_LINK_LIBRARIES(ole_browser ${IUPOLE_LIBRARY} ${IUP_LIBRARY})
			INSTALL(TARGETS ole_browser DESTINATION ${INSTALL_EXAMPLE} COMPONENT Example)
		ENDIF()

		# pplot.cpp example app
		ADD_EXECUTABLE(pplot examples/C/pplot.cpp)
		TARGET_LINK_LIBRARIES(pplot ${CD_LIBRARY} ${IUPCONTROLS_LIBRARY} ${IUPPPLOT_LIBRARY} ${IUP_LIBRARY})

		ADD_EXECUTABLE(mathglsamples examples/C/mathglsamples.c)
		TARGET_LINK_LIBRARIES(mathglsamples ${IUPIM_LIBRARY} ${IM_LIBRARY_PROCESS} ${IM_LIBRARY}  ${IUPCONTROLS_LIBRARY}  ${IUPMGLPLOT_LIBRARY} ${IUP_LIBRARY})


		INSTALL(TARGETS canvas1 canvas2 canvas3 cells_checkboard cells_degrade cells_numbering
						colorbar glcanvas glcanvas_touch_modelview glcanvas_touch_projection
						scrollbar pplot mathglsamples
			DESTINATION ${INSTALL_EXAMPLE}
			COMPONENT Example)

	#2DO: lua_init
	if(LUA_FOUND)
		ADD_EXECUTABLE(lua_init examples/C/lua_init/lua_init.c)
		TARGET_LINK_LIBRARIES(lua_init ${LUA_LIBRARIES} ${IUP_LIBRARY_LUA} ${IUP_LIBRARY})
		INSTALL(TARGETS lua_init DESTINATION ${INSTALL_EXAMPLE})
		install_example( examples/C/lua_init/lua_init.lua )
	endif()