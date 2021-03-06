
Log "Starting '$ISO_MKISOFS_BIN'"
LogPrint "Making ISO image"

pushd $TMP_DIR >&2

# If isofs directory exists, add its content to ISO_FILES (when backup must be part of the ISO images)
if [ -d isofs ] ; then
    ISO_FILES=( ${ISO_FILES[@]} isofs )
fi

# mkisofs command for ppc64/ppc64le arch
$ISO_MKISOFS_BIN $v -o "$ISO_DIR/$ISO_PREFIX.iso" -U -chrp-boot -R -J -volid "$ISO_VOLID" -v -graft-points "${ISO_FILES[@]}" >&2

StopIfError "Could not create ISO image (with $ISO_MKISOFS_BIN)"
popd >&2

iso_image_size=( $(du -h "$ISO_DIR/$ISO_PREFIX.iso") )
LogPrint "Wrote ISO image: $ISO_DIR/$ISO_PREFIX.iso ($iso_image_size)"

# Add ISO image to result files
RESULT_FILES=( "${RESULT_FILES[@]}" "$ISO_DIR/$ISO_PREFIX.iso" )
