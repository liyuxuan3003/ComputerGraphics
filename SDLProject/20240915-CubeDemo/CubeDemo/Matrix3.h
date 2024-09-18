#ifndef MATRIX3_H
#define MATRIX3_H

#include "Vec3.h"

class Matrix3
{
public:
    double a[3][3];
    Matrix3(
        double a00,double a01,double a02,
        double a10,double a11,double a12,
        double a20,double a21,double a22);
    Matrix3(const Matrix3 &matrix3);
    Matrix3();
    ~Matrix3();
    double Determinant();
    Matrix3 ReplaceColumn(Vec3 v,int col);
    Matrix3 ReplaceRow(Vec3 v,int row);
};
#endif