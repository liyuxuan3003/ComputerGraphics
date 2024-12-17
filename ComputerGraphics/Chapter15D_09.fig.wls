#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]


SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter15D_09.fig.wls";
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


func1=Piecewise[{
		{v=(t-0);(v),0<=t<1},
		{v=(t-1);(1-v),1<=t<2},
		{Indeterminate,True}
	}];


xConfig1={
	PlotRange->{-0.3,1.3},
	PlotStyle->Black,
	FrameTicks->{Table[{t,xLaTeX["u_{i+"<>ToString[t]<>"}",0.6]},{t,0,2}],xTicks[{-0.2,1.2,0.2},{2,1}]},
	Epilog->Join[{Text[xLaTeX[ToString[N[func1//.{t->1},3]],1.0],{1,1.08}]},xPoint[Table[{x,func1//.{t->x}},{x,{0,1,2-0.0000000001}}]]],
	Evaluate@xFigLabel["u","b_{i,1}(u)"],
	Evaluate@xFigConfig
};


fig1=Plot[func1,{t,0,2},Evaluate@xConfig1]


func2=Piecewise[{
		{v=(t-0);(v^2)/2,0<=t<1},
		{v=(t-1);(-2v^2+2v+1)/2,1<=t<2},
		{v=(t-2);(v^2-2v+1)/2,2<=t<3},
		{Indeterminate,True}
	}];


xConfig2={
	PlotRange->{-0.3,1.3},
	PlotStyle->Black,
	FrameTicks->{Table[{t,xLaTeX["u_{i+"<>ToString[t]<>"}",0.6]},{t,0,4}],xTicks[{-0.2,1.2,0.2},{2,1}]},
	Epilog->Join[{Text[xLaTeX[ToString[N[func2//.{t->1.5},3]],1.0],{1.5,0.82}]},xPoint[Table[{x,func2//.{t->x}},{x,{0,1,2,3-0.0000000001}}]]],
	Evaluate@xFigLabel["u","b_{i,2}(u)"],
	Evaluate@xFigConfig
};


fig2=Plot[func2,{t,0,3},Evaluate@xConfig2]


func3=Piecewise[{
		{v=(t-0);(v^3)/6,0<=t<1},
		{v=(t-1);(-3v^3+3v^2+3v+1)/6,1<=t<2},
		{v=(t-2);(3v^3-6v^2+4)/6,2<=t<3},
		{v=(t-3);(-v^3+3v^2-3v+1)/6,3<=t<4},
		{Indeterminate,True}
	}];


xConfig3={
	PlotRange->{-0.3,1.3},
	PlotStyle->Black,
	FrameTicks->{Table[{t,xLaTeX["u_{i+"<>ToString[t]<>"}",0.6]},{t,0,4}],xTicks[{-0.2,1.2,0.2},{2,1}]},
	Epilog->Join[{Text[xLaTeX[ToString[N[func3//.{t->2},2]],1.0],{2,0.74}]},xPoint[Table[{x,func3//.{t->x}},{x,{0,1,2,3,4-0.0000000001}}]]],
	Evaluate@xFigLabel["u","b_{i,3}(u)"],
	Evaluate@xFigConfig
};


fig3=Plot[func3,{t,0,4},Evaluate@xConfig3]


func4=Piecewise[{
		{v=(t-0);-beta v^2+beta v^3,0<=t<1},
		{v=(t-1);beta v+(3-2beta)v^2+(beta-2)v^3,1<=t<2},
		{v=(t-2);1+(beta-3)v^2+(2-beta)v^3,2<=t<3},
		{v=(t-3);-beta v+2beta v^2-beta v^3,3<=t<4},
		{Indeterminate,True}
	}]//.{beta->0.5};


xConfig4={
	PlotRange->{-0.3,1.3},
	PlotStyle->Black,
	FrameTicks->{Table[{t,xLaTeX["u_{i+"<>ToString[t]<>"}",0.6]},{t,0,4}],xTicks[{-0.2,1.2,0.2},{2,1}]},
	Epilog->Join[xPoint[Table[{x,func4//.{t->x}},{x,{0,1,2,3,4-0.0000000001}}]]],
	Evaluate@xFigLabel["u","b_{i}(u)"],
	Evaluate@xFigConfig
};


fig4=Plot[func4,{t,0,4},Evaluate@xConfig4]


fig={fig1,fig2,fig3,fig4}


figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]],ImageResolution->2000]]&)/@figWithName]
