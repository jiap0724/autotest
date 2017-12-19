# #!/bin/sh
# adb uninstall com.picooc.international
# echo "卸载完成！"
# adb install -r /Users/jiapeng/Desktop/app-release.apk
# echo "安装完成！"
# adb shell am start -n "com.picooc.international/com.picooc.international.activity.start.WelcomeActivity" 
# echo "启动app"

####################################
count=0
rootPath=./
toolsPath=./tools/
currentFolderName=${PWD##*/}

#在tools路径下
if [ "$currentFolderName" == "tools" ] ; then
	rootPath=../
	toolsPath=./
fi

apkUnzipFolder="${rootPath}apkUnzipFolder"
androidManifestTxt="${rootPath}AndroidManifest.txt"

for line in $(find ${rootPath}* -prune -iname '*.apk'); do 
    echo "开始检查:$line"
    unzip -o -q -d $apkUnzipFolder $line
    java -jar ${toolsPath}AXMLPrinter2.jar $apkUnzipFolder/AndroidManifest.xml > $androidManifestTxt
	python ${toolsPath}xmlParsePy.py
	let count=$count+1
done

if [ -d $apkUnzipFolder ]; then 
rm -rf $apkUnzipFolder
fi

if [ -f $androidManifestTxt ]; then 
rm -r $androidManifestTxt
fi

echo "完成，共检查${count}个文件"
