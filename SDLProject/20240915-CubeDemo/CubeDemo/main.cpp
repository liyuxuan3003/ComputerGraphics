#include <cstdio>
#include <cmath>
#include <algorithm>
#include <SDL2/SDL.h>

#include "Vec3.h"
#include "Color.h"
#include "Triangle.h"
#include "Ray.h"
#include "Matrix3.h"

#define TRIANGLE_NUM 12

void GenerateScene(SDL_Renderer *pRender)
{
    Triangle mesh[TRIANGLE_NUM];
    //Ensure the a,b,c [Right Hand]-> n outside
    mesh[0] =Triangle(Vec3(0,0,0),Vec3(0,1,0),Vec3(1,0,0));
    mesh[1] =Triangle(Vec3(0,0,0),Vec3(0,0,1),Vec3(0,1,0));
    mesh[2] =Triangle(Vec3(0,0,0),Vec3(1,0,0),Vec3(0,0,1));
    mesh[3] =Triangle(Vec3(1,1,0),Vec3(1,0,0),Vec3(0,1,0));
    mesh[4] =Triangle(Vec3(0,1,1),Vec3(0,1,0),Vec3(0,0,1));
    mesh[5] =Triangle(Vec3(1,0,1),Vec3(0,0,1),Vec3(1,0,0));
    /********/
    mesh[6] =Triangle(Vec3(1,1,1),Vec3(0,1,1),Vec3(1,0,1));
    mesh[7] =Triangle(Vec3(1,1,1),Vec3(1,0,1),Vec3(1,1,0));
    mesh[8] =Triangle(Vec3(1,1,1),Vec3(1,1,0),Vec3(0,1,1));
    mesh[9] =Triangle(Vec3(0,0,1),Vec3(1,0,1),Vec3(0,1,1));
    mesh[10]=Triangle(Vec3(1,0,0),Vec3(1,1,0),Vec3(1,0,1));
    mesh[11]=Triangle(Vec3(0,1,0),Vec3(0,1,1),Vec3(1,1,0));
    /********/
    for(int i=0;i<TRIANGLE_NUM;i++)
    {
        // mesh[i].colD=Color(0xA0,0xA0,0xA0);
        // mesh[i].colS=Color(0x40,0x40,0x40);
        mesh[i].colD=Color(0x40,0x40,0x40);
        mesh[i].colS=Color(0xA0,0xA0,0xA0);
    }
    Color colBackground=Color(0x00,0x00,0x00);
    Color colLight=Color(0xBB,0xBB,0xBB);
    Color colLightEnv=Color(0x44,0x44,0x44);
    // Color colLightEnv=Color(0x00,0x00,0x00);
    // Vec3 light=Vec3(0,-1,3);
    Vec3 light=Vec3(0,1,1.5);
    Vec3 e=Vec3(2,-1,2);
    Vec3 w=Vec3(1,-1,1).Normalize();
    Vec3 v=Vec3(-1,1,2).Normalize();
    Vec3 u=Vec3::Cross(v,w);
    double xl=-1;
    double xr=+1;
    double yb=-1;
    double yt=+1;
    int nx=500;
    int ny=500;
    double tmin=0;
    double tmax=10;
    double tList[TRIANGLE_NUM];
    double px=10000;
    for(int i=0;i<nx;i++)
    {
        for(int j=0;j<ny;j++)
        {
            double ux=xl+(double(i)+0.5)*(xr-xl)/nx;
            double vx=yb+(double(j)+0.5)*(yt-yb)/ny;
            Ray p(Vec3(e+u*ux+v*vx),Vec3(-w));
            int tLoc=-1;
            for(int k=0;k<TRIANGLE_NUM;k++)
            {
                Triangle f=mesh[k];
                Matrix3 m=Matrix3(
                    f.a.x-f.b.x, f.a.x-f.c.x, p.d.x,
                    f.a.y-f.b.y, f.a.y-f.c.y, p.d.y,
                    f.a.z-f.b.z, f.a.z-f.c.z, p.d.z
                );
                Vec3 vm=f.a-p.e;
                Matrix3 mbeta=m.ReplaceColumn(vm,0);
                Matrix3 mgamma=m.ReplaceColumn(vm,1);
                Matrix3 mt=m.ReplaceColumn(vm,2);
                double dm=m.Determinant();
                double dmbeta=mbeta.Determinant();
                double dmgamma=mgamma.Determinant();
                double dmt=mt.Determinant();
                double beta=dmbeta/dm;
                double gamma=dmgamma/dm;
                double t=dmt/dm;
                tList[k]=INFINITY;
                if(t>=tmin && t<=tmax)
                {
                    if(beta<=1 && gamma<=1-beta && beta>=0 && gamma>=0)
                    {
                        tList[k]=t;
                        if(tLoc==-1)
                            tLoc=k;
                        else if(t<tList[tLoc])
                            tLoc=k;
                    }
                }
            }
            Color col=colBackground;
            if(tLoc!=-1)
            {
                Triangle tri=mesh[tLoc];
                Vec3 inter=p.e+p.d*tList[tLoc];
                Vec3 sn=Vec3::Cross(tri.b-tri.a, tri.c-tri.b).Normalize();
                Vec3 sl=(light-inter).Normalize();
                Vec3 sv=(p.e-inter).Normalize();
                Vec3 sh=(sv+sl).Normalize();
                col=Color::Multi(std::max(Vec3::Dot(sn,sl),0.0),tri.colD)+
                    Color::Multi(pow(std::max(Vec3::Dot(sn,sh),0.0),px),tri.colS)+
                    Color::Multi(1,tri.colD*colLightEnv);
            }
            SDL_SetRenderDrawColor(pRender,col.r,col.g,col.b,col.a);
            SDL_RenderDrawPoint(pRender,i,500-j);
        }
    }
}

int main(int argc,char *argv[]) 
{
	SDL_Init(SDL_INIT_EVERYTHING);
	SDL_Window *pWindow=SDL_CreateWindow("Demo3D",
        SDL_WINDOWPOS_UNDEFINED,SDL_WINDOWPOS_UNDEFINED,500,500,0);
    SDL_Renderer *pRender=SDL_CreateRenderer(pWindow,-1,SDL_RENDERER_SOFTWARE);
    SDL_Surface *pSurface=SDL_CreateRGBSurface(0,500,500,32,
        0x00FF0000,0x0000FF00,0x000000FF,0xFF000000);
    SDL_Rect rect={0,0,500,500};
    int running=1;

    GenerateScene(pRender);
    SDL_RenderPresent(pRender);

    while(running)
    {
        SDL_Event event;
        if(SDL_PollEvent(&event))
        {
            switch (event.type)
            {
                case SDL_QUIT:
                    running = 0;
                    break;
            }
        }
    }

    SDL_RenderReadPixels(pRender,&rect,0,pSurface->pixels,pSurface->pitch);
    SDL_SaveBMP(pSurface,"build/1.bmp");

    SDL_Quit();
	return 0;
}