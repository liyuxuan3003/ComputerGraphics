#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]


Rs=Abs[(n1 Cos[thetai]-n2 Sqrt[1-(n1/n2 Sin[thetai])^2])/(n1 Cos[thetai]+n2 Sqrt[1-(n1/n2 Sin[thetai])^2])]^2;


Rp=Abs[(n1 Sqrt[1-(n1/n2 Sin[thetai])^2]-n2 Cos[thetai])/(n1 Sqrt[1-(n1/n2 Sin[thetai])^2]+n2 Cos[thetai])]^2;


Ts=1-Rs;


Tp=1-Rp;


Reff=(1/2)(Rs+Rp);


Teff=1-Reff;


R0=((n1-n2)/(n1+n2))^2;


Rappr=R0+(1-R0)(1-Cos[thetai])^5;


Tappr=1-Rappr;


func1={Rs,Rp,Reff,Rappr}//.{n1->1.0,n2->5};


Plot[func1,{thetai,0,Pi/2},Frame->True,PlotRange->All]


func2={R0}//.{n1->1};


Plot[func2,{n2,0,10},Frame->True,PlotRange->All]
