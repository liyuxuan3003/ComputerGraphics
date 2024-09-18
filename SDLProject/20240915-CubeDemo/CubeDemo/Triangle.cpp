#include "Triangle.h"

Triangle::Triangle(Vec3 a,Vec3 b,Vec3 c,Color colD,Color colS)
{
    this->a=a;
    this->b=b;
    this->c=c;
    this->colD=colD;
    this->colS=colS;
}

Triangle::Triangle(const Triangle& triangle)
{
    this->a=triangle.a;
    this->b=triangle.b;
    this->c=triangle.c;
    this->colD=triangle.colD;
    this->colS=triangle.colS;
}

Triangle::Triangle()
{

}

Triangle::~Triangle()
{
    
}