#include "Matrix3.h"

Matrix3::Matrix3(
    double a00,double a01,double a02,
    double a10,double a11,double a12,
    double a20,double a21,double a22)
{
    a[0][0]=a00;
    a[0][1]=a01;
    a[0][2]=a02;
    a[1][0]=a10;
    a[1][1]=a11;
    a[1][2]=a12;
    a[2][0]=a20;
    a[2][1]=a21;
    a[2][2]=a22;
}

Matrix3::Matrix3(const Matrix3 &matrix3)
{
    for(int i=0;i<3;i++)
        for(int j=0;j<3;j++)
            a[i][j]=matrix3.a[i][j];
}

Matrix3::Matrix3()
{

}

Matrix3::~Matrix3()
{
    
}

double Matrix3::Determinant()
{
    return 
        +a[0][0]*a[1][1]*a[2][2]
        +a[1][0]*a[2][1]*a[0][2]
        +a[2][0]*a[0][1]*a[1][2]
        -a[2][0]*a[1][1]*a[0][2]
        -a[1][0]*a[0][1]*a[2][2]
        -a[0][0]*a[2][1]*a[1][2];
}

Matrix3 Matrix3::ReplaceColumn(Vec3 v,int col)
{
    Matrix3 m=(*this);
    m.a[0][col]=v.x;
    m.a[1][col]=v.y;
    m.a[2][col]=v.z;
    return m;
}

Matrix3 Matrix3::ReplaceRow(Vec3 v,int row)
{
    Matrix3 m=(*this);
    m.a[row][0]=v.x;
    m.a[row][1]=v.y;
    m.a[row][2]=v.z;
    return m;
}