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

i = 0
for sheet in wb.sheets():
    print(i)
    i += 1
    for row in range(2, sheet.nrows):
        col_value = {}
        text = sheet.cell(row, 0).value
        title = sheet.cell(row, 1).value
        if(title is not None and text is not '' and not text.startswith('You are free')):
            try:
                title = str(title)
                text = str(text)
            except:
                pass
            col_value['text'] = text
            col_value['title'] = title
            db.collection("data").document(title).set(col_value)
