import json
from pathlib import Path
from cagrex import CAGR
from utils import load_credentials, semester_range


CREDENTIALS = load_credentials()
CLASS_CODES_TO_SEARCH = ["INE"]
# CLASS_CODES_TO_SEARCH = ["INE", "MTM", "EEL", "ZZD"]
SEMESTER_RANGE = semester_range(2016, 2021, False)

OUTPUT_PATH = Path(__file__).parent.parent / "output"

cagr = CAGR()
cagr.login(CREDENTIALS["username"], CREDENTIALS["password"])
print("Logged in succesfully")

classes = []
for semester in SEMESTER_RANGE:
    for code in CLASS_CODES_TO_SEARCH:
        classes.extend(cagr.search_classes(code, semester))
        print(f"Processed {semester}, {code}")

# test this
with open(OUTPUT_PATH / "INE-2016-2021.json", "w") as file:
    json.dump(classes, file)
    print("Wrote file")
