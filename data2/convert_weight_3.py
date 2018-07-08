#!/usr/bin/python

import sys

def printBuffer(lineNumber, buffer):
  out = str(lineNumber) 
  for n in buffer:
    out = out + ' ' + str(n)
  print(out)

buffer = []
print('param weight_3 : 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 :=')
lineNumber = 0

for line in sys.stdin:
  words = line.strip().split(' ')
  if len(words) < 4:
    continue
  if words[0] == '[' or words[0][0] == '[':
    if len(buffer) > 0:
      printBuffer(lineNumber, buffer)
    lineNumber = lineNumber + 1
    if words[0] == '[':
      words = words[1:]
    else:
      words[0] = words[0][1:]
    buffer = []
  if words[-1] == ']':
    words = words[:-1]
  for n in words:
    if n != '':
      if n[-1] == ']':
        n = n[0:-1]
      buffer.append(float(n))
printBuffer(lineNumber, buffer)
print(';')
