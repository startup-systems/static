# Static Site Builder

In this assignment, you are going to be creating a (simple) static site builder for blogs, as a shell script.

## Example

Given the [`examples/simple/`](examples/simple/) as the input, which looks like this:

```
examples/
— simple/
  — postone.txt
  — some-other-post.txt
```

running the following:

```bash
./generate.sh examples/simple/ output/
```

should create:

```
output/
— postone.html
— some-other-post.html
```

In other words, for each of the original `.txt` files, a corresponding `.html` file should be created. If [`examples/simple/postone.txt`](`examples/simple/postone.txt`) contains

```
Post 1 Title

This is the body of Post 1.
```

then `output/postone.html` should look like

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Post 1 Title</title>
  </head>
  <body>
    This is the body of Post 1.
  </body>
</html>
```

## Requirements

* The script takes two arguments:
    1. The input directory
    1. The output directory
* Given an input directory of plain text files, your script should convert each one to an HTML page the output directory. It should work with any number of input files, in any directory, with any arbitrary names.
* The first line of each text file is the title, then there's an empty line, then the rest is the body.
* The generated pages should use the provided [template HTML file](template.html), replacing the `{{title}}` and `{{body}}`.
* If the output directory doesn't exist, create it and any missing parent directories (a.k.a. "recursively").
* All of the tests + Code Climate checks should pass.
    * `xfail` and `XPASS` correspond to the tests for the extra credit, so don't worry about them otherwise.

Fill in the [`generate.sh`](generate.sh) shell script with your code. You should not need to modify any other files.

### Extra credit

Too easy? Try the following:

* Any URLs should be hyperlinked. For example:

    ```
    https://someurl.com/somepath
    ```

    anywhere in the body should turn into

    ```html
    <a href="https://someurl.com/somepath">https://someurl.com/somepath</a>
    ```

* Any blank lines followed by more content should create a new paragraph. For example:

    ```
    Some text.

    Some more text.
    ```

    in the body should turn into

    ```html
    <p>
      Some text.
    </p>
    <p>
      Some more text.
    </p>
    ```

## Things you might need

* Loop(s)
* `basename`
* `sed`
* `head`
* `tail`
* Shell variables
* Shell script arguments

## Run tests locally

Inside your [virtual machine](https://github.com/startup-systems/vm):

```bash
cd /vagrant/static
# install dependencies
pip3 install -r requirements.txt

# run the "simple" tests (get these passing first)
pytest -v -k simple
# run all required tests (including randomized ones)
pytest -v
# run all tests, including extra credit ones
pytest --runxfail -v

# run the Code Climate checks locally
sudo apt update
sudo apt install shellcheck
shellcheck generate.sh
# if it doesn't print anything, you're good to go!
```

More info:

* [pytest](http://doc.pytest.org/)
* [ShellCheck](https://www.shellcheck.net/)
