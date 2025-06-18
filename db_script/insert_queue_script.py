import sqlite3

# Connect to SQLite DB (creates it if it doesn't exist)
conn = sqlite3.connect('C:/Users/Amen 53/Documents/my flutter learning/japaneese_app/assets/db/kanji_app.db')
c = conn.cursor()

# Create lessons_kanji_queue table
c.execute('''
CREATE TABLE IF NOT EXISTS lessons_kanji_queue (
    id INTEGER PRIMARY KEY,
    kanji TEXT,
    meaning TEXT,
    on_reading TEXT,
    kun_reading TEXT
)
''')

# Create lessons_vocab_queue table
c.execute('''
CREATE TABLE IF NOT EXISTS lessons_vocab_queue (
    id INTEGER PRIMARY KEY,
    word TEXT,
    meaning TEXT,
    reading TEXT
)
''')


# Fetch 10 kanji from kanji table
c.execute('''
    SELECT id, kanji, meaning, on_reading, kun_reading
    FROM kanji
    WHERE id > 8
    ORDER BY id asc
    LIMIT ?
    ''',(2,))

rows = c.fetchall()

# Insert them into lessons_kanji_queue
for row in rows:
    id = int(row[0])
    kanji = row[1]
    meaning = row[2]
    on_reading = row[3]
    kun_reading = row[4]
    c.execute('''
        INSERT OR REPLACE INTO lessons_kanji_queue
        (id, kanji, meaning, on_reading, kun_reading)
        VALUES (?, ?, ?, ?, ?)
    ''', (id, kanji, meaning.replace('/', ','), on_reading.replace('/', ','), kun_reading.replace('/', ',')))



# Fetch 10 vocabs from vocab table
c.execute('''
    SELECT id, word, meaning, reading
    FROM vocabulary
    ORDER BY id ASC
    LIMIT 10
''')

rows = c.fetchall()

# Insert them into lessons_vocab_queue
for row in rows:
    id = int(row[0])
    word = row[1]
    meaning = row[2]
    reading = row[3]
    c.execute('''
        INSERT OR REPLACE INTO lessons_vocab_queue
        (id, word, meaning, reading)
        VALUES (?, ?, ?, ?)
    ''', (id, word, meaning.replace('/', ','), reading.replace('/', ',')))


# Commit and close connection
conn.commit()
conn.close()
print("done !!")
