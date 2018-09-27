
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



### input variable, clamp x[.,.,1], leave x[.,.,2] free this is the answer we seek

param x_{i in 1..rows_0 + 2 * padding_height_0, j in 1..columns_0 + 2 * padding_width_0, k in 1..depth_0};
subject to xValue{i in 1..rows_0 + 2 * padding_height_0, j in 1..columns_0 + 2 * padding_width_0, k in 1..depth_0}:
x[i, j, k] = x_[i, j, k];

# objective makes x[,,1] match expected input, x[,,2] match itself, and a4 match expected output value
minimize discrepency: 
sum{i in 2..rows_0, j in 1..columns_0} (x[i + padding_height_0, j + padding_width_0, 2] - x[1 + padding_height_0, j + padding_width_0, 2])^2
;

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

param row_1_base := 5;
param column_1_base := 2;

param bias_1{i in 1..depth_1};

# activations
var a1{i in 1..rows_1 + 2 * padding_height_1, j in 1..columns_1 + 2 * padding_width_1, k in 1..depth_1};

# preactivations
var z1{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1};

param weight_1{i in 1..filter_height_1, j in 1..filter_width_1, l in 1..filter_depth_1, k in 1..depth_1};

subject to preactivation1{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1}:
 z1[i, j, k] = bias_1[k] + sum{l in 1..filter_height_1, m in 1..filter_width_1, n in 1..filter_depth_1}
 weight_1[l, m, n, k] *
 x[row_1_base + ((i - 1) * 2) + l, column_1_base + ((j - 1) * 2) + m,
 n];





### activation targets, use this to verify the model with a known fixed point (Remove after verification)

param z1_{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1};

subject to z1Value{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1}:
z1[i, j, k] = z1_[i, j, k];

# subject to a1Value{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1}:
# a1[i + padding_height_1, j + padding_width_1, k] = a1_[i, j, k];

# subject to a2Value{i in 1..totalUnitsLayer2}:
# a2[i] = a2_[i];

# subject to z2Value{i in 1..totalUnitsLayer2}:
# z2[i] = z2_[i];

# subject to a3Value{i in 1..columns_3}:
# a3[i] = a3_[i];

# subject to z3Value{i in 1..columns_3}:
# z3[i] = z3_[i];

