//Number of Rings
no_of_rings=8; // [3:12]

//Width of Donut Ring (in mm)
donut_width=30; // [20:50]

//Radius of Donut Ring (in mm)
donut_radius=10; // [5:15]

//Density between Donut Rings
donut_density=9; // [1:12]

//$fn Value of Cup
sharpness=5; // [3:100]


module ring(){
    rotate_extrude(convexity = 10, $fn = sharpness)
    translate([donut_width, 0, 0])
    circle(r = donut_radius);
}

module bottom(){
    linear_extrude(height = 5,center = true,convexity = 10,twist = 0)
    circle(r = donut_width,$fn = sharpness);
}
module cup(){
    for(p = [0:no_of_rings]){
        translate([0,0,donut_density*p])
        rotate([0,0,p*(360/no_of_rings)])
        ring();
    }
    bottom();
}


cup();