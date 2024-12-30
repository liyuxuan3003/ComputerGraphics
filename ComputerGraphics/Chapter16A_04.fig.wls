#!/usr/bin/env wolframscript
(* ::Package:: *)

ClearAll["Global`*"]


SetDirectory[NotebookDirectory[]];
Needs["MaTeX`"];


nbFileName="Chapter16A_04.fig.wls";
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


xFig3DContConfig={
	ViewPoint->{-100,-80,65},BaseStyle->xLabelFont};


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


xfofBlinn=Exp[-r d^2];
xfofMetaballs=Piecewise[{{1-3(d/r)^2,0<=d<r/3},{(3/2)(1-d/r)^2,r/3<=d<r},{0,d>=r}}];
xfofSoftobj=Piecewise[{{(1-(4d^6)/(9r^6)+(17d^4)/(9r^4)-(22d^2)/(9r^2)),d<r},{0,d>=r}}];
xfofWyvill=Piecewise[{{(1-(d^2)/(r^2))^3,d<r},{0,d>=r}}];


Plot[xfofSoftobj//.{r->1},{d,0,1}]


xblendRicci=(fa^n+fb^n)^(1/n);
xblendPasko=(fa+fb+alpha Sqrt[fa^2+fb^2]);
xblendMax=Max[fa,fb];
xblendMin=Min[fa,fb];


xpa={-0.4,0,0};
xpb={+0.4,0,0};


xdis=Function[{pr,ptar},Norm[pr-ptar]];


xf=xfofSoftobj//.{r->1,d->xdis[{x,y,z},#1]}&;


func1=xblendPasko//.{fa->xf[xpa],fb->xf[xpb],n->1,alpha->-1.0};
func2=xblendPasko//.{fa->xf[xpa],fb->xf[xpb],n->1,alpha->-0.5};
func3=xblendPasko//.{fa->xf[xpa],fb->xf[xpb],n->1,alpha->0.0};
func4=xblendPasko//.{fa->xf[xpa],fb->xf[xpb],n->1,alpha->+0.5};
func5=xblendPasko//.{fa->xf[xpa],fb->xf[xpb],n->1,alpha->+1.0};


funcList={func1,func2,func3,func4,func5};


fig1=Table[ContourPlot3D[f==0.5,{x,-1.2,1.2},{y,-0.6,0.6},{z,-0.6,0.6},ViewPoint->{80,-100,65},ImageSize->250,BoxRatios->{2,1,1},
Ticks->{xTicks[{-1,1,1},{2,1}],xTicks[{-0.5,0.5,0.5},{2,1}],xTicks[{-0.5,0.5,0.5},{2,1}]},
ColorFunction->Function[{x,y,z,f},Blend[{Hue[-z],White},0.5]],
Evaluate@xFig3DLabel["x","y","z"]],{f,funcList}]


fig=fig1


figWithName=Transpose[{fig,nbPDFNameList[[1;;Length[fig]]]}];
ReleaseHold[(Hold[Export[#[[2]],#[[1]],ImageResolution->2000]]&)/@figWithName]
