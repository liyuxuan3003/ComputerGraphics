#include "Color.h"

Color::Color(uint8_t r,uint8_t g,uint8_t b,uint8_t a)
{
    this->r=r;
    this->g=g;
    this->b=b;
    this->a=a;
}

Color::Color(const Color &color)
{
    this->r=color.r;
    this->g=color.g;
    this->b=color.b;
    this->a=color.a;
}

Color Color::operator+(const Color &c)
{
    return Color(r+c.r, g+c.g, b+c.b, a);
}

Color Color::operator-(const Color &c)
{
    return Color(r-c.r, g-c.g, b-c.b, a);
}

Color Color::operator*(const Color &c)
{
    return Color(
        int(r)*int(c.r)/(255),
        int(g)*int(c.g)/(255),
        int(b)*int(c.b)/(255),
        a
    );
}

Color Color::Multi(const double &n,const Color &c)
{
    return Color(c.r*n, c.g*n, c.b*n, c.a);
}

Color::Color()
{

}

Color::~Color()
{
    
}