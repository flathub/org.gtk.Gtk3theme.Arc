#!/usr/bin/env bash

set -euf -o pipefail

declare -A variants=(
  ['-Darker']='"--disable-light", "--disable-dark"'
  ['-Dark']='"--disable-light", "--disable-darker"'
  ['-solid']='"--disable-darker", "--disable-dark", "--disable-transparency"'
  ['-Darker-solid']='"--disable-light", "--disable-dark", "--disable-transparency"'
  ['-Dark-solid']='"--disable-light", "--disable-darker", "--disable-transparency"'
)

for variant in "${!variants[@]}"; do
  outdir="../org.gtk.Gtk3theme.Arc$variant/"
  sed -e "s/Arc/Arc$variant/g" -e "s/@CONFIG_OPTS@/${variants[$variant]}/" 'org.gtk.Gtk3theme.Arc.json.in' > "$outdir/org.gtk.Gtk3theme.Arc$variant.json"
  sed -e "s/Arc/Arc$variant/g" 'org.gtk.Gtk3theme.Arc.appdata.xml' > "$outdir/org.gtk.Gtk3theme.Arc$variant.appdata.xml"
  cp append-solid-suffix.patch $outdir
done

sed -e 's/@CONFIG_OPTS@/"--disable-dark", "--disable-darker"/' 'org.gtk.Gtk3theme.Arc.json.in' > 'org.gtk.Gtk3theme.Arc.json'