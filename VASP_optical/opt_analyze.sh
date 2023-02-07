#!/bin/bash
rm -f *.dat
### Extracting the Imaginary and real dielectric function information from VASP output file

line1=$( grep -n 'IMAGINARY DIELECTRIC' OUTCAR| awk '{print$1}'| sed 's/://g')
line2=$( grep -n 'REAL DIELECTRIC' OUTCAR| awk '{print$1}'| sed 's/://g')
line4=$(grep -n 'epsilon' OUTCAR| awk '{print$1}'| sed 's/://g')


echo $line1
echo $line2
line3=$(echo $line2-2|bc)
line4=$(echo $line4-2|bc)

echo $line1
echo $line2

sed -n ${line1},${line3}p   OUTCAR > img.dat
sed -n ${line2},${line4}p   OUTCAR > real.dat


