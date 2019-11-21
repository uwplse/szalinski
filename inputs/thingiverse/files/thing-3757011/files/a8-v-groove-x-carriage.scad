
// Set to 'preview' while changing paramters. Set to 'create' before clicking 'Create Thing'. Rendering will fail (timeout will be displayed), but export will work!
create_thing=0; // [0:preview, 1:create]

// center distance of the wheels
wheeldistance=30;

// center distance of the rods.
roddistance=45.5;

// CR10/mk8 mounting block
include_CR10_mount = 0; // [0:no, 1:yes]
// BLTouch mount
include_BLTouch = 0; // [0:no, 1:yes]
// E3D mount
include_E3D_mount = 0; // [0:no, 1:yes]
// Add a sensor holder to the carriage (if activated: print with support advised!) - ATTENTION: Depending on the position of your sensor holder, it may interfere with other components (e.g. cooling fan of hotend, cable chain, ...) -> Based on this fact, the sensor holder on the back of the carriage is still the recommended version (links can be found in the thing-description.)
include_sensor_holder = 0; // [0:no, 1:yes]
// E3D side fan holder
include_fan_holder = 0; // [0:no, 1:yes]

/* [Hidden] */

plate=1;
beltholder=2;
full=3;

view=1;

$fn= create_thing?50:10;

width=62;
height=88;
thickness_backplate=4;

/* [CR10-mount] */

// left/right on plate
mount_x=-20.5; // [-30:-10]
// up/down on plate
mount_y=16;    // [10:20]
// depth(height) of the mounting block
mount_depth=6; // [5:10]

/* [BLTouch] */

// left/right on plate
sensor_x=20.5;       // [10:30]
// up/down on plate
sensor_y=16;         // [10:20]

/* [E3D-mount] */

// X-Offset of hotend mounting point in mm (0mm recommended)
x_offset_hotend = 0;  // [-8:0.1:8]

// Total height of hotend (top to nozzle tip) in mm (E3Dv6: ~63mm, Some Clones: ~74mm)
hotend_height = 63; // [60:85]

/* [Fan-Holder] */

// Zip tie hole on fan holder
zip_tie_hole_fan_holder = 1; // [0:no, 1:yes]

// Fan holder offset in z-direction in mm (printer coordinate system - up/down)
z_offset_fan_holder = 0;  // [-3:0.1:10]

// Fan holder offset in x-direction in mm (printer coordinate system - left/right)
x_offset_fan_holder = 0;  // [-10:0.1:3]

// Fan holder offset in y-direction in mm (printer coordinate system - back/forth)
y_offset_fan_holder = 0; // [-10:0.1:6]

/* [Sensor-Holder] */

// X-Offset of sensor holder mounting point in mm (>0mm recommended)
x_offset_sensor = 0; // [-8:0.1:20]

// Y-Offset of sensor holder mounting point in mm (0mm recommended)
y_offset_sensor = 0; // [-2:0.1:20]

// Z-Offset of sensor holder mounting point in mm
z_offset_sensor = 0; // [-12:0.1:15]

// Select your sensor diameter (Most common: M18, M12, M8)
sensor_diameter = 18; //[6:1:20]

// Height/thickness of the sensor holder (default: 8mm)
sensor_holder_height = 8; //[5:0.1:20]

// Thickness of the wall surrounding the sensor (default: 4mm)
sensor_holder_wall_thickness = 4;  //[2:0.1:10]

/* [Hidden] */

left=-15*sqrt(4/3);
right=15*sqrt(4/3);
bottom=-height/2+6;
radius=2.4+0;


mountx=mount_x;
mounty=mount_y+bottom;
mountdepth=mount_depth;

sensorx=sensor_x;
sensory=sensor_y+bottom;

translate([width/2,height/2,0])
  union() {
    if(view==plate || view==full)
    {
     difference() {
      union() {
          Plate();
          if(include_CR10_mount)
            MountingpointCR10(mountx,mounty,mountdepth);
          if(include_BLTouch)
            sensorHolderBLTouch(sensorx, sensory);
      }
      BeltHoles();
      if(include_CR10_mount)
        MountingpointCR10Holes(mountx,mounty,mountdepth);
     }
    }
    
    
    if(view==beltholder || view==full) {
     flip = view==beltholder ? 0:180;
     rotate([0,flip,0]) {
      union() {
       translate([0,bottom+25+9,-6])
        difference() {
          // https://www.thingiverse.com/thing:2174995/
          import("Anet_a8_gt2_X_belt.stl");
        
         cube([100,20,12],center=true);
         cube([31,20,40],center=true);
        }
       translate([-23,bottom+15+7,4])
        cube([15,2,8],center=true);
       translate([-23,bottom+15+9,1])
        cube([15,4,2],center=true);
    
       translate([+23,bottom+15+7,4])
        cube([15,2,8],center=true);
       translate([+23,bottom+15+9,1])
        cube([15,4,2],center=true);
      }
     }
    }
    
    
    if(view==full) {
        bearings();
        rods();
    }

  }

// Merge z offset fan and hotend length
z_offset_fan_holder_merge = (74-hotend_height) + z_offset_fan_holder;

if(include_E3D_mount)
  MountingpointE3D(16+x_offset_hotend,37.24,13.75);

if(include_fan_holder)
  FanHolder2(x_offset_fan_holder-3,z_offset_fan_holder_merge, -y_offset_fan_holder);

if(include_sensor_holder)
                sensorHolder(65+x_offset_sensor,25+z_offset_sensor,20+y_offset_sensor,sensor_diameter,sensor_holder_height,sensor_holder_wall_thickness);
 


module Plate() {
difference() {
 linear_extrude(thickness_backplate) {
  offset(r=+2*radius)
   offset(r=-2*radius)
    square([width, height], center=true);
  }

  // lower bearings holes
   translate([left,bottom,0])
   cylinder(h=thickness_backplate,r=radius);
   translate([right,bottom,0])
   cylinder(h=thickness_backplate,r=radius);
   translate([0,bottom+wheeldistance,0])
   cylinder(h=thickness_backplate,r=radius);
  // upper bearings holes
   translate([left,bottom+wheeldistance+roddistance,0])
   cylinder(h=thickness_backplate,r=radius);
   translate([right,bottom+wheeldistance+roddistance,0])
   cylinder(h=thickness_backplate,r=radius);
 }
}

beltholex=19.05;
beltholex2=26.05;
beltholetop=bottom+39;
beltholebottom=bottom+28;

module BeltHoles() {
  translate([-beltholex2,beltholetop,0])
    cylinder(h=thickness_backplate, r=2.7/2);
  translate([+beltholex2,beltholetop,0])
    cylinder(h=thickness_backplate, r=2.7/2);

  translate([-beltholex,beltholetop,0])
    cylinder(h=thickness_backplate, r=2.7/2);
  translate([+beltholex,beltholetop,0])
    cylinder(h=thickness_backplate, r=2.7/2);

  translate([-beltholex,beltholebottom,0])
    cylinder(h=thickness_backplate, r=2.7/2);
  translate([+beltholex,beltholebottom,0])
    cylinder(h=thickness_backplate, r=2.7/2);
}

module MountingpointCR10(x_pos,y_pos,dh){
    width = 20;
    height = 6;
    holes_distance = 13.7;
    translate([x_pos,y_pos,0])
            cube([width,height,dh+thickness_backplate],
                center=false);
}
module MountingpointCR10Holes(x_pos,y_pos,dh){
    width = 20;
    height = 6;
    holes_distance = 13.7;
    translate([x_pos,y_pos,0]) {
        // Screw holes
        translate([width/2-holes_distance/2,height/2,0]){
        cylinder(h=dh+thickness_backplate, r=3/2, center=false);
        }

        translate([width/2+holes_distance/2,height/2,0]){    
        cylinder(h=dh+thickness_backplate, r=3/2, center=false); 
        }
    }
}

module sensorHolderBLTouch(x,y){
    width = 10;
    height = 3;
    depth = 28;
    holes_distance = 18;
    translate([x,y,thickness_backplate-0.01])
    difference(){  
        union()
        {
            cube([width,height,depth], center=false);  
            translate([width*.05,depth*.6,-height])
            rotate([34,0,0])
            cube([width*.9,height,depth*1.05], center=false);
        }
        
        // Screw holes
        translate([width/2,height, 2.0+depth/2-holes_distance/2]){
            rotate([-90,0,0]) {    
                cylinder(h=height*10, r=3/2, center=true);
                translate([0,0,height])
                cylinder(h=height*4,r=5/2, center=false);
            }
        }
        
        translate([width/2,height, 2.0+depth/2+holes_distance/2]){
            rotate([90,0,0])
                cylinder(h=height*10, r=3/2, center=true); 
        }
        
        // Adjustmenthole
        translate([width/2,height, 2.0+depth/2]){
            rotate([90,0,0])
                cylinder(h=height*10, r=5/2, center=true);
        }
    } 

}

module bearings() {
  z=-5.5-1;
  color("grey") {
    bearing(left,  bottom, z, 0, 0);
    bearing(right, bottom, z, 0, 0);
    bearing(0, bottom+wheeldistance, z, 0, 0);

    bearing(left,  bottom+wheeldistance+roddistance, z, 0, 0);
    bearing(right, bottom+wheeldistance+roddistance, z, 0, 0);
  }
}

module bearing(x,y,z, rx, ry) {
 translate([x,y,z])
  rotate([rx,ry,0])
   rotate_extrude($fn=50)
    polygon( points=[
        [2.5, 11/2],
        [20/2, 11/2],
        [24.5/2, 5.5/2],
        [20/2, 0],
        [24.5/2, -5.5/2],
        [20/2, -11/2],
        [2.5, -11/2],
       ] );
}

module rods() {
    color("red") {
      translate([0,bottom+wheeldistance/2,-5.5-1])
      rotate([0,90,0])
        cylinder(d=8, h=100, center=true);
      translate([0,bottom+wheeldistance/2+roddistance,-5.5-1])
      rotate([0,90,0])
        cylinder(d=8, h=100, center=true);
    }
}


module FanHolder2(offset_x, offset_y, offset_z){  
thickness = 6;  
y_lower_screw = 9.5;
z_lower_screw = 62.5;    
  
difference(){  
    
translate([offset_x-0.1, offset_y, offset_z])    
difference(){
    
    union(){
    difference(){
    union(){
        hull(){
        FanHolder_Shape([0,0,0],thickness,1,7.5,7.5,offset_y>=9.5? offset_y-9.5 : 0);
        }
        
        // Support
        FanHolder_Support();
    }
    
    hull(){
    FanHolder_Shape([0-0.1,6,-15],thickness+0.2,0.1,2,10,30);
    }
    }

    // Rounded inner edge
    inner_radius = 1;
    
    FanHolder_Shape([0,6,-15],thickness,inner_radius,3,10,30);
    
   // infill between rounded edges 
    translate([inner_radius,0,0]) rotate([0,90,0]) linear_extrude(height = thickness-inner_radius*2) projection() rotate([0,-90,0]) FanHolder_Shape([0,6,-15],thickness,inner_radius,3,10,30);
    
    }
    
    // Add screw holes
    translate([-0.1,y_lower_screw,z_lower_screw])
    rotate([0,90,0])
    cylinder(h=thickness+0.2, r=1.25);
    
    translate([-0.1,y_lower_screw+41,z_lower_screw-41])
    rotate([0,90,0])
    cylinder(h=thickness+0.2, r=1.25);
    
    // Zip tie hole fan holder
    if(zip_tie_hole_fan_holder){
        hull(){
        translate([-0.1,65,13])
        rotate([0,90,0])
        cylinder(h=thickness+0.2, r=0.75);
     
        translate([-0.1,65-2.7,13+2.7])
        rotate([0,90,0])
        cylinder(h=thickness+0.2, r=0.75);
        }
    }    
    

}

    // Cut too long bottom elements
    translate([-500,-500,-500]) cube([1000,1000,500]);
}
}

module FanHolder_Support(){
    thickness = 3;
    width = 10;

    translate([0,0.3,0])
    difference(){
    union(){
    difference(){
    
        union(){
            hull(){
            translate([28,5,-33])
            rotate([0,-14,0])
            cylinder(h=100, r=thickness/2);
            
            translate([28,5+width-thickness,-33])
            rotate([0,-14,0])
            cylinder(h=100, r=thickness/2);
            }
            
            translate([4.6,5-thickness/2,40])
            rotate([0,-14,0])
            cube([5,width,15], centering=false);
        }
        
        difference(){
        translate([7,1,40])
        rotate([-90,0,0])
        cylinder(h=width+5, r=2.9);
            
        translate([7,1,30])
        rotate([0,-14,0])
        cube([10,width+5,10], centering=false);    
        }
    }
    
    angle2 = 180;
    angle1 = 14;
    
    start = 5;
    end = 5+width-thickness;
    
    for(y_stop = [start , end])
    {
        // bend
        translate([7,y_stop,40])
        rotate([90,0,0])
        difference()
        {
        // torus
        rotate_extrude()
        translate([1.2 + thickness/2, 0, 0])
        circle(r=thickness/2);
        // lower cutout
        rotate([0, 0, angle1])
        translate([-50 * (((angle2 - angle1) <= 180)?1:0), -100, -50])
        cube([100, 100, 100]);
        // upper cutout
        rotate([0, 0, angle2])
        translate([-50 * (((angle2 - angle1) <= 180)?1:0), 0, -50])
        cube([100, 100, 100]);
        }
    }
    
    
    // infill between rounded edges 
    translate([0,5,0]) rotate([-90,0,0]) linear_extrude(height = width-thickness/2*2) projection() rotate([90,0,0]) 
    {
        // bend
        translate([7,start,40])
        rotate([90,0,0])
        difference()
        {
        // torus
        rotate_extrude()
        translate([1.2 + thickness/2, 0, 0])
        circle(r=thickness/2);
        // lower cutout
        rotate([0, 0, angle1])
        translate([-50 * (((angle2 - angle1) <= 180)?1:0), -100, -50])
        cube([100, 100, 100]);
        // upper cutout
        rotate([0, 0, angle2])
        translate([-50 * (((angle2 - angle1) <= 180)?1:0), 0, -50])
        cube([100, 100, 100]);
        }
    };
    
    
    
    
    
}
translate([-4.2,0,0])
cube([10,20,100]);
}
}

module FanHolder_Shape(offset,thickness,radius,bend1,bend2,reduceHeight = 0){

bend_radius = bend1 - radius*2;   
bend_radius2 = bend2 - radius*2;     
    
// Leave like this   
angle_1 = 0;
angle_2 = 135;
angle_3 = 180;
length_1 =75;
length_2 =80-(reduceHeight/cos(angle_2-90));
length_3 =20+reduceHeight;

start = (0+radius);
end  = (thickness-radius);

union(){
for(x_stop = [start , end])
{
translate([offset[0]+x_stop,10+offset[1],60+offset[2]])    
rotate([90,0,-90])    
union() {
// lower arm
rotate([0, 0, angle_1])
translate([bend_radius + radius, 0.02, 0])
rotate([90, 0, 0])
cylinder(r=radius, h=length_1+0.04);

// middle arm
rotate([0, 0, angle_2])
translate([bend_radius + radius, -0.02, 0])
rotate([-90, 0, 0])
cylinder(r=radius, h=length_2+0.04);

// upper arm
translate([-sin(angle_2)*length_2+ cos(angle_2)*(bend_radius - bend_radius2),cos(angle_2)*length_2+ sin(angle_2)*(bend_radius - bend_radius2),0])
rotate([0, 0, angle_3])
translate([bend_radius2 + radius, -0.02, 0])
rotate([-90, 0, 0])
cylinder(r=radius, h=length_3+0.04);
// bend
difference()
{
// torus
rotate_extrude()
translate([bend_radius + radius, 0, 0])
circle(r=radius);
// lower cutout
rotate([0, 0, angle_1])
translate([-50 * (((angle_2 - angle_1) <= 180)?1:0), -100, -50])
cube([100, 100, 100]);
// upper cutout
rotate([0, 0, angle_2])
translate([-50 * (((angle_2 - angle_1) <= 180)?1:0), 0, -50])
cube([100, 100, 100]);
}

// bend2
translate([-sin(angle_2)*length_2 + cos(angle_2)*(bend_radius - bend_radius2),cos(angle_2)*length_2 + sin(angle_2)*(bend_radius - bend_radius2),0])
difference()
{
// torus
rotate_extrude()
translate([bend_radius2 + radius, 0, 0])
circle(r=radius);
// lower cutout
rotate([0, 0, angle_2])
translate([-50 * (((angle_3 - angle_2) <= 180)?1:0), -100, -50])
cube([100, 100, 100]);
// upper cutout
rotate([0, 0, angle_3])
translate([-50 * (((angle_3 - angle_2) <= 180)?1:0), 0, -50])
cube([100, 100, 100]);

}
}
}
}   
}

module MountingpointE3D(x_pos,y_pos,dh){
    width = 30;
    height = 12.68;
    height_upper_ring_hotend = 3.8;
    height_ring_rinse = 5.88;
    
    translate([x_pos,y_pos,thickness_backplate-0.01])
    difference(){  
        union()
        {            
            cube([width,height,dh], center=false);  
        }
        
        // Screw holes
        translate([4,height/2,0.1])    
   cylinder(h=dh, r=2.83/2, center=false); 
        
        translate([width-4,height/2,0.1])    
   cylinder(h=dh, r=2.83/2, center=false); 
        
        // Mounting clip
        translate([width/2,-1,dh]) 
        rotate([-90,0,0])
   cylinder(h=height-height_ring_rinse-height_upper_ring_hotend+1, r=8.17, center=false); 
        
        translate([width/2,height-height_upper_ring_hotend,dh]) 
        rotate([-90,0,0])
   cylinder(h=height_upper_ring_hotend+1, r=8.17, center=false);
        
        translate([width/2,-1,dh]) 
        rotate([-90,0,0])
   cylinder(h=height+2, r=6, center=false); 
    } 
}

///

module sensorHolder(x,y,z,dia,thickness,wall){
    
    difference(){
        union(){
            hull(){
                translate([x,y,z])
                    rotate([90,0,0])
                        cylinder(r=dia/2+wall, h=thickness);   
                
                // Position on left in carriage
                translate([50,y,wall/2+0.1])
                    rotate([90,0,0])
                        cylinder(r=wall/2, h=thickness);
            
                // Position on right in carriage
                translate([60,y,wall/2+0.1])
                    rotate([90,0,0])
                        cylinder(r=wall/2, h=thickness);
                
            }
        }
        
        translate([x,y+1,z])
                rotate([90,0,0])
                    cylinder(r=dia/2, h=thickness+2);
        
        
    }
    
}



