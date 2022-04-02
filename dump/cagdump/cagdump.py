import sys
import json
from pathlib import Path
from cagrex import CAGR
from fixes import INE_COURSE_NAMES_IN_20171
from utils import load_credentials, semester_range


CREDENTIALS = load_credentials()

# todo: move to input
CLASS_CODES_TO_SEARCH = ["MTM", "EEL"]
SEMESTER_RANGE = semester_range(2016, 2021, False)

OUTPUT_PATH = Path(__file__).parent.parent.parent / "output"
OUTPUT_FILE = "output.json" if sys.argv[1] is None else sys.argv[1]


cagr = CAGR()
cagr.login(CREDENTIALS["username"], CREDENTIALS["password"])
print("Logged in succesfully")

classes = []
for semester in SEMESTER_RANGE:
    for code in CLASS_CODES_TO_SEARCH:
        classes.extend(cagr.search_classes(code, semester))
        print(f"Processed {semester}, {code}")

with open(OUTPUT_PATH / OUTPUT_FILE, "w") as file:
    json.dump(classes, file)
    print("Wrote file")
