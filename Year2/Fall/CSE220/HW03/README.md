# Homework 3
Welcome to your first programming assignment in CSE 220.

For this assignment, you will have to implement various functions found in the `src/` directory.

## Running your Code

Starting with this assignment, you will be using Make to compile your C code. Make is a build automation tool that compiles and links program source code into executable programs.

For this assignment, you only have to worry about using one make command:

```bash
make
```

Running `make` will read through the changes implemented in the `src/` directory and compile the executable binaries in the `build/` directory.

If your code successfully compiles, you will find the `bit`, `float`, and `integer` files. In order to run these files, type:

```bash
./build/FILENAME
```

into your terminal, replacing `FILENAME` with the name of the executable you want to run.

## Submitting your Code

After succesfully completing the assignment and passing all the test cases you have created, remember to comment out your test cases. After that, please run:
```bash
make clean
```
This will remove the `build/` directory before your submit your code.

After that, zip up your entire assignment, INCLUDING your Makefile. The zip file should be named `FallCSE220-<SBUusername>-<SBUID#>.zip` 