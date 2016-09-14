from bs4 import BeautifulSoup

def check_content(path, title, body):
    soup = BeautifulSoup(open(path), 'html.parser')
    titletag = soup.find('title')
    assert titletag.string.strip() == title
    bodytag = soup.find('body')
    assert bodytag.string.strip() == body
