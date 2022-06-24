#!/usr/bin/python

'''
    news_fetch.py

    This script fetches 'the hindu' and 'indian express' from `www.bitul.in`
    and saves in a user defined directory in pdf format.

    Config vars:
        download_dir : Destination to save the news papers
'''

from requests import get, Session
from requests.exceptions import RequestException
from contextlib import closing
from bs4 import BeautifulSoup
from selenium import webdriver
from datetime import datetime
from os import path, mkdir
import time

def notabot_scam():
    '''
    Scams the website by opening page and waiting for some time
    into thinking i am not a bot, sinister 😈
    '''
    driver = webdriver.Firefox()
    driver.get("http://www.bitul.in")
    time.sleep(15)
    driver.close()

# Google drive file download
def download_file_from_google_drive(id, destination):
    URL = "https://docs.google.com/uc?export=download"

    session = Session()

    response = session.get(URL, params = { 'id' : id }, stream = True)
    token = get_confirm_token(response)

    if token:
        params = { 'id' : id, 'confirm' : token }
        response = session.get(URL, params = params, stream = True)

    save_response_content(response, destination)

def get_confirm_token(response):
    for key, value in response.cookies.items():
        if key.startswith('download_warning'):
            return value

    return None

def save_response_content(response, destination):
    CHUNK_SIZE = 32768

    with open(destination, "wb") as f:
        for chunk in response.iter_content(CHUNK_SIZE):
            if chunk: # filter out keep-alive new chunks
                f.write(chunk)

# Simple helper functions
def simple_get(url):
    """
    Attempts to get the content at `url` by making an HTTP GET request.
    If the content-type of response is some kind of HTML/XML, return the
    text content, otherwise return None.
    """
    try:
        headers={'User-Agent': 'Mozilla/5.0'}
        with closing(get(url, stream=True, headers=headers)) as resp:
            if is_good_response(resp):
                return resp.content
            else:
                return None

    except RequestException as e:
        print(f'Error during requests to {url} : {str(e)}')
        return None


def is_good_response(resp):
    """
    Returns True if the response seems to be HTML, False otherwise.
    """
    content_type = resp.headers['Content-Type'].lower()
    return (resp.status_code == 200
            and content_type is not None
            and content_type.find('html') > -1)

if __name__ == '__main__':

    # try to make sure the website doesn't stop the script from running
    notabot_scam()

    # global vars
    today_date, today_month, today_year = datetime.now().strftime('%B-%d-%Y').split('-')
    save_date = datetime.now().strftime('%Y%m%d')

    # download directory
    download_dir = path.expanduser('~') +'/news'
    # check existance of download_dir
    if not path.isdir(download_dir):
        mkdir(download_dir)

    ####################
    # THE HINDU
    ####################
    paper = 'hindu'
    url = 'https://www.bitul.in/epaper/the-hindu/'
    html = simple_get(url)
    soup = BeautifulSoup(html, 'html.parser')
    ptags = soup.find_all('p')

    print('Trying to fetch hindu')
    ele = None
    for ptag in ptags:
        if today_date in  ptag.text and today_month in ptag.text and today_year not in ptag.text:
            ele = ptag
            break

    if ele:
        for atag in ele.find_all('a'):
            if 'Full' in atag.text:
                dlink = atag['href']
                file_id = dlink.split('/')[5]
                destination = download_dir + f'/{save_date}-{paper}-{today_month}-{today_date}.pdf'
                download_file_from_google_drive(file_id, destination)
        print(f'Successfully downloaded Hindu {today_month} {today_date}')
    else:
        print('No relevant ptag found.')

    ####################
    # INDIAN EXPRESS
    ####################
    paper = 'indian-express'
    url = 'https://www.bitul.in/epaper/indian-express-pdf/'
    html = simple_get(url)
    soup = BeautifulSoup(html, 'html.parser')
    ptags = soup.find_all('p')

    print('Trying to fetch indian express')
    ele = None
    for ptag in ptags:
        if today_date in  ptag.text and today_month in ptag.text and today_year not in ptag.text:
            ele = ptag
            break

    if ele:
        dlink = ele.find('a')['href']
        file_id = dlink.split('/')[5]
        destination = download_dir + f'/{save_date}-{paper}-{today_month}-{today_date}.pdf'
        download_file_from_google_drive(file_id, destination)
        print(f'Successfully downloaded Indian Express {today_month} {today_date}')
    else:
        print('No relevant ptag found.')
