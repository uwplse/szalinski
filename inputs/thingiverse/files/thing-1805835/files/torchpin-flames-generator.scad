use <perlin_flames.scad>


/*[Flame]*/
//Number of flame axes (panels) to generate
num_axis = 3;

//Random seeds for the flames, one seed per axis is required
flame_seeds = [58344,34422,5345];

//Constant base height for each flame
flame_base_height = 3;

//Height for variation of flame peaks, higher values for more wild flames
flame_variation_height = 7;

//Amount rotation (degrees) of flame around the center of the base
flame_rotation = 10;



/*[Hidden]*/

//Width of the wallplate
wall_plate_width = 5;

//Height of the wallplate
wall_plate_length = 5;

//Z position offet for wallplate
wall_plate_z_offset = 0;

//Number of holes randomly generated in the flames
num_holes = 0;

//Needs not to be specified if no holes are used
hole_seeds = [584937,42343,34334,333];

//Height tolerance for connector to hole
flame_base_connector_height_tolerance = 0.5;

//Connector height of flame to handle
flame_base_connector_height = 3.0-flame_base_connector_height_tolerance;

//torch handle
//Handle's base width
handle_width = 10;
handle_length = handle_width;
handle_height = 25;



module pyramid(base_width, base_length, base_height, height, tip_type){
    pointed_end_type = "flat";
    pointed_end_size = 2.0;
    
    hull(){
        translate([base_width/-2, base_length/-2, 
        height])
        cube([
        base_width, base_length, base_height
        ], 0);
        
        if (tip_type == "round"){
            translate([0,0,0])
            sphere(pointed_end_size);
        }
        else if (tip_type == "flat"){
            translate([
            pointed_end_size/-2,
            pointed_end_size/-2,
            0])
            cube([
            pointed_end_size, 
            pointed_end_size, 
            pointed_end_size], 
            0);
        }
    }
}

module torch_pin_handle(){
    

    
    square_base_height = 0.2;
    wall_thickness = 0.4;       //as percent to volume of handle





    //Main pyramid
    color([102/255, 68/255, 0, 255/255])
    pyramid(handle_width, handle_length, square_base_height, handle_height-square_base_height, "flat");
       
    


    //torch handle
    pin_handle_radius = handle_width*0.4;
    pin_handle_height = 3;
    pin_handle_thickness = 3;
    pin_handle_z_pos = handle_height/1.75;

    wallplate_inset = 1.5;
    
    union(){
        //rim
        color("grey")
        translate([0,0,pin_handle_z_pos])
        rotate_extrude(convexity = 20, slices=1000)
        translate([pin_handle_radius-1, 0, 0])
        square([pin_handle_thickness, pin_handle_height], $fn =100);
        
        //handle wallplate
        color("grey")
        translate([pin_handle_radius + wallplate_inset,wall_plate_width *-0.5,pin_handle_z_pos - (wall_plate_length*0.5) + (pin_handle_height*0.5) + wall_plate_z_offset])
        cube([2,wall_plate_width,wall_plate_length]);
    }

    
};

module torch_pin_flames(){
    //flame base
    flame_width = 7;

    flame_base_scale = 0.85;

    flame_base_width = handle_width * 0.85;
    flame_base_length = flame_base_width;
    flame_base_thickness = 1;
    
    
    
    translate([0, 0, 0])
    union(){
        //base
        color("red")
        translate([flame_base_width * -0.5, flame_base_length * -0.5, 0])
        cube([flame_base_width,flame_base_length,flame_base_thickness],0);

                   
        
        //flames
        rotate([0,0,flame_rotation])
        for (i = [0:1:num_axis-1]){
            step_angle = 180/num_axis;
            
            color("orange")
            rotate([0,0,i*step_angle])
            translate([flame_base_width * -0.5, flame_base_length * -0.5, flame_base_thickness])
            translate([0,flame_base_length * 0.5 -0.25,0])rotate([0,0,0])scale([((flame_width-3) * 0.5)/(flame_base_width*0.235),1,1])perlin_flames(flame_base_height,flame_variation_height,flame_width,num_holes,flame_seeds[i],hole_seeds[i]);
        }
    }
}


//======================================
//1d Perlin noise generator
//Credits:
//http://www.scratchapixel.com/lessons/procedural-generation-vritual-worlds/procedural-patterns-noise-part-1/creating-simple-1D-noise


//linear interpolation
function lerp(low, high, t) = low* (1-t) + (high *t);

//linearily interpolate between two randoms
function eval(r,x) = let(xMin = floor(x))lerp(
    r[xMin], 
    r[xMin+1], 
    x-xMin
);


//generate the perlin noise
function perlin_1d(min, max, seed, num_values) = [
    let(r = rands(min, max, num_values+5, seed))
    for( i=[0:1:(num_values-1)])eval(r,i/(num_values-1) *10)
];




//print seperately
//torch_pin_handle();
translate([0,0,0])torch_pin_flames();