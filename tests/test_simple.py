import os
import pytest
import subprocess
import tempfile
from helpers import *

@pytest.fixture
def output_dir():
    with tempfile.TemporaryDirectory(suffix='-static') as tmpdirname:
        subprocess.run(['./generate.sh', 'examples/simple/', tmpdirname])
        yield tmpdirname

def get_files(path):
    files = os.listdir(path)
    files.sort()
    return files

def test_no_errors():
    with tempfile.TemporaryDirectory(suffix='-static') as tmpdirname:
        result = subprocess.run(['./generate.sh', 'examples/simple/', tmpdirname])
        assert result.returncode == 0

def test_files(output_dir):
    files = get_files(output_dir)
    assert files == ['postone.html', 'some-other-post.html']

def test_titles(output_dir):
    files = get_files(output_dir)

    potst1path = os.path.join(output_dir, files[0])
    check_title(potst1path, "Post One Title")

    otherpostpath = os.path.join(output_dir, files[1])
    check_title(otherpostpath, "Some Other Post Title")

def test_bodies(output_dir):
    files = get_files(output_dir)

    potst1path = os.path.join(output_dir, files[0])
    check_body(potst1path, "This is the body of Post One.")

    otherpostpath = os.path.join(output_dir, files[1])
    check_body(otherpostpath, "This is the body of the other post.")
