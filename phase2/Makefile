instal:
	bison -d code_bison.y -o app.cpp
	flex -o app_lex.cpp lex_code.l
	g++ app.cpp app_lex.cpp

clean:
	rm -rf a.out app.cpp app_lex.cpp