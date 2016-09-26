# Grading script

The score is out of 100.

## Checking a single pull request

From this directory, run:

```bash
pip3 install -r ../requirements.txt
python3 run_single.py <pull_request_url>
```

## Grading all submissions

_This is intended for staff._

1. Download the [class survey data](https://docs.google.com/spreadsheets/d/1aQkPiTDqfxBtZDBCWAkU7Sizlf_KLoMEzJkbwhXBgjo/edit#gid=209566137).
    * `File`->`Download as`->`Comma-separated values`
1. From this directory, run:

    ```bash
    pip3 install -r ../requirements.txt
    python3 run_all.py <path/to/responses>.csv grades.csv
    ```

1. `grades.csv` can then be uploaded to CMS.
