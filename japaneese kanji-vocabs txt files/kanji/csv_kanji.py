import requests
import json
import csv

def fetch_kanji_data(kanji):
    url = f"https://kanjiapi.dev/v1/kanji/{kanji}"
    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        print("Data ready !!!")
        return data
    else:
        raise Exception(f"Failed to fetch data. Status Code: {response.status_code}")

def read_kanji_file(filename):
    list_kanji = []
    id_counter = 1
    with open(filename, "r", encoding="utf-8") as file:
        for line in file:
            line = line.strip()  # Remove leading/trailing whitespace
            try:
                kanji_data = fetch_kanji_data(line)
                kanji_row = [
                    id_counter,
                    line,
                    '/'.join(kanji_data["meanings"]),
                    '/'.join(kanji_data["on_readings"]),
                    '/'.join(kanji_data["kun_readings"]),
                    "null",
                    0
                ]
                id_counter += 1
                list_kanji.append(kanji_row)
            except Exception as e:
                print(f"Error processing {line}: {e}")
    return list_kanji

def write_to_csv(csvname,fields,kanjis) :
    # writing to csv file with UTF-8 encoding
    with open(csvname, 'w', encoding='utf-8-sig', newline='') as csvfile:
        csvwriter = csv.writer(csvfile)
        csvwriter.writerow(fields)
        csvwriter.writerows(list_kanji)

# Example usage:
list_kanji = read_kanji_file("kanji/kanji-jlpt-n3.txt")
fields = ['id','kanji','meaning','on_reading','kun_reading','next_review_time','correct_counter']
#print(list_kanji[0])
write_to_csv("kanji/kanji-jlpt-n3.csv",fields,list_kanji)