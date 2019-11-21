/* [Basic] */

shape = "Flower";  // [Flower, Circle, Heart]
model = "Outer"; // [Outer, Inner]
width = 30;
radius = 20;
height = 100;
thickness = 1;
spacing = 0.65;
twist = 180;

/* [Advanced] */

convexity = 10;
slices = 200;
   
module hollow_out(shell_thickness) {
    difference() {
        children();
        offset(delta = -shell_thickness) children();
    } 
}

module twist_bottle(model, height, thickness, twist, spacing, convexity, slices) {
    $fn = 96;
    
    module outer_container() {
        translate([0, 0, thickness])
            linear_extrude(height = height, twist = twist, convexity = convexity, slices = slices) 
                hollow_out(thickness) children();
                
        linear_extrude(thickness) 
            children();    
    }
    
    module inner_container() {
        linear_extrude(height = height, twist = twist, convexity = convexity, slices = slices) 
            hollow_out(thickness) 
                offset(r = -thickness - spacing) 
                    children();                
        
        translate([0, 0, height]) 
            rotate(twist) 
                linear_extrude(thickness) 
                    children();      
    }
    
    if(model == "Outer") {
        outer_container() 
            children();
    }
    
    if(model == "Inner") {
        translate([0, 0, height + thickness])
            rotate([180, 0, 0]) 
                inner_container() 
                    children();
    }
} 

module heart_sub_component(radius) {
    rotated_angle = 45;
    diameter = radius * 2;
    $fn = 48;

    translate([-radius * cos(rotated_angle), 0, 0]) 
        rotate(-rotated_angle) union() {
            circle(radius);
            translate([0, -radius, 0]) 
                square(diameter);
        }
}

module heart(radius, center = false) {
    offsetX = center ? 0 : radius + radius * cos(45);
    offsetY = center ? 1.5 * radius * sin(45) - 0.5 * radius : 3 * radius * sin(45);

    translate([offsetX, offsetY, 0]) union() {
        heart_sub_component(radius);
        mirror([1, 0, 0]) heart_sub_component(radius);
    }
}

if(shape == "Flower") {
    twist_bottle(model, height, thickness, twist, spacing, convexity, slices) union() {
        for(i = [0:3]) {
            rotate(90 * i) 
                translate([radius * 0.5, 0, 0]) 
                    circle(radius * 0.5);
        }
    }  
}

if(shape == "Circle") {
    twist_bottle(model, height, thickness, twist, spacing, convexity, slices) difference() {
        circle(radius);
        for(a = [0:120:240]) {
            rotate(a) 
                translate([radius, 0, 0]) 
                    circle(radius / 4);
        }
    }
}

if(shape == "Heart") {
    twist_bottle(model, height, thickness, twist, spacing, convexity, slices) 
        heart(radius * 1.9 / (3 * sin(45) + 1), center = true);
}

