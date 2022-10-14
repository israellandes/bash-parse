#1/bin/bash

function join_by {
  local d=${1-} f=${2-}
  if shift 2; then
    printf %s "$f" "${@/#/$d}"
  fi
}

parse()
{
rm render.txt &
touch render.txt
rm dates.txt
cp dates.csv dates.txt
sed -i 's/2021//g' dates.txt
sed -i -e 's/^/2021-/' dates.txt
value=$(<dates.txt)
new2="${value//./-}"
echo "$new2" > dates.txt
string=$(cat dates.txt)

while read line
do
   echo "--------------"
   echo
   echo "Before:"
   echo "$line"
   echo
   echo "--------------"
   echo
   echo "After:"
   echo

#   // or some_function "$line"
   IFS='- ' read -r -a array <<< "$line"
   join_by - "${array[0]}" "${array[2]}" "${array[1]}" > render1.txt
   pv="$(cat render1.txt)" 
   pv=" "${pv}"T"${array[3]}"Z"

   render="$(cat render1.txt)" 
   echo "$pv" >> render.txt
   echo

#	for element in "${array[@]}"
#	do
#	    echo "$element"
#	done
        echo "--------------"
   
done < dates.txt

cat render.txt | tr -d " \t\n\r" 
cat render.txt
}
parse
