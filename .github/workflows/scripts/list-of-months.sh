start="20210107"
end="20230501"
while [[ $start < $end ]]
  do
     start=$(date -d "$start + 14 day" +"%Y%m%d")
     echo "$start" $(date -d "$start + 14 day" +"%Y%m%d")

done
