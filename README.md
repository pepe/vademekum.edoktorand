# Vademekum

Modul Vademekum pro systém eDoktorand provozovaný na České zemědělské
univerzitě v Praze.

Obsahuje pouze jednoduché modely pro dokument a uživatelský účet,
víceméně pro testovací a analytické potřeby.

## Vývoj

### Závislosti

Repozitář se nachází na [https://github.com/pepe/vademekum.edoktorand](https://github.com/pepe/vademekum.edoktorand).

Po naklonování:

    > git clone git://github.com/pepe/vademekum.edoktorand.git

#### Ne Ruby

[MongoDB](http://www.mongodb.org/)

Na MacOS X nejlépe přes [Homebrew](https://github.com/mxcl/homebrew):

    > brew install mongodb

#### Ruby

spustit vytvoření bundle:

    > bundle install

Dále je možné prověřit funkčnost spuštěním testů:

    > rspec spec

Pro spuštění ve vývojářském módu je potřeba v konzoli spustit skript pro
nahrání příkladových dat. **Pozor smaže celou databázi a nahradí novými
daty!**:

    > bundle console
    bc > load "db/seed.rb"

Poté je možno spustit server

    > bundle exec padrino start

a stránka je viditelná na adrese [http://localhost:3000](http://localhost:3000).
