#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]


mC={
	{1,1-1/beta,1,1},
	{1,0,0,0},
	{1,1,1,1},
	{1,1/beta,2/beta,3/beta}};
mB=FullSimplify@Inverse[mC];


vu={{1,u,u^2,u^3}}


vp=Transpose[{{p[0],p[1],p[2],p[3]}}]


f0=Dot[vu,mB,vp][[1]][[1]]
f1=D[f0,u]
f2=D[f1,u]
f3=D[f2,u]


pSet={
	{0,0},
	{2,0},
	{2,2},
	{4,2},
	{6,2},
	{6,0},
	{8,0}
}


pList={};


funcList={};


Do[
	AppendTo[funcList,f0//.{p[0]->pSet[[i+0]],p[1]->pSet[[i+1]],p[2]->pSet[[i+2]],p[3]->pSet[[i+3]]}];
	AppendTo[pList,Table[Table[D[funcList[[i]],{u,j}]//.{u->uval},{j,0,3}],{uval,{0,1}}]];	
,{i,1,Length[pSet]-3}];


xbeta=(1-alpha)/2;


func=Table[Piecewise[Table[{funcList[[n+1]][[id]]//.{u->t-n,beta->xbeta},n<=t<=n+1},{n,0,Length[pSet]-4}]],{id,{1,2}}];


ParametricPlot[Table[func,{alpha,{0,-1,-2,-2.5}}],{t,0,4},Frame->True]


funcList//.{beta->xbeta,alpha->0}


pList//.{beta->xbeta,alpha->0}
