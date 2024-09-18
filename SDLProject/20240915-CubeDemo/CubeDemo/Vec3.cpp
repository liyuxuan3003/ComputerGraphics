#include <cmath>

#include "Vec3.h"

Vec3::Vec3(double x,double y,double z)
{
    this->x=x;
    this->y=y;
    this->z=z;
}

Vec3::Vec3(const Vec3 &vec3)
{
    this->x=vec3.x;
    this->y=vec3.y;
    this->z=vec3.z;
}

Vec3::Vec3()
{

}

Vec3::~Vec3()
{
    
}

double Vec3::Length()
{
    return sqrt(x*x + y*y + z*z);
}

Vec3 Vec3::operator+(const Vec3 &v)
{
    return Vec3(x+v.x, y+v.y, z+v.z);
}

Vec3 Vec3::operator-(const Vec3 &v)
{
    return Vec3(x-v.x, y-v.y, z-v.z);
}

Vec3 Vec3::operator-()
{
    return Vec3(-x,-y,-z);
}

Vec3 Vec3::operator*(const double &n)
{
    return Vec3(x*n, y*n, z*n);
}

Vec3 Vec3::operator/(const double &n)
{
    return Vec3(x/n, y/n, z/n);
}

Vec3 Vec3::Normalize()
{
    Vec3 v=(*this);
    v=v/v.Length();
    return v;
}

double Vec3::Dot(const Vec3 &v1,const Vec3 &v2)
{
    return v1.x*v2.x + v1.y*v2.y + v1.z*v2.z;
}

Vec3 Vec3::Cross(const Vec3 &v1,const Vec3 &v2)
{
    return Vec3(
        v1.y*v2.z - v1.z*v2.y,
        v1.z*v2.x - v1.x*v2.z,
        v1.x*v2.y - v1.y*v2.x
    );
}