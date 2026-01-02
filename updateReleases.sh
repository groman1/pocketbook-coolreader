#!/bin/sh
mkdir -p releases/applications
cp -r data/common/system releases/
mkdir releases/system/share/cr3/skins
mkdir releases/system/share/cr3/bin
cp pbpro4/cr3gui/cr3-pb.app releases/system/share/cr3/bin/
cp releases/system/bin/cr3-pb.app releases/applications/
