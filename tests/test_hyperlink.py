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

@pytest.mark.xfail
def test_no_errors():
    with tempfile.TemporaryDirectory(suffix='-static') as tmpdirname:
        result = generate(tmpdirname)
        assert result.returncode == 0

@pytest.mark.xfail
def test_files(output_dir):
    files = helpers.get_files(output_dir)
    assert files == ['post.html']

@pytest.mark.xfail
def test_anchor(output_dir):
    files = helpers.get_files(output_dir)
    post_path = os.path.join(output_dir, files[0])
    anchor = helpers.get_tag(post_path, 'a')
    assert anchor['href'] == 'https://google.com'
    assert anchor.string == 'https://google.com'
