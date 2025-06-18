def remove_extras_file(filename) :
    new_list_kanji = []
    with open(filename, "r", encoding="utf-8") as file :
        for line in file:
            if line not in ['古','新','入','出'] :  
                new_list_kanji.append(line[0]) 
    return new_list_kanji

def write_file(filename,list) :
    with open(filename, "w", encoding="utf-8") as file :
        [file.write(line+"\n") for line in list]
    file.close()

kanji_list = remove_extras_file("kanji-jlpt-n4.txt")
write_file("kanji-jlpt-n4.txt",kanji_list)