---
title: jsdelivr
date: 2018-12-13T19:52:00+08:00
tags: ["中文","技术"]
---

### 引

​	今天，在研究本博客采用的主题时发现，一些NPM Package文件采用的CDN是`jsdelivr`。

之前了解过也在项目中用过一些常规的CDN服务来加速`js`和`css`文件的获取。

主要有：

- 又拍云的公共js库: [http://jscdn.upai.com/](http://jscdn.upai.com/)
- 七牛的[staticfile.org](staticfile.org) 
- [CDNJS](https://cdnjs.com)

### 介绍

这次了解了`jsdelivr`之后发现这个加速库好强大，速度好快，而且还能加速任意Github Repo里的文件。

上一下官网的截图吧：

![20181213154470254417585.png](https://lib.azfs.com.cn/20181213154470254417585.png-m)

1. 支持npm package

2. 支持Github Repo

3. 支持wordpress

### Github CDN

这里主要讲一下Github库文件的分发：

`jsdelivr`支持指定任意版本，任一commit，如果文件本身没有压缩，在`js`或`css`文件后加上`.min`则`jsdevlir`自动帮你压缩并生成map文件。另外还可以通过`https://www.jsdelivr.com/package/gh/user/repo`这个地址打开专属你的github repo的文件列表界面，好看哈哈哈~

官方的README中如下描述：

> All packages hosted on npm and tagged releases on GitHub are automatically available on jsDelivr. 

举个栗子：
如官网所描述，如果github库中有release则可以通过这个地址 `https://cdn.jsdelivr.net/gh/user/repo@version/file`获取到github仓库中的文件，并且可以在路径中指定相应的relaese版本号

但是如果一个repo如果没有release版本，则可直接输入master分支的文件路径进行访问，地址如
`https://cdn.jsdelivr.net/gh/user/repo/file` 
另外，也可通过指定`commit hash`来指定获取某次`commit`的文件，如：
[指定commit hash的地址](https://cdn.jsdelivr.net/gh/kaiya/homepage@88fa8cd6a49cca64473437ee9f812abb44c180fc/js/search.js)

对于本博客的[Github Repo](https://github.com/kaiya/kaiya) 有两个分支：`master`和`gh-pages`分支，并且将`gh-pages`分支中的文件tag成release版本，则通过[这个地址](https://cdn.jsdelivr.net/gh/kaiya/kaiya@0.0.34/dist/even.min.js) 则可访问到对应的js文件。

这样，无论一个repo有几个分支或者有没有relaese版本都可对其文件进行加速！

### 总结

`jsdelivr`真好用哈哈哈哈哈😂



