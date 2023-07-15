#!/bin/sh

PREFIX="[RACING]"
RESOURCE="npwd_qb_racing"

echo "$PREFIX Creating release"

## Create temporary folder and move files into it. Keeping same structure according to fxmanifest.lua
mkdir -p ./temp/$RESOURCE

cp README.md fxmanifest.lua ./temp/$RESOURCE
cp -r ./web ./temp/$RESOURCE
cp -r ./dist ./temp/$RESOURCE/dist # Copy files


echo "$PREFIX Zipping it up: $RESOURCE.zip"

cd ./temp && zip -r ../$RESOURCE.zip ./$RESOURCE