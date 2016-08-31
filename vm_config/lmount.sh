#!/bin/bash
fusermount -zu ~/h 
sshfs -o Ciphers=arcfour -o Compression=no -o reconnect -o ServerAliveInterval=15 -o transform_symlinks -o follow_symlinks 192.168.124.1:/home/lufimtse ~/h
