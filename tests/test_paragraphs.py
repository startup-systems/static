import helpers
import os
import pytest
import tempfile

def generate(dest):
    input_dir = os.path.join('examples', 'paragraphs')
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
def test_body(output_dir):
    files = helpers.get_files(output_dir)
    post_path = os.path.join(output_dir, files[0])
    body = helpers.get_tag(post_path, 'body')
    # get all child tags
    # https://www.crummy.com/software/BeautifulSoup/bs4/doc/#true
    paragraphs = body.find_all(True)
    assert len(paragraphs) == 3

    for paragraph in paragraphs:
        assert paragraph.name == 'p'

    contents = [p.string.strip() for p in paragraphs]
    assert contents[0] == "This is the first paragraph. It has multiple sentences."
    assert contents[1] == "Then there's another paragraph."
    assert contents[2] == "And another."
