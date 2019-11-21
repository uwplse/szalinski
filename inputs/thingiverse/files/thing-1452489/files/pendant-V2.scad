/* [Main] */
//Selection (Circle or Rectangle)
choice="circle";//circle, rectangle
//Pendant Thickness(Height)
PT=2;
//Resolution
$fn = 200;

/* [Circle} */
//Pendant Radius
PR=20;//in mm

/* [Rectangle] */
//Length
L=40;//in mm
//Breadth
B=40;//in mm

/* [Text] */
//Text
print="Pendant";
//Text Size
TS=5;
//https://www.google.com/fonts [eg Liberation Sans:style=Bold Italic]
Font="Comic Sans MS";
//Text Thickness
TT=2; // in mm

/* [Advanced Text] */
// Spacing
space=1;
//Text Twist
t=0;

/* [Text Alignment] */
//Vertical
VA="center";// Eg left, right, center, or any number
//Horizontal
HA="center";//Eg top, center, bottom, baseline, or any number

/* [Keychain/Ring] */
//Height 
height=1;
//Outer Diameter
Outer_Diameter = 7;
//Inner Diameter    
Inner_Diameter = 5;
//X Position Offset
X=0;
//Y Position Offset
Y=0;
//Z Position Offset
Z=0;


//todo cut in pendant 

if(choice=="circle"||choice=="Circle"||choice=="c"){
    cylinder(PT, PR,PR);
    translate([X,PR+1+Y,Z])
    ring();
    }
    
else if(choice=="rectangle"||choice=="Rectangle"||choice=="r"){
    translate([-L/2,-B/2,0,]){
    cube([L,B,PT]);
    translate([L/2+X,B+2+Y,Z])
    ring();
    }
}


//TEXT
translate([0,0,(PT+TT)/2 ]){
linear_extrude(height=TT,twist=t){
scale([1,1,TT]){
text(print,TS,Font,halign=HA ,valign=VA,spacing=space);
    }
}
}






module ring(
        h=height,
        od = Outer_Diameter,
        id = Inner_Diameter,
        de = 0.1
        ) 
{
    difference() {
        cylinder(h=h, r=od/2);
        translate([0, 0, -de])
            cylinder(h=h+2*de, r=id/2);
    }
}