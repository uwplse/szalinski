    /* This project was built by Stas Wright in an effort to make 3D Printable standoffs for quad copters that's adjustable/customizable.
    This is my 2nd OpenSCAD project & the first one built for Thingiverse Customization.
    Hopefully it works, and hopefully others can improve on it.
*/

// Standoff Height
standoff_height = 6; // [0:0.1:100]

// Standoff Inner Radius 2.2 = M2, 3.2 = M3
standoff_radius = 2.2; // [0:0.1:100]

// Standoff thickness (made this customizable due to different 3D printer nozzles)
standoff_thickness = 1;  // [0:0.1:100] 

// Distance of the holes from each other.  ex 20mm x 20mm Flight Controller.
mounting_hole_distance = 30.5; // [0:0.1:500]

// Height of the arms that connect the standoffs.
connector_height = 2; // [0:0.1:100] 


/* [Hidden] */
cyl_outside_r = standoff_radius + standoff_thickness;
mnt_distance = mounting_hole_distance/2;
mnt_holes_num = 4;

difference(){
 rotate([0,0,45]){ //this rotates the connecting arms 45degress so the corners meet the standoffs.
    difference(){
          cube([mnt_distance*1.6,mnt_distance*1.6,connector_height],true);
            cube([mnt_distance*1.35,mnt_distance*1.35,connector_height],true);
            }} // This creates the inside hole.
for (i=[1:mnt_holes_num]) { //this makes sure the inside of the standoff is open.
            translate([mnt_distance*cos(i*(360/mnt_holes_num)),mnt_distance*sin(i*(360/mnt_holes_num)),0])
           cylinder(standoff_height+1,standoff_radius,standoff_radius,center=true);}}
// This is where we create the standoffs.
for (i=[1:mnt_holes_num]) {
translate([mnt_distance*cos(i*(360/mnt_holes_num)),mnt_distance*sin(i*(360/mnt_holes_num)),0])
 difference(){
 cylinder(standoff_height,cyl_outside_r,cyl_outside_r,center=true);
// this opens up the inside of the standoff.
     cylinder(standoff_height,standoff_radius,standoff_radius,center=true);
     
 }
 }
