# Grading script

This folder is intended for staff. To get assignment grades:

1. Download the [class survey data](https://docs.google.com/spreadsheets/d/1aQkPiTDqfxBtZDBCWAkU7Sizlf_KLoMEzJkbwhXBgjo/edit#gid=209566137).
    * `File`->`Download as`->`Comma-separated values`
1. Run

    ```bash
    pip3 install requests
    python3 grade.py path/to/responses.csv grades.csv
    ```
