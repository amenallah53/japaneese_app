import sqlite3

# Connect to DB
conn = sqlite3.connect('C:/Users/Amen 53/Documents/my flutter learning/japaneese_app/assets/db/kanji_app.db')
c = conn.cursor()

# Execute SELECT query
#c.execute("update vocabulary set meaning = 'japanese person' where word = '日本人'",)
c.execute("select meaning from vocabulary where word = '日本人'")

rows = c.fetchall()

# Print results
for row in rows:
    print(row)

# Commit changes
conn.commit()

# Close connection
conn.close()
