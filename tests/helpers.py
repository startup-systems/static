from bs4 import BeautifulSoup
import os
import subprocess

def get_tag(path, selector):
    soup = BeautifulSoup(open(path), 'html.parser')
    return soup.find(selector)

def get_content(path, selector):
    tag = get_tag(path, selector)
    return tag.string.strip()

def check_title(path, title):
    assert get_content(path, 'title') == title

def check_body(path, body):
    assert get_content(path, 'body') == body

def generate(source, dest):
    script = os.path.join('.', 'generate.sh')
    input_dir = os.path.join('examples', 'simple')
    return subprocess.run([script, source, dest])
