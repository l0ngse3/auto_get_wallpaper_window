#!/bin/bash

#copy folder
copy_folder="/f/Data/Image/wallpaper/copy_folder"

#mobile image folder
mobile_folder="/f/Data/Image/wallpaper/mobile_folder"

#desktop image folder
desktop_folder="/f/Data/Image/wallpaper/desktop_folder"

#go to file contain image
cd /c/Users/$USERNAME/AppData/Local/Packages

folder_data=$(ls | grep "Microsoft.Windows.ContentDeliveryManager_")
cd $folder_data/LocalState/Assets

all_image=$(ls)

#copy all imge
for image in ${all_image}
do
	cp ${image} ${copy_folder}
done

#rename all image
cd $copy_folder
arr=$(ls | grep -v jpg)
for file_name in ${arr}
do
	mv ${file_name} ${file_name}.jpg
done

#split image into two type: mobile and desktop
arr=$(ls)
for file_name in ${arr}
do
	is_desktop=$(file ${file_name} | grep "1920x1080" | wc -l)
	is_mobile=$(file ${file_name} | grep "1080x1920" | wc -l)
	
	#echo $is_desktop
	#echo $is_mobile
	
	if [ $is_desktop -eq 1 ]; then
		is_exist=$(ls $desktop_folder | grep "${file_name}" | wc -l)
		if [ $is_exist -eq 0 ];then
			cp ${file_name} $desktop_folder
		else
			#echo "Exiested"
			continue
		fi
	elif [ $is_mobile -eq 1 ]; then
		is_exist=$(ls $mobile_folder | grep "${file_name}" | wc -l)
		if [ $is_exist -eq 0 ];then
			cp ${file_name} $mobile_folder
		else
			#echo "Exiested"
			continue
		fi
	fi
done

cd $copy_folder
rm -rf *
