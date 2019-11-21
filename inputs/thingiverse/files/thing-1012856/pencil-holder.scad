shape = 2; //[1:shape 1,2:shape 2]

//How long is your pencil? (in millimeters, excluding the tip)
pen_length = 100;

//What is the radius of your pencil? (in millimeters)
pen_radius = 10;

//How many times should the holder wrap your pencil?
number_of_twists = 2; //[1:10]

//How thick should the holder be?
holder_thickness = 6; //[1:10]

show_pencil = "no"; //[yes, no]


module shape1() {
    circle(r=holder_thickness+1, $fn=50);
}

module shape2() {           
    for(i=[0, 60, 120, 180, 240, 300, 360]) {
        rotate([0, 0, i]) {
            translate([(tan(30)-0.6), 0, 0])
                square([holder_thickness, holder_thickness]);
        }
    }
}


if(show_pencil == "yes") {
    
    linear_extrude(height = pen_length, center = false, slices = 1000) {
        circle(r=pen_radius, $fn=6);
    }
    
    translate([0, 0, -20]) {   
        linear_extrude(height = 20, slices= 1000, scale = pen_radius) {
            circle(r=1, $fn=6);
        }
    }
}

linear_extrude(height = pen_length, center = false, convexity = 3, twist = 360 * number_of_twists, slices = 1000)
translate([pen_radius + holder_thickness, 0, 0]) {
    rotate([0, 30, 0])
        
        if(shape == 1) shape1();
        if(shape == 2) shape2();
       
}