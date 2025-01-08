#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]


SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter10B_04.fig.wls";
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
	ViewPoint->{-100,-80,65},PlotPoints->50,MaxRecursion -> 5,
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


xf2=Function[{fliter},(fliter/.{x->x})(fliter/.{x->y})];


xf2Gauss=xf2[xfGauss[1]];


xUnit=Image[ImageData[#]/Sum[y,{y,Sum[x,{x,ImageData[#]}]}]]&;


xFliter=xUnit[Image[Table[Table[N[xf2Gauss],{x,-3,3}],{y,-3,3}]]];


xDirac=Function[{m,n},Image[Table[Table[If[x==m && y==n,1,0],{x,-3,3}],{y,-3,3}]]];


xShadow=Function[{alpha,m,n},{xDirac[0,0],xUnit[ImageConvolve[xFliter,xDirac[m,n]]]}];


xSharp=Function[{alpha},(1+alpha)xDirac[0,0]-alpha xFliter];


xImage=Rasterize[Exp[Pi],Background->White,RasterSize->{50,50},ImageSize->100]


fig1=Table[ImageConvolve[xImage,xSharp[a]],{a,{-1,0,1}}]


fig=fig1


figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]],ImageResolution->2000]]&)/@figWithName]
