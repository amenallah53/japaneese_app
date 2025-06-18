def read_file(filename) :
    list_vocab = []
    with open(filename, "r", encoding="utf-8") as file :
        for line in file:
            line = line.strip()  # Remove leading/trailing whitespace
            if line :  # Check if line is not empty after stripping
                list_vocab.append(line[4:line.find(" ",4)]) 
    return list_vocab

def write_file(filename,list) :
    with open(filename, "w", encoding="utf-8") as file :
        [file.write(line+"\n") for line in list]
    file.close()

vocab_list = read_file("vocab/vocab-jlpt-n3.txt")
print(vocab_list)
write_file("vocab/vocab-jlpt-n3.txt",vocab_list)