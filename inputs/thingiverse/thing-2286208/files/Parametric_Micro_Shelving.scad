// Brian's Micro Shelving

// Pick which parts to create
part = "all";  // [all:All,base:Base,top_shelf:Top Shelf,legs:Legs]
retaining_wall_width = 1.25;

/* [Base Shelf and Device Dimensions] */
// Base Shelf Device Width
bd_width = 120;
// Base Shelf Device Depth
bd_depth = 60;
// Base Shelf Device Height
bd_height = 30;
// Base Shelf Device Retaining Wall (true or false)
bd_retaining_wall = 0; //[0:True,1:False]
// Base Shelf Device Retaining Wall Length
bd_retaining_wall_length = 10;
// Base Shelf Device Retaining Wall Height
bd_retaining_wall_height = 6;

/* [Top shelf and Device Dimensions] */
// Top shelf Device Width
tsd_width = 140;
// Top shelf Device Depth
tsd_depth = 135;
// Top shelf Device Height
tsd_height =  25;
// Top shelf Device Retaining Wall
tsd_retaining_wall = 0; //[0:True,1:False]
// Top shelf Device Retaining Wall Length
tsd_retaining_wall_length = 7; //Retaining Wall Length
// Top shelf Device Retaining Wall Height
tsd_retaining_wall_height = 8;  //Retaining Wall Height 


/* [Hidden] */
leg_x = 4;
leg_y = 4;
leg_hole_x = leg_x + .2;
leg_hole_y = leg_x + .2;
leg_hole_border = 3;
base_z = 5;
base_x = ((max(bd_width, tsd_width) + (leg_hole_x * 2) + (leg_hole_border * 4) + (retaining_wall_width * 2)));
base_y = ((max(bd_depth, tsd_depth) + (leg_hole_y * 2) + (retaining_wall_width * 2)));
leg_z = bd_height + 8;


print_micro_shelf();


module print_micro_shelf(){
if (part == "all"){
        // Print base, Shelf, and legs
        print_all();
    } else if (part == "base"){
        // Print base
        print_base();
    } else if (part == "top_shelf"){
        // Print top shelf
        print_topshelf();
    } else if (part == "legs") {
        // Print legs
        print_legs();
    } else {
        // all Parts
        print_all();
    }
}


module print_all(){
    base();
    topshelf();
    legs();
}

module print_base(){
    base();
}

module print_topshelf(){
    topshelf();
}

module print_legs(){
    legs();
}

module base(){
    // Base
    shelf(base_x, base_y, base_z);
    if (bd_retaining_wall == 0) {translate([((base_x - bd_width)/2),((base_y - bd_depth)/2),base_z]) retaining_wall(bd_retaining_wall_height, bd_retaining_wall_length, bd_width, bd_depth);}
}

module topshelf(){
    // Top shelf
    rotate([180,0,0]) translate([0,10,(-base_z+1)]) shelf(base_x, base_y, (base_z-1));
    if (tsd_retaining_wall == 0) {translate([((base_x - tsd_width)/2),(((base_y - tsd_depth)/2)- (base_y+10)) , (base_z-1)]) retaining_wall(tsd_retaining_wall_height, tsd_retaining_wall_length, tsd_width, tsd_depth);}
    }


module legs(){
    //legs
    translate([(base_x + 10), 80, 0]) cube ([leg_x, leg_z, leg_y]);
    translate([(base_x + 10), (80 + (-5 - leg_z)), 0]) cube ([leg_x, leg_z, leg_y]);
    translate([(base_x + 24), 80, 0]) cube ([leg_x, leg_z, leg_y]);
    translate([(base_x + 24), (80 + (-5 - leg_z)), 0]) cube ([leg_x, leg_z, leg_y]);
}


// Shelf 
module shelf(shelf_x, shelf_y, shelf_z){
leg_hole_z = shelf_z - 1;
difference(){
cube([shelf_x, shelf_y, shelf_z]);
translate([leg_hole_border, leg_hole_border, (shelf_z - leg_hole_z)]) 
    cube([leg_hole_x, leg_hole_y, (leg_hole_z)]);    
translate([(shelf_x - leg_hole_x - leg_hole_border),leg_hole_border, (shelf_z - leg_hole_z)]) 
    cube([leg_hole_x, leg_hole_y, (leg_hole_z)]);    
translate([leg_hole_border,(base_y - leg_hole_y - leg_hole_border), (shelf_z - leg_hole_z)]) 
    cube([leg_hole_x, leg_hole_y, (leg_hole_z)]);    
translate([(shelf_x - leg_hole_x - leg_hole_border), (shelf_y - leg_hole_y - leg_hole_border), (shelf_z - leg_hole_z)])
    cube([leg_hole_x, leg_hole_y, (leg_hole_z)]);    
   }
}


// Retaining wall
module retaining_wall(rw_height, border, device_x, device_y){    
  difference(){
    cube([(device_x+(2*retaining_wall_width)), (device_y+(2*retaining_wall_width)), rw_height]);
    translate([retaining_wall_width,retaining_wall_width,0]) cube([device_x, device_y, (rw_height+5)]);
    translate([0,border,0]) cube([retaining_wall_width,(device_y - (2*border)),rw_height]);
    translate([border,0,0]) cube([(device_x - (2*border)), retaining_wall_width, rw_height]); 
    translate([(device_x+retaining_wall_width),border,0]) cube([retaining_wall_width,(device_y - (2*border)),rw_height]);  
    translate([border,(device_y+retaining_wall_width),0]) cube([(device_x - (2*border)), retaining_wall_width, rw_height]); 
  }
}

