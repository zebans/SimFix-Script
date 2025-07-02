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
vid=$2	# Version id

if [ $# -lt 2 ]; then
	echo "⚠️  : At least 2 parameter"
	echo "Example: ./merge_d4j_mut.sh Chart 7"
	echo "Plz try again."
	exit 1
else
	echo "Current pid: $pid"
	echo "Current pid_low: $pid_low"
	echo "Current vid: $vid"
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


simfix_dir=$home_dir/SimFix
simfix_final_dir=$simfix_dir/final

# TODO: Get FL Result for APR Tool
apr_stmt_susps_path=$simfix_final_dir/sbfl/ochiai/$pid_low/$vid/stmt-susps.txt

# TODO: Patch Spac
apr_patch_dir=$simfix_final_dir/patch
apr_tool=$simfix_final_dir/simfix.jar


# TODO: Backup Patch Space
mkdir -p $expr_dir/APR_PATCH/$pid_low/$vid
backup_pid_vid_dir=$expr_dir/APR_PATCH/$pid_low/$vid


# TODO: Backup Process
if [ -d $apr_patch_dir ];then
	# TODO: If Success to fix the bug id
	mv $apr_patch_dir $backup_pid_vid_dir # mv src_folder target_folder/src_folder
	> $backup_pid_vid_dir/success_$pid_vid
else
	# TODO: If fail to fix the bug id
	> $backup_pid_vid_dir/fail_$pid_vid
fi





























