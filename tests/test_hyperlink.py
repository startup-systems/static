import helpers
import os
import pytest
import tempfile

def generate(dest):
    input_dir = os.path.join('examples', 'hyperlink')
    return helpers.generate(input_dir, dest)

@pytest.fixture
def output_dir():
    with tempfile.TemporaryDirectory(suffix='-static') as dest:
        generate(dest)
        yield dest

def test_no_errors():
    with tempfile.TemporaryDirectory(suffix='-static') as tmpdirname:
        result = generate(tmpdirname)
        assert result.returncode == 0

def test_files(output_dir):
    files = helpers.get_files(output_dir)
    assert files == ['post.html']

@pytest.mark.xfail
def test_hyperlink(output_dir):
    files = helpers.get_files(output_dir)

    post_path = os.path.join(output_dir, files[0])
    helpers.check_body(post_path, 'This is a post, with a link to <a href="https://google.com">https://google.com</a>.')
