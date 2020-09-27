---
title: 七牛融合CDN的坑
date: 2018-07-17T21:47:00+08:00
draft: false
tags: ['Tech', 'zh-CN']
categories: ['Tech']
author: Kaiya Xiong
autoCollapseToc: true
summary: Complaints about the CDN service provided by QiNiu.

---

感觉被七牛云存储坑了一波。

七牛对开启HTTPS功能的对象存储收费均按照HTTPS计算，即使你是使用HTTP方式访问的也是按照HTTPS收费。。。

![image-20180719200048806](https://ws2.sinaimg.cn/large/006tNc79gy1ftff8us6elj30pm06sgmz.jpg)

记录一下

于是我专门建立了一个域名用于HTTP请求（大文件），小图片文件就都走HTTPS吧。

* libnos.azfs.com.cn 用于HTTP访问
* pbnysx2de.bkt.clouddn.com 对象存储默认域名
* lib.azfs.com.cn 用于HTTPS访问