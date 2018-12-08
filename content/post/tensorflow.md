---
title: "Tensorflow"
date: 2018-08-12T01:03:09+08:00
lastmod: 2018-08-12T01:03:09+08:00
draft: false
tags: ["Tensorflow", "Tech"]
categories: ["Tensorflow", "Tech"]
author: Kaiya Xiong
---

最近看了莫烦Python教程，morvan讲的很不错，视频很短，很喜欢😍这种边敲代码边解释原理的教程。

[教程官网](https://morvanzhou.github.io/)

刚刚看了Tensorflow的讲解，记录一下：

``` python
import tensorflow as tf
import numpy as np

# create data
x_data = np.random.rand(100).astype(np.float32)
y_data = x_data*0.1 + 0.3

Weights = tf.Variable(tf.random_uniform([1], -1.0, 1.0))
biases = tf.Variable(tf.zeros([1]))

y = Weights*x_data + biases

loss = tf.reduce_mean(tf.square(y-y_data))
optimizer = tf.train.GradientDescentOptimizer(0.5)
train = optimizer.minimize(loss)
init = tf.global_variables_initializer()
sess = tf.Session()
sess.run(init)          # Very important

for step in range(201):
    sess.run(train)
    if step % 20 == 0:
        print(step, sess.run(Weights), sess.run(biases))

```

首先，使用numpy生成100个随机数，然后制定他们的标签符合公式$y = 0.1\*x + 0.3$，目的是让程序学习到这个公式，
然后使用tensorflow生成随机-1到1之间的数作为权重，[1]表示生成的是一维数，偏置初始设置为0.

y就为预测的y值. 损失函数为y和y_data之间的平方差，优化函数为梯度下降算法，0.5为学习速率.

```python
train = optimizer.minimize(loss)
```
这句代码道出了机器学习的精髓：训练就是使用优化算法最小化损失函数！！

接着，tf初始化，tf创建session，session运行初始化。

这个程序跑201步，每一步都在session中运行训练，然后每20个输出一个当前步、权重和偏置。
