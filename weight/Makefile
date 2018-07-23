all:	ampl_weight_1.dat ampl_weight_2.dat ampl_weight_3.dat ampl_weight_4.dat

ampl_weight_1.dat: weight_conv1.txt ../python/convert_weight_1.py
	python3 ../python/convert_weight_1.py < weight_conv1.txt > ampl_weight_1.dat

ampl_weight_2.dat:  weight_conv2.txt ../python/convert_weight_2.py
	python3 ../python/convert_weight_2.py < weight_conv2.txt > ampl_weight_2.dat

ampl_weight_3.dat:  weight_fc1.txt ../python/convert_weight_3.py
	python3 ../python/convert_weight_3.py < weight_fc1.txt > ampl_weight_3.dat

ampl_weight_4.dat: weight_fc2.txt ../python/convert_weight_4.py
	python3 ../python/convert_weight_4.py < weight_fc2.txt > ampl_weight_4.dat


clean:
	rm -f ampl_weight_?.dat
