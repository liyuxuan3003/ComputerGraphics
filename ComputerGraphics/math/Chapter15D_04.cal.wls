#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]


mB={
	{1,0,0},
	{-2,2,0},
	{1,-2,1}};
mC=FullSimplify@Inverse[mB];


mC


vu={{1,u,u^2}}


vp=Transpose[{{p[0],p[1],p[2]}}]


f0=Dot[vu,mB,vp][[1]][[1]]
f1=D[f0,u]
f2=D[f1,u]
f3=D[f2,u]


pSet={
	{0,0},
	{2,4},
	{4,0}
}


pList={};


funcList={};


Do[
	AppendTo[funcList,f0//.{p[0]->pSet[[i+0]],p[1]->pSet[[i+1]],p[2]->pSet[[i+2]]}];
	AppendTo[pList,Table[Table[D[funcList[[i]],{u,j}]//.{u->uval},{j,0,3}],{uval,{0,1}}]];	
,{i,1,Length[pSet]-2}];


func=Table[Piecewise[Table[{funcList[[n+1]][[id]]//.{u->t-n},n<=t<=n+1},{n,0,Length[funcList]-1}]],{id,{1,2}}];


ParametricPlot[{func},{t,0,1},Frame->True]


FullSimplify@funcList


pList
