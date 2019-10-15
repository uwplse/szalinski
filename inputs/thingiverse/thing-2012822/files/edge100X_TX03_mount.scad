// Camera angle
CAMERA_ANGLE = 25;

module tx01_box(angle) {
  inner_width = 19;
  inner_depth = 8;
  height = 8;
  tx_box(19, 8, 8, angle);  
}

module tx03_box(angle) {
  inner_width = 20.5;
  inner_depth = 8.5;
  height = 9.75;
  tx_box(inner_width, inner_depth, height, angle);  
}

module tx_box(inner_width, inner_depth, height, angle) {
    
    wall_thickness = 1.5;
    
    width = inner_width + wall_thickness;
    depth = inner_depth + wall_thickness;
    
    extra_height = (angle + 1)/4;
    
    lens_width=9;
    lens_height=7;
    lens_x_offset = 0;
    lens_z_offset = 0;
    
    lcd_width=8;
    lcd_height=6;
    lcd_x_offset = 5;
    lcd_z_offset = 0;
    
    cap_width=4.5;
    cap_height=2;
    cap_x_offset = 1.3;
    cap_z_offset = 0;
    
    pcord_width=3;
    pcord_height=2.4;
    pcord_x_offset = 7.5;
    pcord_z_offset = 0;
    
    // center
    translate([-width/2, depth/2, -.75])
        difference() {
            // add camera angle
            rotate ([-angle, 0, 0])
                // rotate around rear edge
                translate([0, -depth, 0])
                    difference() {
                        // outer box
                        translate ([0, 0, -extra_height])
                            cube([width, depth, height + extra_height]);
                        // inner box
                        translate ([wall_thickness/2, wall_thickness/2, -extra_height - .5])
                            cube([inner_width, inner_depth, height + extra_height + 1]);
                        
                        // Lens cutout
                        lens_x = (width/2) - (lens_width/2) + lens_x_offset;
                        lens_z = height - lens_height + lens_z_offset;
                        translate ([lens_x, -.5, lens_z])
                            cube([lens_width, wall_thickness+1, lens_height]);
                        // Cap cutout
                        cap_x = (width/2) - (cap_width/2) + cap_x_offset;
                        cap_z = lens_z - cap_height + cap_z_offset;
                        translate ([cap_x, - .5, cap_z - .5])
                            cube([cap_width, wall_thickness + 1, cap_height + .5]);
                        
                        // LCD cutout
                        lcd_x = (width/2) - (lcd_width/2) + lcd_x_offset;
                        lcd_z = height - lcd_height + lcd_z_offset;
                        translate ([lcd_x, depth - wall_thickness + .5, lcd_z])
                            cube([lcd_width, wall_thickness + 1, lcd_height]);
                        // PowerCord cutout
                        pcord_x = (width/2) - (pcord_width/2) + pcord_x_offset;
                        pcord_z = lcd_z - pcord_height + pcord_z_offset;
                        translate ([pcord_x, depth - wall_thickness + .5, pcord_z])
                            cube([pcord_width, wall_thickness + 1, pcord_height]);
                        
                    }
            // cut bottom flat
            translate ([-1, -depth*3, -extra_height])
                cube([ width + 2, depth*3, extra_height]);
        }
}

module 1104_100_plate(hole_spacing, height) {
    
    r1 = (hole_spacing + 5) / 2.0;
    r1cut = 0.7 * r1;
    r1offset = 0.82 * r1;
    
    r2 = (hole_spacing - 5) / 2.0;
    r2cut = 0.85 * r2;
    r2offset = 0.95 * r2;
    
    rnut = 1.65;
    
    difference() {
        // Outer
        difference() {
            cylinder(r=r1, h=height, center=true, $fn=16);        
            translate([r1offset, r1offset, 0])
                cylinder(r=r1cut, h=4, center=true);
            translate([r1offset, -r1offset, 0])
                cylinder(r=r1cut, h=4, center=true);
            translate([-r1offset, -r1offset, 0])
                cylinder(r=r1cut, h=4, center=true);        
            translate([-r1offset, r1offset, 0])
                cylinder(r=r1cut, h=4, center=true);
        }
        
        // Inner
        difference() {
            cylinder(r=r2, h=2*height, center=true, $fn=8);        
            translate([r2offset, r2offset, 0])
                cylinder(r=r2cut, h=2*height, center=true);
            translate([r2offset, -r2offset, 0])
                cylinder(r=r2cut, h=2*height, center=true);
            translate([-r2offset, -r2offset, 0])
                cylinder(r=r2cut, h=2*height, center=true);        
            translate([-r2offset, r2offset, 0])
                cylinder(r=r2cut, h=2*height, center=true);
        }
        
       // M3 Holes
        translate([-hole_spacing / 2.0, 0, 0])        
            cylinder(r=rnut, h=2*height, center=true, $fn=16);
        translate([hole_spacing / 2.0, 0, 0])
            cylinder(r=rnut, h=2*height, center=true, $fn=16);
        translate([0, -hole_spacing / 2.0, 0])
            cylinder(r=rnut, h=2*height, center=true, $fn=16);
        translate([0, hole_spacing / 2.0, 0])
            cylinder(r=rnut, h=2*height, center=true, $fn=16);
    }
}

translate([0, 0, 0]) rotate([0, 0, 0]) 1104_100_plate(47, 1.5);
translate([0, 0, 0]) tx03_box(CAMERA_ANGLE);