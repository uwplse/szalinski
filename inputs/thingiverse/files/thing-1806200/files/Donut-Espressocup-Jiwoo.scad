//Number of Rings
no_of_rings=12; // [3:12]

//Width of Donut Ring (in mm)
donut_width=14; // [20:50]

//Radius of Donut Ring (in mm)
donut_radius=4; // [5:15]

//Density between Donut Rings
donut_density=5; // [1:12]

//$fn Value of Cup
sharpness=7; // [3:100]

//Angle Value of Cup
donut_angle=0.07; // [0:0.5]

inside_value=2.15; // [0:3]


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
        scale([1+donut_angle*p,1+donut_angle*p,1])
        rotate([0,0,p*(360/no_of_rings)])
        ring();
    }
    bottom();
}

difference(){
    translate([0,0,donut_radius*no_of_rings*(donut_density/4)*0.5])
    cylinder(donut_radius*no_of_rings*(donut_density/4),donut_width,donut_width*(1+donut_angle*no_of_rings), center=true);
    
    translate([0,0,donut_radius*no_of_rings*(donut_density/4)*0.5])
    cylinder(donut_radius*no_of_rings*(donut_density/4)+1,donut_width-donut_radius*inside_value,donut_width*(1+donut_angle*no_of_rings)-donut_radius*inside_value, center=true, $fn = 100);
}

cup();