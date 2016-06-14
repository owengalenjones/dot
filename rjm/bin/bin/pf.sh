#!/bin/bash

# http://blog.trackets.com/2014/05/17/ssh-tunnel-local-and-remote-port-forwarding-explained-with-examples.html

ssh -L $1:localhost:$2 core
