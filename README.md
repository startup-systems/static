# Static Site Builder
## Description
A (simple) static site builder for blogs, as a shell script.

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
