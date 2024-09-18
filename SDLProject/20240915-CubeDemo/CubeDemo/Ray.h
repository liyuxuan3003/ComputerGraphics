#ifndef RAY_H
#define RAY_H

#include "Vec3.h"

class Ray
{
public:
    Vec3 e;
    Vec3 d;
    Ray(Vec3 e,Vec3 d);
    Ray(const Ray &ray);
    Ray();
    ~Ray();
};

#endif