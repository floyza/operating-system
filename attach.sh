#!/usr/bin/env bash

gdb -s kernel/os -ex 'target remote localhost:1234'
