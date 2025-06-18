import requests
import json
import csv

def fetch_vocab_data(vocab):
    url = f"https://jlpt-vocab-api.vercel.app/api/words?word={vocab}"
    response = requests.get(url)
    if response.status_code == 200 :
        data = response.json()
        print("Data ready !!!")
        return data
    else:
        raise Exception(f"Failed to fetch data. Status Code: {response.status_code}")

def read_vocab_file(filename):
    list_vocab = []
    id_counter = 0
    with open(filename, "r", encoding="utf-8") as file:
        for line in file:
            id_counter += 1
            line = line.strip()  # Remove leading/trailing whitespace
            try:
                vocab_data = fetch_vocab_data(line)
                vocab_row = [
                    id_counter,
                    line,
                    vocab_data["words"][0]["meaning"].replace(",","/"),
                    vocab_data["words"][0]["furigana"].replace(",","/"),
                    "null",
                    0
                ]
                list_vocab.append(vocab_row)
            except Exception as e:
                list_vocab.append([id_counter,line,"","","null",0])
                print(f"Error processing {line}: {e}")

    return list_vocab

def write_to_csv(csvname,fields,list_vocab) :
    # writing to csv file with UTF-8 encoding
    with open(csvname, 'w', encoding='utf-8-sig', newline='') as csvfile:
        csvwriter = csv.writer(csvfile)
        csvwriter.writerow(fields)
        csvwriter.writerows(list_vocab)

# Example usage:
list_vocab = read_vocab_file("vocab/vocab-jlpt-n3.txt")
fields = ['id','word','meaning','reading','next_review_time','correct_counter']
'''
try :
    vocab_data = fetch_vocab_data("会う")
    print(vocab_data["words"][0]["meaning"])
    print(vocab_data["words"][0]["furigana"])
except Exception as e :
    print(f"Error processing 会う : {e}")
'''
print(list_vocab[0])
write_to_csv("vocab/vocab-jlpt-n3.csv",fields,list_vocab)