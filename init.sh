#!/bin/bash

cd /MONAIBootcamp2021
#/usr/bin/tini --
jupyter notebook --port=8888 --no-browser --ip=0.0.0.0 --allow-root
