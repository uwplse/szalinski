// Licence: Creative Commons, Attribution
// Parametrized button battery clip holder

// Thingiverse user by bmcage
// Same idea as http://www.thingiverse.com/thing:48606 but 
// parametric


//what button battery should this hold
battery = "CR2032";  //[CR2032, AG13, custom]
//if custom battery, what is radius ?
custom_radius = 10; // [5:30]
//if custom battery, what is width ?
custom_width = 4; // [1:10]
//width of edges, hint: take 2*nozzle diameter of your printer
edge = 0.8;
//radius of the holes for wire
radwire = 1.2;

//how many rings at bottom to sew to
sewrings = 3; //[0:6]
//two sewholes in the sides
sidesew = "true"; //[true, false]
//two sewholes in top part too
topsew = "true";  //[true, false]

use <MCAD/fonts.scad>
//letter to ingrave in the top, first line
letter = "+"; 
//letter to ingrave in the top, second line
lettersec = "LOVE"; 

//width of letter
letterwidth = 6; // [1:10]
//height of letter
letterheight = 8; // [1:10]

//Dual print part. Top, bottom, or together. On creation of STL an stl for these 3 parts will be generated.
part = "together"; // [together, top, bottom]


//number in x direction
rack_x = 1;
//distance in rack
rack_dist_x = 60;
//number in y directionuse 
rack_y = 1;
//distance in rack
rack_dist_y = 30;

use <utils/build_plate.scad>;

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y); 


module test(){
  echo("test");
}


//process the text, we have beta_1 for the symbol, use beta_2 for border!
thisFont=8bit_polyfont();
x_shift=thisFont[0][0];
y_shift=thisFont[0][1];
theseIndicies=search(letter,thisFont[2],1,1);
wordlength = (len(theseIndicies));
theseIndiciessec=search(lettersec,thisFont[2],1,1);
wordlengthsec = (len(theseIndiciessec));

scale_x = letterwidth / x_shift;
scale_y = letterheight / y_shift;
ingrave = edge/4.*3;

//the bottom section
module divider(radius,width) {
  difference() {
    cylinder(r=radius+edge, h=edge+radwire/2,$fn=50);
    translate([-radius/2,1,0]) cylinder(r=radwire, h=edge+10,center=true,$fn=50);
    translate([radius/2,1,0]) cylinder(r=radwire, h=edge+10,center=true,$fn=50);
    translate([-radius/2, 1-radwire,edge]) cube([radius,2*radwire,2*radwire]);
    }  
  difference() {
    cylinder(r=radius+2*edge, h=edge+radwire/2+width,$fn=50);
    cylinder(r=radius, h=4*(edge+0.8+width),$fn=50, center=true);
    //translate([0, 2*radius, width+edge+radwire]) cube([4*radius, 4*radius,2*width], center = true);
    }
}

module clip(radius, width, rotated=true){
  //three legs
  for (i=[0:2]){
    rotate([0,0,i*360/3]) {
    translate([radius+edge,-1.5,edge+radwire/2+1])cube([edge,3,2]);
    translate([radius+edge+0.5,-1.5,edge+radwire/2+1]) cube([2,3,(edge+radwire/2)+width]);
    }
  }
  if (rotated){
  for (i=[0:2]){
    rotate([0,0,i*360/3+asin(3./(radius+2.5+edge))-1]) {
    translate([radius+edge,-1.5,edge+radwire/2+1])cube([edge,3,(edge+radwire/2)+width]);
    translate([radius+edge+0.5,-1.5,edge+radwire/2+1]) cube([2,3,(edge+radwire/2)+width]);
    }
  }
    
  }
}

module letter(Indi){
  for( j=[0:(len(Indi)-1)] ) 
    translate([-letterwidth/2 + j*(-letterwidth-1),0,0])
    mirror([-1,0,0])scale([scale_x,scale_y,1]){
      translate([-letterwidth/2, -letterheight/2,0])
      linear_extrude(height=ingrave) 
        polygon(points=thisFont[2][Indi[j]][6][0],paths=thisFont[2][Indi[j]][6][1]);
      }
}

//top section
module topsection(radius,width) {
  difference() {
    rotate([180,0,0])
    translate([0,0,-(edge+edge+radwire+width+1)])
  union() {
      translate([0,0,edge+edge+radwire+width+1]) 
      rotate([180,0,0]) difference()   {
        cylinder(r=radius+edge+2, h=edge+radwire/2,$fn=50);
        translate([-radius/2,1,0]) cylinder(r=radwire, h=edge+10,center=true,$fn=50);
        translate([radius/2,1,0]) cylinder(r=radwire, h=edge+10,center=true,$fn=50);
        translate([-radius/2, 1-radwire,edge]) cube([radius,2*radwire,2*radwire]);
        }
      clip(radius, width, false);
    }
  translate([len(theseIndicies)*(letterwidth+1)/2.,letterheight/2+1,-ingrave/10]) letter(theseIndicies);
  translate([len(theseIndiciessec)*(letterwidth+1)/2.,-letterheight/2-1,-ingrave/10]) letter(theseIndiciessec);
  }
    //now some rings to hang it to something
   if (topsew == "true")
    for (i=[0:1]){
      rotate([0,0,i*360/2])
        difference() {
          translate([0,radius+radwire+2*edge,0]) cylinder(r=radwire+2*edge, h=edge+radwire/2,$fn=50);
          translate([0,radius+radwire+2*edge,-0.8]) cylinder(r=radwire, h=2*(edge+0.8),$fn=50);
        }
    }
}

module bottomsection(radius, width){
 difference() {
   union() {   
    difference(){ 
      divider(radius,width);
      clip(radius, width);
    }
    //now some rings to hang it to something
    for (i=[0:sewrings]){
      rotate([0,0,i*360/sewrings])
        difference() {
          translate([0,radius+radwire+2*edge,0]) cylinder(r=radwire+2*edge, h=edge+radwire,$fn=50);
          translate([0,radius+radwire+2*edge,-0.8]) cylinder(r=radwire, h=2*(edge+0.8),$fn=50);
        }
    }
   }
   if (sidesew == "true"){
     translate([0,0,(2*edge+radwire/2+width)/2]) rotate([90,0,70])cylinder(r=radwire, h=4*radius,center=true,$fn=50);
   }
 }
}

//the ensemble
module holder(radius, width) {
  if (part == "together" || part == "top") topsection(radius,width);
  if (part == "together" || part == "bottom") 
    translate([2*(radius+4*edge+radwire),0,0]) bottomsection(radius,width);
}

if (battery == "CR2032") {
 translate([-(rack_x-1)/2 * rack_dist_x,-(rack_y-1)/2 * rack_dist_y,0])
 for (i=[1:rack_x]) {
   for (j=[1:rack_y]) {
     translate([(i-1)*rack_dist_x, (j-1)*rack_dist_y, 0])
       holder(10.8, 3.2+1);
   }
 }
}
if (battery == "AG13") {
 translate([-(rack_x-1)/2 * rack_dist_x,-(rack_y-1)/2 * rack_dist_y,0])
 for (i=[1:rack_x]) {
   for (j=[1:rack_y]) {
     translate([(i-1)*rack_dist_x, (j-1)*rack_dist_y, 0])
    holder(6, 6.3+1);
   }
 }
}
if (battery == "custom") {
 translate([-(rack_x-1)/2 * rack_dist_x,-(rack_y-1)/2 * rack_dist_y,0])
 for (i=[1:rack_x]) {
   for (j=[1:rack_y]) {
     translate([(i-1)*rack_dist_x, (j-1)*rack_dist_y, 0])
    holder(custom_radius,custom_width);
   }
 }
} 
