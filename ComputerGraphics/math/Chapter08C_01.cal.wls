#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]


xp[0]={2,0,0};
xp[1]={-1,1.73,0};
xp[2]={-1,-1.73,0};


xt={0,0,01};


(xp[0]+xp[1]+xt)/3
(xp[1]+xp[2]+xt)/3
(xp[2]+xp[0]+xt)/3


2 Normalize[Cross[xt-xp[0],xt-xp[1]]]
2 Normalize[Cross[xt-xp[1],xt-xp[2]]]
2 Normalize[Cross[xt-xp[2],xt-xp[0]]]


N[Sqrt[6]/3]
