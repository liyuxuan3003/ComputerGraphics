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


bit=Function[ti,Product[(t-tj)/(tj-ti),{tj,Select[Table[x-1,{x,1,Length[pSet]}],#!=ti&]}]];


func=Sum[pSet[[i]]bit[i-1],{i,1,Length[pSet]}];


ParametricPlot[func,{t,0,Length[pSet]-1},Frame->True]


Plot[Evaluate@Table[bit[ti],{ti,0,Length[pSet]-1}],{t,0,Length[pSet]-1},Frame->True]


FullSimplify@func
