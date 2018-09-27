from x import x     # x[depth, row, column]
from w1 import w1
from z1 import z1   # z1[row, column, depth]

b1 = [-1.5993764e-03,  1.5842086e-03,  9.1546599e-04,  6.1487175e-05,
      -5.4973643e-04,  2.7095852e-03,  1.5602008e-03, 7.3724525e-04,
      8.3429677e-06, -8.6893897e-06,  8.0423272e-04,  3.4193427e-03,
      1.3294573e-03, -4.2469562e-03,  1.1862431e-03,  6.7702564e-04]

rowBest = None
columnBest = None
errorBest = None
filterBest = None

numFilters = 1
filterWidth = 8
filterHeight = 3
filterDepth = 2
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
                    sum = sum + w1[filter][depth][height][width] * x[depth][effectiveRow][effectiveColumn]
        error = sum - target
        print('filter', filter, 'row0', row0, 'column0', column0, '\tbias', bias, '\tsum', sum, '\ttarget', target, '\terror', error)
        global errorBest, rowBest, columnBest, filterBest
        if errorBest is None or abs(error) < abs(errorBest):
            errorBest = error
            rowBest = row0
            columnBest = column0
            filterBest = filter


searchForPosition = True
if searchForPosition:

    for i in range(10):
        targetRow = i
        targetColumn = 10
        targetDepth = 0
        errorBest = None
        target = z1[targetRow][targetColumn][targetDepth]
        print('finding best match for target', targetRow, targetColumn, targetDepth, '=', target)
        for row0 in range(100):
            for column0 in range(100):
                compute(row0, column0, b1[0], target)
        print('best row', rowBest, 'column', columnBest, 'filter', filterBest, 'error', errorBest)

else:

    row0 = 5
    column0= 2
    for i in range(5):
        target = z1[0][0][i]
        print(i, 'target', target, 'bias', b1[0])
        compute(row0, column0, b1[0], target)
        column0 = column0 + stride

