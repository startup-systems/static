import csv


class Student:
    def __init__(self, row):
        """Takes a `row` as a dictionary."""
        self.net_id = row['NetID']
        self.github_username = row['GitHub username']

    @classmethod
    def read_all(cls, csv_path):
        with open(csv_path) as csvfile:
            reader = csv.DictReader(csvfile)
            return [cls(row) for row in reader]

    @classmethod
    def all_by_github_username(cls, csv_path):
        students = cls.read_all(csv_path)
        # http://stackoverflow.com/a/3070270/358804
        return {s.github_username: s for s in students}
