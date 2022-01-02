#!/usr/bin/env bash

set -euf -o pipefail

declare -A variants=(
  ['-Darker']='"-Dvariants=darker"'
  ['-Dark']='"-Dvariants=dark"'
  ['-Lighter']='"-Dvariants=lighter"'
  ['-solid']='"-Dvariants=light", "-Dtransparency=false"'
  ['-Darker-solid']='"-Dvariants=darker", "-Dtransparency=false"'
  ['-Dark-solid']='"-Dvariants=dark", "-Dtransparency=false"'
  ['-Lighter-solid']='"-Dvariants=lighter", "-Dtransparency=false"'
)

for variant in "${!variants[@]}"; do
  outdir="../org.gtk.Gtk3theme.Arc$variant/"
  sed -e "s/Arc/Arc$variant/g" -e "s/@CONFIG_OPTS@/${variants[$variant]}/" 'org.gtk.Gtk3theme.Arc.json.in' > "$outdir/org.gtk.Gtk3theme.Arc$variant.json"
  sed -e "s/Arc/Arc$variant/g" 'org.gtk.Gtk3theme.Arc.appdata.xml' > "$outdir/org.gtk.Gtk3theme.Arc$variant.appdata.xml"
done

sed -e 's/@CONFIG_OPTS@/"-Dvariants=light"/' 'org.gtk.Gtk3theme.Arc.json.in' > 'org.gtk.Gtk3theme.Arc.json'