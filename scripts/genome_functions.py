## Function definitions
### Load Data
def loadData(filename):
    with open(filename, 'r') as myfile:
        text = myfile.read().replace('\n', '')
    return text

### Pattern finding function
def PatternCount(text, pattern):
    count = 0
    for i in range(len(text)-len(pattern)+1):
        if text[i:i+len(pattern)] == pattern:
            count = count + 1
    return count

# reference : https://www.biostars.org/p/307731/
def FrequentWords(text,  k):
    # words frequency dictionary
    freq = {}
    n = len(text)
    for i in range (n-k+1):
        Pattern = text [i:i+k]
        if Pattern not in freq:
            freq [Pattern] = 1 # if a pattern found is not already  in the dictionary freq{}, it is assigned a value of 1 and added to the list
        else:
            freq [Pattern] +=1 # however, if the pattern is already in the dictionary, its value should go up by 1 (so if it has been found, it is initially given a pattern of 1, and then this adds another 1 if it is found again
    return freq

# most frequent pattern
def MostFrequentWord(text, k):
    freqs = FrequentWords(text,k)
    max_value = max(freqs.values())  # maximum value
    max_keys = [k for k, v in freqs.items() if v == max_value]
    return max_value, max_keys

### Pattern Matching Function
def PatternMatching(text, pat):
    positions = [] # empty list
    for i in range(len(text)-len(pattern)+1):
        if text[i:i+len(pattern)] == pattern:
            positions.append(i)
    return positions


# Optimization -------------------------------
''' Binary encoding of genome pattern

Each genome letter is encoded as a two bit value.
A genome pattern of length l is interpreted as a little endian binary word of length 2*l.
For each letter in the genome, the letter encoding value is multiplied by 4 powered to the letter position.

Examples:
    AAA -> 0
    AAC -> 1
    AAG -> 2
    AAT -> 3
    ACA -> 4

Returns: a code representing the sum of the given binary word
'''
def patternToNumber(pattern):
    letterDict = {'A' : 0, 'C' : 1, 'G' : 2, 'T' : 3}
    reversedPattern = pattern[::-1] # little endian pattern
    patternCode = 0
    ''' loops over the reversed pattern '''
    for i in range(len(reversedPattern)):
        patternCode += letterDict[reversedPattern[i]] * 4**i
    return patternCode

''' Binary decoding of genome pattern

Inverse funtion of patternToNumber

Examples:
    0 -> AAA
    1 -> AAC
    2 -> AAG
    3 -> AAT
    4 -> ACA

Returns: a pattern given for the given number
'''
def numberToPattern(patternCode, length):
    numberDict = {0:'A', 1:'C', 2:'G', 3:'T'}
    pattern = []
    # copy pattern code
    remainingCode = patternCode
    while remainingCode > 0:
        value = remainingCode % 4
        pattern.append(numberDict[value])
        remainingCode -= value
        remainingCode /= 4
    while len(pattern) < length:
        pattern.append('A')
    return ''.join(pattern[::-1])

''' Map Frequencies

Creates a dictionary of each pattern code of length k and its frequency count.

inspired by :
https://www.biostars.org/p/307731/

'''
def MapFrequencies(text, k):
    freq = {} # pattern frequencies dictionary
    n = len(text)
    for i in range (n-k+1):
        pattern = text [i:i+k]
        patternCode = patternToNumber(pattern)
        if patternCode not in freq:
            freq[patternCode] = 1 # if a pattern found is not already  in the dictionary freq{}, it is assigned a value of 1 and added to the list
        else:
            freq[patternCode] +=1 # however, if the pattern is already in the dictionary, its value should go up by 1 (so if it has been found, it is initially given a pattern of 1, and then this adds another 1 if it is found again
    return freq

''' Computing Frequencies

text : the genome
k : length of the patterns searched

Return: a frequency array of the most frequent k-mers in the text and their occurence
'''
def ComputingFrequencies(text, k):
    freqs = MapFrequencies(text, k)
    max_value = max(freqs.values())  # maximum key value
    max_patterns = [numberToPattern(key, k) for key, v in freqs.items() if v == max_value]
    return max_value, max_patterns

