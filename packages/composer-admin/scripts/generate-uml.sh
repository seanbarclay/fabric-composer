#!/bin/bash

# Exit on first error, print all commands.
set -ev

# Grab the Concerto directory.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# Check for the system tests.
case ${TEST_SUITE} in
system*)
    echo Not executing as running system tests.
    exit 0
    ;;
esac

echo $(date) Generating PlantUML source files for public and private APIs...
node ./node_modules/composer-common/lib/codegen/parsejs.js --format PlantUML --inputDir "$DIR/lib" --outputDir "$DIR/out/uml"
node ./node_modules/composer-common/lib/codegen/parsejs.js --format PlantUML --private --inputDir "$DIR/lib" --outputDir "$DIR/out/uml-private"

echo $(date) Generating images for public and private APIs...
node ./node_modules/composer-common/lib/tools/plantumltoimage.js --inputDir "$DIR/out/uml" --outputDir "$DIR/out/diagrams"
node ./node_modules/composer-common/lib/tools/plantumltoimage.js --inputDir "$DIR/out/uml-private" --outputDir "$DIR/out/diagrams-private"
echo $(date) Processed UML files
