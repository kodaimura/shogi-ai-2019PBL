# -*- coding: utf-8 -*-
import scrapy
from myproject.items import MyprojectItem
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.options import Options

class KifuSpider(scrapy.Spider):
    page_count = 0
    name = 'kifu'
    allowed_domains = ['shogidb2.com']
    start_urls = ['https://shogidb2.com/latest/page/1',]
    
    def __init__(self):
        self.driver = webdriver.Chrome(executable_path='/Users/murakamikoudai/pyve/shogi/myproject/myproject/spiders/chromedriver')

    def parse_game_page(self,response):
        item = MyprojectItem()
     
        item['k'] = response.css('body > div.container-fluid > script').re(r'[+|-]\d\d\d\d[A-Z][A-Z]')
        return item

    def parse(self, response):
        KifuSpider.page_count += 1
        
        options = Options()
        options.add_argument("--headless")
        driver = webdriver.Chrome(executable_path='/Users/murakamikoudai/pyve/shogi/myproject/myproject/spiders/chromedriver', options=options)
        driver.get(response.url)
        response.replace(body=driver.page_source)
        
        if KifuSpider.page_count == 1:
            next_page = driver.find_element_by_css_selector('#app > div > div:nth-child(2) > div.col-12.col-md-6 > nav:nth-child(5) > ul > li:nth-child(2) > a').get_attribute('href')
        elif KifuSpider.page_count == 2:
            next_page = driver.find_element_by_css_selector('#app > div > div:nth-child(2) > div.col-12.col-md-6 > nav:nth-child(5) > ul > li:nth-child(4) > a').get_attribute('href')
        elif KifuSpider.page_count == 3:
            next_page = driver.find_element_by_css_selector('#app > div > div:nth-child(2) > div.col-12.col-md-6 > nav:nth-child(5) > ul > li:nth-child(5) > a').get_attribute('href')
        
        elif KifuSpider.page_count == 6:
            return 0
            
        else:
            next_page = driver.find_element_by_css_selector('#app > div > div:nth-child(2) > div.col-12.col-md-6 > nav:nth-child(5) > ul > li:nth-child(6) > a').get_attribute('href')
        
        
       

        game_elements = driver.find_elements_by_css_selector('div > div.list-group > a')
        
        games = list()
        
        for element in game_elements:
            games.append(element.get_attribute('href'))
        
        for game in games:
            yield scrapy.Request(game, callback = self.parse_game_page)
            
        driver.close()
            
        yield scrapy.Request(next_page, callback = self.parse)
        
        
        



