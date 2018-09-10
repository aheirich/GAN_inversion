
# input layer 0 is two 100x100 input arrays (10,000 each)
# first input array should be constrained to known values
# second input array is what we want the network to supply

param rows_0 := 100;
param columns_0 := 100;
param depth_0 := 2;

param padding_height_0 := 5;
param padding_width_0 := 5;

# inputs
var x{i in 1..rows_0 + 2 * padding_height_0, j in 1..columns_0 + 2 * padding_width_0, k in 1..depth_0};
#subject to rangemaxx{i in 1..rows_0 + 2 * padding_height_0, j in 1..columns_0 + 2 * padding_width_0, k in 1..depth_0}:
#x[i, j, k] <= 100;
#subject to rangeminx{i in 1..rows_0 + 2 * padding_height_0, j in 1..columns_0 + 2 * padding_width_0, k in 1..depth_0}:
#x[i, j, k] >= -100;

# objective makes x match
minimize discrepency: sum{i in 2..rows_0, j in 1..columns_0} (x[i + padding_height_0, j + padding_width_0, 2] - x[1 + padding_height_0, j + padding_width_0, 2])^2;

# layer 1 is 50x50x16 convolutional layer
# each convolution filter is 3x8x2 with stride of 2,2
# there are 16 filters

# layer-1
param rows_1 := 50;
param columns_1 := 50;
param depth_1 := 16;

param stride := 2;

param filter_height_1 := 3;
param filter_width_1 := 8;
param filter_depth_1 := 2;

param filter_height_1_half = 1;
param filter_width_1_half = 4;

param padding_height_1 := 5;
param padding_width_1 := 5;

param bias_1{i in 1..depth_1};

# activations
var a1{i in 1..rows_1 + 2 * padding_height_1, j in 1..columns_1 + 2 * padding_width_1, k in 1..depth_1};

# preactivations
var z1{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1};

# range constraints
#subject to rangemax1{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1}:
#z1[i, j, k] <= 100;
#subject to rangemin1{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1}:
#z1[i, j, k] >= -100;

param weight_1{i in 1..filter_height_1, j in 1..filter_width_1, l in 1..filter_depth_1, k in 1..depth_1};

subject to preactivation1{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1}:
z1[i, j, k] = bias_1[k] * sum{l in 1..filter_height_1, m in 1..filter_width_1, n in 1..filter_depth_1}
weight_1[l, m, n, k] *
x[padding_height_0 + ((i - 1) * 2) + 1 + l - filter_height_1_half,
  padding_width_0 + ((j - 1) * 2) + 1 + m - filter_width_1_half,
n];






# leaky Relu leakiness parameter
param leakiness := 0.2;

# compute activations with padding
subject to activation1{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1}:
a1[i + padding_height_1, j + padding_width_1, k] = z1[i, j, k] * (1 / (1 + exp(-10000.0 * z1[i, j, k])))
+ (1 - (1 / (1 + exp(-10000.0 * z1[i, j, k])))) * leakiness * z1[i, j, k];

# zero padding for a1
subject to zeropad1_1{i in 1..padding_height_1, j in 1..columns_1, k in 1..depth_1}:
a1[i, j, k] = 0;
subject to zeropad1_2{i in 1..padding_height_1, j in 1..columns_1, k in 1..depth_1}:
a1[i + padding_height_1 + rows_1, j, k] = 0;
subject to zeropad1_3{i in 1..rows_1, j in 1..padding_width_1, k in 1..depth_1}:
a1[i + padding_height_1, j, k] = 0;
subject to zeropad1_4{i in 1..rows_1, j in 1..padding_width_1, k in 1..depth_1}:
a1[i + padding_height_1, j + padding_width_1 + columns_1, k] = 0;






### activation targets

var x_{i in 1..rows_0 + 2 * padding_height_0, j in 1..columns_0 + 2 * padding_width_0, k in 1..depth_0};
var z1_{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1};
var a1_{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1};

subject to xValue{i in 1..rows_0 + 2 * padding_height_0, j in 1..columns_0 + 2 * padding_width_0, k in 1..depth_0}:
x[i, j, k] = x_[i, j, k];

subject to z1Value{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1}:
z1[i, j, k] = z1_[i, j, k];

subject to a1Value{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1}:
a1[i + padding_height_1, j + padding_width_1, k] = a1_[i, j, k];
