
/*
author: Lukas Süss aka mechadense
date: 2014  
licence: public domain 

Description:
This demo code illustrates
how the lack of any dynammic array manipulation in OpenSCAD 
effectively inhibits parametric resolution
in geometries using the polygon(...) command.
*/

// test part geometry
r0 = 3.5;
dr = 1.25; // profile depth
l  = 10;
k  = 3; // thread lead
n  = 2; // multi start
turns = l/(k*n);

roughscrew();

module roughscrew()
{
  linear_extrude(height=l,center=false,convexity=6,twist=360*turns,$fn=16)
  polygon(points=pointarray16(r0,dr,n), paths=[path16]);
}

function rr(r0,dr,n,phi) = r0 + dr*(profile1(phi*n)-1);
function profile1(x) = (1 - cos(x))/2;
function c(i) = (i/16.0)*360; // index to angle conversion

// section with necessarily hardcoded 16 vertex resolution
path16 = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
function pointarray16(r0,dr,n) = [[rr(r0,dr,n,c(0))*cos(c(0)),rr(r0,dr,n,c(0))*sin(c(0))],[rr(r0,dr,n,c(1))*cos(c(1)),rr(r0,dr,n,c(1))*sin(c(1))],[rr(r0,dr,n,c(2))*cos(c(2)),rr(r0,dr,n,c(2))*sin(c(2))],[rr(r0,dr,n,c(3))*cos(c(3)),rr(r0,dr,n,c(3))*sin(c(3))],[rr(r0,dr,n,c(4))*cos(c(4)),rr(r0,dr,n,c(4))*sin(c(4))],[rr(r0,dr,n,c(5))*cos(c(5)),rr(r0,dr,n,c(5))*sin(c(5))],[rr(r0,dr,n,c(6))*cos(c(6)),rr(r0,dr,n,c(6))*sin(c(6))],[rr(r0,dr,n,c(7))*cos(c(7)),rr(r0,dr,n,c(7))*sin(c(7))],[rr(r0,dr,n,c(8))*cos(c(8)),rr(r0,dr,n,c(8))*sin(c(8))],[rr(r0,dr,n,c(9))*cos(c(9)),rr(r0,dr,n,c(9))*sin(c(9))],[rr(r0,dr,n,c(10))*cos(c(10)),rr(r0,dr,n,c(10))*sin(c(10))],[rr(r0,dr,n,c(11))*cos(c(11)),rr(r0,dr,n,c(11))*sin(c(11))],[rr(r0,dr,n,c(12))*cos(c(12)),rr(r0,dr,n,c(12))*sin(c(12))],[rr(r0,dr,n,c(13))*cos(c(13)),rr(r0,dr,n,c(13))*sin(c(13))],[rr(r0,dr,n,c(14))*cos(c(14)),rr(r0,dr,n,c(14))*sin(c(14))],[rr(r0,dr,n,c(15))*cos(c(15)),rr(r0,dr,n,c(15))*sin(c(15))]];
