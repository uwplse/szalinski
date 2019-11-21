//igus bearing-generator – fully customizable
// -Beta test - v. 0.8 - 30.12.16  Tom Krause

//Use iglidur tribofilament in order to reach similar wear-characteristics as with conventional iglidur bearings. Always lubricant-free, maintenance-free and easy to print with iglidur I150 tribofilament.

//Check this website for more information: www.igus.eu/tribofilament

//Here are some tips how to use the "bearing-generator":
    //Choose "flange", if you have axial forces.
    //Choose "slit", if the bearing should have a slit in order to mount it more easily.
    //Be aware of clearance.
    //Be aware that the real inside-diameter will be smaller than in the 3d-model.
    //Be aware of oversize at the outside-diameter. If you want to have one “press-fit”.
    //Settings at the printer: with small wall-thicknesses you may need to reduce the “parameters” to 1 and you may also need to adjust the “shell-thickness”. Otherwise changes at the 3d-model won’t affect the printed part.
//Choose with or without flange
flange="yes"; // [yes,no]
//Choose with or without slit
slit="no"; // [yes,no]
//[mm]
insidediameter=10.4;
//[mm]
outsidediameter=12.1;
//[mm]
length=10.0;
//[mm] no effect when "no flange" selected
flangediameter=15.0;
//[mm] no effect when "no flange" selected
flangethicknes=1.0;
//[mm] no effect when "no slit" selected
slit_width=1.0;
//[°] no effect when "no slit" selected
slit_angle=10; // [0,10,20]
d1=insidediameter;
d2=outsidediameter;
b1=length;
d3=flangediameter;
b2=flangethicknes;
b3=slit_width;
a=slit_angle;
if(((b2+1)>b1)&&flange=="yes")
   {translate([d3+d2+d1,0,b1+3])text("flange too thick",size=(8+(d3+d2+d1)/3));}
if((d2-d1)<1)
   {translate([d3+d2+d1,(14+(d3+d2+d1)/3),b1+3])text("increase wallthickness",size=(8+(d3+d2+d1)/3));}
if(d3<d2&&flange=="yes")
   {translate([d3+d2+d1,-(14+(d3+d2+d1)/3),b1+3])text("increase flangediameter",size=(8+(d3+d2+d1)/3));}  
    module bearing() 
{ 
    if(flange=="no") {difference() { 
    union () {cylinder(b1-0.8,d2,d2,$fn=100);translate([0,0,b1-0.8]) 
    cylinder(0.8,d2,d2-0.5,$fn=100);}
    translate([0,0,-1]) 
    cylinder(b1+2,d1,d1,$fn=100);if(slit=="yes") { translate([d2,0,b1/2-1]) rotate([a,0,0]) cube([d2*2,b3,b1*1.5+4],center=true);}}
    }
    else
        difference() { 
    union () {cylinder(b1-0.8,d2,d2,$fn=100);translate([0,0,b1-0.8]) 
    cylinder(0.8,d2,d2-0.5,$fn=100);cylinder(b2,d3,d3,$fn=100);}
    translate([0,0,-1]) 
    cylinder(b1+2,d1,d1,$fn=100);if(slit=="yes") { translate([d3,0,b1/2-1]) rotate([a,0,0]) cube([d3*2,b3,b1*1.5+4],center=true);}}   
}
bearing();