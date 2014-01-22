all: octocopy
	ghc src/main.hs -o octopus

clean: octoclean
	rm src/*.hi src/*.o

octocopy:
	cp src/.octopus .octopus

octoclean:
	rm octopus .octopus
