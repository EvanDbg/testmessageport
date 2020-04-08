# source .env

ARCHS = arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = testmessageport
testmessageport_FILES = Tweak.xm

testmessageport_LIBRARIES += rocketbootstrap

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"