//How big? (mm)
radius = 100;

//How tall? (mm)
height = 11;

//If you would like a cutout in the corner in case of a moulding, set to not zero
cornercut_radius = 20; //[0:5:40]

//What is the size of your cube? 57 is standard(mm)
cube_size = 57;

//How deep should your cube rest? Recommended is a little more than a third your cube size. (mm)
depth = 20;//[1:30]

//Would you like to preview how your cube will sit?
preview_cube = "false"; // [true:yes, false:no]


//option to preview the cube's location
if (preview_cube == "true"){
    translate([radius/2,radius/2,cube_size - depth +1])
        rotate([45,36,45]) 
        cube(cube_size, center=true);
}

    
difference(){
    
    //main body
    $fn = 200;
    cylinder(h=height, r=radius );
    
    //cut the cylinder into a quarter cylinder
    translate([-radius,0,0]) cube(2*radius, center=true);
    translate([0,-radius,0]) cube(2*radius, center=true);
    
    //cutout for the cube
    translate([radius/2,radius/2,cube_size - depth + (height/2)])
        rotate([45,36,45]) 
        cube(cube_size, center=true);
    
    //cutout for a moulding
    translate([0,0,-1]) cylinder(h=height +2 , r=cornercut_radius);
    
}
