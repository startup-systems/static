import helpers
import os
import pytest
import tempfile

def generate(dest):
    input_dir = os.path.join('examples', 'simple')
    return helpers.generate(input_dir, dest)

@pytest.fixture
def output_dir():
    with tempfile.TemporaryDirectory(suffix='-static') as tmpdirname:
        generate(tmpdirname)
        yield tmpdirname

def test_no_errors():
    with tempfile.TemporaryDirectory(suffix='-static') as tmpdirname:
        result = generate(tmpdirname)
        assert result.returncode == 0

def test_files(output_dir):
    files = helpers.get_files(output_dir)
    assert files == ['postone.html', 'some-other-post.html']

def test_titles(output_dir):
    files = helpers.get_files(output_dir)

    potst1path = os.path.join(output_dir, files[0])
    helpers.check_title(potst1path, "Post One Title")

    otherpostpath = os.path.join(output_dir, files[1])
    helpers.check_title(otherpostpath, "Some Other Post Title")

def test_bodies(output_dir):
    files = helpers.get_files(output_dir)

    potst1path = os.path.join(output_dir, files[0])
    helpers.check_body_text(potst1path, "This is the body of Post One.")

    otherpostpath = os.path.join(output_dir, files[1])
    helpers.check_body_text(otherpostpath, "This is the body of the other post.")

def test_subdirectory_creation():
    with tempfile.TemporaryDirectory(suffix='-static') as tmpdirname:
        dest = os.path.join(tmpdirname, 'subdir')
        result = generate(dest)
        assert result.returncode == 0

        files = helpers.get_files(dest)
        assert files == ['postone.html', 'some-other-post.html']

def test_recursive_directory_creation():
    with tempfile.TemporaryDirectory(suffix='-static') as tmpdirname:
        dest = os.path.join(tmpdirname, 'subdir', 'subsubdir')
        result = generate(dest)
        assert result.returncode == 0

        files = helpers.get_files(dest)
        assert files == ['postone.html', 'some-other-post.html']
