#!/bin/bash

REGEX_FILE="$(dirname $0)/urlmatch.regex"

function MakeAnchor() {
  echo $@ | tr "# " "_"
}

# Header.
cat <<EOF_EOF_EOF
<html>
  <head>
    <title>logs! logs! logs!</title>
  </head>
  <body>
EOF_EOF_EOF

# Table of contents.
echo "    <div>"
echo "      <div id=\"TOC\"><h1>Table of Contents</h1></div>"
for logfile in "$@"; do
  anchor=$(MakeAnchor "$logfile")
  echo "      <div><a href="#$anchor">$logfile</a></div>"
done
echo "      <hr/>"
echo "    </div>"

# Contents.
for logfile in "$@"; do
  anchor=$(MakeAnchor "$logfile")
  echo "    <div>"
  echo "      <div id=\"$anchor\"><h1>$logfile:</h1></div>"
  for URL in $(grep -hoPf "$REGEX_FILE" -- "$logfile"); do
    echo "      <div><a href=\"$URL\">$URL</a></div>"
  done
  echo "      <hr/>"
  echo "    </div>"
done

# Footer.
cat <<EOF_EOF_EOF
  </body>
 </html>
EOF_EOF_EOF

# Done.
