---
title: "使用Youtube-dl下载Youtube 4K视频"
date: 2020-09-23T14:03:09+08:00
lastmod: 2020-09-23T14:03:09+08:00
draft: false
tags: ["Tech","Tools", "zh-CN"]
categories: ["Tech", "Tools"]
author: 'Kaiya Xiong'
summary: Download Youtube Videos using Youtube-dl.
---
### 前言
Youtube作为非常火🔥的视频平台，它有很多内容质量非常高的视频。Youtube官方并没有提供下载的方法，如果我们想下载它上面的视频该怎么办呢？如果你在网络上搜索，你可以看到很多Youtube视频下载的方法，当然这些方法都各有优缺点，如不能下载分辨率大于1080P的视频等。

众所周知，Youtube在国内是无法使用的。如果你想高速畅快地下载Youtube上的高清视频，一个快速的XX是必须的~

### 现有方式
1. [clipconverter.cc](http://www.clipconverter.cc/) 

    这是一个在线下载视频的网站，你只需要将Youtube的视频链接粘贴进来，然后选择需要的格式、分辨率，等它转码后，点击下载即可。这个是我以前需要下载Youtube视频时最常用的工具，但是最近貌似抽风了，几乎无法使用。
2. [4K video Downloader](https://www.4kdownload.com/) 

    这个工具必须要下载他们的客户端，我下载过几次。。但是我把视频链接粘贴过来之后，它就一直解析链接中。。一直在解析。。然后等了半天告诉我，解析失败.... 这个工具我前后下载过几次，从来没有使用成功过。也不知道是不是我使用的方式不对🌚
    
### Youtube-dl的使用
[Youtube-dl](https://github.com/ytdl-org/youtube-dl)是一个基于命令行的下载工具，对小白童鞋不是很友好（可以考虑基于这个工具开发个可视化网站🤣
#### 环境准备
由于这个工具是基于Python语言开发的，需要安装Python的环境。到[Python](https://www.python.org/)下载安装包安装即可（当然也可以使用Anaconda、miniconda、virtualenv等安装，在此不赘述）。
#### Youtube-dl
1. 下载

下载方式有很多，直接下载已编译好的压缩包（解压后将目录地址放到环境变量PATH中即可）、pip安装、Homebrew安装（macOS系统）等方式均可。
由于前面已经准备好Python环境，使用pip安装还是非常方便的：
```bash
sudo -H pip install --upgrade youtube-dl
```

2. 配置

默认的配置文件位置如下（或者通过`--config-location`选项指定配置文件位置）：

- Win: `%APPDATA%\youtube-dl\config.txt` 或 `C:\Users\<user name>\youtube-dl.conf`

- Linux和Mac: `/etc/youtube-dl.conf` 或 `~/.config/youtube-dl/config`

代理配置如下：
```bash
# Use this proxy
--proxy 127.0.0.1:8087
```

#### FFmpeg
使用此工具下载Youtube高清视频时，视频画面和音频是分离开的，所以需要FFmpeg工具完成合并。在[FFmpeg](https://www.ffmpeg.org/)下载

下载完可执行文件后，将其放到系统PATH路径包含的路径里，如Linux和Mac可以放到`/usr/local/bin`里面，或者将可执行文件的路径添加到PATH变量中。

### 开始下载视频
#### 最简单的下载命令：
```bash
youtube-dl <url>
```
比如
```bash
youtube-dl https://www.youtube.com/watch?v=3M0Bhy19Ta4
```
#### 配置代理
```bash
youtube-dl --proxy "http://127.0.0.1:1087" <url>
```
#### 选择画质
1. 第一种方式：直接选择最优画质

```bash
youtube-dl -f bestvideo+bestaudio <url>
```

2. 第二种方式：先查出来可选画质列表，再选择指定画质资源
首先使用`-F`参数列出所有可选分辨率列表：
```bash
youtube-dl -F <url>
或
youtube-dl --list-formats <url>
```

输出如下：

```bash
(base) ☁  abdm [master] ⚡ youtube-dl -F --proxy "socks5://127.0.0.1:1080/" https://www.youtube.com/watch\?v\=3M0Bhy19Ta4
[youtube] 3M0Bhy19Ta4: Downloading webpage
[info] Available formats for 3M0Bhy19Ta4:
format code  extension  resolution note
249          webm       audio only tiny   56k , opus @ 50k (48000Hz), 1.47MiB
250          webm       audio only tiny   73k , opus @ 70k (48000Hz), 1.90MiB
140          m4a        audio only tiny  127k , m4a_dash container, mp4a.40.2@128k (44100Hz), 3.59MiB
251          webm       audio only tiny  141k , opus @160k (48000Hz), 3.72MiB
278          webm       256x144    144p   97k , webm container, vp9, 24fps, video only, 1.53MiB
160          mp4        256x144    144p  110k , avc1.4d400c, 24fps, video only, 706.04KiB
242          webm       426x240    240p  232k , vp9, 24fps, video only, 1.80MiB
133          mp4        426x240    240p  245k , avc1.4d4015, 24fps, video only, 1.29MiB
243          webm       640x360    360p  404k , vp9, 24fps, video only, 3.43MiB
134          mp4        640x360    360p  634k , avc1.4d401e, 24fps, video only, 3.24MiB
244          webm       854x480    480p  747k , vp9, 24fps, video only, 5.76MiB
135          mp4        854x480    480p 1160k , avc1.4d401e, 24fps, video only, 6.36MiB
247          webm       1280x720   720p 1663k , vp9, 24fps, video only, 12.10MiB
136          mp4        1280x720   720p 2321k , avc1.4d401f, 24fps, video only, 11.96MiB
248          webm       1920x1080  1080p 3090k , vp9, 24fps, video only, 22.00MiB
137          mp4        1920x1080  1080p 4360k , avc1.640028, 24fps, video only, 21.53MiB
271          webm       2560x1440  1440p 8981k , vp9, 24fps, video only, 53.97MiB
313          webm       3840x2160  2160p 17969k , vp9, 24fps, video only, 171.59MiB
18           mp4        640x360    360p  347k , avc1.42001E, 24fps, mp4a.40.2@ 96k (44100Hz), 9.80MiB
22           mp4        1280x720   720p  550k , avc1.64001F, 24fps, mp4a.40.2@192k (44100Hz) (best)
```

输出的结果中第一列为格式代码

选择指定格式下载：
```bash
youtube-dl -f 313 --proxy "socks5://127.0.0.1:1080/" https://www.youtube.com/watch\?v\=3M0Bhy19Ta4
```
可以下载指定格式代码为313的`313          webm       3840x2160  2160p 17969k , vp9, 24fps, video only, 171.59MiB`这个视频资源。

然后下载音频文件：
```bash
youtube-dl -f 140 --proxy "socks5://127.0.0.1:1080/" https://www.youtube.com/watch\?v\=3M0Bhy19Ta4
```
然后再使用FFmpeg进行合并。

另外，此工具也提供了一种简单的方式 `youtube-dl -f 视频格式代码+音频格式代码`，注意 必须视频格式代码在前，音频格式代码在后。
如：
```bash
youtube-dl -f 313+140 --proxy "socks5://127.0.0.1:1080/" https://www.youtube.com/watch\?v\=3M0Bhy19Ta4
```
使用这种方式进行下载时，工具会自动检测FFmpeg是否存在在系统PATH中，如果存在的话，会自动调用FFmpeg进行视频和音频的合并。
