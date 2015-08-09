# Iriguti

Display three random page that you saved to your Pocket.

## Installation

### Install using docker container
Replace the SECRET_KEY_BASE and POCKET_KEY to your pocket api.

```
$ git clone https://github.com/ongaeshi/iriguti.git
$ cd iriguti
$ docker build -t iriguti .
$ docker run --name iriguti -p 3000:3000 -e RAILS_ENV=production -e SECRET_KEY_BASE=xxxxx -e POCKET_KEY=yyyyy iriguti
```

