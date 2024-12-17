#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]


pSet={
	{0,0},
	{2,2},
	{4,0},
	{6,2},
	{8,0},
	{10,2},
	{12,0}
}


d=Length[pSet]-1;


bit=Function[i,Binomial[d,i]u^i(1-u)^(d-i)];


func=Sum[pSet[[i]]bit[i-1],{i,1,Length[pSet]}];


ParametricPlot[func,{u,0,1},Frame->True]


FullSimplify@func
