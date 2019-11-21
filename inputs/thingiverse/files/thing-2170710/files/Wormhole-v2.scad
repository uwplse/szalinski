//Change the color of the wormhole.
red_value = .5;//[0:0.1:2]
green_value = .5;//[0:0.1:2]
blue_value = .5;//[0:0.1:2]

//Fragmented sections that make up the circle.
fn = 100; //[0:100]

//Wormhole hole diameter.
hole_diameter = 25;//

//Wormhole wall thickness | This changes the thickness of the cresent shape that is rotated to make the wormhole.
wall_thickness = 5;//[-100:100]

//Change the size in the x, y, and z directions.
scale_x = 2;//
scale_y = 2;//
scale_z = 2;//

module curve_template(){
     difference(){
           circle(20, $fn = fn);
                translate([wall_thickness,0,0]){
                    circle(20, $fn = fn);  
                }
               
     }
    
}

scale([scale_x, scale_y, scale_z]){
    color([red_value, green_value, blue_value])
    rotate_extrude(){
        translate([hole_diameter,0,0]){
            curve_template();
        }
    }
}

// by nick@midheaventech.com