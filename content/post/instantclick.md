---
title: "Instantclick"
date: 2018-07-20T10:43:48+08:00
---

## Instanclick usage in Hugo
看了Showfom大神的[博客](https://sb.sb)，这个博客能实现不刷新就可以加载页面的效果，和ruby-china.org很像，不过我不知道他们用的技术是不是相同的。

找了一圈live template没找到，最后打开大神的博客，F12看了一波，发现加载了一个instanclick的js文件，随后了解到就是使用这个js库实现的不刷新加载页面，其实是预加载链接`pre-load`。

## Hugo中的实现
对于我使用的主题`hugo-smorg`，在主题文件夹中的layouts/partials中的js-body-bottom.html中添加如下代码即可：

```javascript
<script src="https://cdn.staticfile.org/instantclick/3.0.1/instantclick.min.js" data-no-instant></script>
<script data-no-instant>InstantClick.init();</script>
```
