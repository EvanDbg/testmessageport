## It got error: "(ipc/send) invalid destination port" while sending message from sandbox app to SpringBoard through CPDistributedMessagingCenter under iOS 11.4.1 + unc0ver.

## Situations:
* iOS 11.4.1 + unc0ver -> Failed
* iOS other versions + unc0ver -> Successful
* iOS all versions + Electra -> Successful

## How to build?
* Set THEOS path and THEOS_DEVICE_IP inside build.sh
* Execute ./build.sh,  it will build the app and tweak then install it.