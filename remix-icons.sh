#!/usr/bin/bash

DIR_BASE=/usr/share/themes
DIR_NAME=$(gsettings get org.gnome.desktop.interface gtk-theme | sed "s/'//g")
DIR_FILE_GTK=$DIR_BASE/$DIR_NAME/gtk-3.0/gtk.css

DIR_TEMP=$HOME/.cache/zorin-touchup
DIR_ICON=$HOME/.local/share/zorin-touchup/icons
DIR_REAL_LIGHT=$HOME/.local/share/icons/Light-Icons
DIR_REAL_DARK=$HOME/.local/share/icons/Dark-Icons

mkdir -p $DIR_TEMP/icons/light
mkdir -p $DIR_TEMP/icons/dark
mkdir -p $DIR_ICON/light
mkdir -p $DIR_ICON/dark
mkdir -p $DIR_REAL_LIGHT
mkdir -p $DIR_REAL_DARK

cp -rf $DIR_ICON/light $DIR_TEMP/icons
cp -rf $DIR_ICON/dark $DIR_TEMP/icons

THEME_COLOR_EG=$(cat $DIR_FILE_GTK | grep -i "define-color theme_unfocused_fg_color" | cut -d ' ' -f3 | sed "s/;//g")
THEME_COLOR_FG=$(cat $DIR_FILE_GTK | grep -i "define-color theme_fg_color" | cut -d ' ' -f3 | sed "s/;//g")
THEME_COLOR_BG=$(cat $DIR_FILE_GTK | grep -i "define-color theme_bg_color" | cut -d ' ' -f3 | sed "s/;//g")

echo "FG: ${THEME_COLOR_FG} BG: ${THEME_COLOR_BG} EG: ${THEME_COLOR_EG}"

FILE_NME=$DIR_TEMP/list.txt
FILE_TOP=$DIR_TEMP/list_top.txt

# WHITE ICONS
ls $DIR_TEMP/icons/light/scalable/ > $FILE_TOP
while read -r LINE; do
	ls $DIR_TEMP/icons/light/scalable/$LINE/*.svg > $FILE_NME
	while read -r LINE; do
		sed -i 's|#cccccc|'${THEME_COLOR_FG}'|g' ${LINE}
		sed -i 's|#ffaa00|'${THEME_COLOR_EG}'|g' ${LINE}

		sed -i "s|fill:#cccdce|fill:${THEME_COLOR_EG}|g" ${LINE}
		sed -i "s|stop-color:#ddd|stop-color:${THEME_COLOR_FG}|g" ${LINE}
    		sed -i "s|stop-color:#fff|stop-color:${THEME_COLOR_FG}|g" ${LINE}
		sed -i "s|fill:#707073|fill:${THEME_COLOR_BG}|g" ${LINE}
	done < $FILE_NME
	rm -f $FILE_NME
done < $FILE_TOP
rm -f $FILE_TOP

# BLACK ICONS
ls $DIR_TEMP/icons/dark/scalable/ > $FILE_TOP
while read -r LINE; do
        ls $DIR_TEMP/icons/dark/scalable/$LINE/*.svg > $FILE_NME
        while read -r LINE; do
                sed -i 's|#000000|'${THEME_COLOR_FG}'|g' ${LINE}
                sed -i 's|#ffaa00|'${THEME_COLOR_EG}'|g' ${LINE}

		sed -i "s|fill:#999|fill:${THEME_COLOR_EG}|g" ${LINE}
                sed -i "s|stop-color:#000|stop-color:${THEME_COLOR_FG}|g" ${LINE}
                sed -i "s|stop-color:#666|stop-color:${THEME_COLOR_FG}|g" ${LINE}
                sed -i "s|fill:#000000|fill:${THEME_COLOR_BG}|g" ${LINE}
        done < $FILE_NME
        rm -f $FILE_NME
done < $FILE_TOP
rm -f $FILE_TOP

# COPY OVER TO THE REAL DIRECTORY
cp -rf $DIR_TEMP/icons/light/* $DIR_REAL_LIGHT
cp -rf $DIR_TEMP/icons/dark/* $DIR_REAL_DARK



# REFRESH ICONS
gsettings set org.gnome.desktop.interface icon-theme "Hicolor"
sleep 1
if [[ $DIR_NAME == *"Dark"* ]]; then
	gsettings set org.gnome.desktop.interface icon-theme "Light-Icons"
else
	gsettings set org.gnome.desktop.interface icon-theme "Dark-Icons"
fi
