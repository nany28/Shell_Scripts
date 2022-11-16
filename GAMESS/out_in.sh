#!/bin/bash
rm -f *.dat
### Extracting the final coordinates from gamess.out file
line1=$(grep -n "COORDINATES OF ALL ATOMS ARE (ANGS)" gamess.out| tail -1 | awk '{print$1}'| sed 's/://g')
line2=$(grep -n "INTERNUCLEAR DISTANCES (ANGS.)" gamess.out| tail -1 | awk '{print$1}'| sed 's/://g')

echo $line1
echo $line2
line1=$(echo $line1+3|bc)
line2=$(echo $line2-2|bc)

echo $line1
echo $line2

sed -n ${line1},${line2}p   gamess.out >> final_coor.dat
echo ' $END' >> final_coor.dat
cp -f gamess.out optimize.out
# Writng final coordinates to input file

c1=$(grep -n "C1" propyl.inp| tail -1 | awk '{print$1}'| sed 's/://g')

sed  ${c1}q propyl.inp >> top.dat
rm -f propyl.inp
cat top.dat final_coor.dat >> propyl.inp
