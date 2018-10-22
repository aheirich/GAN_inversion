#
# extract_solution.py
#

import sys


def getFirstColumn(words):
  for word in words:
    try:
      column = int(word)
      return column
    except ValueError:
      pass

def getColumns(words):
  result = []
  for word in words[1:]:
    if word != '':
      result.append(float(word))
  return result

solution = []

lineNumber = 0
f = open(sys.argv[1], "r")
while True:
  line = f.readline().strip()
  lineNumber = lineNumber + 1
  if ("[*,*,2]" in line): break

for line in f:
  line = line.strip()
  if line is None: break
  if line.startswith(":") and line.endswith(":="):
    words = line.split(' ')
    currentColumn = getFirstColumn(words)
  if line.startswith('6 '):
    words = line.split(' ')
    solution = solution + getColumns(words)
    if currentColumn > 100: break

padding = 5
for x in solution[padding:-padding]:
  print(x)

