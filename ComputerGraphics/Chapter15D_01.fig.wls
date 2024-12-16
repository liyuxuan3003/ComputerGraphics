#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]


SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter15D_01.fig.wls";
nbPDFName="build/"<>StringReplace[nbFileName,"wls"->"pdf"];
nbPDFNameList=(StringReplace[nbPDFName,".fig"->#<>".fig"]&)/@Alphabet[];
Export[nbPDFName,""]


xLaTeX=(MaTeX[
	#1,Magnification->#2,
	"Preamble"->{"\\usepackage{xcolor}","\\usepackage{siunitx}","\\usepackage{physics}","\\usepackage{upgreek}"}])&;
xLabelFont={FontColor->Black,FontFamily->"Latin Modern",FontSize->5};


xFigConfig={
	Frame->True,GridLines->Automatic,ImageSize->Automatic->300,
	FrameStyle->BlackFrame,PlotStyle->ColorData[10],BaseStyle->xLabelFont};
xFigLabel=(FrameLabel->{xLaTeX[#1,0.8],xLaTeX[#2,0.8]})&;


xFig3DConfig={
	ViewPoint->{-100,-80,65},PlotPoints -> 50,MaxRecursion -> 5,
	ExclusionsStyle->{None,{Black,Thin}},ColorFunction->ColorData["DarkRainbow"],
	BaseStyle->xLabelFont};
xFig3DLabel=(AxesLabel->{xLaTeX[#1,0.8],xLaTeX[#2,0.8],xLaTeX[#3,0.8]})&;


xTicks=(Table[{x,xLaTeX[ToString[PaddedForm[x,{#2[[1]],#2[[2]]}]],0.5]},{x,#1[[1]],#1[[2]],#1[[3]]}])&;
xTicksProp=(Table[{x #3,xLaTeX[ToString[PaddedForm[x,{#2[[1]],#2[[2]]}]],0.5]},{x,#1[[1]],#1[[2]],#1[[3]]}])&;
xTicksLog=(Table[{10^x,xLaTeX["10^{"<>ToString[x]<>"}",0.5]},{x,#1[[1]],#1[[2]],#1[[3]]}])&;
xTicksLog1=(Table[{10^x,xLaTeX["1\\times 10^{"<>ToString[x]<>"}",0.5]},{x,#1[[1]],#1[[2]],#1[[3]]}])&;
xTicksLog2=(Table[{2 10^x,xLaTeX["2\\times 10^{"<>ToString[x]<>"}",0.5]},{x,#1[[1]],#1[[2]],#1[[3]]}])&;
xTicksLog5=(Table[{5 10^x,xLaTeX["5\\times 10^{"<>ToString[x]<>"}",0.5]},{x,#1[[1]],#1[[2]],#1[[3]]}])&;


xGrids=(Table[x,{x,#1[[1]],#1[[2]],#1[[3]]}])&;
xGridsLog=(Flatten[Table[Table[{If[#2[[1]]<=(n 10^x)<=#2[[2]],(n 10^x),{}]},{n,1,9,1}],{x,#1[[1]],#1[[2]],#1[[3]]}]])&;


xText=Style[#1,FontSize->#2,FontFamily->"Noto Serif CJK SC"]&;
xTextConsolas=Style[#1,FontSize->#2,FontFamily->"Consolas"]&;


xLegend=(Placed[LineLegend[#1,
	LegendMarkerSize->{{22,1}},
	LegendFunction->"Panel",
	LegendMargins->1,
	LegendLayout->#2],#3])&;


xPoint=({Black,PointSize[0.015],Point[#],White,PointSize[0.010],Point[#],Black})&;


MyColor=Table[ColorData[10][x],{x,{1,2,3,4,5,6,8}}]


xbeta=(1-alpha)/2;
xalpha=0;
funcCardinal=Evaluate[{
	-beta u+2beta u^2-beta u^3,
	1+(beta-3)u^2+(2-beta)u^3,
	beta u+(3-2beta)u^2+(beta-2)u^3,
	-beta u^2+beta u^3}//.{beta->xbeta,alpha->xalpha}];
deltau=1/6;
xu=Function[{n},If[n>=0,If[n<=6,n/6,1],0]];
xub=Function[{n},If[n>=0,If[n<=10,n/10,1],0]];


func1=FullSimplify@Table[
	Piecewise[Join[Table[{funcCardinal[[pw+1]]/.{u->(u-xu[n-pw+1])/deltau},xu[n-pw+1]<=u<xu[n-pw+2]},{pw,0,3}],{{Indeterminate,True}}]]
,{n,0,6}];


xConfig1={
	PlotRange->{-0.3,1.3},
	ImageSize->Automatic->500,
	PlotStyle->MyColor,
	AspectRatio->1/3,
	FrameTicks->{Table[{n/6,xLaTeX["u_"<>ToString[n],0.6]},{n,0,6}],xTicks[{-0.2,1.2,0.2},{2,1}]},
	Prolog->{
		{Black,Opacity[0.04],Rectangle[{0,1.0},{1/6,1.3}]},
		{Black,Opacity[0.04],Rectangle[{5/6,1.0},{1,1.3}]}
	},
	Epilog->{
		{Black,Opacity[0.04],Rectangle[{0,-0.3},{1/6,1.0}]},
		{Black,Opacity[0.04],Rectangle[{5/6,-0.3},{1,1.0}]},
		Red,Text[xText["Invaild Region",7],{0.5/6,-0.13}],
		Blue,Text[xText["Invaild Region",7],{5.5/6,-0.13}]
	},
	PlotLegends->xLegend[Table[xLaTeX["b_"<>ToString[n]<>"(u)",0.7],{n,0,6}],{"Row",1},{Center,Top}],
	Evaluate@xFigLabel["u","b(u)"],
	Evaluate@xFigConfig
};


fig1=Plot[func1,{u,0,1},Evaluate@xConfig1]


func2=Table[Product[If[j==n,1,(u-xu[j])/(xu[n]-xu[j])],{j,0,6}],{n,0,6}];


xConfig2={
	PlotRange->{-1.3,1.7},
	ImageSize->Automatic->500,
	PlotStyle->MyColor,
	AspectRatio->1.875/3,
	FrameTicks->{Table[{n/6,xLaTeX["u_"<>ToString[n],0.6]},{n,0,6}],xTicks[{-1.19,1.61,0.2},{2,1}]},
	PlotLegends->xLegend[Table[xLaTeX["b_"<>ToString[n]<>"(u)",0.7],{n,0,6}],{"Row",1},{Center,Top}],
	Evaluate@xFigLabel["u","b(u)"],
	Evaluate@xFigConfig
};


fig2=Plot[func2,{u,0,1},Evaluate@xConfig2]


func3=Table[(6!)/(n!(6-n)!) u^n(1-u)^(6-n),{n,0,6}];


xConfig3={
	PlotRange->{-0.3,1.3},
	ImageSize->Automatic->500,
	PlotStyle->MyColor,
	AspectRatio->1/3,
	FrameTicks->{Table[{n/6,xLaTeX["u_"<>ToString[n],0.6]},{n,0,6}],xTicks[{-0.2,1.2,0.2},{2,1}]},
	PlotLegends->xLegend[Table[xLaTeX["b_"<>ToString[n]<>"(u)",0.7],{n,0,6}],{"Row",1},{Center,Top}],
	Evaluate@xFigLabel["u","b(u)"],
	Evaluate@xFigConfig
};


fig3=Plot[func3,{u,0,1},Evaluate@xConfig3]


func4=Table[
	Piecewise[{
		{v=(u-xub[n+0])/(xub[n+1]-xub[n+0]);(v^3)/6,xub[n+0]<=u<xub[n+1]},
		{v=(u-xub[n+1])/(xub[n+2]-xub[n+1]);(-3v^3+3v^2+3v+1)/6,xub[n+1]<=u<xub[n+2]},
		{v=(u-xub[n+2])/(xub[n+3]-xub[n+2]);(3v^3-6v^2+4)/6,xub[n+2]<=u<xub[n+3]},
		{v=(u-xub[n+3])/(xub[n+4]-xub[n+3]);(-v^3+3v^2-3v+1)/6,xub[n+3]<=u<xub[n+4]},
		{Indeterminate,True}
	}]
,{n,0,6}];


xConfig4={
	PlotRange->{-0.3,1.3},
	ImageSize->Automatic->500,
	PlotStyle->MyColor,
	AspectRatio->1/3,
	FrameTicks->{Table[{n/10,xLaTeX["u_{"<>ToString[n]<>"}",0.6]},{n,0,10}],xTicks[{-0.2,1.2,0.2},{2,1}]},
	PlotLegends->xLegend[Table[xLaTeX["b_"<>ToString[n]<>"(u)",0.7],{n,0,6}],{"Row",1},{Center,Top}],
	Evaluate@xFigLabel["u","b(u)"],
	Evaluate@xFigConfig
};


fig4=Plot[func4,{u,0,1},Evaluate@xConfig4]


fig={fig1,fig2,fig3,fig4}


figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]],ImageResolution->2000]]&)/@figWithName]
