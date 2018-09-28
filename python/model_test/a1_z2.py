from a1 import a1
from w2 import w2
from z2 import z2


b2 = [ 8.6049121e-03,  2.5172469e-03,  3.6516413e-03,  2.5646177e-03,
      3.6787922e-03,  7.1763969e-03,  2.2968510e-02,  2.3482554e-03,
      9.0238024e-03,  1.4990627e-02,  3.9704717e-03, -1.0760536e-02,
      1.9333864e-02,  9.7632415e-05, -1.2250900e-03,  9.9583454e-03,
      3.3728122e-03, -1.1445956e-02,  7.9989722e-03,  7.5499560e-03,
      -1.7739191e-04,  5.8587361e-04, -2.6702957e-04,  1.3437148e-04,
      2.2867101e-03,  1.5459181e-02,  3.6918171e-02, -1.3757165e-03,
      1.8754778e-03,  1.4310528e-03,  5.1401868e-03,  3.9782193e-03]

# index a1 by [row, column, depth]
# the original weight_conv_2.txt is ordered by depth(32), filterDepth(16), filterHeight(8), filterWidth(3)
# index w2 by [depth(32), filterDepth(16), filterHeight(8), filterWidth(3)]
# index z2 by [row, column, depth]

rowBest = None
columnBest = None
errorBest = None
filterBest = None

numFilters = 1 # 32
filterWidth = 3
filterHeight = 8
filterDepth = 16
stride = 2
padding = 5

def compute(row0, column0, bias, target):
    sum = bias
    for filter in range(numFilters):
        for depth in range(filterDepth):
            for height in range(filterHeight):
                for width in range(filterWidth):
                    effectiveRow = row0 + height
                    effectiveColumn = column0 + width
                    sum = sum + w2[filter][depth][height][width] * a1[effectiveRow][effectiveColumn][depth]
        error = sum - target
        print('filter', filter, 'row0', row0, 'column0', column0, '\tbias', bias, '\tsum', sum, '\ttarget', target, '\terror', error);
        global errorBest, rowBest, columnBest, filterBest
        if errorBest is None or abs(error) < abs(errorBest):
            errorBest = error
            rowBest = row0
            columnBest = column0
            filterBest = filter

searchForPosition = True
if searchForPosition:
    
    for i in range(10):
        targetRow = 10
        targetColumn = i
        targetDepth = 0
        errorBest = None
        target = z2[targetRow][targetColumn][targetDepth]
        print('finding best match for target', targetRow, targetColumn, targetDepth, '=', target)
        for row0 in range(40):
            for column0 in range(40):
                compute(row0, column0, b2[0], target)
        print('best row', rowBest, 'column', columnBest, 'filter', filterBest, 'error', errorBest)
