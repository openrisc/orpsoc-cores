LEGACY_DIR=$BUILD_ROOT/src/de0_nano
DIR=$BUILD_ROOT/src/de0_nano_0
echo $LEGACY_DIR
echo $DIR
[ -d $LEGACY_DIR ] && ln -s $LEGACY_DIR $DIR
