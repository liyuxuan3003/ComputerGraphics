#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]


mC={
	{1,0,0,0},
	{0,1,0,0},
	{0,0,2,0},
	{1,1,1,1}};
mB=Inverse[mC]


vu={{1,u,u^2,u^3}}


vp=Transpose[{{p[0],p[1],p[2],p[3]}}]


f0=Dot[vu,mB,vp][[1]][[1]]
f1=D[f0,u]
f2=D[f1,u]
f3=D[f2,u]


pList={
	{{{0,0},{0,4},{8,-4},{}},{{},{},{},{}}},
	{{{2,2},{},{},{}},{{},{},{},{}}},
	{{{4,0},{},{},{}},{{},{},{},{}}},
	{{{6,-2},{},{},{}},{{},{},{},{}}},
	{{{8,0},{},{},{}},{{},{},{},{}}}
};


funcList={};


Do[
	AppendTo[funcList,f0//.{p[0]->pList[[i]][[1]][[1]],p[1]->pList[[i]][[1]][[2]],p[2]->pList[[i]][[1]][[3]],p[3]->pList[[i+1]][[1]][[1]]}];
	pList[[i]][[1]][[4]]=D[funcList[[i]],{u,3}]//.{u->0};
	pList[[i]][[2]][[1]]=D[funcList[[i]],{u,0}]//.{u->1};
	pList[[i]][[2]][[2]]=D[funcList[[i]],{u,1}]//.{u->1};
	pList[[i]][[2]][[3]]=D[funcList[[i]],{u,2}]//.{u->1};
	pList[[i]][[2]][[4]]=D[funcList[[i]],{u,3}]//.{u->1};
	pList[[i+1]][[1]][[2]]=pList[[i]][[2]][[2]];
	pList[[i+1]][[1]][[3]]=pList[[i]][[2]][[3]];
,{i,1,Length[pList]-1}];


func=Table[Piecewise[Table[{funcList[[n+1]][[id]]//.{u->t-n},n<=t<n+1},{n,0,3}]],{id,{1,2}}];


ParametricPlot[{func},{t,0,5},Frame->True]


FullSimplify@funcList


pList
