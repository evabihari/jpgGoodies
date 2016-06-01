#!/bin/bash
# based on the GPS information stored in the JPEG file aks location data
# from GOOGLE API and stores into the ImageLocation and UserComment arguments
# usage for all JPG files within a directory:
#    for i in *.JPG; do <Location/addLocation.sh> $i; done
# parameters to the script:
# Parameter1: FileName

export KEY=<KEY>
export Artist=<ARTIST>
export Owner=<OWNER>
export CopyRight='2016'

export Text=`exiftool -c "%+.6f"  $1|grep "GPS Position"`

export Lattitude=`echo $Text | sed -e 's/.* : //;s/, .*//'` ; echo $Lattitude
export Longitude=`echo $Text | sed -e 's/.* //'` ; echo $Longitude

export OUTPUT="out.txt"

curlCmd="curl -vs -o $OUTPUT https://maps.googleapis.com/maps/api/geocode/json?latlng=$Lattitude,$Longitude&key=$KEY"

eval $curlCmd
wait ${!}

echo "FileName: " $1

export Address=`grep formatted_address $OUTPUT|sed -n 1p` ; echo $Address

export AddressInfo=`echo $Address | sed -e 's/",$//;s/.* : "//'` ; echo $AddressInfo

exiftool -UserComment="$AddressInfo" -ImageDescription="$AddressInfo" -OwnerName="$Owner" -Artist="$Artist" -CopyRight="$CopyRight" $1

export Text=''
export AddressInfo=''
export Address=''

rm $OUTPUT
