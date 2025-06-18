import sqlite3
import csv

# Connect to SQLite database (will create if it doesn't exist)
conn = sqlite3.connect('kanji_app.db')
cursor = conn.cursor()

# Create table (example)
cursor.execute('''
CREATE TABLE IF NOT EXISTS srs_stage (
    id TEXT PRIMARY KEY,
    stage TEXT
)
''')

#insert 
#apprentice levels
cursor.execute('''INSERT INTO srs_stage VALUES (?, ?)''', ('a1','apprentice 1'))
cursor.execute('''INSERT INTO srs_stage VALUES (?, ?)''', ('a2','apprentice 2'))
cursor.execute('''INSERT INTO srs_stage VALUES (?, ?)''', ('a3','apprentice 3'))
cursor.execute('''INSERT INTO srs_stage VALUES (?, ?)''', ('a4','apprentice 4'))
#guru levels
cursor.execute('''INSERT INTO srs_stage VALUES (?, ?)''', ('g1','guru 1'))
cursor.execute('''INSERT INTO srs_stage VALUES (?, ?)''', ('g2','guru 2'))
#master level
cursor.execute('''INSERT INTO srs_stage VALUES (?, ?)''', ('m','master'))
#enlightened level
cursor.execute('''INSERT INTO srs_stage VALUES (?, ?)''', ('e','enlightened'))
#burned level
cursor.execute('''INSERT INTO srs_stage VALUES (?, ?)''', ('b','burned'))


# Save and close
conn.commit()
conn.close()
print("Data inserted successfully.")
