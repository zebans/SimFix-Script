#!/bin/bash

# Teminal Window
cols=$(tput cols)
fill=$(printf '%*s' "$cols" '' | tr ' ' '=')

# Work Directory
home_dir=/home/ncyu
proj_dir=$home_dir/MyProject
expr_dir=$home_dir/Expr_file

cd $expr_dir
if [ -d /home/ncyu/Expr_file/SimFix-Script ];then
	rm -rf /home/ncyu/Expr_file/SimFix-Script
fi

git clone https://github.com/zebans/SimFix-Script.git

cd /home/ncyu/Expr_file/SimFix-Script

cp -f * $expr_dir

cd /home/ncyu/Expr_file

chmod +x *.sh
