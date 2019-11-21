file = "";       // [image_surface:100x100]
dimension = 100;
fn = 24;
shadow = "YES"; // [YES, NO]
shadow_thickness = 1.5;

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

stereographic_projection(dimension, fn)
    projection(cut = true) 
	    translate([-dimension / 2, -dimension / 2, -0.5]) 
		    surface(file);
		
if(shadow == "YES") {
	linear_extrude(shadow_thickness) projection(cut = true) 
		translate([-dimension / 2, -dimension / 2, -0.5]) 
			surface(file);
}