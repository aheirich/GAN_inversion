all:	ampl_weight_2.dat ampl_weight_3.dat

ampl_weight_2.dat:  weight_conv2.txt convert_weight_2.py
	python3 convert_weight_2.py < weight_conv2.txt > ampl_weight_2.dat

ampl_weight_3.dat:  weight_fc1.txt convert_weight_3.py
	python3 convert_weight_3.py < weight_fc1.txt > ampl_weight_3.dat

clean:
	rm -f ampl_weight_3.dat
