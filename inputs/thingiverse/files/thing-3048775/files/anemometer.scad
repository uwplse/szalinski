

N=3;//number of cup
//cup_external_diameter=26.25;
cup_internal_diameter=25;
cup_tickness=2;
arm_lenght=24.5;
center_axle_external_diameter=27.85;
center_axle_internal_diameter=2.75;
center_axle_height=24;
magnet_diameter=4;
magnet_axle_distance=10;
//screw_lenght=7.3;
screw_diam=1.75;
//screw_head=3.5;
//center_axle_tickness=1.45;
$fn=200;


// Length of the Egg
egg_length = 42; // [10:2:200]
// Number of steps to sample the half profile of the egg
steps = 150; // [50:5:300]


//center axle
difference() {
    
    //Make the top part of the egg:
translate([0,0,-egg_length/2])
difference()
{
	solid_egg(length=egg_length, offset=0, steps=steps);

	//the cube for cutting the egg into two pieces:
	translate([-egg_length/2,-egg_length/2,-egg_length/2])
		cube([egg_length, egg_length, egg_length]);
}

 ///cone   
    
   //extrude
cylinder(h = 7.5, r=9, center =false);
       
    
  //axle  
cylinder(h = center_axle_height-4, r=center_axle_internal_diameter/2, center =false);
    
 //magnet
    rotate([0,0,40])
  translate([magnet_axle_distance, 0, 0])
    
    cylinder(h = center_axle_height, r=magnet_diameter/2, center =false); 
    
 //screw 
    translate([0, 0, 13])
    rotate([50,90,90])
    cylinder(h = 40, r=screw_diam/2, center =false); 
}


//cups 
for ( i = [0 : N-1] )

{
    
   
    
    //arm
    rotate( i * 360 / N, [0, 0, 1])
    translate(v = [arm_lenght+10, -3, 2.5])
    difference(){ 
    cube (size = [arm_lenght+20,5,5], center =true);
     
        
    //clear inner sphere arm
        translate(v = [15, 2, 11])
    sphere(r = cup_internal_diameter/2, $fn=100); 
    }

    
    //cup
    rotate( i * 360 / N, [0, 0, 1])

    translate(v = [arm_lenght+cup_internal_diameter, 0, 14.5]) 
    difference()  {
    sphere(r = cup_internal_diameter/2+cup_tickness, $fn=100);

    union() {
       sphere(r = cup_internal_diameter/2, $fn=100); 

       translate(v = [0, 10, 0])
        //cut half sphere
       cube (size = [cup_internal_diameter*2,21,cup_internal_diameter*2], center =true);
    }//end union
    }//end diff
}//end for



//////////////////////////////////////
// taken form https://www.thingiverse.com/thing:2797274/
//////////////////////////////////////

// Egg profile computing function
function egg(x, l)= 0.9*l*pow(1-x/l, 2/3)*sqrt(1-pow(1-x/l, 2/3));

// Create egg profile
module egg_profile(length=egg_length, offset=0, steps=steps) {
    ss = length / (steps-1); // step size
    v1 = [for (x=[0:ss:length]) [egg(x, length), x + offset]];
    // Make absolute sure the last point brings the profile
    // back to the axis
    v2 = concat(v1, [[0, length + offset]]);
    // Close the loop
    v3 = concat(v2, [[0, offset]]);
        polygon(points = v3);
}

// Create a solid egg part
module solid_egg(length=egg_length, offset=0, steps=steps) {
    rotate_extrude(convexity = 10) {
        egg_profile(length=length, offset=offset, steps=steps);
    }
}