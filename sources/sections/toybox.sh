# Build toybox

[ ! -z "$ARCH" ] && DO_CROSS=CROSS_COMPILE=${ARCH}-

setupfor toybox
make defconfig &&
CFLAGS="$CFLAGS $STATIC_FLAGS" make $DO_CROSS || dienow

if [ -z "$USE_TOYBOX" ]
then
  ln -sf toybox "$STAGE_DIR"/patch &&
  ln -sf toybox "$STAGE_DIR"/oneit &&
  ln -sf toybox "$STAGE_DIR"/netcat || dienow
else
  make install_flat PREFIX="$STAGE_DIR" || dienow
fi

cp toybox${SKIP_STRIP:+_unstripped} "$STAGE_DIR/toybox"

cleanup
