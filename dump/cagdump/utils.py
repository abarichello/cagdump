import itertools
import sys
import json
from pathlib import Path
from typing import List


_PATH = Path(__file__).parent.parent / "credentials.json"


def load_credentials():
    try:
        print(f"Opening credentials at {_PATH}")
        with _PATH.open() as f:
            return json.load(f)

    except IOError:
        print("Failed opening credentials file")
        sys.exit(-1)


def semester_range(start: int, end: int, drop_second_semester: bool) -> List[str]:
    years = [str(x) for x in list(range(start, end + 1))]
    sufixes = ["1", "2"]
    cartesian_product = list(itertools.product(*[years, sufixes]))
    semesters = [x[0] + x[1] for x in cartesian_product]
    if drop_second_semester:
        del semesters[-1]
    return semesters
