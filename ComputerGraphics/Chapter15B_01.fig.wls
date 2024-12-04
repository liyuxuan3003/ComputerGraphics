#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]


SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter15B_01.fig.wls";
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


xBlendingStyle=Join[xFigConfig,{
	PlotRange->{-0.25,1.05},
	FrameTicks->{xTicks[{0,1,0.2},{2,1}],xTicks[{-0.2,1,0.2},{2,1}]},
	xFigLabel["u","b(u)"]
}];


func1={1-u,u};
func1Style={Red,Blue};
func1Legend=xLegend[{xLaTeX["b_0(u)",0.7],xLaTeX["b_1(u)",0.7]},"Column",{Left,Center}];
fig1=Plot[func1,{u,0,1},
PlotStyle->func1Style,
PlotLegends->func1Legend,
Evaluate@xBlendingStyle]


func2={1-u^2,u-u^2,u^2};
func2Style={Red,Directive[Red,Dashed],Blue};
func2Lengend=xLegend[{xLaTeX["b_0(u)",0.7],xLaTeX["b_1(u)",0.7],xLaTeX["b_2(u)",0.7]},"Column",{Left,Center}];
fig2=Plot[func2,{u,0,1},
PlotStyle->func2Style,
PlotLegends->func2Lengend,
Evaluate@xBlendingStyle]


cubicStyle={Red,Directive[Red,Dashed],Directive[Blue,Dashed],Blue};
cubicLegend=xLegend[{xLaTeX["b_0(u)",0.7],xLaTeX["b_1(u)",0.7],xLaTeX["b_2(u)",0.7],xLaTeX["b_3(u)",0.7]},"Column",{Left,Center}];


func3={1-u^3,u-u^3,0.5u^2-0.5u^3,u^3};
fig3=Plot[func3,{u,0,1},
PlotStyle->cubicStyle,
PlotLegends->cubicLegend,
Evaluate@xBlendingStyle]


func4={1-3u^2+2u^3,u-2u^2+u^3,3u^2-2u^3,-u^2+u^3};
fig4=Plot[func4,{u,0,1},
PlotStyle->cubicStyle,
PlotLegends->cubicLegend,
Evaluate@xBlendingStyle]


xbeta=(1-alpha)/2;
xalpha=0;
func5=Evaluate[{
	-beta u+2beta u^2-beta u^3,
	1+(beta-3)u^2+(2-beta)u^3,
	beta u+(3-2beta)u^2+(beta-2)u^3,
	-beta u^2+beta u^3}//.{beta->xbeta,alpha->xalpha}];
fig5=Plot[func5,{u,0,1},
PlotStyle->cubicStyle,
PlotLegends->cubicLegend,
Evaluate@xBlendingStyle]


func6={(1-u)^3,3u (1-u)^2,3u^2(1-u),u^3};
fig6=Plot[func6,{u,0,1},
PlotStyle->cubicStyle,
PlotLegends->cubicLegend,
Evaluate@xBlendingStyle]


fig={fig1,fig2,fig3,fig4,fig5,fig6}


figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]],ImageResolution->2000]]&)/@figWithName]
