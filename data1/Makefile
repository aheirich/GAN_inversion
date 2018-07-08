OUT=ampl_input_fake1.dat ampl_input_fake2.dat ampl_input_fake3.dat ampl_input_fake4.dat ampl_input_real1.dat ampl_input_real2.dat ampl_input_real3.dat ampl_input_real4.dat

all:	$(OUT)

ampl_input_fake1.dat:	feature-label\ pair/fake1.txt convertInput.py
	python3 convertInput.py "$<" > $@

ampl_input_fake2.dat:	feature-label\ pair/fake2.txt convertInput.py
	python3 convertInput.py "$<" > $@

ampl_input_fake3.dat:	feature-label\ pair/fake3.txt convertInput.py
	python3 convertInput.py "$<" > $@

ampl_input_fake4.dat:	feature-label\ pair/fake4.txt convertInput.py
	python3 convertInput.py "$<" > $@

ampl_input_real1.dat:	feature-label\ pair/real1.txt convertInput.py
	python3 convertInput.py "$<" > $@

ampl_input_real2.dat:	feature-label\ pair/real2.txt convertInput.py
	python3 convertInput.py "$<" > $@

ampl_input_real3.dat:	feature-label\ pair/real3.txt convertInput.py
	python3 convertInput.py "$<" > $@

ampl_input_real4.dat:	feature-label\ pair/real4.txt convertInput.py
	python3 convertInput.py "$<" > $@


clean:
	rm -f $(OUT)
