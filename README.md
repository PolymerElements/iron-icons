[![Published on NPM](https://img.shields.io/npm/v/@polymer/iron-icons.svg)](https://www.npmjs.com/package/@polymer/iron-icons)
[![Build status](https://travis-ci.org/PolymerElements/iron-icons.svg?branch=master)](https://travis-ci.org/PolymerElements/iron-icons)
[![Published on webcomponents.org](https://img.shields.io/badge/webcomponents.org-published-blue.svg)](https://webcomponents.org/element/@polymer/iron-icons)

## iron-icons

`iron-icons` is a utility import that includes the definition for the
`iron-icon` element, `iron-iconset-svg` element, as well as an import for the
default icon set.

The `iron-icons` directory also includes imports for additional icon sets that
can be loaded into your project.

Example loading icon set:

```html
<script type="module">
  import '@polymer/iron-icons/maps-icons.js';
</script>
```

To use an icon from one of these sets, first prefix your `iron-icon` with the
icon set name, followed by a colon, ":", and then the icon id.

Example using the directions-bus icon from the maps icon set:

```html
<iron-icon icon="maps:directions-bus"></iron-icon>
```

See: [Documentation](https://www.webcomponents.org/element/@polymer/iron-icons),
 [Demo](https://www.webcomponents.org/element/@polymer/iron-icons/demo/demo/index.html).

See [iron-icon](https://www.webcomponents.org/element/@polymer/iron-icon) for
more information about working with icons.

See [iron-iconset](https://www.webcomponents.org/element/@polymer/iron-iconset)
and
[iron-iconset-svg](https://www.webcomponents.org/element/@polymer/iron-iconset-svg)
for more information about how to create a custom iconset.

## Usage

### Installation

```
npm install --save @polymer/iron-icons
```

### In an HTML file

```html
<html>
  <head>
    <script type="module">
      import '@polymer/iron-icon/iron-icon.js';
      import '@polymer/iron-icons/iron-icons.js';
    </script>
  </head>
  <body>
    <iron-icon icon="search"></iron-icon>
  </body>
</html>
```

### In a Polymer 3 element

```js
import {PolymerElement} from '@polymer/polymer/polymer-element.js';
import {html} from '@polymer/polymer/lib/utils/html-tag.js';

import '@polymer/iron-icon/iron-icon.js';
import '@polymer/iron-icons/iron-icons.js';

class ExampleElement extends PolymerElement {
  static get template() {
    return html`
      <iron-icon icon="search"></iron-icon>
    `;
  }
}

customElements.define('example-element', ExampleElement);
```

## Contributing

If you want to send a PR to this element, here are the instructions for running
the tests and demo locally:

### Installation

```sh
git clone https://github.com/PolymerElements/iron-icons
cd iron-icons
npm install
npm install -g polymer-cli
```

### Running the demo locally

```sh
polymer serve --npm
open http://127.0.0.1:<port>/demo/
```

### Running the tests

```sh
polymer test --npm
```
