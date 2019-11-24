#!/bin/bash
if [ $# -eq 0 ]
then
echo "You must include a log file after this command. Example: ./botscript example.log"
exit
fi

if ! [ -f $1 ]
then
echo "The file $(pwd)/$1 doesn't exist."
exit
else
fpath="$(pwd)/$1"
filename=$1
fi

touch tmpuserlist
rnum=1
echo "bots found:"
while read LINE
do
if [[ $LINE =~ "user logged in" ]]
then
user=$(head -n $rnum $filename| tail -n1 | awk -F '|' '{print $3}')
timestamp=$(head -n $rnum $filename | tail -n1 | awk -F '|' '{print $1}')
nline=$(head -n $((rnum + 1)) $filename | tail -n1)
nline2=$(head -n $((rnum + 2)) $filename | tail -n1)

if [[ "$nline" == *"$user"* && "$nline" == *"user changed password"* && "$nline" == *"$timestamp"* && "$nline2" == *"$user"* && "$nline2" == *"user logged off"* && "$nline2" == *"$timestamp"* ]]
then
echo $user >> tmpuserlist
fi
fi
((rnum++))
done < $filename
cat tmpuserlist | sort | uniq
rm -f tmpuserlist