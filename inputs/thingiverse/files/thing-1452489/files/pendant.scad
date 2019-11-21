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


//todo cut in pendant 

if(choice=="circle"||choice=="Circle"||choice=="c"){
    cylinder(PT, PR,PR);
    translate([0,PR+1,0])
    ring();
    }
    
else if(choice=="rectangle"||choice=="Rectangle"||choice=="r"){
    translate([-L/2,-B/2,0,]){
    cube([L,B,PT]);
    translate([B/2,B+2,0])
    ring();
    }
}



translate([0,0,(PT+TT)/2 ]){
linear_extrude(height=TT,twist=t){
scale([1,1,TT]){
text(print,TS,Font,halign=HA ,valign=VA,spacing=space);
    }
}
}






module ring(
        h=1,
        od = 7,
        id = 5,
        de = 0.1
        ) 
{
    difference() {
        cylinder(h=h, r=od/2);
        translate([0, 0, -de])
            cylinder(h=h+2*de, r=id/2);
    }
}