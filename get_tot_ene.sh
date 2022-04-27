
#!/bin/bash

rm -f jobs_no

for d in ./*/ 	
do 
cd "$d"

 result=${PWD##*/}


te=$(grep 'TOTAL ENERGY' gamess.out | tail -1 | awk '{print$4}')
echo $result $te >> ../tot_ene
cd ../	
done
