import os
import subprocess
import tempfile
from bs4 import BeautifulSoup

def test_simple():
    with tempfile.TemporaryDirectory(suffix='static') as tmpdirname:
        result = subprocess.run(['./generate.sh', 'examples/simple/', tmpdirname])
        assert result.returncode == 0

        files = os.listdir(tmpdirname)
        files.sort()
        assert files == ['post1.html', 'post2.html']

        # check that files have appropriate content

        path = os.path.join(tmpdirname, files[0])
        soup = BeautifulSoup(open(path), 'html.parser')
        title = soup.find('title')
        assert title.string.strip() == "Post 1 Title"
        body = soup.find('body')
        assert body.string.strip() == "This is the body of Post 1."

        path = os.path.join(tmpdirname, files[1])
        soup = BeautifulSoup(open(path), 'html.parser')
        title = soup.find('title')
        assert title.string.strip() == "Post 2 Title"
        body = soup.find('body')
        assert body.string.strip() == "This is the body of Post 2."
