#!/usr/bin/env python3
# 
# Show file descriptors open for process and limit

import psutil

for p in psutil.process_iter(attrs=['pid', 'name', 'username', 'num_fds']):
    try:
        soft, hard = p.rlimit(psutil.RLIMIT_NOFILE)
        cur = p.info['num_fds']
        usage = int(cur / soft * 100)
        print('{:>2d}% {}/{}/{}'.format(
            usage,
            p.info['pid'],
            p.info['username'],
            p.info['name'],
            ))
    except psutil.NoSuchProcess:
        pass
