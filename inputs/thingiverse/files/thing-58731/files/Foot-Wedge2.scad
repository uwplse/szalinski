//Customizable Foot Wedge

//Variables
// Define the width of your heel
heel_width =80; //Numeric value of heel width 

//Define the length of the wedge past your heel
l=70; //Length of the cube

//Define the height of the front of the wedge
h=5; //Numeric value of height of insert from front of wedge

//Define the angle of the wedge
wedge_angle=10; //[0:20]

//Calculated variables
r=heel_width/2; //Radius of the Circle
total_l = r+l; //Total Length


foot_wedge();

module foot_wedge(){
difference(){
union(){
translate([r,l,0])cylinder(h*2+l*tan(wedge_angle),r,r, $fs=1);
translate([0,0,0])cube([r*2,l,h*2+l*tan(wedge_angle)]);
}
translate([-1,0,h])rotate([wedge_angle,0,0])cube([r*2+10,total_l*2,h*2+l*tan(wedge_angle)]);
translate([0,-total_l,-1])cube([r*2,total_l,(h*2+l*tan(wedge_angle))+2]);
}
}

