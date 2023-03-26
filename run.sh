#!/bin/bash
set -e
DATABASE_COLLECTIONS=('collection1' 'collection2' 'collection3')
DATABASE_NAME="db1"
DATABASE_URI="mongodb://root:password@127.0.0.1:27017/"

suffix=$(date +%s)
rm -rf ./exports
for i in "${DATABASE_COLLECTIONS[@]}"
do
    echo "exporting $i ..."
    mongoexport --uri $DATABASE_URI --db $DATABASE_NAME --authenticationDatabase=admin --collection $i -o exports/$i.json
    echo "exporting $i ... DONE"
    echo "" 
done

echo "creating archive ..."
tar -czvf $DATABASE_NAME-$suffix.tar.gz exports
echo "creating archive ... DONE"
echo ""

echo "cleaning up ..."
rm -rf ./exports
echo "cleaning up ... DONE"