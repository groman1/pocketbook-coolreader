# CoolReader 3 - free e-book reader
(c) Vadim Lopatin, 1998-2009
All source codes (except thirdparty directory) are provided under the terms of GNU GPL license, version 2

--------------------------------------------------------------------------------

This is a fork of the [pocketbook-coolreader](https://github.com/blchinezu/pocketbook-coolreader/releases), and was created for my Pocketbook 613 without WiFi and touchscreen, which makes some of the port's features useless.

It features some fixes (feature removals) of the original port:
 - No Google/Wikipedia icons in the dictionary menu
 - No link navigation menu, intended for use with keybinds of Pocketbook

--------------------------------------------------------------------------------

### Directories:

    crengine   - CREngine (DOM/XML/CSS ebook rendering library) sources
    cr3gui     - CR3 with CR3GUI for e-ink devices sources
    thirdparty - third party libraries, to use if not found in system
    tinydict   - small library for .dict file format support
    tools      - miscellaneous configuration files

--------------------------------------------------------------------------------

### External dependencies:

    common: zlib, libpng, libjpeg, freetype, libcurl
    cr3gui/xcb: libxcb, fontconfig
    cr3gui/nanoX: libnanoX

--------------------------------------------------------------------------------

## How to build and install

- Download the [SDK](https://github.com/blchinezu/pocketbook-sdk) and dependencies (zip, g++, cmake)
- Move the FRSCSDK folder from the downloaded SDK two directories higher than this repository
- Build with:
```bash
bash make.sh pro4
```
- The executable will be located at cr3gui/cr3-pb.app , put it into applications and system/share/cr3/bin folders on your Pocketbook
- All other files will be located at data/common/ , copy the system folder into the root directory of your Pocketbook
