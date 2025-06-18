def read_file(filename) :
    list_kanji = []
    with open(filename, "r", encoding="utf-8") as file :
        for line in file:
            line = line.strip()  # Remove leading/trailing whitespace
            if line :  # Check if line is not empty after stripping
                list_kanji.append(line[0]) 
    return list_kanji

def write_file(filename,list) :
    with open(filename, "w", encoding="utf-8") as file :
        [file.write(line+"\n") for line in list]
    file.close()

kanji_list = read_file("kanji/kanji-jlpt-n3.txt")
write_file("kanji/kanji-jlpt-n3.txt",kanji_list)