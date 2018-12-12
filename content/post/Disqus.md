---
title: Disqus科学使用方式
date: 2018-12-12T16:50:00+08:00
tags: ["中文","技术"]
---

### 前言

由于某些原因Disqus这个很多博客使用的评论系统没法在大陆使用了。本文记录一下本博客对Disqus的改造过程，以供参考。说一下本博客的情况：基于Hugo静态博客生成器、使用[Hugo Even](https://github.com/olOwOlo/hugo-theme-even)主题。网上有很多教程一般都需要有一个自己的VPS来运行转发程序，但是我发现使用Heroku来跑这个转发程序效果还不错。
总体架构：

![图片来源:blog.fooleap.org](https://lib.azfs.com.cn/20181212154460512397630.png-l)

此处利用了一个PHP程序来转发Disqus API请求 [https://github.com/fooleap/disqus-php-api](https://github.com/fooleap/disqus-php-api)。
首先JS检测用户网络是否能够访问Disqus，如果能就直接访问原版Disqus。如果不能则请求自己的服务器通过PHP程序转发Disqus API请求，并显示自制的Disqus评论框。

### 一、Disqus

使用 API 实现匿名评论功能，需在 Disqus 后台[网站设置](https://disqus.com/admin/settings/community/)，设置相关选项。
* 开启匿名评论，Guest Commenting 项中勾选 Allow guests to comment。
* 若需评论免审，Pre-moderation 项选中 None。


必须在 [Disqus API](https://disqus.com/api/applications/) 申请注册一个 App，取得相关的公钥（**API Key**）、私钥（**API Secret**），并填写于后端的配置文件 `config.php` 中。

App 设置方面，回调链接请填写 `login.php` 文件的绝对地址，可根据自己情况填写。

### 二、Heroku

1. 首先在[Heroku](https://heroku.com)注册账号，可以直接通过Github登录；
2. 新建一个App，填写App名字，选择位置如下图：
![2018121215446058857644.png](https://lib.azfs.com.cn/2018121215446058857644.png-l)
3. 选择Deploy部署，可以通过Heroku CLI部署或者通过关联Github Repo部署，很方便。但是这里不建议通过Github部署，因为PHP文件里有些敏感信息，所以建议通过Heroku CLI部署。Heroku CLI安装过程省略，官网上有。

    ```shell
    $ heroku login                      //调起浏览器登录Heroku账号
    $ heroku git:clone -a disqusproxy   //克隆Heroku的Git仓库，将disqusproxy替换为你自己的App名字
    $ cd disqusproxy
    ```
    
    将[PHP程序](https://github.com/fooleap/disqus-php-api)下载下来，将api文件夹内的文件都放到这个文件夹内，修改config.php文件，将上面获取的API Key、API Secret填入配置文件中，在根据配置文件提示填入你的Disqus账号信息。另外由于Gravatar在国内也不太稳定可以将配置文件下面的Gravatar CDN修改为`//gravatar.loli.net/avatar/`，配置文件如下图：

    ![20181212154460966999228.png](https://lib.azfs.com.cn/20181212154460966999228.png-l)

    修改完后使用Git推送到heroku
    
    ```shell
    $ git add .     
    $ git commit -am "make it better"
    $ git push heroku master            //Git工作流，推送到Heroku的Git仓库
    ```
4. 可以测试访问https://{app name}.herokuapp.com/login.php判断是否安装成功。


### 三、前端

1. 将[PHP程序](https://github.com/fooleap/disqus-php-api)Repo里的iDisqus.min.css和iDisqus.min.js文件下载下来放入static文件夹内。
2. 由于本博客采用的主题有Disqus功能，所以要先把以前的Div元素和涉及Disqus的代码清除。
3. 引入CSS

    ```html
    <link rel="stylesheet" href="path/to/iDisqus.min.css" />
    ```

    注：由于本博客采用的是[Even主题](https://github.com/olOwOlo/hugo-theme-even)，所以以下针对前端的修改在`themes/even/layouts/partials/comments.html`中，不同主题请自行修改。

4. 创建容器

    ```html
    <div id="comment"></div>
    ```

5. 引入JS

    ```html
    <script src="path/to/iDisqus.min.js"></script>
    ```

6. 创建实例

    ```javascript
    var disq = new iDisqus('comment', {
            forum: 'kyxiong',
            api: 'https://dqproxy.herokuapp.com/',
            site: 'https://kaiyai.com',
            mode: 1,
            timeout: 3000,
            init: true
          });
    ```

    如下图：

    ![20181212154461004878666.png](https://lib.azfs.com.cn/20181212154461004878666.png-l)

    参数解释：

    - `forum`: disqus中forum的shortname
    - `api`: 上文中PHP转发程序的地址
    - `site`: 欲开启Disqus科学评论的网站地址
    - `mode`: 模式：
        - `1`: 检测能否访问 Disqus，若能则加载 Disqus 原生评论框，超时则加载简易评论框
        - `2`: 仅加载简易评论框
        - `3`: 同时加载两种评论框，先显示简易评论框，Disqus 加载完成则切换至 Disqus 评论框
    - `timeout`: 超时时间设置，检测用户网络，如果连接原生Disqus超过这个时间则开启本转发程序转发Disqus API请求。单位毫秒。
    - `init`: 是否自动初始化

### 四、大功告成！

使用Hugo生成静态网站预览，记得本地预览默认是关闭Disqus的，要注释掉comments中的代码

```javascript
if (window.location.hostname === 'localhost') return;
```

放到生产环境后记得再注释回来哟。


    

