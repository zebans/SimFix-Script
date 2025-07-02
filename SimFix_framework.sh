#!/bin/bash

# Teminal Window
cols=$(tput cols)
fill=$(printf '%*s' "$cols" '' | tr ' ' '=')

# Work Directory
home_dir=/home/ncyu
proj_dir=$home_dir/MyProject
expr_dir=$home_dir/Expr_file

# Parameter ($# -> count arg) ($1 -> no.1 arg) ...
pid=$1	# Project id
pid_low=$(echo $1 | tr 'A-Z' 'a-z')
#vid=$2	# Version id

if [ $# -lt 1 ]; then
	echo "⚠️  : At least 1 parameter"
	echo "Example: ./merge_d4j_mut.sh Chart"
	echo "Plz try again."
	exit 1
else
	echo "Current pid: $pid"
	echo "Current pid_low: $pid_low"
#	echo "Current vid: $vid"
fi

echo
echo "$fill"
echo

# TODO Function: Patching
#echo "👤 Name: $(person_get_name "$person1")"

fixed_proj_dir=$proj_dir/Fixed/$pid_low
fixed_pid_vid_dir=$fixed_proj_dir/${pid_low}_${vid}_fixed

buggy_proj_dir=$proj_dir/Buggy/$pid_low
buggy_pid_vid_dir=$buggy_proj_dir/${pid_low}_${vid}_buggy

if [ $pid_low = "chart" ];then
	vid=26
elif [ $pid_low = "closure" ];then
	vid=133
elif [ $pid_low = "lang" ];then
	vid=65
elif [ $pid_low = "math" ];then
	vid=106
elif [ $pid_low = "time" ];then
	vid=27
else
	echo "$pid Not exist in Defects4j 1.2.0"
	exit 1
fi

# for ((i=1;i<=10;i++))
# TODO: Backup Process
for ((current_vid=1;current_vid<=$vid;current_vid++))
do
	/home/ncyu/Expr_file/checkout.sh $pid $current_vid
	start=$(date +%s)
	/home/ncyu/Expr_file/SimFix_gzoltar.sh $pid $current_vid
	/home/ncyu/Expr_file/Fix.sh $pid $current_vid
	end=$(date +%s)
	duration=$((end -start))
	touch $expr_dir/${pid_low}_timer.txt
	echo "${pid_low}-${current_vid} time: $duration seconds."
	echo "${pid_low}-${current_vid} time: $duration seconds." >> $expr_dir/${pid_low}_timer.txt
	/home/ncyu/Expr_file/backup.sh $pid $current_vid
done





























