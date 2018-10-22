import sys

f = open(sys.argv[1], "r")
sum = 0
count = 0
for line in f.readlines():
  word = line.strip()
  value = float(word)
  sum = sum + value
  count = count + 1
print("mean", sum / count)
