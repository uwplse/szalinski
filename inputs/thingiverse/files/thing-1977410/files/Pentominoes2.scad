// Title: Pentoninoes
// Author: http://www.thingiverse.com/Jinja
// Date: 17-12-2016

/////////// START OF PARAMETERS /////////////////

// The width of the squares in mm
pixelSide = 10;

// The height of the pieces in mm
pixelHeight = 2; 

// The depth of the hole in each piece in mm
holeDepth = 1; 

// The width of the border in mm
pixelBorder = 2; 

// How many mm to shrink the border so there is space between the pieces
shrinkage = 0.25; 

piece1 = 1; // [0:Hide,1:Show]
piece2 = 1; // [0:Hide,1:Show]
piece3 = 1; // [0:Hide,1:Show]
piece4 = 1; // [0:Hide,1:Show]
piece5 = 1; // [0:Hide,1:Show]
piece6 = 1; // [0:Hide,1:Show]
piece7 = 1; // [0:Hide,1:Show]
piece8 = 1; // [0:Hide,1:Show]
piece9 = 1; // [0:Hide,1:Show]
piece10 = 1; // [0:Hide,1:Show]
piece11 = 1; // [0:Hide,1:Show]
piece12 = 1; // [0:Hide,1:Show]
piece13 = 1; // [0:Hide,1:Show]
piece14 = 1; // [0:Hide,1:Show]
piece15 = 1; // [0:Hide,1:Show]
piece16 = 1; // [0:Hide,1:Show]
piece17 = 1; // [0:Hide,1:Show]
piece18 = 1; // [0:Hide,1:Show]

/////////// END OF PARAMETERS /////////////////


$fs=0.3*1.0;
$fa=6.0*1.0; //smooth
//$fa=20; //rough

if(piece1)
{
    Piece1();
}
if(piece2)
{
    translate([pixelSide*2.1,-pixelSide*1.1,0])
    Piece2();
}
if(piece3)
{
    translate([-0.1*pixelSide,pixelSide*2.1,0])
    Piece3();
}
if(piece4)
{
    translate([-1.2*pixelSide,pixelSide*3.2,0])
    Piece4();
}
if(piece5)
{
    translate([-0.1*pixelSide,pixelSide*4.3,0])
    Piece5();
}
if(piece6)
{
    translate([2.1*pixelSide,pixelSide*3.4,0])
    Piece6();
}
if(piece7)
{
    translate([3.2*pixelSide,pixelSide*-1.1,0])
    Piece7();
}
if(piece8)
{
    translate([3.2*pixelSide,pixelSide*3.4,0])
    Piece8();
}
if(piece9)
{
    translate([5.3*pixelSide,pixelSide*0,0])
    Piece9();
}
if(piece10)
{
    translate([5.4*pixelSide,pixelSide*2.1,0])
    Piece10();
}
if(piece11)
{
    translate([6.5*pixelSide,pixelSide*3.2,0])
    Piece11();
}
if(piece12)
{
    translate([5.4*pixelSide,pixelSide*4.3,0])
    Piece12();
}
if(piece13)
{
    translate([8.6*pixelSide,pixelSide*2.3,0])
    Piece13();
}
if(piece14)
{
    translate([8.4*pixelSide,pixelSide*-0,0])
    Piece14();
}
if(piece15)
{
    translate([10.5*pixelSide,pixelSide*-1.1,0])
    Piece15();
}
if(piece16)
{
    translate([10.7*pixelSide,pixelSide*2.2,0])
    Piece16();
}
if(piece17)
{
    translate([10.8*pixelSide,pixelSide*3.3,0])
    Piece17();
}
if(piece18)
{
    translate([12.9*pixelSide,pixelSide*3.7,0])
    Piece18();
}



module Piece1()
{
    Pixel(0,0, 0,1,0,1,0,1,1,1);
    Pixel(1,0, 0,1,1,1,1,1,1,1);
    Pixel(0,1, 1,1,1,1,1,1,0,1);
    Pixel(-1,0, 1,1,1,1,0,1,0,1);
    Pixel(-1,-1, 1,1,0,1,1,1,1,1);
}

module Piece2()
{
    Pixel(0,0, 0,1,0,1,1,1,1,1);
    Pixel(0,1, 1,1,0,1,1,1,0,1);
    Pixel(0,2, 1,1,0,1,1,1,0,1);
    Pixel(0,3, 1,1,1,1,1,1,0,1);
    Pixel(-1,0, 1,1,1,1,0,1,1,1);
}

module Piece3()
{
    Pixel(0,0, 0,1,1,1,0,1,1,1);
    Pixel(1,0, 0,1,0,1,1,1,1,1);
    Pixel(1,1, 1,1,1,1,1,1,0,1);
    Pixel(-1,0, 1,1,1,1,0,1,0,1);
    Pixel(-1,-1, 1,1,0,1,1,1,1,1);
}

module Piece4()
{
    Pixel(0,0, 0,0,0,1,0,1,1,1);
    Pixel(1,0, 0,1,1,1,1,1,1,1);
    Pixel(0,1, 0,1,1,1,1,1,0,0);
    Pixel(-1,0, 1,1,0,0,0,1,1,1);
    Pixel(-1,1, 1,1,1,1,0,0,0,1);
}

module Piece5()
{
    Pixel(0,0, 1,1,0,1,0,1,1,1);
    Pixel(1,0, 0,1,1,1,1,1,1,1);
    Pixel(0,1, 0,1,1,1,1,1,0,1);
    Pixel(-2,1, 1,1,1,1,0,1,1,1);
    Pixel(-1,1, 0,1,1,1,0,1,1,1);
}

module Piece6()
{
    Pixel(0,0, 1,1,0,1,1,1,1,1);
    Pixel(0,1, 1,1,0,1,1,1,0,1);
    Pixel(0,2, 0,1,0,1,1,1,0,1);
    Pixel(0,3, 1,1,1,1,1,1,0,1);
    Pixel(-1,2, 1,1,1,1,0,1,1,1);
}

module Piece7()
{
    scale([-1,1,1])
    Piece2();
}

module Piece8()
{
    scale([-1,1,1])
    Piece6();
}

module Piece9()
{
    scale([-1,1,1])
    Piece1();
}

module Piece10()
{
    scale([-1,1,1])
    Piece3();
}

module Piece11()
{
    scale([-1,1,1])
    Piece4();
}

module Piece12()
{
    scale([-1,1,1])
    Piece5();
}

module Piece13()
{
    Pixel(0,0, 1,1,0,1,1,1,1,1);
    Pixel(0,1, 1,1,0,1,1,1,0,1);
    Pixel(0,2, 1,1,0,1,1,1,0,1);
    Pixel(0,3, 1,1,0,1,1,1,0,1);
    Pixel(0,4, 1,1,1,1,1,1,0,1);
}

module Piece14()
{
    Pixel(0,0, 0,1,0,1,1,1,1,1);
    Pixel(1,1, 0,1,1,1,1,1,1,1);
    Pixel(0,1, 1,1,1,1,0,1,0,1);
    Pixel(-1,0, 1,1,1,1,0,1,0,1);
    Pixel(-1,-1, 1,1,0,1,1,1,1,1);
}

module Piece15()
{
    Pixel(0,0, 0,1,1,1,0,1,1,1);
    Pixel(1,0, 0,1,0,1,1,1,1,1);
    Pixel(1,1, 1,1,1,1,1,1,0,1);
    Pixel(-1,0, 1,1,0,1,0,1,1,1);
    Pixel(-1,1, 1,1,1,1,1,1,0,1);
}

module Piece16()
{
    Pixel(0,0, 0,1,1,1,0,1,1,1);
    Pixel(1,0, 0,1,1,1,1,1,1,1);
    Pixel(-1,2, 1,1,1,1,1,1,0,1);
    Pixel(-1,0, 1,1,0,1,0,1,1,1);
    Pixel(-1,1, 1,1,0,1,1,1,0,1);
}

module Piece17()
{
    Pixel(0,0, 1,1,0,1,1,1,1,1);
    Pixel(0,1, 1,1,0,1,1,1,0,1);
    Pixel(0,2, 0,1,1,1,0,1,0,1);
    Pixel(1,2, 0,1,1,1,1,1,1,1);
    Pixel(-1,2, 1,1,1,1,0,1,1,1);
}

module Piece18()
{
    Pixel(0,0, 0,1,0,1,0,1,0,1);
    Pixel(1,0, 0,1,1,1,1,1,1,1);
    Pixel(0,1, 1,1,1,1,1,1,0,1);
    Pixel(-1,0, 1,1,1,1,0,1,1,1);
    Pixel(0,-1, 1,1,0,1,1,1,1,1);
}


module Pixel( x, y, s1, s2, s3, s4, s5, s6, s7, s8 )
{
    translate([x*pixelSide, y*pixelSide,0])
    difference()
    {
        cube([pixelSide,pixelSide,pixelHeight],true);
        //translate([0,0,0.5*pixelHeight])
        union()
        {
            translate([0,0,pixelHeight-holeDepth])
            cube([pixelSide-2*pixelBorder,pixelSide-2*pixelBorder,pixelHeight],true);
            if(!s1)
            {
                translate([-pixelBorder,0,pixelHeight-holeDepth])
                cube([pixelSide-2*pixelBorder,pixelSide-2*pixelBorder,pixelHeight],true);
            }
            else
            {
                translate([-(pixelSide-shrinkage),0,0])
                cube([pixelSide,pixelSide,pixelHeight],true);
            }

            if(!s2)
            {
                translate([-(pixelSide-pixelBorder),(pixelSide-pixelBorder),pixelHeight-holeDepth])
                cube([pixelSide,pixelSide,pixelHeight],true);
            }

            if(!s3)
            {
                translate([0,pixelBorder,pixelHeight-holeDepth])
                cube([pixelSide-2*pixelBorder,pixelSide-2*pixelBorder,pixelHeight],true);
            }
            else
            {
                translate([0,(pixelSide-shrinkage),0])
                cube([pixelSide,pixelSide,pixelHeight],true);
            }


            if(!s4)
            {
                translate([(pixelSide-pixelBorder),(pixelSide-pixelBorder),pixelHeight-holeDepth])
                cube([pixelSide,pixelSide,pixelHeight],true);
            }

            if(!s5)
            {
                translate([pixelBorder,0,pixelHeight-holeDepth])
                cube([pixelSide-2*pixelBorder,pixelSide-2*pixelBorder,pixelHeight],true);
            }
            else
            {
                translate([(pixelSide-shrinkage),0,0])
                cube([pixelSide,pixelSide,pixelHeight],true);
            }


            if(!s6)
            {
                translate([(pixelSide-pixelBorder),-(pixelSide-pixelBorder),pixelHeight-holeDepth])
                cube([pixelSide,pixelSide,pixelHeight],true);
            }

            if(!s7)
            {
                translate([0,-pixelBorder,pixelHeight-holeDepth])
                cube([pixelSide-2*pixelBorder,pixelSide-2*pixelBorder,pixelHeight],true);
            }
            else
            {
                translate([0,-(pixelSide-shrinkage),0])
                cube([pixelSide,pixelSide,pixelHeight],true);
            }


            if(!s8)
            {
                translate([-(pixelSide-pixelBorder),-(pixelSide-pixelBorder),pixelHeight-holeDepth])
                cube([pixelSide,pixelSide,pixelHeight],true);
            }
            
            if(s8!=0)
            {
                translate([-(pixelSide-shrinkage)*0.5,-(pixelSide-shrinkage)*0.5,0])
                cube([shrinkage,shrinkage,pixelHeight],true);
            }

            if(s6!=0)
            {
                translate([(pixelSide-shrinkage)*0.5,-(pixelSide-shrinkage)*0.5,0])
                cube([shrinkage,shrinkage,pixelHeight],true);
            }

            if(s4!=0)
            {
                translate([(pixelSide-shrinkage)*0.5,(pixelSide-shrinkage)*0.5,0])
                cube([shrinkage,shrinkage,pixelHeight],true);
            }

            if(s2!=0)
            {
                translate([-(pixelSide-shrinkage)*0.5,(pixelSide-shrinkage)*0.5,0])
                cube([shrinkage,shrinkage,pixelHeight],true);
            }

        }
    }
}
