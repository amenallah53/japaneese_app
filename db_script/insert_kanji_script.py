'''
import sqlite3
import csv

# Connect to SQLite DB (creates it if it doesn't exist)
conn = sqlite3.connect('kanji_app.db')
c = conn.cursor()

# Create table
c.execute('/''
CREATE TABLE IF NOT EXISTS kanji (
    id INTEGER PRIMARY KEY,
    kanji TEXT,
    meaning TEXT,
    on_reading TEXT,
    kun_reading TEXT,
    state TEXT CHECK (state IN ('locked','unlocked')),
    next_review_time DATE,
    correct_counter INTEGER,
    srs_stage_id TEXT REFERENCES srs_stage(id),
    jlpt_level TEXT
)
''/')

# Open CSV file and skip header
with open('C:/Users/Amen 53/Documents/my flutter learning/japaneese_app/japaneese kanji-vocabs txt files/kanji/kanji-jlpt-n3.csv', 'r', encoding='utf-8') as csvfile:
    reader = csv.reader(csvfile)
    next(reader)

    for row in reader:
        id = int(row[0])
        kanji = row[1]
        meaning = row[2]
        on_reading = row[3]
        kun_reading = row[4]
        c.execute('/''
    INSERT OR REPLACE INTO kanji 
    (id, kanji, meaning, on_reading, kun_reading, state, next_review_time, correct_counter, srs_stage_id, jlpt_level)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
''/', (id+177, kanji, meaning.replace('/',','), on_reading.replace('/',','), kun_reading.replace('/',','), "locked", None, 0, None, "jlpt-3"))


# Commit and close connection
conn.commit()
conn.close()
print("done !!")
'''