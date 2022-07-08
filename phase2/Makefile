install:
	bison -d code_bison.y -o app.cpp
	flex -o app_lex.cpp project.lex
	g++ app.cpp app_lex.cpp

clean:
	rm -rf a.out app.cpp app_lex.cpp app.hpp output.txt
