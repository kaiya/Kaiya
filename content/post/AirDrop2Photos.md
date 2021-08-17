---
title: "iPhone AirDrop到Mac自动更改默认存储位置"
date: 2021-08-16T22:03:09+08:00
lastmod: 2021-08-16T22:03:09+08:00
draft: false
tags: ["Tech","Tools", "zh-CN"]
categories: ["Tech", "Tools"]
author: 'Kaiya Xiong'
summary: Automatically change the default location of AirDrop from iPhone to Mac.
---
--
>
真的很喜欢缺省。

iPhone使用AirDrop传照片到Mac时，如果双方登陆的不是同一个iCloud账户，则会询问Mac是否接收，然后可以选择打开方式、存储位置等。

但是，如果两个设备登陆的是同一个iCloud账户，则会默认放到`下载`文件夹里。

现在有个需求，上述情况，默认将AirDrop来的照片导入到`相簿.app`中。

首先下载[脚本文件](https://imgs.azfs.com.cn/Quarantine%20Filter.action.zip)，并安装（信任即可

然后打开`Automator`，新建`Folder Action` ，选择接收文件夹为`下载`文件夹。左侧搜索`Quar`添加Quarantine Filter，并选择AirDrop File。如下图。

![-w1972](http://img.azfs.com.cn/16291262510895.jpg)

继续左侧搜索🔍添加`将文件添加进相簿`，并选择`导入且不加入专辑`，如下图所示。
![-w993](http://img.azfs.com.cn/16291263679382.jpg)

保存，测试，收工！