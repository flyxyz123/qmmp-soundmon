# references:
# https://github.com/cspiegel/qmmp-adplug
# https://github.com/cspiegel/qmmp-openmpt

HEADERS += decoderbpfactory.h \
           decoder_bp.h \
           bphelper.h
    
SOURCES += decoderbpfactory.cpp \
           decoder_bp.cpp \
           bphelper.cpp \
           libbp/channel.cpp \
           libbp/instrument.cpp \
           libbp/module.cpp \
           libbp/player.cpp \
           libbp/soundplayer.cpp

CONFIG += warn_on plugin link_pkgconfig

TEMPLATE = lib

QMAKE_CLEAN += lib$${TARGET}.so

unix {
	CONFIG += link_pkgconfig
	PKGCONFIG += qmmp
	
	QMMP_PREFIX = $$system(pkg-config qmmp --variable=prefix)
	PLUGIN_DIR = $$system(pkg-config qmmp --variable=plugindir)/Input
	LOCAL_INCLUDES = $${QMMP_PREFIX}/include
	LOCAL_INCLUDES -= $$QMAKE_DEFAULT_INCDIRS
	INCLUDEPATH += $$LOCAL_INCLUDES
	
	plugin.path = $${PLUGIN_DIR}
	plugin.files = lib$${TARGET}.so
	INSTALLS += plugin
}
