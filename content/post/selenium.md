---
title: Using Selenium in Python
date: 2020-10-01T18:10:20+08:00
draft: false
tags: ['Tech', 'Python', 'Selenium', 'Chrome headlss', 'Hermes Notifyer']
categories: ['Tech', 'Python']
author: かいや
autoCollapseToc: true
summary: Using Selenium with Chrome's headless mode for simulating human's behavior in the browser.
---

### 前情提要
今年三月份写了个[爱马仕的上新提醒工具](../hermesnotifyer/)。一开始还运行的蛮好的，只要官方有上新，立马就会邮件通知到我。

燃鹅，过了几个月，我发现连续好久都没有上新了（我当时还以为国外疫情严重，爱马仕员工没有去公司所以才没有上新呢🤣）。我打开当时使用的接口一看，被封了。。接口加了验证码😢，我用SS看了一下，IP直接被Ban了😥。看来我这小工具已经惊动了官方了（害怕😨）。

现在官网已经全部都加上了人机验证，所以没法使用Python去调用他们的产品信息查询接口，所以要另辟蹊径了。我们可以使用`selenium`来模拟人在浏览器中的行为，进而让官网认为我们是正常的浏览请求网页。

### Prerequisite
#### selenium
使用`conda`或者pip安装selenium
```bash
conda install selenium
pip install selenium
```
#### Chrome Driver
因为需要模拟Chrome浏览器，我们要去[https://chromedriver.chromium.org/downloads](https://chromedriver.chromium.org/downloads)下载驱动。

⚠️注意，一定要下载和你的Chrome浏览器版本对应的驱动版本。如我的Chrome版本是`85.0.4183.121`，下载的ChromeDriver版本是`85.0.4183.87`.

### 使用
使用selenium通过chrome driver模拟Chrome浏览器，我们可以使用直接调起Chrome浏览器的方式，或者使用`headless`模式（此模式下无需调起浏览器，其实是在后台调起的。）
#### 直接调起方式
```python
from selenium import webdriver
driver = webdriver.Chrome(executable_path='./chromedriver') # 相对路径 此处参数为上面👆下载的ChromeDriver的可执行文件的位置，如果已经将其加入到系统的环境变量PATH中，则无需此参数.

try:
    driver.get('<login_url>')
except TimeoutException:
    print('time out!')

username_field = driver.find_element_by_id('username')
password_field = driver.find_element_by_id('password')
submit_button = driver.find_element_by_id('submit_btn')
username_field.clear()
username_field.send_keys('<username>')
password_field.send_keys('<password>')
submit_button.click()
time.sleep(5)
driver.quit() # Quits the driver and closes every associated window.
```

#### headless模式
```python
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException, NoSuchElementException
import time

options = webdriver.ChromeOptions()
options.add_argument('--headless')  # headless mode
driver = webdriver.Chrome(options=options, executable_path='./chromedriver')

try:
    driver.get('<login_url>')
except TimeoutException:
    print('time out!')

try:
    username_field = driver.find_element_by_id('username')
    password_field = driver.find_element_by_id('password')
    submit_button = driver.find_element_by_id('submit_btn')
except NoSuchElementException:
    print('No Such Element')

username_field.clear()

username_field.send_keys('<username>')
password_field.send_keys('<password>')
submit_button.click()

try:
    element = WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.ID, 'visit-list-talbe'))
    )
except Exception as e:
    print(e)
finally:
    print(driver.find_element_by_tag_name('tbody').text)
    driver.quit() # Quits the driver and closes every associated window.
```

