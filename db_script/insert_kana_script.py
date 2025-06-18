import sqlite3
import csv

# Connect to SQLite DB (creates it if it doesn't exist)
conn = sqlite3.connect('kanji_app.db')
c = conn.cursor()

# Create table
c.execute('''
CREATE TABLE IF NOT EXISTS katakana (
    kana TEXT PRIMARY KEY,
    romanji_reading TEXT,
    type_column TEXT,
    correct_counter INTEGER,
    srs_stage_id TEXT REFERENCES srs_stage(id)
)
''')

# Open CSV file
with open('C:/Users/Amen 53/Documents/my flutter learning/japaneese_app/japaneese kanji-vocabs txt files/katakana/katakana combinations.csv', 'r', encoding='utf-8') as csvfile:
    reader = csv.reader(csvfile)

    for row in reader:
        kana = row[0]
        romanaji_reading = row[1]
        type_column = row[2]
        c.execute('''
    INSERT OR REPLACE INTO katakana 
    (kana, romanji_reading, type_column, correct_counter, srs_stage_id)
    VALUES (?, ?, ?, ?, ?)
''', (kana, romanaji_reading, type_column, 0, None))


# Commit and close connection
conn.commit()
conn.close()
print("done !!")