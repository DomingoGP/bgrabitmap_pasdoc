# path for pasdoc, sed and dot.
# expected to be in a folder sibiling of bgrabitmap
# c:\bgrabitmap   <-- 
# c:\bgrabitmap_lazdoc 


export PATH=$PATH:"/c/Aplicaciones/pasdoc/bin":"/c/Program Files/Git/usr/bin":"/c/Program Files (x86)/Graphviz/bin"
DOCSPATH=docs
export SOURCEPATH=../bgrabitmap/bgrabitmap

mkdir -p $DOCSPATH

echo "Some files needs preprocess to be parsed by pasdoc."
pascal_pre_proc -D BGRABITMAP_USE_LCL -D FPC -D WINDOWS -D FPC_FULLVERSION=30202 -I $SOURCEPATH $SOURCEPATH/bgrabitmaptypes.pas >bgrabitmaptypes.pas

#  pasdoc gives error parsing   TColorHelper = type helper for TColor 
# but works with:    TColorHelper = class helper for TColor
# so we change that.

sed -i 's/type helper/class helper/g' bgrabitmaptypes.pas

pasdoc --include $SOURCEPATH --output $DOCSPATH @config_file.txt -S files.txt 

# Gives error with last versions ???
# https://github.com/pasdoc/pasdoc/issues/124
# edit GVUses.dot and change DiGraph  ->  digraph
# edit GVClasses.dot and change DiGraph  ->  digraph

sed -i 's/DiGraph/digraph/g' $DOCSPATH/GVUses.dot
sed -i 's/DiGraph/digraph/g' $DOCSPATH/GVClasses.dot

#remove Classes and SysUtils to make the image more readable

sed -i '/"SysUtils"/d' $DOCSPATH/GVUses.dot
sed -i '/"sysutils"/d' $DOCSPATH/GVUses.dot
sed -i '/"Classes"/d' $DOCSPATH/GVUses.dot
sed -i '/"classes"/d' $DOCSPATH/GVUses.dot

dot -Grankdir=LR -T svg $DOCSPATH/GVUses.dot > $DOCSPATH/GVUses.svg
#dot -T svg $DOCSPATH/GVUses.dot > $DOCSPATH/GVUses.svg
#dot -T svg $DOCSPATH/GVClasses.dot > $DOCSPATH/GVClasses.svg
dot -Grankdir=LR -T svg $DOCSPATH/GVClasses.dot > $DOCSPATH/GVClasses.svg
#delete preprocessed file.
rm bgrabitmaptypes.pas
