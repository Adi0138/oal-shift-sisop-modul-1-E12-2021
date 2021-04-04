#!/bin/bash

n=1
for ((i=1; i<=23; i++))
do
        if ((n<=9))
        then
		wget -O Koleksi_0$n.jpg -a foto.log https://loremflickr.com/320/240/kitten
                for((j=1; j<n; j++))
                do
			if cmp -s "./Koleksi_0$j.jpg" "./Koleksi_0$n.jpg";
				then
                                rm "./Koleksi_0$n.jpg"
				n=$((n-1))     
				
				break
                        fi
                done
        else
		wget -O Koleksi_$n.jpg -a foto.log https://loremflickr.com/320/240/kitten
                for((j=1; j<n; j++))
                do
			if ((j<10))
                        	then
				if cmp -s "./Koleksi_0$j.jpg" "./Koleksi_$n.jpg";
				then 
				rm "./Koleksi_$n.jpg"
			        n=$((n-1))
				
			        break
				fi
			else
				if cmp -s "./Koleksi_$j.jpg" "./Koleksi_$n.jpg"; 
				then 
				rm "./Koleksi_$n.jpg"
				n=$((n-1))
				
				break
                        	fi
                        fi
                done
        fi
        n=$((n+1))
done

