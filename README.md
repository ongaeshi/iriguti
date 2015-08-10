# Iriguti

Display three random page that you saved to your Pocket.

## Installation

### Install using docker

Build container.

```
$ git clone https://github.com/ongaeshi/iriguti.git
$ cd iriguti
$ docker build -t iriguti .
```

Run container. Replace the SECRET_KEY_BASE and POCKET_KEY to your pocket api.

```
$ sudo docker run --name iriguti -d -p 3000:80 -e SECRET_KEY_BASE=xxxx -e POCKET_KEY=yyyy iriguti
```

Run container using the host database in `/path/to/production.sqlite3`.

```
$ sudo docker run --name iriguti -d -p 3000:80 -e SECRET_KEY_BASE=xxxx -e POCKET_KEY=yyyy -v /path/to/production.sqlite3:/app/db/production.sqlite3 iriguti
```

