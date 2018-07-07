
# need to pad the input images and the first intermediate layer
# TODO provide input_constraint as a .dat file with padding
# TODO what is the value of the leakiness parameter from the model?

# input layer 0 is two 100x100 input arrays (10,000 each)
# first input array should be constrained to known values
# second input array is what we want the network to supply

param rows_0 := 100;
param columns_0 := 100;
param depth_0 := 2;

param padding_height_0 := 4;
param padding_width_0 := 2;

# inputs
var x{i in 1..rows_0, j in 1..columns_0, k in 1..depth_0};
subject to rangemaxx{i in 1..rows_0, j in 1..columns_0, k in 1..depth_0}:
x[i, j, k] <= 100;
subject to rangeminx{i in 1..rows_0, j in 1..columns_0, k in 1..depth_0}:
x[i, j, k] >= -100;

param input_constraint{i in 1..rows_0, j in 1..columns_0};

subject to constrainedInput{i in 1..rows_0, j in 1..columns_0}:
x[i, j, 1] = input_constraint[i, j];

# layer 1 is 50x50x16 convolutional layer
# each convolution filter is 3x8x2
# there are 16 filters

# layer-1
param rows_1 := 50;
param columns_1 := 50;
param depth_1 := 16;

param filter_height_1 := 8;
param filter_width_1 := 3;
param filter_depth_1 := 2;

param padding_height_1 := 4;
param padding_width_1 := 2;

param bias_1{i in 1..depth_1};

# activations
var a1{i in 1..rows_1 + filter_height_1, j in 1..columns_1 + filter_width_1, k in 1..depth_1};



# preactivations
var z1{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1};

# range constraints
subject to rangemax1{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1}:
z1[i, j, k] <= 100;
subject to rangemin1{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1}:
z1[i, j, k] >= -100;

param weight_1{i in 1..filter_height_1, j in 1..filter_width_1, k in 1..filter_depth_1, l in 1..depth_1};

subject to preactivation1{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1}:
z1[i, j, k] = bias_1[k]

# TODO can this be written like weight_1[i%8,j%3,k%2]

+ weight_1[1, 1, 1, k] * x[i + padding_height_0, j + padding_width_0, 1] # assume padding_height_1 padding in y
+ weight_1[1, 1, 2, k] * x[i + padding_height_0, j + padding_width_0, 2] # assume padding_width_1 padding in x
+ weight_1[1, 2, 1, k] * x[i + padding_height_0, j + padding_width_0 + 1, 1]
+ weight_1[1, 2, 2, k] * x[i + padding_height_0, j + padding_width_0 + 1, 2]
+ weight_1[1, 3, 1, k] * x[i + padding_height_0, j + padding_width_0 + 2, 1]
+ weight_1[1, 3, 2, k] * x[i + padding_height_0, j + padding_width_0 + 2, 2]

+ weight_1[2, 1, 1, k] * x[i + padding_height_0 + 1, j + padding_width_0, 1]
+ weight_1[2, 1, 2, k] * x[i + padding_height_0 + 1, j + padding_width_0, 2]
+ weight_1[2, 2, 1, k] * x[i + padding_height_0 + 1, j + padding_width_0 + 1, 1]
+ weight_1[2, 2, 2, k] * x[i + padding_height_0 + 1, j + padding_width_0 + 1, 2]
+ weight_1[2, 3, 1, k] * x[i + padding_height_0 + 1, j + padding_width_0 + 2, 1]
+ weight_1[2, 3, 2, k] * x[i + padding_height_0 + 1, j + padding_width_0 + 2, 2]

+ weight_1[3, 1, 1, k] * x[i + padding_height_0 + 2, j + padding_width_0, 1]
+ weight_1[3, 1, 2, k] * x[i + padding_height_0 + 2, j + padding_width_0, 2]
+ weight_1[3, 2, 1, k] * x[i + padding_height_0 + 2, j + padding_width_0 + 1, 1]
+ weight_1[3, 2, 2, k] * x[i + padding_height_0 + 2, j + padding_width_0 + 1, 2]
+ weight_1[3, 3, 1, k] * x[i + padding_height_0 + 2, j + padding_width_0 + 2, 1]
+ weight_1[3, 3, 2, k] * x[i + padding_height_0 + 2, j + padding_width_0 + 2, 2]

+ weight_1[4, 1, 1, k] * x[i + padding_height_0 + 3, j + padding_width_0, 1]
+ weight_1[4, 1, 2, k] * x[i + padding_height_0 + 3, j + padding_width_0, 2]
+ weight_1[4, 2, 1, k] * x[i + padding_height_0 + 3, j + padding_width_0 + 1, 1]
+ weight_1[4, 2, 2, k] * x[i + padding_height_0 + 3, j + padding_width_0 + 1, 2]
+ weight_1[4, 3, 1, k] * x[i + padding_height_0 + 3, j + padding_width_0 + 2, 1]
+ weight_1[4, 3, 2, k] * x[i + padding_height_0 + 3, j + padding_width_0 + 2, 2]

+ weight_1[5, 1, 1, k] * x[i + padding_height_0 + 4, j + padding_width_0, 1]
+ weight_1[5, 1, 2, k] * x[i + padding_height_0 + 4, j + padding_width_0, 2]
+ weight_1[5, 2, 1, k] * x[i + padding_height_0 + 4, j + padding_width_0 + 1, 1]
+ weight_1[5, 2, 2, k] * x[i + padding_height_0 + 4, j + padding_width_0 + 1, 2]
+ weight_1[5, 3, 1, k] * x[i + padding_height_0 + 4, j + padding_width_0 + 2, 1]
+ weight_1[5, 3, 2, k] * x[i + padding_height_0 + 4, j + padding_width_0 + 2, 2]

+ weight_1[6, 1, 1, k] * x[i + padding_height_0 + 5, j + padding_width_0, 1]
+ weight_1[6, 1, 2, k] * x[i + padding_height_0 + 5, j + padding_width_0, 2]
+ weight_1[6, 2, 1, k] * x[i + padding_height_0 + 5, j + padding_width_0 + 1, 1]
+ weight_1[6, 2, 2, k] * x[i + padding_height_0 + 5, j + padding_width_0 + 1, 2]
+ weight_1[6, 3, 1, k] * x[i + padding_height_0 + 5, j + padding_width_0 + 2, 1]
+ weight_1[6, 3, 2, k] * x[i + padding_height_0 + 5, j + padding_width_0 + 2, 2]

+ weight_1[7, 1, 1, k] * x[i + padding_height_0 + 6, j + padding_width_0, 1]
+ weight_1[7, 1, 2, k] * x[i + padding_height_0 + 6, j + padding_width_0, 2]
+ weight_1[7, 2, 1, k] * x[i + padding_height_0 + 6, j + padding_width_0 + 1, 1]
+ weight_1[7, 2, 2, k] * x[i + padding_height_0 + 6, j + padding_width_0 + 1, 2]
+ weight_1[7, 3, 1, k] * x[i + padding_height_0 + 6, j + padding_width_0 + 2, 1]
+ weight_1[7, 3, 2, k] * x[i + padding_height_0 + 6, j + padding_width_0 + 2, 2]

+ weight_1[8, 1, 1, k] * x[i + padding_height_0 + 7, j + padding_width_0, 1]
+ weight_1[8, 1, 2, k] * x[i + padding_height_0 + 7, j + padding_width_0, 2]
+ weight_1[8, 2, 1, k] * x[i + padding_height_0 + 7, j + padding_width_0 + 1, 1]
+ weight_1[8, 2, 2, k] * x[i + padding_height_0 + 7, j + padding_width_0 + 1, 2]
+ weight_1[8, 3, 1, k] * x[i + padding_height_0 + 7, j + padding_width_0 + 2, 1]
+ weight_1[8, 3, 2, k] * x[i + padding_height_0 + 7, j + padding_width_0 + 2, 2]

;


# leaky Relu leakiness parameter
param leakiness := 0.1;

# compute activations with padding
subject to activation1{i in 1..rows_1, j in 1..columns_1, k in 1..depth_1}:
a1[i, j, k] = z1[i, j, k] * tanh(100.0 * z1[i, j, k]) + (1 - tanh(100.0 * z1[i, j, k])) * leakiness * z1[i, j, k];

# zero padding for a1
subject to zeropad1_1{i in 1..padding_height_0, j in 1..columns_1, k in 1..depth_1}:
a1[i, j, k] = 0;
subject to zeropad1_2{i in 1..padding_height_0, j in 1..columns_1, k in 1..depth_1}:
a1[i + padding_height_0 + rows_1, j, k] = 0;
subject to zeropad1_3{i in 1..rows_1, j in 1..padding_width_0, k in 1..depth_1}:
a1[i, j, k] = 0;
subject to zeropad1_4{i in 1..rows_1, j in 1..padding_width_0, k in 1..depth_1}:
a1[i, j + padding_width_0 + columns_1, k] = 0;




# layer 2 is 25x25x32 convolutional layer
# each convolution filter is 8x3x2
# there are 32 filters

# layer-2
param rows_2 := 25;
param columns_2 := 25;
param depth_2 := 32;

param filter_height_2 := 3;
param filter_width_2 := 8;
param filter_depth_2 := 16;

param bias_2{i in 1..depth_2};

# activations
var a2{i in 1..rows_2, j in 1..columns_2, k in 1..depth_2};

# preactivations
var z2{i in 1..rows_2, j in 1..columns_2, k in 1..depth_2};

# range constraints
subject to rangemax2{i in 1..rows_2, j in 1..columns_2, k in 1..depth_2}:
z1[i, j, k] <= 100;
subject to rangemin2{i in 1..rows_2, j in 1..columns_2, k in 1..depth_2}:
z1[i, j, k] >= -100;

param weight_2{i in 1..filter_height_2, j in 1..filter_width_2, k in 1..filter_depth_2, l in 1..depth_2};

subject to preactivation2{i in 1..rows_2, j in 1..columns_2, k in 1..depth_2}:
z1[i, j, k] = bias_2[k]

+ weight_2[1, 1, 1, k] * a1[i + padding_height_1, j + padding_width_1, 1]
+ weight_2[1, 1, 2, k] * a1[i + padding_height_1, j + padding_width_1, 2]
+ weight_2[1, 2, 1, k] * a1[i + padding_height_1, j + padding_width_1 + 1, 1]
+ weight_2[1, 2, 2, k] * a1[i + padding_height_1, j + padding_width_1 + 1, 2]
+ weight_2[1, 3, 1, k] * a1[i + padding_height_1, j + padding_width_1 + 2, 1]
+ weight_2[1, 3, 2, k] * a1[i + padding_height_1, j + padding_width_1 + 2, 2]
+ weight_2[1, 4, 1, k] * a1[i + padding_height_1, j + padding_width_1 + 3, 1]
+ weight_2[1, 4, 2, k] * a1[i + padding_height_1, j + padding_width_1 + 3, 2]
+ weight_2[1, 5, 1, k] * a1[i + padding_height_1, j + padding_width_1 + 4, 1]
+ weight_2[1, 5, 2, k] * a1[i + padding_height_1, j + padding_width_1 + 4, 2]
+ weight_2[1, 6, 1, k] * a1[i + padding_height_1, j + padding_width_1 + 5, 1]
+ weight_2[1, 6, 2, k] * a1[i + padding_height_1, j + padding_width_1 + 5, 2]
+ weight_2[1, 7, 1, k] * a1[i + padding_height_1, j + padding_width_1 + 6, 1]
+ weight_2[1, 7, 2, k] * a1[i + padding_height_1, j + padding_width_1 + 6, 2]
+ weight_2[1, 8, 1, k] * a1[i + padding_height_1, j + padding_width_1 + 7, 1]
+ weight_2[1, 8, 2, k] * a1[i + padding_height_1, j + padding_width_1 + 7, 2]

+ weight_2[2, 1, 1, k] * a1[i + padding_height_1 + 1, j + padding_width_1, 1]
+ weight_2[2, 1, 2, k] * a1[i + padding_height_1 + 1, j + padding_width_1, 2]
+ weight_2[2, 2, 1, k] * a1[i + padding_height_1 + 1, j + padding_width_1 + 1, 1]
+ weight_2[2, 2, 2, k] * a1[i + padding_height_1 + 1, j + padding_width_1 + 1, 2]
+ weight_2[2, 3, 1, k] * a1[i + padding_height_1 + 1, j + padding_width_1 + 2, 1]
+ weight_2[2, 3, 2, k] * a1[i + padding_height_1 + 1, j + padding_width_1 + 2, 2]
+ weight_2[2, 4, 1, k] * a1[i + padding_height_1 + 1, j + padding_width_1 + 3, 1]
+ weight_2[2, 4, 2, k] * a1[i + padding_height_1 + 1, j + padding_width_1 + 3, 2]
+ weight_2[2, 5, 1, k] * a1[i + padding_height_1 + 1, j + padding_width_1 + 4, 1]
+ weight_2[2, 5, 2, k] * a1[i + padding_height_1 + 1, j + padding_width_1 + 4, 2]
+ weight_2[2, 6, 1, k] * a1[i + padding_height_1 + 1, j + padding_width_1 + 5, 1]
+ weight_2[2, 6, 2, k] * a1[i + padding_height_1 + 1, j + padding_width_1 + 5, 2]
+ weight_2[2, 7, 1, k] * a1[i + padding_height_1 + 1, j + padding_width_1 + 6, 1]
+ weight_2[2, 7, 2, k] * a1[i + padding_height_1 + 1, j + padding_width_1 + 6, 2]
+ weight_2[2, 8, 1, k] * a1[i + padding_height_1 + 1, j + padding_width_1 + 7, 1]
+ weight_2[2, 8, 2, k] * a1[i + padding_height_1 + 1, j + padding_width_1 + 7, 2]

+ weight_2[3, 1, 1, k] * a1[i + padding_height_1 + 2, j + padding_width_1, 1]
+ weight_2[3, 1, 2, k] * a1[i + padding_height_1 + 2, j + padding_width_1, 2]
+ weight_2[3, 2, 1, k] * a1[i + padding_height_1 + 2, j + padding_width_1 + 1, 1]
+ weight_2[3, 2, 2, k] * a1[i + padding_height_1 + 2, j + padding_width_1 + 1, 2]
+ weight_2[3, 3, 1, k] * a1[i + padding_height_1 + 2, j + padding_width_1 + 2, 1]
+ weight_2[3, 3, 2, k] * a1[i + padding_height_1 + 2, j + padding_width_1 + 2, 2]
+ weight_2[3, 4, 1, k] * a1[i + padding_height_1 + 2, j + padding_width_1 + 3, 1]
+ weight_2[3, 4, 2, k] * a1[i + padding_height_1 + 2, j + padding_width_1 + 3, 2]
+ weight_2[3, 5, 1, k] * a1[i + padding_height_1 + 2, j + padding_width_1 + 4, 1]
+ weight_2[3, 5, 2, k] * a1[i + padding_height_1 + 2, j + padding_width_1 + 4, 2]
+ weight_2[3, 6, 1, k] * a1[i + padding_height_1 + 2, j + padding_width_1 + 5, 1]
+ weight_2[3, 6, 2, k] * a1[i + padding_height_1 + 2, j + padding_width_1 + 5, 2]
+ weight_2[3, 7, 1, k] * a1[i + padding_height_1 + 2, j + padding_width_1 + 6, 1]
+ weight_2[3, 7, 2, k] * a1[i + padding_height_1 + 2, j + padding_width_1 + 6, 2]
+ weight_2[3, 8, 1, k] * a1[i + padding_height_1 + 2, j + padding_width_1 + 7, 1]
+ weight_2[3, 8, 2, k] * a1[i + padding_height_1 + 2, j + padding_width_1 + 7, 2]
;


# compute activations with leaky Relu
subject to activation2{i in 1..rows_2, j in 1..columns_2, k in 1..depth_2}:
a2[i, j, k] = z2[i, j, k] * tanh(100.0 * z2[i, j, k]) + (1 - tanh(100.0 * z2[i, j, k])) * leakiness * z2[i, j, k];



# layer 3 is a layer of 16 leaky Relus, it is preceded by a flattened version of layer 2
param columns_3 := 16;

param bias_3{i in 1..columns_3};

# activations
var a3{i in 1..columns_3};

# preactivations
var z3{i in 1..columns_3};

# range constraints
subject to rangemax3{i in 1..columns_3}:
z3[i] <= 100;
subject to rangemin3{i in 1..columns_3}:
z3[i] >= -100;


param totalUnitsLayer2 := rows_2 * columns_2 * depth_2;
param weight_3{i in 1..totalUnitsLayer2, j in 1..columns_3};


subject to preactivation3{l in 1..columns_3, i in 1..rows_2, j in 1..columns_2, k in 1..depth_2}:
z3[l] = bias_3[l] + a2[i, j, k] * weight_3[i * j * k, l];

# compute activations with leaky Relu
subject to activation3{i in 1..columns_3}:
a3[i] = z3[i] * tanh(100.0 * z3[i]) + (1 - tanh(100.0 * z3[i])) * leakiness * z3[i];


# layer 4 is a single output neuron
param columns_4 := 1;

param bias_4{i in 1..columns_4};

# activation
var a4{i in 1..columns_4};

# preactivation
var z4{i in 1..columns_4};

# range constraints
subject to rangemax4{i in 1..columns_4}:
z4[i] <= 100;
subject to rangemin4{i in 1..columns_4}:
z4[i] >= -100;

param weight_4{i in 1..columns_3, j in 1..columns_4};

subject to preactivation4{i in 1..columns_3, j in 1..columns_4}:
z4[j] = bias_4[j] + z3[i] * weight_4[i, j];

subject to activation4{i in 1..columns_4}:
a4[i] = 1.0 / (1.0 + exp(-z4[i]));

