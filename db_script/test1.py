import sqlite3

# Connect to DB
conn = sqlite3.connect('C:/Users/Amen 53/Documents/my flutter learning/japaneese_app/assets/db/kanji_app.db')
c = conn.cursor()

# Execute SELECT query
c.execute("drop table vocabulary",)

# Commit changes
conn.commit()

# Close connection
conn.close()
