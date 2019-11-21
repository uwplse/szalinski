base_z = 60;
base_x = 180;
base_y = 120;

shelf_z = 30;
shelf_x = base_x;
shelf_y = 32;

wall_thickness = 5;

translate([0,shelf_y,0]) {
    //base cube
    difference(){
        cube([base_x,base_y-shelf_y,wall_thickness]);   
        cable_opening_x = 20;
        cable_opening_y = 30;
        //cable opening in base cube
        translate([base_x/2-cable_opening_x/2, (base_y-shelf_y)/2 - cable_opening_y/2,0]){
            cube([cable_opening_x,cable_opening_y,wall_thickness]); 
        }
    } 
}


translate([0,shelf_y,0]) {
    //left wall
    difference(){
        color("red")
        cube([wall_thickness,base_y-shelf_y,base_z]);     
        cable_opening_y = 40;
        cable_opening_z = 25;
        //cable opening in left wall
        translate([0, (base_y-cable_opening_y-shelf_y)/2, base_z - cable_opening_z - wall_thickness]){
            cube([wall_thickness,cable_opening_y,cable_opening_z]); 
        }
    }    
}

translate([base_x-wall_thickness,shelf_y,0]) {
    //right wall
    cube([wall_thickness,base_y-shelf_y,base_z]);        
}

translate([0,0,shelf_z]) {
    color("green")
    //shelf base    
    cube([shelf_x,shelf_y+wall_thickness,wall_thickness]);       
}

translate([0,shelf_y,0]) {
    //shelf front wall upper
    difference(){
        color("green")
        cube([shelf_x,wall_thickness,shelf_z]);     
        cable_opening_x = 20;
        cable_opening_z = 15;
        //cable opening in front upper wall
        translate([shelf_x/2-cable_opening_x/2, 0,shelf_z - cable_opening_z]){
            cube([cable_opening_x,wall_thickness,cable_opening_z]); 
        }
    }
}

translate([0,0,shelf_z]) {
    color("green")
    //shelf front wall lower
    cube([shelf_x,wall_thickness,shelf_z]);       
}

translate([shelf_x- wall_thickness,0,shelf_z]) {
    //shelf right wall
    cube([wall_thickness,shelf_y,base_z-shelf_z]);        
}

translate([0,0,shelf_z]) {
    color("red")
    //shelf left wall
    cube([wall_thickness,shelf_y,base_z-shelf_z]);        
}

module base_screw_plate(plate_size=7, screw_size=3, plate_thickness=3, x,y){
    screw_plate_size = 7;
    screw_plate_thickness = 3;
    translate([x,y,base_z-screw_plate_thickness]) {
        difference(){
            color("blue")
            //base_screw_hole 
            cube([screw_plate_size, screw_plate_size , screw_plate_thickness]);
            color("red")
            translate([screw_plate_size/2, screw_plate_size/2, 0]){
                cylinder (h = screw_plate_thickness, r=1.5);
            }
        }   
    }
}

base_screw_plate(x = base_x/2, y = wall_thickness);
base_screw_plate(x = wall_thickness, y = wall_thickness);
base_screw_plate(x = wall_thickness, y = base_y-7);
base_screw_plate(x = base_x - 12, y = wall_thickness);
base_screw_plate(x = base_x - 12, y = base_y-7);
