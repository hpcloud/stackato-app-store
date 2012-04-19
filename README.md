## Overview

The Stackato App Store is a feature of Stackato that allows people to install apps directly from their sources. A Stackato Admin can point their Stackato installation at 1 or more "stores". By default, Stackato points to store data in this repo.

A store is just a database of pointers to the source locations of apps, and a little extra meta info needed to install the app.

## Adding Apps to the Store

This is a set of instructions for adding an app to the current Stackato store.

### On this branch (store)

* Edit the `$VERSION/$NAME.yaml` file with your new app info.
  * Be sure to add it in alphabetical order by id.
  * id should be unique, short and lowercase
  * Look at other apps for guidance
* Make sure your app entry in the yaml points to a valid repo
* Run `make` to update the `apps.json` and `apps.jsonp` files.

