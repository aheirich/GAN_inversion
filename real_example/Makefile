X=real1/X.dat real2/X.dat real3/X.dat real4/X.dat real5/X.dat
Z1=real1/Z1.dat real2/Z1.dat real3/Z1.dat real4/Z1.dat real5/Z1.dat
A1=real1/A1.dat real2/A1.dat real3/A1.dat real4/A1.dat real5/A1.dat
Z2=real1/Z2.dat real2/Z2.dat real3/Z2.dat real4/Z2.dat real5/Z2.dat
A2=real1/A2.dat real2/A2.dat real3/A2.dat real4/A2.dat real5/A2.dat
Z3=real1/Z3.dat real2/Z3.dat real3/Z3.dat real4/Z3.dat real5/Z3.dat
A3=real1/A3.dat real2/A3.dat real3/A3.dat real4/A3.dat real5/A3.dat
Z4=real1/Z4.dat real2/Z4.dat real3/Z4.dat real4/Z4.dat real5/Z4.dat

ALL=$(X) $(Z1) $(A1) $(Z2) $(A2) $(Z3) $(A3) $(Z4)

all:	$(ALL)

clean:
	rm -f $(ALL)

real1/X.dat:	real1/1.input\ of\ conv1.txt ../python/convertInputReal.py
	python3 ../python/convertInputReal.py real1/1.input\ of\ conv1.txt > $@

real2/X.dat:	real2/1.input\ of\ conv1.txt ../python/convertInputReal.py
	python3 ../python/convertInputReal.py real2/1.input\ of\ conv1.txt > $@

real3/X.dat:	real3/1.input\ of\ conv1.txt ../python/convertInputReal.py
	python3 ../python/convertInputReal.py real3/1.input\ of\ conv1.txt > $@

real4/X.dat:	real4/1.input\ of\ conv1.txt ../python/convertInputReal.py
	python3 ../python/convertInputReal.py real4/1.input\ of\ conv1.txt > $@

real5/X.dat:	real5/1.input\ of\ conv1.txt ../python/convertInputReal.py
	python3 ../python/convertInputReal.py real5/1.input\ of\ conv1.txt > $@

real1/Z1.dat:	real1/2.output\ of\ conv1.txt ../python/convert_preactivation_1.py
	python3 ../python/convert_preactivation_1.py real1/2.output\ of\ conv1.txt z1_ > $@

real2/Z1.dat:	real2/2.output\ of\ conv1.txt ../python/convert_preactivation_1.py
	python3 ../python/convert_preactivation_1.py real2/2.output\ of\ conv1.txt z1_ > $@

real3/Z1.dat:	real3/2.output\ of\ conv1.txt ../python/convert_preactivation_1.py
	python3 ../python/convert_preactivation_1.py real3/2.output\ of\ conv1.txt z1_ > $@

real4/Z1.dat:	real4/2.output\ of\ conv1.txt ../python/convert_preactivation_1.py
	python3 ../python/convert_preactivation_1.py real4/2.output\ of\ conv1.txt z1_ > $@

real5/Z1.dat:	real5/2.output\ of\ conv1.txt ../python/convert_preactivation_1.py
	python3 ../python/convert_preactivation_1.py real5/2.output\ of\ conv1.txt z1_ > $@

real1/A1.dat:	real1/3.output\ of\ conv1\ after\ activation\ ==\ input\ of\ conv2.txt ../python/convert_preactivation_1.py
	python3 ../python/convert_preactivation_1.py real1/3.output\ of\ conv1\ after\ activation\ ==\ input\ of\ conv2.txt a1_ > $@

real2/A1.dat:	real2/3.output\ of\ conv1\ after\ activation\ ==\ input\ of\ conv2.txt ../python/convert_preactivation_1.py
	python3 ../python/convert_preactivation_1.py real2/3.output\ of\ conv1\ after\ activation\ ==\ input\ of\ conv2.txt a1_ > $@

real3/A1.dat:	real3/3.output\ of\ conv1\ after\ activation\ ==\ input\ of\ conv2.txt ../python/convert_preactivation_1.py
	python3 ../python/convert_preactivation_1.py real3/3.output\ of\ conv1\ after\ activation\ ==\ input\ of\ conv2.txt a1_ > $@

real4/A1.dat:	real4/3.output\ of\ conv1\ after\ activation\ ==\ input\ of\ conv2.txt ../python/convert_preactivation_1.py
	python3 ../python/convert_preactivation_1.py real4/3.output\ of\ conv1\ after\ activation\ ==\ input\ of\ conv2.txt a1_ > $@

real5/A1.dat:	real5/3.output\ of\ conv1\ after\ activation\ ==\ input\ of\ conv2.txt ../python/convert_preactivation_1.py
	python3 ../python/convert_preactivation_1.py real5/3.output\ of\ conv1\ after\ activation\ ==\ input\ of\ conv2.txt a1_ > $@


real1/Z2.dat:	real1/4.output_of_conv2.txt ../python/convert_preactivation_2.py
	python3 ../python/convert_preactivation_2.py real1/4.output_of_conv2.txt z2_ > $@

real2/Z2.dat:	real2/4.output_of_conv2.txt ../python/convert_preactivation_2.py
	python3 ../python/convert_preactivation_2.py real2/4.output_of_conv2.txt z2_ > $@

real3/Z2.dat:	real3/4.output_of_conv2.txt ../python/convert_preactivation_2.py
	python3 ../python/convert_preactivation_2.py real3/4.output_of_conv2.txt z2_ > $@

real4/Z2.dat:	real4/4.output_of_conv2.txt ../python/convert_preactivation_2.py
	python3 ../python/convert_preactivation_2.py real4/4.output_of_conv2.txt z2_ > $@

real5/Z2.dat:	real5/4.output_of_conv2.txt ../python/convert_preactivation_2.py
	python3 ../python/convert_preactivation_2.py real5/4.output_of_conv2.txt z2_ > $@

real1/A2.dat:	real1/5.output\ of\ conv2\ after\ activation.txt ../python/convert_preactivation_2.py
	python3 ../python/convert_preactivation_2.py real1/5.output\ of\ conv2\ after\ activation.txt a2_ > $@

real2/A2.dat:	real2/5.output\ of\ conv2\ after\ activation.txt ../python/convert_preactivation_2.py
	python3 ../python/convert_preactivation_2.py real2/5.output\ of\ conv2\ after\ activation.txt a2_ > $@

real3/A2.dat:	real3/5.output\ of\ conv2\ after\ activation.txt ../python/convert_preactivation_2.py
	python3 ../python/convert_preactivation_2.py real3/5.output\ of\ conv2\ after\ activation.txt a2_ > $@

real4/A2.dat:	real4/5.output\ of\ conv2\ after\ activation.txt ../python/convert_preactivation_2.py
	python3 ../python/convert_preactivation_2.py real4/5.output\ of\ conv2\ after\ activation.txt a2_ > $@

real5/A2.dat:	real5/5.output\ of\ conv2\ after\ activation.txt ../python/convert_preactivation_2.py
	python3 ../python/convert_preactivation_2.py real5/5.output\ of\ conv2\ after\ activation.txt a2_ > $@


real1/Z3.dat:	real1/7.output\ of\ fc1.txt ../python/convert_preactivation_3.py
	python3 ../python/convert_preactivation_3.py real1/7.output\ of\ fc1.txt z3_ > $@

real2/Z3.dat:	real2/7.output\ of\ fc1.txt ../python/convert_preactivation_3.py
	python3 ../python/convert_preactivation_3.py real2/7.output\ of\ fc1.txt z3_ > $@

real3/Z3.dat:	real3/7.output\ of\ fc1.txt ../python/convert_preactivation_3.py
	python3 ../python/convert_preactivation_3.py real3/7.output\ of\ fc1.txt z3_ > $@

real4/Z3.dat:	real4/7.output\ of\ fc1.txt ../python/convert_preactivation_3.py
	python3 ../python/convert_preactivation_3.py real4/7.output\ of\ fc1.txt z3_ > $@

real5/Z3.dat:	real5/7.output\ of\ fc1.txt ../python/convert_preactivation_3.py
	python3 ../python/convert_preactivation_3.py real5/7.output\ of\ fc1.txt z3_ > $@

real1/A3.dat:	real1/8.output\ of\ fc1\ after\ activation.txt ../python/convert_preactivation_3.py
	python3 ../python/convert_preactivation_3.py real1/8.output\ of\ fc1\ after\ activation.txt a3_ > $@

real2/A3.dat:	real2/8.output\ of\ fc1\ after\ activation.txt ../python/convert_preactivation_3.py
	python3 ../python/convert_preactivation_3.py real2/8.output\ of\ fc1\ after\ activation.txt a3_ > $@

real3/A3.dat:	real3/8.output\ of\ fc1\ after\ activation.txt ../python/convert_preactivation_3.py
	python3 ../python/convert_preactivation_3.py real3/8.output\ of\ fc1\ after\ activation.txt a3_ > $@

real4/A3.dat:	real4/8.output\ of\ fc1\ after\ activation.txt ../python/convert_preactivation_3.py
	python3 ../python/convert_preactivation_3.py real4/8.output\ of\ fc1\ after\ activation.txt a3_ > $@

real5/A3.dat:	real5/8.output\ of\ fc1\ after\ activation.txt ../python/convert_preactivation_3.py
	python3 ../python/convert_preactivation_3.py real5/8.output\ of\ fc1\ after\ activation.txt a3_ > $@

real1/Z4.dat:	real1/9.output\ of\ fc2\ ==\ final\ single\ output.txt ../python/convert_preactivation_4.py
	python3 ../python/convert_preactivation_4.py real1/9.output\ of\ fc2\ ==\ final\ single\ output.txt  > $@

real2/Z4.dat:	real2/9.output\ of\ fc2\ ==\ final\ single\ output.txt ../python/convert_preactivation_4.py
	python3 ../python/convert_preactivation_4.py real2/9.output\ of\ fc2\ ==\ final\ single\ output.txt  > $@

real3/Z4.dat:	real3/9.output\ of\ fc2\ ==\ final\ single\ output.txt ../python/convert_preactivation_4.py
	python3 ../python/convert_preactivation_4.py real3/9.output\ of\ fc2\ ==\ final\ single\ output.txt  > $@

real4/Z4.dat:	real4/9.output\ of\ fc2\ ==\ final\ single\ output.txt ../python/convert_preactivation_4.py
	python3 ../python/convert_preactivation_4.py real4/9.output\ of\ fc2\ ==\ final\ single\ output.txt  > $@

real5/Z4.dat:	real5/9.output\ of\ fc2\ ==\ final\ single\ output.txt ../python/convert_preactivation_4.py
	python3 ../python/convert_preactivation_4.py real5/9.output\ of\ fc2\ ==\ final\ single\ output.txt  > $@

