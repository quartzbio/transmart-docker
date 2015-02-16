
NAME=transmart
TAG=transmart_sample_data:v1


build: 
	docker build -t $(NAME) .

run-inside: build
	docker run -ti -p 8080:8080  $(NAME) bash

run: build
	docker run --rm --name  transmart -p 8080:8080 -p 8983:8983 -p 5432:5432 $(NAME) 

test: build
	-docker stop -t 0 transmart_test
	-docker rm transmart_test
	docker run -d --name transmart_test  -p 8080:8080 $(NAME)
	@echo =============== TESTING transmart [wait] =========================
	sleep 1
	@echo 'testing front page:'
	@NB=$$(wget https://localhost:4443/ 2>&1 | grep -c 'translational medicine data mart'); \
		if [ "$$NB" -ge 0 ]; then echo OK; else echo FAILED; fi; 
	-docker stop -t 0 transmart_test
