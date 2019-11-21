txt = "GGGG";
size = 100;
fn = 24;
shadow = "YES"; // [YES, NO]
base_height = 2;

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

module chinese_4_char_idioms(txt, size) {
    frame_width = 0.225 * size;

    for(i = [0:3]) {
        offset_x = size * 0.8 * (i == 1 || i == 2 ? 1 : -1) + 
                   frame_width / 2 * (i == 0 || i == 3 ? 1 : -1);
        offset_y = size * 0.8 * (i == 0 || i == 1 ? 1 : -1) +
                   frame_width / 2 * (i == 0 || i == 1 ? -1 : 1);
        
        translate([offset_x, offset_y, 0]) intersection() {
            union() {
                rotate(-135 - 90 * i) scale([1.15, 1, 1]) 
                    text(txt[i], size = size, font = "微軟正黑體:style=Bold", valign = "center", halign = "center");   
                
                difference() {
                    square(size * 1.6, center = true);
                    square(size * 1.15, center = true);
                }
                
               /* // patch for "恭喜發財"
                if(txt[i] == "財") {
                    translate([-size / 2.15, -size / 10, 0]) square([size / 7.5, size / 6]);
                }
                if(txt[i] == "發") {
                    translate([size / 10, size / 2.5, 0]) square([size / 8.25, size / 8]);
                }*/
            }
            square(size * 1.6, center = true);
        }
    }
}

stereographic_projection(size * 2.975, fn) 
    chinese_4_char_idioms(txt, size);

if(shadow == "YES") {
    color("red") linear_extrude(base_height) chinese_4_char_idioms(txt, size);
}