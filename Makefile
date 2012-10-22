all:
	tsc server.ts
	tsc test/*.ts

clean:
	rm *.js
	rm */*.js
	git checkout jsonrpc.js
