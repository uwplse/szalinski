/* [Print Settings] */

enable_tolerance = true; // [true,false]

// Select the tolerance with layer height value to print.
tolerance = 0.1; // [0.05:Layer Height is 0.3,0.1:Layer Height is 0.2, 0.2:Layer Height is 0.1,0.3:Layer Height is 0.05]

/* [Funnel] */

funnel_outer_diameter = 34.8; // [20:0.1:60]
funnel_inner_diameter = 30.4; // [20:0.1:60]
funnel_slot_depth = 10; // [1:0.1:20]

/* [Body] */

stopper_body_height = 30;
stopper_body_diameter = 40;
stopper_body_length = 40; // [30:1:50]
stopper_plate_thick = 2; // [1:0.1:5]
stopper_plate_additional_length = 10; // [0:1:20]
stopper_plate_pulling_hole_diameter = 16; // [10:0.1:30]
stopper_plate_text = "Coffee";
stopper_plate_text_engrave_depth = 1; 
stopper_plate_text_size = 8;

/* [Bottom Tube] */


bottom_tube_diameter = 30;  // [10:0.1:50]
bottom_tube_thick = 2.5;
bottom_tube_height = 10;


/* [Hidden] */

tube_type = "Round"; // [Square:Square slot to the grinder,Round:Round slot to the grinder]
//TODO: let funnel slot also fit the square funnel.

hole_diameter = funnel_inner_diameter-4; 
stopper_plate_length = stopper_body_length + stopper_plate_additional_length;

$fn = 200;

// Update value is the tolerance trigger has on
if (enable_tolerance){
    funnel_outer_diameter = funnel_outer_diameter+(tolerance*2);
    funnel_inner_diameter = funnel_inner_diameter-(tolerance*2);
    bottom_tube_diameter = bottom_tube_diameter-(tolerance*2);
}

//
//
translate([0,0,stopper_body_diameter])
rotate([90,0,0])
union(){
    translate([0,0,-bottom_tube_height])
        createBottom(tube_type,bottom_tube_diameter, bottom_tube_thick, bottom_tube_height);
    difference(){
        createMiddle(body=[stopper_body_height,stopper_body_diameter,stopper_body_length], funnel=[funnel_outer_diameter,funnel_inner_diameter,funnel_slot_depth], tunnel=hole_diameter);
        
        translate([0,5,stopper_body_height*0.75])
        scale([1.1,1.05,1.20])
            createStopPlate(stopper_plate_thick,stopper_plate_length, stopper_body_diameter, hole_diameter, stopper_plate_pulling_hole_diameter);
    }
}

translate([stopper_body_diameter,0,0])
difference(){
    createStopPlate(stopper_plate_thick,stopper_plate_length, stopper_body_diameter, hole_diameter, stopper_plate_pulling_hole_diameter);

    linear_extrude(height=stopper_plate_thick)
    translate([0,-stopper_plate_length])
            circle(d=stopper_plate_pulling_hole_diameter);
    
    translate([0,0,stopper_plate_thick-stopper_plate_text_engrave_depth])
    linear_extrude(height=10)
    rotate([0,0,-90])
    text(text=stopper_plate_text, size=stopper_plate_text_size, valign="center",halign="left");
}


module createBottom(slot_type, diameter, thick=2, h=20){
    if (slot_type=="Round"){
        linear_extrude(height=h)
        difference(){
          circle(d=diameter, center=true);
          circle(d=diameter-thick*2, center=true);
        }
    }else if(slot_type=="Square"){
        width = diameter * cos(45);
        inner_width = (diameter - thick*2) * cos(45);
        linear_extrude(height=h)
        difference(){
          square([width,width], center=true);
          square([inner_width,inner_width], center=true);
        }
    }
}
//
module createMiddle(body=[40,40,30], funnel=[30,27,5], tunnel=25){
    
    h_body = body[0];   // height of the stopper body
    d_body = body[1];   // diameter of the body attach to the funnel
    l_body = body[2];   
    od_funnel = funnel[0];  // outer diameter of the funnel
    id_funnel = funnel[1];  // inner diameter of the funnel
    dp_funnel = funnel[2];  // funnel insert distance
    
    difference(){
        hull(){
            // Join the cyliner and cube as the shape of the body.
            cylinder(h=h_body,d=d_body,center=false);
            
            translate([0,0,h_body/2])
            rotate([90,0,0]) 
            linear_extrude(height=l_body, scale=[0.7,1])
                square(size=[d_body,h_body],center=true);
        }
        
        // make slot for funnel
        translate([0,0,h_body])
        difference(){
            cylinder(h=dp_funnel,d=od_funnel,center=true);
            cylinder(h=dp_funnel,d=id_funnel,center=true);
        }
         
        // Cut through
        translate([0,0,h_body])
        rotate([180,0,0])
        linear_extrude(height=h_body, scale=0.6)
        circle(d=tunnel,center=true);

    }
}
//
module createStopPlate(plate_thick=2, plate_length=40, body_diameter, hole_diameter, pulling_hole){
  
    adjusted_diameter = hole_diameter*0.8;
    
    linear_extrude(height=plate_thick)
    hull(){
        circle(d=adjusted_diameter,center=true);
        translate([0,-adjusted_diameter])
        square([adjusted_diameter,plate_length],center=true);
        
        
        translate([0,-plate_length])
            circle(d=adjusted_diameter); 
    }
}
