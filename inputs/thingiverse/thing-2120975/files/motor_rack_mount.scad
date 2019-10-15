
/* Rail Orientation*/
vertical = 1; //[1:Vertical,2:Horizontal]

/* Rack Rail */
rack_rail_height = 30;
rack_rail_width = 5;

rack_hole_height = 13;


/* Motor strap holes */
motor_hole_width = 5;
motor_hole_height = 30;

/* Base Plate size */
base_width = 60;
base_height = 70;


/*[Hidden]*/
rail_thickness=2;

//Holes
difference(){
    //base
    cube([base_width,base_height,2], center=true);
    
    //motor mount
    translate([-base_width/2+15,-base_height/13,0,])cube([motor_hole_width,motor_hole_height,10], center=true);
    translate([base_width/2-15,-base_height/13,0,])cube([motor_hole_width,motor_hole_height,10], center=true);
    
    //rack hole
    if (vertical == 1){
        translate([-base_width/2+rail_thickness,(base_height/2) -15 +rail_thickness,-5])cube([rack_hole_height, rack_rail_width, 10], center=false);
    }
};

//rail
module rack_rail(){
    
    
    if (vertical == 1){
        //vertical rail
        translate([-base_width/2, (base_height/2) -15,1])rotate([90,0,90])union(){
            cube([2,rack_rail_height,8], center=false);
            cube([2+rack_rail_width,rack_rail_height,2], center=false);
            translate([rail_thickness+rack_rail_width,0,0])cube([rail_thickness,rack_rail_height,8], center=false);
        };
    }
    else if (vertical == 2){
        //horizontal rail
        translate([rack_rail_height-(base_width/2), (base_height/2) -15,-1])rotate([0,0,90])union(){
            cube([2,rack_rail_height,8], center=false);
            cube([2+rack_rail_width,rack_rail_height,2], center=false);
            translate([rail_thickness+rack_rail_width,0,0])cube([rail_thickness,rack_rail_height,8], center=false);
        };
    }
};

rack_rail();
