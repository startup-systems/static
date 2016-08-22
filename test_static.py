import tempfile
import subprocess

def test_simple():
    with tempfile.TemporaryDirectory(suffix="static") as tmpdirname:
        result = subprocess.run(["./generate.sh", "examples/simple/", tmpdirname])
        assert result.returncode == 0
        # TODO check that appropriate files exist with appropriate content
