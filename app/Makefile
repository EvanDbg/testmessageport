include $(THEOS)/makefiles/common.mk

ARCHS = arm64

APPLICATION_NAME = testmessageport
testmessageport_FILES = main.m XXAppDelegate.m XXRootViewController.m
testmessageport_FRAMEWORKS = UIKit CoreGraphics Foundation

include $(THEOS_MAKE_PATH)/application.mk

after-install::
	install.exec "killall \"testmessageport\"" || true
