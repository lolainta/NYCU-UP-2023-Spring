# HW1 Demo

## Setup

1. Download testcase file from the [LINK](https://up23.zoolab.org/up23/hw1/hw1testcase.zip).
2. `unzip hw1testcase.zip`
3. run `setup.sh` in `testcase` folder.
4. compile your program and move it into the `testcase` folder.

## Example Case

```
BEGIN open-blacklist
/etc/passwd
/etc/shadow
END open-blacklist

BEGIN read-blacklist
-----BEGIN CERTIFICATE-----
END read-blacklist

BEGIN connect-blacklist
www.nycu.edu.tw:443
google.com:80
END connect-blacklist

BEGIN getaddrinfo-blacklist
www.ym.edu.tw
www.nctu.edu.tw
END getaddrinfo-blacklist
```

### Example1
* command: `./launcher ./sandbox.so config-example.txt cat /etc/passwd`
### Example2
* command: `./launcher ./sandbox.so config-example.txt cat /etc/hosts`
### Example3
* command: `./launcher ./sandbox.so config-example.txt cat /etc/ssl/certs/Amazon_Root_CA_1.pem`
### Example5
* command: `./launcher ./sandbox.so config-example.txt wget http://google.com -t 1`
### Example6
* command: `./launcher ./sandbox.so config-example.txt wget https://www.nycu.edu.tw -t 1`
### Example7
* command: `./launcher ./sandbox.so config-example.txt wget http://www.google.com -q -t 1`
### Example8
* command: `./launcher ./sandbox.so config-example.txt python3 -c 'import os;os.system("wget http://www.google.com -q -t 1")'`
## Hidden Case

```

BEGIN open-blacklist
/etc/passwd
/test/notfound
END open-blacklist

BEGIN read-blacklist
HTTP/1.1 301
END read-blacklist

BEGIN connect-blacklist
freebsd.cs.nctu.edu.tw:443
END connect-blacklist

BEGIN getaddrinfo-blacklist
www.ym.edu.tw
www.nctu.edu.tw
END getaddrinfo-blacklist

```

### Case1
* command: `./launcher ./sandbox.so config.txt cat /tmp/testfile ; ./launcher ./sandbox.so config.txt cat /etc/passwd ; ./launcher ./sandbox.so config.txt cat /etc/hosts`
### Case2
* command: `./launcher ./sandbox.so config.txt wget http://google.com/ -t 1 -o /dev/null ; ./launcher ./sandbox.so config.txt wget http://linux.cs.nctu.edu.tw ; ./launcher ./sandbox.so config.txt wget https://freebsd.cs.nctu.edu.tw`
### Case3
* command: `./launcher ./sandbox.so config.txt ./case3`