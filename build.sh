#!/bin/sh

export THEOS_DEVICE_IP=192.168.31.212
export THEOS=/opt/theos


cd ./app

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>> building app..."
make clean
make


echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>> copying app to layout..."
rm -rf ../layout/Applications/*
cp -r ./.theos/obj/debug/testmessageport.app ../layout/Applications/


cd ..

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>> building package..."
make clean
make package install
