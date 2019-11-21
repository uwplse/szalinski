/* [Basic] */

stick_leng = 80;
stick_thickness = 5;
inner_square_leng = 60;
leng_diff = 1.75;
min_leng = 13;
stick_fn = 24;

/* [Advanced] */

cap_style = "CAP_CIRCLE"; // [CAP_BUTT, CAP_CIRCLE, CAP_SPHERE]
angle_offset = 5;
layer_offset = 1.2;

/**
* line3d.scad
*
* Creates a 3D line from two points. 
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-line3d.html
*
**/

module line3d(p1, p2, thickness, p1Style = "CAP_CIRCLE", p2Style = "CAP_CIRCLE") {
    r = thickness / 2;

    frags = $fn > 0 ? 
        ($fn >= 3 ? $fn : 3) : 
        max(min(360 / $fa, r * 2 * 3.14159 / $fs), 5)
    ;
    
    dx = p2[0] - p1[0];
    dy = p2[1] - p1[1];
    dz = p2[2] - p1[2];
    
    
    length = sqrt(pow(dx, 2) + pow(dy, 2) + pow(dz, 2));

    ay = 90 - atan2(dz, sqrt(pow(dx, 2) + pow(dy, 2)));
    az = atan2(dy, dx);

    module cap_butt() {
        translate(p1) 
            rotate([0, ay, az]) 
                linear_extrude(length) 
                    circle(r);
    }
                
    module capCube(p) {
        w = r / 1.414;
        translate(p) 
            rotate([0, ay, az]) 
                translate([0, 0, -w]) 
                    linear_extrude(w * 2) 
                        circle(r);       
    }
    
    module capSphere(p) {
        translate(p) 
            rotate([0, ay, az]) 
                sphere(r * 1.0087);          
    }
    
    module cap(p, style) {
        if(style == "CAP_CIRCLE") {
            capCube(p);     
        } else if(style == "CAP_SPHERE") { 
            if(frags > 4) {
                capSphere(p);  
            } else {
                capCube(p);       
            }        
        }       
    }
    
    cap_butt();
    cap(p1, p1Style);
    cap(p2, p2Style);
}

module stick_square(inner_square_leng, stick_leng, stick_thickness, cap_style) {
    diff_leng = stick_leng - inner_square_leng;
    half_inner_square_leng = inner_square_leng / 2;
    half_stick_leng = stick_leng / 2;
    
    translate([-half_inner_square_leng, 0, 0])
        line3d(
            [0, -half_stick_leng, 0], 
            [0, half_stick_leng, 0], 
            stick_thickness,
            cap_style,
            cap_style
        );
        
    translate([half_inner_square_leng, 0, 0])
        line3d(
            [0, -half_stick_leng, 0], 
            [0, half_stick_leng, 0], 
            stick_thickness,
            cap_style,
            cap_style
        );
}
    
module spiral_stack(orig_leng, orig_height, current_leng, leng_diff, min_leng, angle_offset, pre_height = 0, i = 0) {
    if(current_leng > min_leng) {

        angle = atan2(leng_diff, current_leng - leng_diff);
        
        factor = current_leng / orig_leng;
        
        translate([0, 0, pre_height]) 
            scale(factor) 
                children();
         
        next_square_leng = sqrt(pow(leng_diff, 2) + pow(current_leng - leng_diff, 2));
        
        height = factor * orig_height + pre_height;
        
        rotate(angle + angle_offset)
            spiral_stack(
                orig_leng, 
                orig_height, 
                next_square_leng, 
                leng_diff, 
                min_leng,
                angle_offset,                
                height,
                i + 1
            ) children();
    } else {
        echo(current_leng / orig_leng * orig_height / 2);
    }
}


spiral_stack(inner_square_leng, stick_thickness * 2, inner_square_leng, leng_diff, min_leng, angle_offset)
    union() {
        height = stick_thickness * layer_offset;
        $fn = stick_fn;
        stick_square(
            inner_square_leng, 
            stick_leng, 
            height, 
            cap_style
        );
            
        translate([0, 0, stick_thickness]) 
            rotate(90) 
                stick_square(
                    inner_square_leng, 
                    stick_leng, 
                    height, 
                    cap_style
                );                
    }
    
