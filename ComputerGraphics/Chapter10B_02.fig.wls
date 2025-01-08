#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]


SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter10B_02.fig.wls";
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


xPoint=({Black,PointSize[0.012],Point[#],White,PointSize[0.007],Point[#],Black})&;


xfBox=Piecewise[{{1/2,0<=Abs[x]<1},{0,Ture}}];
xfTent=Piecewise[{{1-Abs[x],0<=Abs[x]<1},{0,Ture}}];
xfGauss=Function[sigma,(1/(Sqrt[2Pi]sigma))Exp[-x^2/(2 sigma^2)]];
xfB=(1/6)Piecewise[{{-3(1-Abs[x])^3+3(1-Abs[x])^2+3(1-Abs[x])+1,0<=Abs[x]<1},{(2-Abs[x])^3,1<=Abs[x]<2},{0,True}}];
xfC=(1/2)Piecewise[{{-3(1-Abs[x])^3+4(1-Abs[x])^2+(1-Abs[x]),0<=Abs[x]<1},{(2-Abs[x])^3-(2-Abs[x])^2,1<=Abs[x]<2},{0,True}}];
xfM=(1/3)xfB+(2/3)xfC;


xfBoxAlt=Piecewise[{{1/2,0.05<=Abs[x]<0.95},{0,Ture}}];


xSamplesWave=((2.00+{0,1,2,2,1,0,0,0,0,4,1})[[#1+1]])&;
xSamplesConst=(2.00+{2,2,2,2,2,2,2,2,2,2,2}[[#1+1]])&;


DiscretePlot[xSamplesWave[n],{n,0,10},PlotRange->{0,2},PlotRangePadding->Scaled[0.05],Evaluate@xFigConfig]


xReconstruct=Function[{filter,sample},Sum[sample[n] filter/.{x->x-n},{n,0,10}]];


xFliters=Function[{filter,r},Table[Piecewise[{{filter/.{x->x-n},n-r<=x<=n+r},{Indeterminate,True}}],{n,0,10}]];


xStyle=Join[Table[Directive[ColorData[10][n+1],Thickness[0.003]],{n,0,10}],{Black}];


xFunc=Function[{fliter,r,sample},Join[xFliters[fliter,r],{xReconstruct[fliter,sample]}]];


func1=Table[xFunc[a[[1]],a[[2]],xSamplesWave],{a,{
	{xfBox,1},{xfTent,1},{xfGauss[0.5],Infinity},{xfGauss[1.0],Infinity},
	{xfC,2},{xfM,2},{xfB,2}
}}];


func2=Table[xFunc[a[[1]],a[[2]],xSamplesConst],{a,{
	{xfBox,1},{xfTent,1},{xfGauss[0.5],Infinity},{xfGauss[1.0],Infinity},
	{xfC,2},{xfM,2},{xfB,2}
}}];


fig1a=DiscretePlot[xSamplesWave[i],{i,0,10,1},PlotRange->{-0.1,6.1},PlotRangePadding->Scaled[0.05],AspectRatio->1/3,
Evaluate@xFigLabel["i","a[i]"],PlotStyle->Black,FrameTicks->{xTicks[{0,10,1},{1,0}],xTicks[{0.0,6.0,1.0},{2,1}]},
Evaluate@xFigConfig]


fig1b=Table[Plot[func,{x,0,10},PlotRange->{-0.1,6.1},PlotRangePadding->Scaled[0.05],AspectRatio->1/3,
PlotStyle->xStyle,Exclusions->None,
FrameTicks->{xTicks[{0,10,1},{1,0}],xTicks[{0.0,6.0,1.0},{2,1}]},
Epilog->Table[xPoint[{n,xSamplesWave[n]}],{n,0,10}],
Evaluate@xFigLabel["x","(a*f)(x)"],
Evaluate@xFigConfig],{func,func1}]


fig2a=DiscretePlot[xSamplesConst[i],{i,0,10,1},PlotRange->{-0.1,6.1},PlotRangePadding->Scaled[0.05],AspectRatio->1/3,
Evaluate@xFigLabel["i","a[i]"],PlotStyle->Black,FrameTicks->{xTicks[{0,10,1},{1,0}],xTicks[{0.0,6.0,1.0},{2,1}]},
Evaluate@xFigConfig]


fig2b=Table[Plot[func,{x,0,10},PlotRange->{-0.1,6.1},PlotRangePadding->Scaled[0.05],AspectRatio->1/3,
PlotStyle->xStyle,Exclusions->None,
FrameTicks->{xTicks[{0,10,1},{1,0}],xTicks[{0.0,6.0,1.0},{2,1}]},
Epilog->Table[xPoint[{n,xSamplesConst[n]}],{n,0,10}],
Evaluate@xFigLabel["x","(a*f)(x)"],
Evaluate@xFigConfig],{func,func2}]


fig=Join[{fig1a},fig1b,{fig2a},fig2b]


figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]],ImageResolution->2000]]&)/@figWithName]



