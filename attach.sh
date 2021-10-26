#!/usr/bin/env bash

gdb -s out/os -ex 'target remote localhost:1234'
