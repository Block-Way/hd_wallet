package com.dabank.flutter_dabank

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.os.Handler
import android.os.Message
import androidx.core.content.FileProvider
import java.io.File
import java.io.FileOutputStream
import java.net.HttpURLConnection
import java.net.URL

class UpdateManager(private val activity: Activity,
                    private val apkUrl: String,
                    private val event: SendEvent
) {
    companion object {
        private const val ERROR_NET = "ERROR_NET"
        //        private const val ERROR_CANCEL = "ERROR_CANCEL"
        private const val ERROR_INSTALL_FAIL = "ERROR_INSTALL_FAIL"

        private const val DOWN_UPDATE = 1
        private const val DOWN_OVER = 2
        private const val DOWN_ERROR = 3

        private const val SIZE_KEY = "Accept-Length"
    }


    /* 下载包安装路径 */
    private var savePath = ""
    private var fileName = ""

    private var progress: Int = 0
    private var lastEventValue: Int = 0

    private var downLoadThread: Thread? = null
    private var interceptFlag = false
    private var isNotifyEnd = false

    @SuppressLint("HandlerLeak")
    private val mHandler = object : Handler() {
        @SuppressLint("SetTextI18n")
        override fun handleMessage(msg: Message) {
            when (msg.what) {
                DOWN_UPDATE -> {
                    sendEvent(null)
                }
                DOWN_OVER -> {
                    event.send(mapOf("type" to "update", "value" to "100"))
                }
                DOWN_ERROR -> sendEvent(ERROR_NET)
                else -> {
                }
            }
        }
    }

    /**
     * 开始下载apk
     */
    fun start() {
        downLoadThread = Thread(mDownApkRunnable)
        downLoadThread!!.start()
    }

    /**
     * 取消下载
     */
    fun cancel() {
        interceptFlag = true;
    }


    private fun sendEvent(error: String?) {
        if (error == null) {
            // 防止很频繁的 发送event
            if (lastEventValue == progress) {
                return;
            }
            lastEventValue = progress
            if (progress < 100) {
                event.send(mapOf("type" to "update", "value" to "$progress"))
            }
        } else {
            event.send(mapOf("type" to "update", "error" to error))
        }
    }


    private val mDownApkRunnable = Runnable {
        try {
            val url = URL(apkUrl)
            val conn = url.openConnection() as HttpURLConnection
            conn.connect()

            var length = conn.contentLength
            val map = conn.headerFields
            if (map.containsKey(SIZE_KEY) && map[SIZE_KEY] != null && map[SIZE_KEY]!!.size > 0) {
                try {
                    length = Integer.valueOf(map[SIZE_KEY]!![0])
                } catch (e: Exception) {
                }

            }
            val `is` = conn.inputStream

            val file = File(savePath)
            if (!file.exists()) {
                file.mkdir()
            }
            val apkFileName = "$savePath/$fileName"
            val apkFile = File(apkFileName)
            val fos = FileOutputStream(apkFile)

            var count = 0
            val buf = ByteArray(1024)

            do {
                val numRead = `is`.read(buf)
                count += numRead
                progress = (count.toFloat() / length * 100).toInt()
                //更新进度
                mHandler.sendEmptyMessage(DOWN_UPDATE)
                if (numRead <= 0) {
                    //下载完成通知安装
                    mHandler.sendEmptyMessage(DOWN_OVER)
                    break
                }
                fos.write(buf, 0, numRead)
            } while (!interceptFlag)//点击取消就停止下载.

            fos.close()
            `is`.close()
        } catch (e: Exception) {
            e.printStackTrace();
            mHandler.sendEmptyMessage(DOWN_ERROR)
        }
    }

    init {
        fileName = activity.packageName + "_update.apk"

        savePath = if (Build.VERSION.SDK_INT >= 24) {
            activity.filesDir.toString()
        } else {
            Environment.getExternalStorageDirectory().path
        }
    }


    fun installApk() {
        try {
            val apkPath = "$savePath/$fileName"
            val file = File(apkPath)
            val intent = Intent(Intent.ACTION_VIEW)
            //版本在7.0以上是不能直接通过uri访问的
            if (Build.VERSION.SDK_INT >= 24) { //Build.VERSION_CODES.N
                // 由于没有在Activity环境下启动Activity,设置下面的标签
                intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                //参数1 上下文, 参数2 Provider主机地址 和配置文件中保持一致   参数3  共享的文件
                val apkUri = FileProvider.getUriForFile(activity, activity.packageName + ".flutter_file_provider", file)
                //添加这一句表示对目标应用临时授权该Uri所代表的文件
                intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                intent.setDataAndType(apkUri, "application/vnd.android.package-archive")
            } else {
                intent.setDataAndType(Uri.fromFile(file),
                        "application/vnd.android.package-archive")
            }
            activity.startActivity(intent)
            // activity.finish()
        } catch (e: Exception) {
            sendEvent(ERROR_INSTALL_FAIL)
            e.printStackTrace()
        }
    }


}
