#!/bin/bash
#
# @license
# Copyright (c) 2014 The Polymer Project Authors. All rights reserved.
# This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
# The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
# The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
# Code distributed by Google as part of the polymer project is also
# subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
#
set -e

ICONSRC="material-design-icons/"
ORIGIN="git://github.com/google/material-design-icons.git"

# bootstrap a sparse SVG only checkout
bootstrap() {
  mkdir -p ${ICONSRC}
  pushd ${ICONSRC}
  git init
  git config core.sparsecheckout true
  echo "*/svg/production/*_24px.svg" >> .git/info/sparse-checkout
  git remote add -f origin ${ORIGIN}
  popd
}

header() {
cat > $1 <<ENDL
<!--
Copyright (c) 2014 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
-->

<link rel="import" href="../core-icon/core-icon.html">
<link rel="import" href="../core-iconset-svg/core-iconset-svg.html">
<core-iconset-svg id="$2" iconSize="24">
<svg><defs>
ENDL
}

footer(){
cat >> $1 <<ENDL
</defs></svg>
</core-iconset-svg>
ENDL
}

contains() {
  local e
  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
  return 1;
}

build() {
# dirname of path to current script
local runfrom="${0%[/\\]*}"
local folder="$1"

# put these sets into one big "icons" set
local default=(action alert content file navigation toggle)

local name="icons"
local file="../core-icons.html"

# special docs header for core-icons.html
cat > $file <<'ENDL'
<!--
Copyright (c) 2014 The Polymer Project Authors. All rights reserved.
This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
Code distributed by Google as part of the polymer project is also
subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt
-->
<!--

`core-icons` is a utitliy import that includes the definition for the `core-icon` element, `core-iconset-svg` element, as well as an import for the default icon set.

The `core-icons` directory also includes imports for additional icon sets that can be loaded into your project.

Example loading icon set:

    <link rel="import" href="../core-icons/maps-icons.html">

To use an icon from one of these sets, first prefix your `core-icon` with the icon set name, followed by a colon, ":", and then the icon id.

Example using the directions-bus icon from the maps icon set:

    <core-icon icon="maps:directions-bus"></core-icon>


See [core-icon](#core-icon) for more information about working with icons.

See [core-iconset](#core-iconset) and [core-iconset-svg](#core-iconset-svg) for more information about how to create a custom iconset.

@group Polymer Core Elements
@element core-icons
@homepage polymer.github.io
-->
<link rel="import" href="../core-icon/core-icon.html">
<link rel="import" href="../core-iconset-svg/core-iconset-svg.html">
<core-iconset-svg id="icons" iconSize="24">
<svg><defs>
ENDL

# find all the default icons, sort by basename (in perl), run concat
find "${default[@]/#/$folder}" -name "*24px.svg" | xargs $runfrom/concat-svg.js | sort >> $file

footer $file

local dir
for dir in $folder/*/; do
  if contains "`basename $dir`" "${default[@]}"; then
    continue
  fi
  echo $dir
  name=`basename $dir`
  file="../$name-icons.html"
  header $file $name
  find $dir -name "*24px.svg" | xargs $runfrom/concat-svg.js | sort >> $file
  footer $file
done
}

[ -d ${ICONSRC} ] || bootstrap

pushd ${ICONSRC}
git pull origin master
popd

pushd util
npm install
build ../${ICONSRC}
popd
