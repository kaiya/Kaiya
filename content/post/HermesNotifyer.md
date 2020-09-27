---
title: Hermes Notifyer
date: 2020-03-09T11:50:00+08:00

draft: false
tags: ['Tech', 'code', 'Hermes']
categories: ['Tech']
author: Kaiya Xiong
autoCollapseToc: true
summary: Build a Hermes Product Update Notifyer Step by Step.
---

### Build a Hermes Product Update Notifyer Step by Step

- import needed module 

```python
import requests
from lxml import html
import schedule
import time
import json
```

- define a function to search in the Hermes.com site

```python
def isinstock_by_search(local, term):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_0) AppleWebKit/537.36 (KHTML, like Gecko) '
                      'Chrome/69.0.3497.100 Safari/537.36',
    }
    url = 'https://bck.hermes.com/product'
    params = {'locale': local, 'searchterm': term, 'sort': 'relevance'}
    response = requests.get(url=url, params=params, headers=headers)
    resp_text = response.text
    resp_json = json.loads(resp_text)
    total_item = resp_json.get('total')
    if total_item > 0:
        products = resp_json.get('products')
        for product_item in products:
            if product_item.get('hasStock'):
                return True
    else:
        return False
```

the concept behind the code is that we can request the url `https://bck.hermes.com/product?locale=us_en&searchterm=picotin&sort=relevance` to search product(searchterm) by locale in the hermes.com site.

{{<adsense>}}
    
- if the function above return True, aka. the product has stock, we'll send a simple mail to the monitor recipient using Mailgun's Mailing service.

```python
def send_simple_message(in_stock_url):
    response = requests.post(
        "https://api.mailgun.net/v3/sandboxxxx.mailgun.org/messages",
        auth=("api", "apiKey"),
        data={"from": "me@example.com",
              "to": ["recipient@gmail.com"],
              "subject": "title",
              "text": "url: " + in_stock_url})
    if response.status_code == 200:
        print('mail send success')
        return True
    else:
        print('mail send failed')
        return False
```

- define a main task to run combine this function for scheduling

```python
def main_task(monitor_urls, locales, terms):
    for term in terms:
        for local in locales:
            if isinstock_by_search(local, term):
                print('has stock' + term + ' in: ' + local)
                url = 'https://bck.hermes.com/product?locale=' + local + '&searchterm=' + term + '&sort=relevance'
                send_simple_message(url)
    print('ROUND Monitor Done')
```

- the main process

```python
if __name__ == '__main__':

    country_code = ['be/en', 'cz/en', 'dk/en', 'de/de', 'es/es', 'fi/en', 'fr/fr', 'ie/en', 'it/it', 'lu/fr',
                    'nl/en', 'no/en', 'at/de', 'pl/en', 'pt/en', 'ch/fr', 'se/en', 'uk/en', 'us/en', 'ca/en',
                    'jp/ja', 'my/en', 'sg/en', 'au/en']
    
    # build param for GET
    with open('productlist.txt') as f:
        product_list = f.readlines()
    urls = []
    for code in country_code:
        for product in product_list:
            urls.append('https://www.hermes.com/' + code + product)

    # build param for search
    locale_list = []
    for code in country_code:
        locale = code.replace('/', '_')
        locale_list.append(locale)

    term_list = ['picotin']

    schedule.clear()
    schedule.every(30).minutes.do(main_task, urls, locale_list, term_list)
    while True:
        schedule.run_pending()
        time.sleep(1)
```

in this main function, we define country code and product for monitor by get url, and locale, term list for monitor by search in the site. And we also define a scheduler to run this script every one minutes to monitor the product regularlly. 

That's all.

Happy Shopping!!
