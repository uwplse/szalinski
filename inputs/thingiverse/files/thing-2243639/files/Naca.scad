// Naca foils
Naca1 = 0;
Naca2 = 0;
Naca34 = 12;

Points = 50;

ScaleX = 10;
ScaleY = 10;

Type = "Keel"; // [2D,Torpedo,Keel,Hull,Foil1,Foil2]

HullWidth = 5;
KeelHeight = 10;

/* [HIDDEN] */
// Calculations
ml = Naca1  / 100;
pl = Naca2  /  10;
dl = Naca34 / 100;

// Airfoil-Drop
a0 = 0.2969;
a1 = -0.126;
a2 = -0.3516;
a3 = 0.2843;
a4 = -0.1036;

if(Type == "2D") 2DPart();
if(Type == "Hull") Hull(HullWidth);
if(Type == "Keel") Keel(KeelHeight);
if(Type == "Torpedo") Torpedo();
if(Type == "Foil1") Foil1(KeelHeight);
if(Type == "Foil2") Foil2(KeelHeight);

module Foil1(Height){
    rotate([0,180,0]){
        translate([0,0,-Height]) rotate([0,0,270])
            linear_extrude(height=Height,scale=0.2)
               translate([-ScaleX,0]) 2DPart();
        scale(0.2) translate([0,ScaleX,0])rotate([0,0,180])Torpedo();
    }
}
module Foil2(Height){
    rotate([0,180,0]){
        translate([0,0,-Height]) rotate([0,0,90])
            linear_extrude(height=Height,scale=0.2)
                2DPart();
        scale(0.2) Torpedo();
    }
}
module Hull(Width){
    translate([0,0,0]) rotate([0,0,0]) rotate([-90,0,0])
        linear_extrude(height=Width)
            2DPart(true);
    cube([ScaleX,Width,ScaleX/10]);
}

module Keel(Height){
    translate([0,0.15*ScaleX,0]) rotate([0,0,90]) scale(0.5)
        linear_extrude(height=Height)
            2DPart();
    Torpedo();
}

module Torpedo(){
    rotate(a=[90,0,0])
        rotate_extrude(angle=180,$fn=64)
            rotate(a=[0,0,-90])
                2DPart(true);
}

// 0 to Points => 0 <= PI
function x(i) =1-cos(90*i);

function yt(i) = (dl/0.2)*(a0*sqrt(x(i))+
                         a1*x(i)+
                         a2*pow(x(i),2)+
                         a3*pow(x(i),3)+
                         a4*pow(x(i),4));

function y1(i) = (ml/pow(pl,2))*
                     (2*pl*x(i)-pow(x(i),2));
function y2(i) = (ml/pow((1-pl),2))*
                     (1-2*pl+2*pl*x(i)-pow(x(i),2));

function dy1(i) = ((2*ml)/pow(pl,2))*(pl-x(i));
function dy2(i) = ((2*ml)/pow((1-pl),2))*(pl-x(i));

function y(i) =  (x(i) < pl) ? y1(i)  : y2(i);
function dy(i) = (x(i) < pl) ? dy1(i) : dy2(i);

function theta(i) = atan(dy(i));

function xu(i) = x(i)-yt(i)*sin(theta(i));
function yu(i) = y(i)+yt(i)*cos(theta(i));

function xl(i) = x(i)+yt(i)*sin(theta(i));
function yl(i) = y(i)-yt(i)*cos(theta(i));

module 2DPart(half = false){
    p = Points;
    upper = [ 
        for (a = [0 : p])
            [xu(a/p)*ScaleX, yu(a/p)*ScaleY]];
    polygon(upper,convexity =1);
    if(!half){
        lower = [ 
            for (a = [0 : p])
                [xl(a/p)*ScaleX, yl(a/p)*ScaleY]];
            
        polygon(lower,convexity =1);
    }
}





