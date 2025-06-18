import sqlite3

# Connect to DB
conn = sqlite3.connect('C:/Users/Amen 53/Documents/my flutter learning/japaneese_app/assets/db/kanji_app.db')
c = conn.cursor()
n = 2
# Execute SELECT query
'''c.execute(
    '/''
    SELECT id,kanji,meaning,on_reading,kun_reading FROM kanji
    WHERE state = 'locked'
    ORDER BY id asc
    LIMIT ?
    '/'',(n,)
    )'''
c.execute('''SELECT * FROM vocabulary''')

# Fetch all results
rows = c.fetchall()

# Print results
for row in rows:
    print(row)

# Close connection
conn.close()
