import helpers
import os
import pytest
import random
import tempfile

class InputFile:
    def __init__(self, file_number):
        self.file_number = file_number
        self.filename = "post{}.txt".format(self.file_number)
        self.title = "Post {} Title".format(self.file_number)
        self.body = "The body of post {}.".format(self.file_number)

    def write_to(self, dirpath):
        filepath = os.path.join(dirpath, self.filename)
        with open(filepath, 'w') as f:
            f.write(self.title)
            f.write("\n\n")
            f.write(self.body)

@pytest.fixture
def input_dir():
    with tempfile.TemporaryDirectory(suffix='-static-input') as tmpdirname:
        yield tmpdirname

@pytest.fixture
def input_files(input_dir):
    num_files = random.randint(3, 5)
    file_numbers = random.sample(range(0, 9), num_files)
    file_numbers.sort()

    return [InputFile(n) for n in file_numbers]

@pytest.fixture
def populated_input_dir(input_dir, input_files):
    for input_file in input_files:
        input_file.write_to(input_dir)

    yield input_dir

@pytest.fixture
def output_dir():
    with tempfile.TemporaryDirectory(suffix='-static-output') as tmpdirname:
        yield tmpdirname

@pytest.fixture
def populated_output_dir(populated_input_dir, output_dir):
    print("DEBUG")
    result = helpers.generate(populated_input_dir, output_dir)
    assert result.returncode == 0
    yield output_dir

def test_files(input_files, populated_output_dir):
    input_filenames = ["post{}.html".format(f.file_number) for f in input_files]
    output_filenames = helpers.get_files(populated_output_dir)
    assert output_filenames == input_filenames

def test_titles(input_files, populated_output_dir):
    output_files = helpers.get_files(populated_output_dir)

    for input_file in input_files:
        path = os.path.join(populated_output_dir, "post{}.html".format(input_file.file_number))
        helpers.check_title(path, input_file.title)

def test_bodies(input_files, populated_output_dir):
    output_files = helpers.get_files(populated_output_dir)

    for input_file in input_files:
        path = os.path.join(populated_output_dir, "post{}.html".format(input_file.file_number))
        helpers.check_body_text(path, input_file.body)
