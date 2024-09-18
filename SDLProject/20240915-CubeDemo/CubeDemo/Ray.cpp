#include "Ray.h"

Ray::Ray(Vec3 e,Vec3 d)
{
    this->e=e;
    this->d=d;
}

Ray::Ray(const Ray& ray)
{
    this->e=ray.e;
    this->d=ray.d;
}

Ray::Ray()
{

}

Ray::~Ray()
{
    
}