for f in ./src/revy/*.re; do node_modules/.bin/bsc -format $f > ${f%.re}.res && rm $f; done