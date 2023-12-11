#Generated documentation for [bgrabitmap](www.github.com/bgrabitmap) using pasdoc.

https://domingogp.github.io/bgrabitmap_pasdoc/

The pasdoc parser don't support helper types so we must 
preprocess some files.

Requires

pasdoc    https://pasdoc.github.io/

graphwiz  https://www.graphviz.org/

sed       included in git 

Steps to generate.

edit builddocs.sh and change PATH

./builddocs.sh

The directory should be a sibiling of bgrabimap.

```
+--bgrabitmap
|
+--bgrabitmap_pasdoc
   |
   +--docs       <<<--- output here.
```    
	