.PHONY: all build test tidy clean vector

GO := go

default: vector-test

build:
	$(GO) build -o mysql-tester ./src

debug:
	$(GO) build -gcflags="all=-N -l" -o mysql-tester ./src

test: build
	$(GO) test -cover ./...
	#./mysql-tester -check-error

tidy:
	$(GO) mod tidy

clean:
	$(GO) clean -i ./...
	rm -rf mysql-tester

gen_perror: generate_perror/main.go
	$(GO) build -o gen_perror ./generate_perror

run-vector-test: build
	./mysql-tester -all --check-error

update-vector-test: build
	./mysql-tester -all --check-error --record vector
