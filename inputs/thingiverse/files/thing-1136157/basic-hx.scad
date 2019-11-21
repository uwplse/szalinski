// This HX design is based off of the Customizable Square Array of Cylinders
// by jpearce published Jun 19, 2013 http://www.thingiverse.com/thing:105714
// licensed CC-BY-SA 

$fn=100;

//Defines the area of the array of thermal conductors
a=90;

//Defines the radius of the columns of thermal conductors
r=0.5; 

//Defines the length of the columns of thermal conductors
l=80;

//Defines the spacing of the columns
s=10; 

//Wall thickness of fluid channel
w=3;
    
//Length of fluid passage
L=100;
    
//Width of thin side fluid passage
W=20;
    
//Width of thick side of fluid passage
X=90;

module array() {

  q = floor(a/2/s);
    for (x=[-q:q])
      for (y=[-q:q])
        translate([x*s,y*s,r/2])
          cylinder(h=l, r=r,center=true);
  }

module fluidchan() {
    //This makes a nice fluid passage   
    difference(){
        resize(newsize=[X,0,0])cylinder(h=L, r=W/2, center=true);
        resize(newsize=[X-w,0,0])cylinder(h=L+1, r=(W-w)/2, center=true);
        rotate([90,0,0])array();
    }
}
    
fluidchan();