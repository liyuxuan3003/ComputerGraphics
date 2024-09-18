#ifndef COLOR_H
#define COLOR_H

#include <cstdint>

class Color
{
public:
    uint8_t r;
    uint8_t g;
    uint8_t b;
    uint8_t a;
    Color(uint8_t r,uint8_t g,uint8_t b,uint8_t a=0xFF);
    Color(const Color &color);
    Color();
    ~Color();
    Color operator+(const Color &c);
    Color operator-(const Color &c);
    Color operator*(const Color &c);
    static Color Multi(const double &n,const Color &c);
};

#endif