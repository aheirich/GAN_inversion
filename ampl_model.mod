
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

### output variable

# layer 4 is a single output neuron
param columns_4 := 1;
# activation
var a4{i in 1..columns_4};
param  a4_{i in 1..columns_4};
subject to outputConstraint{i in 1..columns_4}:
a4[i] = a4_[i];

### input variable, clamp x[.,.,1], leave x[.,.,2] free this is the answer we seek

param x_{i in 1..rows_0 + 2 * padding_height_0, j in 1..columns_0 + 2 * padding_width_0, k in 1..depth_0};
subject to xValue{i in 1..rows_0 + 2 * padding_height_0, j in 1..columns_0 + 2 * padding_width_0}:
x[i, j, 1] = x_[i, j, 1];

# objective makes x[,,1] match expected input, x[,,2] match itself, and a4 match expected output value
minimize discrepency: 
sum{i in 2..rows_0, j in 1..columns_0} (x[i + padding_height_0, j + padding_width_0, 2] - x[1 + padding_height_0, j + padding_width_0, 2])^2
+
sum{i in 1..rows_0, j in 1..columns_0} (x[i + padding_height_0, j + padding_width_0, 1] - x_[i + padding_height_0, j + padding_width_0, 1])^2
+
sum{i in 1..columns_4} (a4[i] - a4_[i])^2
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
 z1[i, j, k] = bias_1[k] * sum{l in 1..filter_height_1, m in 1..filter_width_1, n in 1..filter_depth_1}
 weight_1[l, m, n, k] *
 x[row_1_base + ((i - 1) * 2) + 1 + l, column_1_base + ((j - 1) * 2) + 1 + m,
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

param bias_2{i in 1..depth_2};
param totalUnitsLayer2 := rows_2 * columns_2 * depth_2;

# activations
var a2{i in 1..totalUnitsLayer2};

# preactivations
var z2{i in 1..totalUnitsLayer2};


param weight_2{i in 1..filter_height_2, j in 1..filter_width_2, k in 1..filter_depth_2, l in 1..depth_2};



subject to preactivation2{i in 1..rows_2, j in 1..columns_2, k in 1..depth_2}:
z2[(i - 1) * columns_2 * depth_2 + (j - 1) * depth_2 + k] = bias_2[k] *
sum{l in 1..filter_height_2, m in 1..filter_width_2, n in 1..filter_depth_2, o in 1..depth_1}
weight_2[l, m, n, k] *
a1[padding_height_1 + ((i - 1) * 2) + 1 + l - filter_height_2_half,
padding_width_1 + ((j - 1) * 2) + 1 + m - filter_width_2_half,
o];



# compute activations with leaky Relu
subject to activation2{i in 1..totalUnitsLayer2}:
a2[i] = z2[i] * (1 / (1 + exp(-10000.0 * z2[i])))
+ (1 - (1 / (1 + exp(-10000.0 * z2[i])))) * leakiness * z2[i];





# layer 3 is a layer of 16 leaky Relus, it is preceded by a flattened version of layer 2
param columns_3 := 16;

param bias_3{i in 1..columns_3};

# activations
var a3{i in 1..columns_3};

# preactivations
var z3{i in 1..columns_3};


param weight_3{i in 1..totalUnitsLayer2, j in 1..columns_3};


subject to preactivation3{l in 1..columns_3}:
z3[l] = bias_3[l] + sum{i in 1..totalUnitsLayer2} a2[i] * weight_3[i, l];


# compute activations with leaky Relu
subject to activation3{i in 1..columns_3}:
a3[i] = z3[i] * (1 / (1 + exp(-10000.0 * z3[i])))
+ (1 - (1 / (1 + exp(-10000.0 * z3[i])))) * leakiness * z3[i];



param bias_4{i in 1..columns_4};


# preactivation
var z4{i in 1..columns_4};

param weight_4{i in 1..columns_3};

subject to preactivation4{i in 1..columns_4}:
z4[i] = bias_4[i] + sum{j in 1..columns_3} z3[j] * weight_4[j];

subject to activation4{i in 1..columns_4}:
a4[i] = 1.0 / (1.0 + exp(-z4[i]));


### activation targets, use this to verify the model with a known fixed point (Remove after verification)

param z1_{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1};
param a1_{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1};
param a2_{i in 1..totalUnitsLayer2};
param z2_{i in 1..totalUnitsLayer2};
param a3_{i in 1..columns_3};
param z3_{i in 1..columns_3};


subject to z1Value{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1}:
z1[i, j, k] = z1_[i, j, k];

subject to a1Value{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1}:
a1[i + padding_height_1, j + padding_width_1, k] = a1_[i, j, k];

subject to a2Value{i in 1..totalUnitsLayer2}:
a2[i] = a2_[i];

subject to z2Value{i in 1..totalUnitsLayer2}:
z2[i] = z2_[i];

subject to a3Value{i in 1..columns_3}:
a3[i] = a3_[i];

subject to z3Value{i in 1..columns_3}:
z3[i] = z3_[i];

