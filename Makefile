all: 
	ghc src/main.hs -o octopus

clean: 
	rm src/*.hi src/*.o
