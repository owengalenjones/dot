#!/bin/bash

ssh -L $1:localhost:$2 core
