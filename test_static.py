import os
import subprocess
import tempfile

def test_simple():
    with tempfile.TemporaryDirectory(suffix="static") as tmpdirname:
        result = subprocess.run(["./generate.sh", "examples/simple/", tmpdirname])
        assert result.returncode == 0

        files = os.listdir(tmpdirname)
        files.sort()
        assert files == ["post1.html", "post2.html"]

        # TODO check that files have appropriate content
