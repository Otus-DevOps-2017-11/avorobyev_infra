#!/bin/bash
#/inventory-1.1/bin/inventory --file environments/stage/inventory.ini --gcp-project mindful-atlas-188816 --gcp-zone europe-west1-d "$@"
WD=$(cd "$(dirname "$0")"; pwd -P )
cd "$WD"
PROJ_WD=/tmp/inventory_scripts
if [ -d "$PROJ_WD" ]
then
  cd "$PROJ_WD"
  git pull
else
  git clone git@github.com:a-vorobyev/scripts.git "$PROJ_WD"
  cd "$PROJ_WD"
fi >/dev/null &&\
./gradlew -q run -Pmy_run_args="--gcp-project mindful-atlas-188816 --gcp-zone europe-west1-d --file ${WD}/inventory.ini $@"
