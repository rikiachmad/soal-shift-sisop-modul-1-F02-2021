#!/bin/bash

echo "Error,Count" > error_message.csv
sed 's,([^(]*$,,' syslog.log > error.log

string="`grep -o 'ERROR.*' error.log | cut -f2- -d ' ' | sort | uniq -c | sort -nr`"

arr=($string)
count="${arr[0]}"

for((i=1; i<${#arr[@]}; i++))
do
  if ! [[ "${arr[$i]}" =~ ^[0-9]+$ ]]; then
    echo -n "${arr[$i]}" >> error_message.csv;
  if ! [[ "${arr[$(($i+1))]}" =~ ^[0-9]+$ ]] && [ $i -ne $((${#arr[@]}-1)) ]; then
    echo -n  " " >> error_message.csv
  fi
  else echo -n -e ",$count\n" >> error_message.csv
    count=${arr[$i]}
  fi
done
echo ",$count" >> error_message.csv

echo "USERNAME,INFO,ERROR" > user_statistic.csv

user=`grep -o "ERROR.*\|INFO.*" syslog.log | cut -f2- -d '(' | sed 's/)$//' | sort | uniq`
data=($user)
for ((i=0; i<${#data[@]}; i++))
do
  error=`grep -c "ERROR.*${data[$i]}" syslog.log`
  info=`grep -c "INFO.*${data[$i]}" syslog.log`
  echo -n  "${data[$i]}," >> user_statistic.csv
  echo -n "$info," >> user_statistic.csv
  echo "$error" >> user_statistic.csv
done
