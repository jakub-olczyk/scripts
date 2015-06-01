template
========
Prosty skrypt w bashu, który kopiuje i nadaje nową nazwę szablonowi z katalogu domowego użytkownika.
Wraz z auto uzupełnianiem opcji w bashu.

Zasada działania jest prosta dla każdego pliku w katalogu Szablony tworzymy simlinki o nazwie opcji, z której ma korzystać skrypt.

Przykładowo:

    $ls ~/Szablony/
    cpp -> Source_cpp.cpp
    perl -> Source_perl.pl
    sh -> Source_bash.sh
    Source_bash.sh
    Source_cpp.cpp
    Source_perl.pl

więc opcje, z których może skorzystać template to:
cpp perl sh

konfiguracja
------------
Polecam utworzenie pliku .bash_completion w katalogu domowym oraz dodanie do .bashrc następującego kodu :

    if [ -f ~/.bash_completion ]; then
        . ~/.bash_completion
    fi

do pliku .bash_completion należy dodać zawartość analogicznego pliku znajdującego się w repozytorium.

Dodatkowo sam skrypt można dodać do katalogu, w którym trzymamy skrypty. Np. ~/.scripts
Następnie należy dodać w /usr/bin/ symlinka do naszego skryptu o nazwie template :

    #ln -s ~/.scripts/template.sh /usr/local/bin/template

co pozwoli na korzystanie ze skryptu w wygodny sposób.
