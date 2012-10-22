all:
	tsc server.ts
	tsc test/*.ts

clean:
	rm -f *.js test/*.js
