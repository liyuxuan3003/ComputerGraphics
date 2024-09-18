#ifndef VEC3_H
#define VEC3_H

class Vec3
{
public:
    double x;
    double y;
    double z;
    Vec3(double x,double y,double z);
    Vec3(const Vec3 &vec3);
    Vec3();
    ~Vec3();
    double Length();
    Vec3 operator+(const Vec3 &v);
    Vec3 operator-(const Vec3 &v);
    Vec3 operator-();
    Vec3 operator*(const double &n);
    Vec3 operator/(const double &n);
    Vec3 Normalize();
    static double Dot(const Vec3 &v1,const Vec3 &v2);
    static Vec3 Cross(const Vec3 &v1,const Vec3 &v2);
};

#endif