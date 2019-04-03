#! /usr/bin/env bash
#
# Filter IJKPlayer project files for iOS.


# 1
# Drag source files to your Xcode project. The structure is like:
#
# IJKMediaPlayer
# |--ijkmedia
#    |--ffmpeg
#    |--ijkplayer
#    |--ijksdl
#    <IJKMediaPlayer-Source>

# 2
# Add <Header Search Paths>:
# $(PROJECT_DIR)/CXPlayer/IJKMediaPlayer/ijkmedia non-recursive
# $(PROJECT_DIR)/CXPlayer/IJKMediaPlayer/ijkmedia/ijkplayer non-recursive
# $(PROJECT_DIR)/CXPlayer/IJKMediaPlayer/ijkmedia/ffmpeg/include non-recursive

# 3
# Add <Compiler Flags> '-fno-objc-arc' for these files:
# ijksdl_vout_ios_gles2.m
# ijkplayer_ios.m
# ijksdl_aout_ios_audiounit.m

# 4
# You may get compiler errors like: 
#
# Undefined symbols for architecture arm64:
#   "_inflate", referenced from:
#       _http_read_stream in libavformat.a(http.o)
#       _rtmp_open in libavformat.a(rtmpproto.o)
#
# Add these libs and Framework to <Linked Frameworks and Libraries> and IJKPlayer project podspec file:
# libz.1.2.5.tbd
# libbz2.1.0.dylib
# libiconv.2.4.0.dylib
# CoreMedia.framework
# VideoToolbox.framework


###### Var ######
IJKMEDIAPLAYER_SOURCE_DIR="IJKMediaPlayer/IJKMediaPlayer"
IJKMEDIAPLAYER_TARGET_DIR="../../IJKMediaPlayer_Project_Files"

IJKPLAYER_SOURCE_DIR="../ijkmedia/ijkplayer/*"
IJKPLAYER_TARGET_DIR=$IJKMEDIAPLAYER_TARGET_DIR/IJKMediaPlayer/ijkmedia/ijkplayer
IJKPLAYER_EXCLUDE_DIR_1=$IJKPLAYER_TARGET_DIR/android
IJKPLAYER_EXCLUDE_DIR_2=$IJKPLAYER_TARGET_DIR/Android.mk

IJKSDL_SOURCE_DIR="../ijkmedia/ijksdl/*"
IJKSDL_TARGET_DIR=$IJKMEDIAPLAYER_TARGET_DIR/IJKMediaPlayer/ijkmedia/ijksdl
IJKSDL_EXCLUDE_DIR_1=$IJKSDL_TARGET_DIR/android
IJKSDL_EXCLUDE_DIR_2=$IJKSDL_TARGET_DIR/Android.mk

FFMPEG_LIB_SOURCE_DIR="build/universal"
FFMPEG_LIB_TARGET_DIR=$IJKMEDIAPLAYER_TARGET_DIR/IJKMediaPlayer/ijkmedia

###### Clean ######
rm -rf $IJKMEDIAPLAYER_TARGET_DIR

###### Copy project files ######
# Filter dir 
mkdir -p $IJKMEDIAPLAYER_TARGET_DIR

# IJKMediaPlayer source files.
cp -r $IJKMEDIAPLAYER_SOURCE_DIR $IJKMEDIAPLAYER_TARGET_DIR 

# ijkplayer iOS source files.
cp -r $IJKPLAYER_SOURCE_DIR $IJKPLAYER_TARGET_DIR
rm -rf $IJKPLAYER_EXCLUDE_DIR_1
rm -rf $IJKPLAYER_EXCLUDE_DIR_2

# ijksdl iOS source files.
cp -r $IJKSDL_SOURCE_DIR $IJKSDL_TARGET_DIR
rm -rf $IJKSDL_EXCLUDE_DIR_1
rm -rf $IJKSDL_EXCLUDE_DIR_2

# FFmpeg lib files.
cp -r $FFMPEG_LIB_SOURCE_DIR $FFMPEG_LIB_TARGET_DIR
mv $FFMPEG_LIB_TARGET_DIR/universal $FFMPEG_LIB_TARGET_DIR/ffmpeg

