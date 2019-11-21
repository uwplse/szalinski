rows = 8;
line_width = 15;
block_width = 50;
shadow = "YES"; // [YES, NO]
fn = 48;

module stereographic_projection(side_leng_shadow, fn) {
    $fn = fn;
    
    half_side_length = side_leng_shadow / 2;
    outer_sphere_r = half_side_length / 3;
    a = atan(sqrt(2) * half_side_length / (2 * outer_sphere_r));
    inner_sphere_r = outer_sphere_r * sin(a);
    
    intersection() { 
        translate([0, 0, outer_sphere_r]) difference() {
            sphere(outer_sphere_r);
            sphere(outer_sphere_r / 2 + inner_sphere_r / 2);
            
            translate([0, 0, outer_sphere_r / 2]) 
                linear_extrude(outer_sphere_r) 
                    circle(inner_sphere_r * sin(90 - a));
        }
     
        linear_extrude(outer_sphere_r * 2, scale = 0.01) children();
    }
}

module grid(rows, block_width, line_width) {
    half_side_length = (block_width * rows + line_width) / 2;
    
    translate([-half_side_length, -half_side_length]) 
        for(i = [0:rows]) {
            translate([0, i * block_width, 0]) 
                square([block_width * rows, line_width]);
                
            translate([i * block_width, 0, 0]) 
                square([line_width, block_width * rows + line_width]);
        }
}
 
stereographic_projection(block_width * rows + line_width, fn) 
    grid(rows, block_width, line_width);
  
if(shadow == "YES") {
     color("black") grid(rows, block_width, line_width);
 }