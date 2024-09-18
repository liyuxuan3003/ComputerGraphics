#ifndef TRIANGLE_H
#define TRIANGLE_H

#include "Vec3.h"
#include "Color.h"

class Triangle
{
public:
    Vec3 a;
    Vec3 b;
    Vec3 c;
    Color colD;
    Color colS;
    Triangle(Vec3 a,Vec3 b,Vec3 c,
        Color colD=Color(0x00,0x00,0x00),
        Color colS=Color(0x00,0x00,0x00));
    Triangle(const Triangle &triangle);
    Triangle();
    ~Triangle();
};


#endif