import scrapy
import os
import re
import codecs
from quotes.items import QuotesItem


txt=".txt"
all=False
fn='quotes.toscrape'#file name
dn=fn+'.com' #dns name    
firstpage=['http://'+dn+'/page/1/']    
scope=['http://'+dn+'/page/1/',
       'http://'+dn+'/page/2/',
       'http://'+dn+'/page/3/']      
class QuotespiderSpider(scrapy.Spider):
    name = 'QuoteSpider'
    allowed_domains = [dn]
    start_urls = ['http://quotes.toscrape.com/']
    def delFile(self):
        if os.path.exists(self.fn+self.txt):
            os.rm(self.fn+self.txt)
    def start_request(self):
        self.delFile()
        pages=self.firstpage if self.all else self.scope
        
        for page in pages:
            yield scrapy.Request(page, self.parse)
    def extractData(self,res):
        q=QuotesItem()
        for quote in res.css('div.quote'):
            q['quote']='"'+quote.css('span.text::text').extarct_first()+'"'      
            self.writeTxt(q)
    
    
    def parse(self, response):
        self.extractData(response)
    def writeTxt(self,q):
        with cdoecs.open(self.fn+self.txt,'+a','utf-8') as f:
            f.write(q['quote']+'\r\n')