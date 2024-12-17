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


(*xub=Function[{n},{0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0}[[n+1]]]*)


xub=Function[{n},If[n>=0,If[n<=10,n/10,1],0]];


bit=Table[
	Piecewise[{
		{v=(u-xub[n+0])/(xub[n+1]-xub[n+0]);(v^3)/6,xub[n+0]<=u<xub[n+1]},
		{v=(u-xub[n+1])/(xub[n+2]-xub[n+1]);(-3v^3+3v^2+3v+1)/6,xub[n+1]<=u<xub[n+2]},
		{v=(u-xub[n+2])/(xub[n+3]-xub[n+2]);(3v^3-6v^2+4)/6,xub[n+2]<=u<xub[n+3]},
		{v=(u-xub[n+3])/(xub[n+4]-xub[n+3]);(-v^3+3v^2-3v+1)/6,xub[n+3]<=u<xub[n+4]},
		{0,True}
	}]
,{n,0,Length[pSet]-1}];


Plot[bit,{u,0,1}]


func=Sum[pSet[[i]]bit[[i]],{i,1,Length[pSet]}];


ParametricPlot[func,{u,0.3,0.7},Frame->True]


N[FullSimplify@func]
