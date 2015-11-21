//
//  AritmOverloads.swift
//  gsnet
//
//  Created by Gabor Soulavy on 21/11/2015.
//  Copyright © 2015 Gabor Soulavy. All rights reserved.
//


//INT -> DOUBLE
//int -> double +
/*
func + (l: int, r: double) -> double {
    return double(l) + r
}

func + (l: double, r: int) -> double {
    return l + double(r)
}

//int -> double -
func - (l: int, r: double) -> double {
    return double(l) - r
}

func - (l: double, r: int) -> double {
    return l - double(r)
}

//int -> double *
func * (l: int, r: double) -> double {
    return double(l) * r
}

func * (l: double, r: int) -> double {
    return l * double(r)
}

//int -> double /
func / (l: int, r: double) -> double {
    return double(l) / r
}

func / (l: double, r: int) -> double {
    return l / double(r)
}

//LONG -> DOUBLE
//long -> double +
func + (l: long, r: double) -> double {
    return double(l) + r
}

func + (l: double, r: long) -> double {
    return l + double(r)
}

//long -> double -
func - (l: long, r: double) -> double {
    return double(l) - r
}

func - (l: double, r: long) -> double {
    return l - double(r)
}

//long -> double *
func * (l: long, r: double) -> double {
    return double(l) * r
}

func * (l: double, r: long) -> double {
    return l * double(r)
}

//long -> double /
func / (l: long, r: double) -> double {
    return double(l) / r
}

func / (l: double, r: long) -> double {
    return l / double(r)
}
*/
/*
//FLOAT -> DOUBLE
//float -> double +
func + (l: float, r: double) -> double {
    return double(l) + r
}

func + (l: double, r: float) -> double {
    return l + double(r)
}

//float -> double -
func - (l: float, r: double) -> double {
    return double(l) - r
}

func - (l: double, r: float) -> double {
    return l - double(r)
}

//float -> double *
func * (l: float, r: double) -> double {
    return double(l) * r
}

func * (l: double, r: float) -> double {
    return l * double(r)
}

//float -> double /
func / (l: float, r: double) -> double {
    return double(l) / r
}

func / (l: double, r: float) -> double {
    return l / double(r)
}
*/
/*
//INT -> LONG
//int -> long +
func + (l: int, r: long) -> long {
    return long(l) + r
}

func + (l: long, r: int) -> long {
    return l + long(r)
}

//int -> long -
func - (l: int, r: long) -> long {
    return long(l) - r
}

func - (l: long, r: int) -> long {
    return l - long(r)
}

//int -> long *
func * (l: int, r: long) -> long {
    return long(l) * r
}

func * (l: long, r: int) -> long {
    return l * long(r)
}

//int -> long /
func / (l: int, r: long) -> long {
    return long(l) / r
}

func / (l: long, r: int) -> long {
    return l / long(r)
}
*/
/*
//UINT -> LONG
//uint -> long +
func + (l: uint, r: long) -> long {
    return long(l) + r
}

func + (l: long, r: uint) -> long {
    return l + long(r)
}

//uint -> long -
func - (l: uint, r: long) -> long {
    return long(l) - r
}

func - (l: long, r: uint) -> long {
    return l - long(r)
}

//uint -> long *
func * (l: uint, r: long) -> long {
    return long(l) * r
}

func * (l: long, r: uint) -> long {
    return l * long(r)
}

//uint -> long /
func / (l: uint, r: long) -> long {
    return long(l) / r
}

func / (l: long, r: uint) -> long {
    return l / long(r)
}
*/
/*
//SHORT -> INT
//short -> int +
func + (l: short, r: int) -> int {
    return int(l) + r
}

func + (l: int, r: short) -> int {
    return l + int(r)
}

//short -> int -
func - (l: short, r: int) -> int {
    return int(l) - r
}

func - (l: int, r: short) -> int {
    return l - int(r)
}

//short -> int *
func * (l: short, r: int) -> int {
    return int(l) * r
}

func * (l: int, r: short) -> int {
    return l * int(r)
}

//short -> int /
func / (l: short, r: int) -> int {
    return int(l) / r
}

func / (l: int, r: short) -> int {
    return l / int(r)
}

//USHORT -> INT
//ushort -> int +
func + (l: ushort, r: int) -> int {
    return int(l) + r
}

func + (l: int, r: ushort) -> int {
    return l + int(r)
}

//ushort -> int -
func - (l: ushort, r: int) -> int {
    return int(l) - r
}

func - (l: int, r: ushort) -> int {
    return l - int(r)
}

//ushort -> int *
func * (l: ushort, r: int) -> int {
    return int(l) * r
}

func * (l: int, r: ushort) -> int {
    return l * int(r)
}

//ushort -> int /
func / (l: ushort, r: int) -> int {
    return int(l) / r
}

func / (l: int, r: ushort) -> int {
    return l / int(r)
}

//BYTE -> INT
//byte -> int +
func + (l: byte, r: int) -> int {
    return int(l) + r
}

func + (l: int, r: byte) -> int {
    return l + int(r)
}

//byte -> int -
func - (l: byte, r: int) -> int {
    return int(l) - r
}

func - (l: int, r: byte) -> int {
    return l - int(r)
}

//byte -> int *
func * (l: byte, r: int) -> int {
    return int(l) * r
}

func * (l: int, r: byte) -> int {
    return l * int(r)
}

//byte -> int /
func / (l: byte, r: int) -> int {
    return int(l) / r
}

func / (l: int, r: byte) -> int {
    return l / int(r)
}

//SBYTE -> INT
//sbyte -> int +
func + (l: sbyte, r: int) -> int {
    return int(l) + r
}

func + (l: int, r: sbyte) -> int {
    return l + int(r)
}

//sbyte -> int -
func - (l: sbyte, r: int) -> int {
    return int(l) - r
}

func - (l: int, r: sbyte) -> int {
    return l - int(r)
}

//sbyte -> int *
func * (l: sbyte, r: int) -> int {
    return int(l) * r
}

func * (l: int, r: sbyte) -> int {
    return l * int(r)
}

//sbyte -> int /
func / (l: sbyte, r: int) -> int {
    return int(l) / r
}

func / (l: int, r: sbyte) -> int {
    return l / int(r)
}

//BYTE SHORT -> INT
//byte -> short +
func + (l: byte, r: short) -> int {
    return int(l) + int(r)
}

func + (l: short, r: byte) -> int {
    return int(l) + int(r)
}

//byte -> int -
func - (l: byte, r: short) -> int {
    return int(l) - int(r)
}

func - (l: short, r: byte) -> int {
    return int(l) - int(r)
}

//byte -> int *
func * (l: byte, r: short) -> int {
    return int(l) * int(r)
}

func * (l: short, r: byte) -> int {
    return int(l) * int(r)
}

//byte -> int /
func / (l: byte, r: short) -> int {
    return int(l) / int(r)
}

func / (l: short, r: byte) -> int {
    return int(l) / int(r)
}

//SBYTE SHORT -> INT
//sbyte -> short +
func + (l: sbyte, r: short) -> int {
    return int(l) + int(r)
}

func + (l: short, r: sbyte) -> int {
    return int(l) + int(r)
}

//sbyte -> int -
func - (l: sbyte, r: short) -> int {
    return int(l) - int(r)
}

func - (l: short, r: sbyte) -> int {
    return int(l) - int(r)
}

//sbyte -> int *
func * (l: sbyte, r: short) -> int {
    return int(l) * int(r)
}

func * (l: short, r: sbyte) -> int {
    return int(l) * int(r)
}

//sbyte -> int /
func / (l: sbyte, r: short) -> int {
    return int(l) / int(r)
}

func / (l: short, r: sbyte) -> int {
    return int(l) / int(r)
}

//SBYTE USHORT -> INT
//sbyte -> ushort +
func + (l: sbyte, r: ushort) -> int {
    return int(l) + int(r)
}

func + (l: ushort, r: sbyte) -> int {
    return int(l) + int(r)
}

//sbyte -> int -
func - (l: sbyte, r: ushort) -> int {
    return int(l) - int(r)
}

func - (l: ushort, r: sbyte) -> int {
    return int(l) - int(r)
}

//sbyte -> int *
func * (l: sbyte, r: ushort) -> int {
    return int(l) * int(r)
}

func * (l: ushort, r: sbyte) -> int {
    return int(l) * int(r)
}

//sbyte -> int /
func / (l: sbyte, r: ushort) -> int {
    return int(l) / int(r)
}

func / (l: ushort, r: sbyte) -> int {
    return int(l) / int(r)
}

//BYTE USHORT -> INT
//byte -> ushort +
func + (l: byte, r: ushort) -> int {
    return int(l) + int(r)
}

func + (l: ushort, r: byte) -> int {
    return int(l) + int(r)
}

//byte -> int -
func - (l: byte, r: ushort) -> int {
    return int(l) - int(r)
}

func - (l: ushort, r: byte) -> int {
    return int(l) - int(r)
}

//byte -> int *
func * (l: byte, r: ushort) -> int {
    return int(l) * int(r)
}

func * (l: ushort, r: byte) -> int {
    return int(l) * int(r)
}

//byte -> int /
func / (l: byte, r: ushort) -> int {
    return int(l) / int(r)
}

func / (l: ushort, r: byte) -> int {
    return int(l) / int(r)
}
*/