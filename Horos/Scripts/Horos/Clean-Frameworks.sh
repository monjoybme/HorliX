#!/bin/sh

set -x

framework_path="$TARGET_BUILD_DIR/$FRAMEWORKS_FOLDER_PATH/Horos.framework"

# many plugins are hard-linked to the API framework, and its name changed over time

alts=( HorosAPI OsiriXAPI 'OsiriX Headers' )
for alt in "${alts[@]}"; do
    alt_framework_path="$TARGET_BUILD_DIR/$FRAMEWORKS_FOLDER_PATH/$alt.framework"
    rm -Rf "$alt_framework_path"
    cp -R "$TARGET_BUILD_DIR/$FRAMEWORKS_FOLDER_PATH/Horos.framework" "$alt_framework_path"
    mv "$alt_framework_path/Versions/A/Horos" "$alt_framework_path/Versions/A/$alt"
    rm "$alt_framework_path/Horos"
    cd "$alt_framework_path"
    ln -s "Versions/A/$alt"
    sed -i '' "s/Horos/$alt/" "Versions/A/Resources/Info.plist"
    sed -i '' "s/org.horosproject.api/org.horosproject.$alt/" "Versions/A/Resources/Info.plist"
    #exception since this is temporary
    sed -i '' "s/org.horosproject.OsiriX\ Headers/org.horosproject.OsiriXHeaders/" "Versions/A/Resources/Info.plist"
done

alts=( HorosDCM )
for alt in "${alts[@]}"; do
    alt_framework_path="$TARGET_BUILD_DIR/$FRAMEWORKS_FOLDER_PATH/$alt.framework"
    rm -Rf "$alt_framework_path"
    cp -R "$TARGET_BUILD_DIR/$FRAMEWORKS_FOLDER_PATH/DCM.framework" "$alt_framework_path"
    mv "$alt_framework_path/Versions/A/DCM" "$alt_framework_path/Versions/A/$alt"
    rm "$alt_framework_path/DCM"
    cd "$alt_framework_path"
    ln -s "Versions/A/$alt"
    sed -i '' "s/DCM/$alt/" "Versions/A/Resources/Info.plist"
    sed -i '' "s/org.horosproject.dcm/org.horosproject.$alt/" "Versions/A/Resources/Info.plist"
done

exit 0
