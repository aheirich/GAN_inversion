
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










# leaky Relu leakiness parameter
param leakiness := 0.2;

var c1{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1} binary;

param Upper := 100.0;
param Lower := -100.0;

subject to c1_a{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1}:
z1[i, j, k] <= Upper * c1[i, j, k];
subject to c1_b{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1}:
z1[i, j, k] >= Lower * (1.0 - c1[i, j, k]);

# subject to c1_{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1}: c1[i, j, k] = (z1[i, j, k] < 0);

# compute activations with padding
subject to activation1{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1}:
a1[i + padding_height_1, j + padding_width_1, k] = (1.0 - c1[i, j, k]) * leakiness * z1[i, j, k] + c1[i, j, k] * z1[i, j, k];


# zero padding for a1
subject to zeropad1_1{i in 1..padding_height_1, j in 1..columns_1, k in 1..depth_1}:
a1[i, j, k] = 0;
subject to zeropad1_2{i in 1..padding_height_1, j in 1..columns_1, k in 1..depth_1}:
a1[i + padding_height_1 + rows_1, j, k] = 0;
subject to zeropad1_3{i in 1..rows_1, j in 1..padding_width_1, k in 1..depth_1}:
a1[i + padding_height_1, j, k] = 0;
subject to zeropad1_4{i in 1..rows_1, j in 1..padding_width_1, k in 1..depth_1}:
a1[i + padding_height_1, j + padding_width_1 + columns_1, k] = 0;




# layer 2 is 25x25x32 convolutional layer
# each convolution filter is 8x3x2
# there are 32 filters

# layer-2
param rows_2 := 25;
param columns_2 := 25;
param depth_2 := 32;

param filter_height_2 := 8;
param filter_width_2 := 3;
param filter_depth_2 := 16;

param filter_height_2_half := 4;
param filter_width_2_half := 1;

param row_2_base := 2;
param column_2_base := 5;

param bias_2{i in 1..depth_2};
param totalUnitsLayer2 := rows_2 * columns_2 * depth_2;

# activations
var a2{i in 1..totalUnitsLayer2};

# preactivations
var z2{i in 1..totalUnitsLayer2};


param weight_2{i in 1..filter_height_2, j in 1..filter_width_2, k in 1..filter_depth_2, l in 1..depth_2};



subject to preactivation2{i in 1..rows_2, j in 1..columns_2, k in 1..depth_2}:
z2[(i - 1) * columns_2 * depth_2 + (j - 1) * depth_2 + k] = bias_2[k] +
sum{l in 1..filter_height_2, m in 1..filter_width_2, n in 1..filter_depth_2, o in 1..depth_1}
weight_2[l, m, n, k] *
a1[row_2_base + ((i - 1) * 2) + l, column_2_base + ((j - 1) * 2) + m,
o];










### activation targets, use this to verify the model with a known fixed point (Remove after verification)

param z1_{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1};
param a1_{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1};
param a2_{i in 1..totalUnitsLayer2};
param z2_{i in 1..totalUnitsLayer2};


subject to z1Value{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1}:
z1[i, j, k] = z1_[i, j, k];

#subject to a1Value{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1}:
#a1[i + padding_height_1, j + padding_width_1, k] = a1_[i, j, k];

# subject to z2Value{i in 1..totalUnitsLayer2}:
# z2[i] = z2_[i];
