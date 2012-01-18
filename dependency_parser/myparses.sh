#!/usr/bin/env bash
#
# Runs the English PCFG parser on one or more files, printing trees only

javac -cp stanford-parser.jar MyParser.java

FILENAME=sources/$1
cat $FILENAME | while read LINE
do
    date
    echo "$LINE"
    filename=$(basename $LINE)
    filename=${filename%.*}
    zcat gigaword/data/$LINE > mydata/$filename
    java -d64 -mx2g -cp "stanford-parser.jar:" MyParser $filename
    rm mydata/$filename
done

#java -mx150m -cp "stanford-parser.jar:" MyParser

#zcat gigaword/data/nyt_eng/nyt_eng_200511.gz | java -cp stanford-parser.jar -mx1g edu.stanford.nlp.parser.lexparser.LexicalizedParser -outputFormat "typedDependencies" -parseInside P grammar/englishPCFG.ser.gz - >> output.txt
