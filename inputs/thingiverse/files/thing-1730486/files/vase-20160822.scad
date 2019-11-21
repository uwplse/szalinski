//General Parameters Basic

//Do you want your vase to be solid (for use of slicer vase mode)
filling = "no"; //[yes,no]
//Outer Radius of the Base in mm
radius = 50; //[10:300]
//Total Height of the Vase in mm
height = 150; //[30:600] 
//number of sides that make up the outside (bigger then 3)
sides = 13; //
//Thickness of the Vase
thickness = 2; //[1:50]
//Degrees the top is twistes in realation to the base
degree_twist = 90; //[0:360]
//If twisted, of how many slices shall the vase consist
number_slices = 3; //[0:100]
//Factor of how much smaller/biller the top is in realation to the base
distortion = 1.9; // [0.1:5]
//How thick the buttom will be in mm
buttom = 3; 
//how tall straight top part is in mm
top = 10; 
//Do you want to have a twistes Vase?
twisting = "yes"; // [yes,no] 
//Do you want to have holes in the side of your Vase?
perforating = "no"; // [yes,no]


//Parameters for Holes
//Distance from the buttom to lowest Hole in mm
lower = 5; //[0:600]
//Distance from the tro straight part to highest hole in mm
upper = 5;  //[0:600
//Radius of the Holes
hole_radius = 3; //[0.5:30]
//How many holes shall there be in one plane (is a multiple of 2)
number_of_holes = 13; //[1:50]
//How many Sides shall the Holes have (Bigger number == cicles)
sides_holes = 8; //[3:100]
// Distance between Holes in mm
row_distance = 1; 


//General Calculated Values
inner_radius = radius - thickness; 
extrude_height = height - buttom - top;

//Hole Calculations
degree_holes  =360/number_of_holes;
row_height=row_distance+(2*hole_radius);
free_edge = height - lower - upper;
rest = free_edge % (row_height);
height_holes= free_edge - rest; //Height that can b used for holes
number_of_rows = height_holes/row_height-1;


hole_start = buttom+lower+hole_radius;



module Rim(solid){
difference(){
    circle(r=radius, $fn=sides);
    if(solid=="no"){
        circle(r=inner_radius, $fn = sides);
        }
    }
}



module extruded(rot){
    //Boden
    linear_extrude(height = buttom)Rim(solid="yes");

    if(rot=="yes"){
    //Oben
    translate([0,0,buttom+extrude_height])
    scale(v=[distortion,distortion,1])
    rotate([0,0,-degree_twist])
    linear_extrude(height = top)Rim(solid="no");

    //Rand
    translate([0,0,buttom])
    linear_extrude(height = extrude_height, twist=degree_twist, slices = number_slices, scale = distortion) Rim(solid="no");
    }
    
    
    if(rot=="no"){
        //Oben
    translate([0,0,buttom+extrude_height])
    scale(v=[distortion,distortion,1])
    linear_extrude(height = top)Rim(solid="no");

    //Rand
    translate([0,0,buttom])
    linear_extrude(height = extrude_height, scale = distortion) Rim(solid="no");
        }
    }



module extruded_filled(rot){
    //Boden
    linear_extrude(height = buttom)Rim(solid="yes");

    if(rot=="yes"){
    //Oben
    translate([0,0,buttom+extrude_height])
    scale(v=[distortion,distortion,1])
    rotate([0,0,-degree_twist])
    linear_extrude(height = top)Rim(solid="yes");

    //Rand
    translate([0,0,buttom])
    linear_extrude(height = extrude_height, twist=degree_twist, slices = number_slices, scale = distortion) Rim(solid="yes");
    }
    
    
    if(rot=="no"){
        //Oben
    translate([0,0,buttom+extrude_height])
    scale(v=[distortion,distortion,1])
    linear_extrude(height = top)Rim(solid="yes");

    //Rand
    translate([0,0,buttom])
    linear_extrude(height = extrude_height, scale = distortion) Rim(solid="yes");
        }
    }    




    
module holes(){
    translate([0,0,hole_start])
     for(row = [0:1:number_of_rows])
        translate([0,0,(row*row_height)])
        for(degree = [0 : degree_holes : 360])
            rotate([90,0,degree])
            cylinder(h=radius*5,r=hole_radius,center=true,
            $fn = sides_holes);
}

module cup(twisted,perforated){
    if(perforated=="yes"){
        if(twisted=="yes"){
            difference(){
            extruded(rot="yes");
            holes();
            }
        }
        if(twisted=="no"){
            difference(){
            extruded(rot="no");
            holes();
            }
        }}   
    
    
    if(perforated=="no"){
        if(twisted=="yes") extruded(rot="yes");
        if(twisted=="no")  extruded(rot="no");
    }
}


module cup_filled(twisted,perforated){
    if(perforated=="yes"){
        if(twisted=="yes"){
            difference(){
            extruded_filled(rot="yes");
            holes();
            }
        }
        if(twisted=="no"){
            difference(){
            extruded_filled(rot="no");
            holes();
            }
        }}   
    
    
    if(perforated=="no"){
        if(twisted=="yes") extruded_filled(rot="yes");
        if(twisted=="no")  extruded_filled(rot="no");
    }
}

    

if(filling=="no"){
cup(twisted=twisting,perforated=perforating);}
if(filling=="yes"){
cup_filled(twisted=twisting,perforated=perforating);}