#!/bin/bash
# Remove the previous intermediate files
rm -f *.dat

# extract the delta and eps_pt values
 for file in $(find . -type f -iname "pt_out_*")
      do echo $file|grep delta $file|tail -4|awk  '{ printf( "%s ", $2 ); } END { printf( "\n   " ); }' ; done >> 2.dat
  for file in $(find . -type f -iname "pt_out_*")
      do grep eps_pt $file | tail -1 | awk '{print$4}' ; done >> 1.dat

# Merge the values from 1.dat and 2.dat into 3.dat
paste 1.dat 2.dat >> 3.dat
sort -k1 -g -r  3.dat >> pt_all.dat     
sed -i '$d' pt_all.dat
len=$(wc -l pt_all.dat | awk '{print$1}')

# Extract the Lowest eigen value
grep "Lowest eigenvalue =" var_out_hci  | tail -1 | awk '{print$9" " $10" " $11" "$12}' >> 4.dat
awk '{for(i=1; i<=n; i++) print}' n=$len 4.dat >> var.dat
grep "eps_var" input.inp  | tail -1 | awk '{print$1}' >> 5.dat
awk '{for(i=1; i<=n; i++) print}' n=$len 5.dat >> eps_var.dat
#Combine the values in pt_all.dat, var.dat, and eps_var.dat and store the result in tot_ene.dat.
paste  pt_all.dat var.dat | awk '{ printf("%2.10f %2.10f %2.11f %2.10f\n",$2+$6,$3+$7, $4+$8, $5+$9)  }' >> tot_ene.dat
##
echo "Varitaion energy" >> final.dat
cat 4.dat >> final.dat
echo "eps1 = " >> final.dat 
cat 5.dat >> final.dat
## Calculating bend and stretch values
awk '{ printf("%.10f %.10f\n",($2-$1)*219474.6,($4-$1)*219474.26)  }' 4.dat  >> var_bend.dat
 echo "Bend and stretch values after variational part= " >> final.dat 
 cat var_bend.dat >> final.dat
echo "petruabtive correction energies" >> final.dat
echo "  eps2       delta1                   delta2                delta3               delta4" >> final.dat
cat pt_all.dat >> final.dat
cat pt_all.dat | awk '{ printf("%2.10f %2.10f %2.10f %2.11f %2.10f\n",$1,$2*-1, $3*-1,$4*-1,$5*-1)}' >> pos_del.dat
# Combine values into graph.dat 
paste  eps_var.dat pos_del.dat  tot_ene.dat >> graph.dat
#tail -1 graph.dat >> ../extrapol.dat
tail -1 tot_ene.dat | awk '{ printf("%.10f %.10f\n",($2-$1)*219474.6,($4-$1)*219474.26)  }' >> bend_stretch.dat
echo " bend and stretch values after perturbative part" >> final.dat
cat bend_stretch.dat >> final.dat

#echo " extrapolation values"
#Summary of the calculation and analysis results
 echo "total_energy = " >> final.dat 
 tail -1 tot_ene.dat >> final.dat
echo "summary of the calculation"
cat final.dat

