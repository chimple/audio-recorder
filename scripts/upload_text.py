import sys
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore


from xlrd import open_workbook

xlsx_file = sys.argv[1]

cred = credentials.Certificate("audio-recorder-e3741-firebase-adminsdk-ia7iz-c6b9bd0d8e.json")
firebase_admin.initialize_app(cred)

db = firestore.client()


wb = open_workbook(xlsx_file)

values = []
for sheet in wb.sheets():
    for row in range(1, sheet.nrows):
        col_names = sheet.row(0)
        col_value = {}
        for name, col in zip(col_names, range(sheet.ncols)):
            value = sheet.cell(row, col).value
            try:
                value = str(value)
            except:
                pass
            col_value[name.value] = value
        db.collection("data").add(col_value)
        values.append(col_value)
