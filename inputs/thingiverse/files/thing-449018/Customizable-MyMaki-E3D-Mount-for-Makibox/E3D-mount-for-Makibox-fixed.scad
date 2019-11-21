// Mount for E3D on Makibox


e=0.0001*1; //epsilon to offset holes and ensure "Simple"
e2=2*e; // 2*episilon to add to width

//CUSTOMIZER VARIABLES

/* [Rods] */

//Channel width (mm)
rod_width = 4.2; // [3.9, 3.95, 4.0, 4.05, 4.1, 4.15, 4.2, 4.25, 4.3, 4.25, 4.4]

//Channel height (mm)
rod_height = 4.0; // [3.9, 3.95, 4.0, 4.05, 4.1, 4.15, 4.2]

//Intra-channel spacing (mm)
rod_spacing = 19.8; // [19.7, 19.75, 19.8, 19.85, 19.9, 19.95, 20.0, 20.05, 20.1, 20.15, 20.2]

//Curved or square slots
//tbc


/* [Hot-end] */

//Neck width  (mm) including tolerance
E3D_neck_width = 12.2;

//Neck height  (mm) including tolerance. Start with 5.4 for v5 and 5.8 for v6
E3D_neck_height = 5.4;

//Width of rest of lower section (mm) including tolerance
E3D_body_width = 16.2;





/* [Mount] */

//Material outside the rods (mm)
edge_material = 6;
//Material above upper rods  (mm)
top_material = 2.8;
//Material below lower rods  (mm)  Start with 3.6 for v5 and 2.2 for v6
bottom_material = 3.6;

mount_width = rod_spacing + rod_width*2 + edge_material*2;
mount_in_width= rod_spacing + rod_width*2;
mount_height= bottom_material + rod_height*2 + top_material;


//total height should be 14.4 for v5, 13.0 for v6
echo("Mount height is:",mount_height);
echo("Should be 14.4 for v5");
echo("Should be 13.0 for v6");

//Screw hole size  (mm)
screw_diameter = 3; // [1,2,3]
space_between_screwholes_and_rods = 1.5*1;

//Split into top and bottom halves to enable assembly
split_size = 0.4;



//Build Plate Type
build_plate_selector = 3*1; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//Build plate x dimension
build_plate_manual_x = 108*1; //[100:400]

//Build plate y dimension
build_plate_manual_y = 148*1; //[100:400]


//preview[view:east, tilt:top]

//CUSTOMIZER VARIABLES END


include <write/Write.scad>
include <utils/build_plate.scad>
use <Write.scad>


//
//
//


build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y); 


difference(){

// adds material below
union(){
// main blocks make a +
 translate([edge_material,0,0])cube(size = [mount_in_width,mount_width,mount_height]);
 translate([0,edge_material,0])cube(size = [mount_width,mount_in_width,mount_height]);

//bevels x 4 round out the +
for(i = [ [edge_material,edge_material,0],
           [edge_material,edge_material+mount_in_width,0],
           [edge_material+mount_in_width,edge_material,0],
           [edge_material+mount_in_width,edge_material+mount_in_width,0] ])
    translate(i)cylinder(r=edge_material,h=mount_height,$fn=40);
 

}



// removes material below
union(){

//a split between the two parts
 translate([-e,-e,bottom_material+rod_height-split_size/2-e])cube(size = [mount_width+e2,mount_width+e2,split_size+e2]);

// slots for the rods
for(i = [[0-e,edge_material-e,bottom_material-e],
           [0-e,edge_material+rod_width+rod_spacing,bottom_material-e] ])
    translate(i)cube(size = [mount_width+e2,rod_width+e2,rod_height+e2]);

//rounded alternative
//rotate([0,90,0])translate([-2,2,0])cylinder(r=2,h=40,$fn=20);
//cube(size=[40,4,2]);


for(i = [[edge_material-e,0-e,bottom_material+rod_height-e],
           [edge_material+rod_width+rod_spacing-e,0-e,bottom_material+rod_height-e] ])
    translate(i)cube(size = [rod_width+e2,mount_width+e2,rod_height+e2]);
//rotate([-90,0,0])translate([2,-2,0])cylinder(r=2,h=40,$fn=20);
//cube(size=[4,40,2]);

// screwholes x4
for(i = [ [edge_material-space_between_screwholes_and_rods,edge_material-space_between_screwholes_and_rods,0-e],
           [mount_width-edge_material+space_between_screwholes_and_rods,edge_material-space_between_screwholes_and_rods,0-e],
           [edge_material-space_between_screwholes_and_rods,mount_width-edge_material+space_between_screwholes_and_rods,0-e],
           [mount_width-edge_material+space_between_screwholes_and_rods,mount_width-edge_material+space_between_screwholes_and_rods,0-e] ])
    translate(i)cylinder(r=screw_diameter/2,h=mount_height+2*e,$fn=20);

// space for the hot-end
 translate([mount_width/2, mount_width/2,0-e])cylinder(r=E3D_body_width/2,h=mount_height-E3D_neck_height+e2,$fn=20);

 translate([mount_width/2, mount_width/4,bottom_material+rod_height+(top_material+rod_height-E3D_neck_height)/2])cube([E3D_body_width+e2,mount_width/2+e2,top_material+rod_height-E3D_neck_height+e2],center=true);

 translate([mount_width/2, mount_width/2,mount_height-E3D_neck_height-e])cylinder(r=E3D_neck_width/2,h=E3D_neck_height+e2,$fn=20);
 translate([mount_width/2, mount_width/4,mount_height-E3D_neck_height/2])cube([E3D_neck_width,mount_width/2+e2,E3D_neck_height+e2],center=true);

 translate([ mount_width*1/4,mount_width/2,(bottom_material+rod_width)/2])cube([mount_width/2,E3D_body_width,bottom_material+rod_width+split_size+e2],center=true);


// cosmetic rounding of body
for(i = [ [-mount_width,mount_width/2,0-e],
			[mount_width/2,-mount_width,0-e],
			[2*mount_width,mount_width/2,0-e],
			[mount_width/2,2*mount_width,0-e] ])
    translate(i)cylinder(r=1.05*mount_width,h=mount_height+e2,$fn=160);

// MyMaki signature
translate([mount_width-9, mount_width/2,mount_height])rotate([0,0,90])write("MyMaki",h=7,t=3, font="write/BlackRose.dxf",center=true);

} // end differences

}

