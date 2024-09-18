#include <stdio.h>
#include <math.h>
#include <SDL2/SDL.h>

typedef struct
{
    double x;
    double y;
    double z;
} Vec3;

Vec3 *Vec3Init(double x,double y,double z)
{
    Vec3 *vec3=malloc(sizeof(Vec3));
    vec3->x=x;
    vec3->y=y;
    vec3->z=z;
    return vec3;
}

Vec3 *Vec3Copy(Vec3 *v)
{
    Vec3 *vec3=malloc(sizeof(Vec3));
    vec3->x=v->x;
    vec3->y=v->y;
    vec3->z=v->z;
    return vec3;
}

void Vec3Free(Vec3 *vec3)
{
    free(vec3);
}

double Vec3Length(const Vec3 *vec3)
{
    return sqrt(vec3->x*vec3->x + vec3->y*vec3->y + vec3->z*vec3->z);
}

double Vec3Dot(const Vec3 *v1,const Vec3 *v2)
{
    return v1->x* v2->x + v1->y*v2->y + v1->z*v2->z;
}

Vec3 *Vec3Cross(const Vec3 *v1,const Vec3 *v2)
{
    Vec3 *v=Vec3Init(
        v1->y*v2->z - v1->z*v2->y,
        v1->z*v2->x - v1->x*v2->z,
        v1->x*v2->y - v1->y*v2->x
    );
    return v;
}

Vec3 *Vec3Normalize(Vec3 *vec3)
{
    double len=Vec3Length(vec3);
    vec3->x/=len;
    vec3->y/=len;
    vec3->z/=len;
    return vec3;
}

typedef struct
{
    Vec3 *a;
    Vec3 *b;
    Vec3 *c;
} Triangle;

Triangle *TriangleInit(Vec3 *a,Vec3 *b,Vec3 *c)
{
    Triangle *triangle=malloc(sizeof(Triangle));
    triangle->a=a;
    triangle->b=b;
    triangle->c=c;
    return triangle;
}

void TriangleFree(Triangle *triangle)
{
    Vec3Free(triangle->a);
    Vec3Free(triangle->b);
    Vec3Free(triangle->c);
    free(triangle);
}

typedef struct
{
    Vec3 *e;
    Vec3 *d;
} Ray;

Ray *RayInit(Vec3 *e,Vec3 *d)
{
    Ray *ray=malloc(sizeof(Ray));
    ray->e=e;
    ray->d=d;
    return ray;
}

void RayFree(Ray *ray)
{
    Vec3Free(ray->e);
    Vec3Free(ray->d);
    free(ray);
}

void GenerateScene()
{
    Triangle *mesh[12];
    mesh[0] =TriangleInit(Vec3Init(0,0,0),Vec3Init(1,0,0),Vec3Init(0,1,0));
    mesh[1] =TriangleInit(Vec3Init(0,0,0),Vec3Init(0,1,0),Vec3Init(0,0,1));
    mesh[2] =TriangleInit(Vec3Init(0,0,0),Vec3Init(0,0,1),Vec3Init(1,0,1));
    mesh[3] =TriangleInit(Vec3Init(1,1,0),Vec3Init(1,0,0),Vec3Init(0,1,0));
    mesh[4] =TriangleInit(Vec3Init(0,1,1),Vec3Init(0,1,0),Vec3Init(0,0,1));
    mesh[5] =TriangleInit(Vec3Init(1,0,1),Vec3Init(0,0,1),Vec3Init(1,0,1));
    /********/
    mesh[6] =TriangleInit(Vec3Init(1,1,1),Vec3Init(0,1,1),Vec3Init(1,0,1));
    mesh[7] =TriangleInit(Vec3Init(1,1,1),Vec3Init(1,0,1),Vec3Init(1,1,0));
    mesh[8] =TriangleInit(Vec3Init(1,1,1),Vec3Init(1,1,0),Vec3Init(0,1,1));
    mesh[9] =TriangleInit(Vec3Init(0,0,1),Vec3Init(0,1,1),Vec3Init(1,0,1));
    mesh[10]=TriangleInit(Vec3Init(1,0,0),Vec3Init(1,0,1),Vec3Init(1,1,0));
    mesh[11]=TriangleInit(Vec3Init(0,1,0),Vec3Init(1,1,0),Vec3Init(0,1,1));
    /********/
    Vec3 *light=Vec3Init(0,-1,3);
    Vec3 *e=Vec3Init(2,-1,2);
    Vec3 *w=Vec3Normalize(Vec3Init(1,-1,1));
    Vec3 *v=Vec3Normalize(Vec3Init(-1,1,2));
    Vec3 *u=Vec3Cross(v,w);
    double xl=-3;
    double xr=+3;
    double yl=-3;
    double yr=+3;
    int nx=500;
    int ny=500;
    for(int i=0;i<nx;i++)
    {
        for(int j=0;j<ny;j++)
        {
            
        }
    }
    return;
}

int main(int argc,char *argv[]) 
{
	SDL_Init(SDL_INIT_EVERYTHING);
	SDL_Window *pWindow=SDL_CreateWindow("Demo3D",
        SDL_WINDOWPOS_UNDEFINED,SDL_WINDOWPOS_UNDEFINED,500,500,0);
    SDL_Renderer *pRender=SDL_CreateRenderer(pWindow,-1,SDL_RENDERER_ACCELERATED);
    GenerateScene();
    int running=1;
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
    SDL_Quit();
	return 0;
}
