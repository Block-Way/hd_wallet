# flutter-dabank

dabank flutter utils

# android update file change

1. add file ./android/app/src/main/res/xml/file_paths.xml
   <?xml version="1.0" encoding="utf-8"?>
   <paths xmlns:android="http://schemas.android.com/apk/res/android">
   <!--代表app 私有的存储区域 Context.getFilesDir()目录下的images目录 /data/user/0/com.lomocoin.lomocoin/files/-->
   <files-path name="file_path" path="." />
   </paths>

2. change file ./android/app/src/main/AndroidManifest.xml
   <provider xmlns:tools="http://schemas.android.com/tools"
       android:name="androidx.core.content.FileProvider"
       android:authorities="${applicationId}.flutter_file_provider"
       android:exported="false"
       android:grantUriPermissions="true"
       tools:replace="android:authorities">
   <meta-data
           android:name="android.support.FILE_PROVIDER_PATHS"
           android:resource="@xml/file_paths"
           tools:replace="android:resource" />
   </provider>
