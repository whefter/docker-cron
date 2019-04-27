# docker-cron

Cron container configured using ENV variables, containing `curl` and `docker`. Meant primarily for use in `docker-compose`.

Inspired by https://github.com/MorbZ/docker-cron.


## Usage

Note that to use the `docker` command inside the container, you need to mount `docker.sock` into it.

Inside your `docker-compose.yml`:
```yaml
  cron:
    image: whefter/cron
    restart: always
    # Recommend to minimize exposure
    network_mode: none
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock"
    environment:
      - "CRON_FOO=0 3 * * * root curl https://api.your-service.org/cron.php"
      - "CRON_BACKUP=0 4 * * * root rsync -a /opt /mnt/backup/opt"
      - "CRON_DOCKER=30 4 * * * root docker exec service-container /backup.sh"
```


## License

MIT License

Copyright (c) 2019 William Hefter

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
