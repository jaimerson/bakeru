# Bakeru [![Build Status](https://travis-ci.org/jaimerson/bakeru.svg?branch=master)](https://travis-ci.org/jaimerson/bakeru)

ばける (ichidan conjugation, romaji bakeru)

  化ける: to appear in disguise, take the form of, change for the worse, corrupt

## Installing
- Make sure you have ruby 2.3.1 installed (get from rvm.io)
- Install bundler if you don't already have it `gem install bundler`
- `bundle install`
- Modify `config/database.yml` with your database config or create an user `bakeru` with password `bakeru` in your postgres.
- Create database with `bundle exec rake db:create`
- Migrate database with `bundle exec rake db:migrate`

## Tests

### Setup
- Create database with `GOSU_ENV=test bundle exec rake db:create`
- Migrate database with `GOSU_ENV=test bundle exec rake db:migrate`

### Running
```
bundle exec rspec
```


## Running
```
ruby main.rb
```

## Acknowledgments
 Sprites from Open Game Art:
 - http://opengameart.org/content/lpc-imp-2
 - http://opengameart.org/content/lpc-goblin
 - Redshrike - graphic artist & William.Thompsonj as contributor
 - Animation class totally ripped of https://github.com/pogist/gosu-spritesheet-example
 - Sword sound from https://www.freesound.org/people/Cribbler/sounds/381864/
 - Background tiles from http://opengameart.org/content/dungeon-tile-set
 - Background sound from https://www.freesound.org/people/IanStarGem/sounds/269591/
 - Sword sprite from https://opengameart.org/content/short-sword-64x64
