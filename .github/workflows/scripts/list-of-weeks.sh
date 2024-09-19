start="20210101"
end="20230501"
while [[ $start < $end ]]
  do
     start=$(date -d "$start + 7 day" +"%Y%m%d")
     echo "          -$start"-$(date -d "$start + 7 day" +"%Y%m%d")

done
