import os
import subprocess
import tempfile
from helpers import *

def test_no_errors():
    with tempfile.TemporaryDirectory(suffix='static') as tmpdirname:
        result = subprocess.run(['./generate.sh', 'examples/simple/', tmpdirname])
        assert result.returncode == 0

def test_files():
    with tempfile.TemporaryDirectory(suffix='static') as tmpdirname:
        subprocess.run(['./generate.sh', 'examples/simple/', tmpdirname])

        files = os.listdir(tmpdirname)
        files.sort()
        assert files == ['post1.html', 'post2.html']

def test_content():
    with tempfile.TemporaryDirectory(suffix='static') as tmpdirname:
        subprocess.run(['./generate.sh', 'examples/simple/', tmpdirname])

        files = os.listdir(tmpdirname)
        files.sort()

        potst1path = os.path.join(tmpdirname, files[0])
        check_content(potst1path, "Post 1 Title", "This is the body of Post 1.")

        post2path = os.path.join(tmpdirname, files[1])
        check_content(post2path, "Post 2 Title", "This is the body of Post 2.")
