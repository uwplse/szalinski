// Parametric Loose Filament Spool Holder by anotherhowie 
// is licensed under the Creative Commons - Attribution license. 
//
// Edits by stellarinnovation:
// * Spool holder diameter (size of hole) as parameter rather than diameter of spindle
// * Filament clips (on the hooks)
// * Hooks do not protrude beyond spindle_depth. There's even a small gap so that multiple spool holders
//   can be mounted next to eachother.
// * Hex connectors
// * Holes on spindle match number of arms (x2)
// * Fillets for strength and looks

// spool holder diameter (mm)
spool_holder_diameter = 51;

// filament hooks diameter (this is the diameter of your filament) (mm)
hook_diameter = 125;

// the size of the whole holder
outside_diameter = 150;

// depth of the holder
spindle_depth = 27.5;

// how many arms on your holder? (3+)
num_arms = 3;

arm_width = 20;

// how thick all the 'flat' parts should be
wall_thickness = 3;

inner_diameter = spool_holder_diameter + 2*wall_thickness;
hex_diameter = 1*6;

module Hub() {

    difference() {   
        union() {
          cylinder(h=spindle_depth - 0.5*wall_thickness, r=inner_diameter/2, $fn=90);
          // flange
          cylinder(h=wall_thickness, r=inner_diameter/2 + wall_thickness, $fn=90);
          // fillet at base of spindle
          cylinder(h=1.5*wall_thickness, r=inner_diameter/2 + 0.5*wall_thickness, $fn=90);
          // top of spindle
          rotate_extrude($fn=90)
            translate([0.5*(inner_diameter - wall_thickness), spindle_depth - 0.5*wall_thickness])
              circle(d=wall_thickness, $fn=24);
        }
        cylinder(h=spindle_depth, r=inner_diameter/2 - wall_thickness, $fn=90);
        
        // fillet at base of spindle
        rotate_extrude($fn=90)
            translate([0.5*(inner_diameter + wall_thickness), 1.5*wall_thickness])
              circle(d=wall_thickness, $fn=24);

        // holes in spindle
        da = 180/num_arms;
        r = min((spindle_depth - 3*wall_thickness)/2, 0.5*inner_diameter*sin(0.25*da));
        for(a= [0:num_arms-1]) {
            rotate(a*da) translate([-inner_diameter*0.6,0,spindle_depth/2]) rotate(a=90, v=[0,1,0]) cylinder(h=inner_diameter*1.2, r=r);
        }
        
    }
}

module Arm() {
    translate([-arm_width/2,0,0]) cube([arm_width,(outside_diameter)/2 , wall_thickness]);
    translate([0,outside_diameter/2,0]) cylinder(r=arm_width/2, h=wall_thickness);
    
    connector_diam = hex_diameter + 4;
    difference() {
        h = spindle_depth - wall_thickness - 1;
        translate([0,hook_diameter/2,0]) cylinder(d=connector_diam, h=h, $fn=24);
        // hex connector
        translate([0,hook_diameter/2,0]) cylinder(d=hex_diameter, h=spindle_depth, $fn=6);
    }
    
    // Fillets
    r = wall_thickness;
    R = 0.5*inner_diameter + wall_thickness + r;
    x0 = 0.5*arm_width + r;
    y0 = sqrt(R*R - x0*x0);
    difference() {
        linear_extrude(height=wall_thickness)
            polygon([[0,0], [x0,y0], [-x0,y0]]);
        for (x=[-x0, +x0])
            translate([x, y0])
                cylinder(r=r, h=wall_thickness, $fn=24);
            
    }
    
    // Fillet at base of hook 
    translate([0,hook_diameter/2,0])
        difference() {
            cylinder(r=0.5*(connector_diam + wall_thickness), h=1.5*wall_thickness, $fn=24);
            
            rotate_extrude($fn=24)
                translate([0.5*(connector_diam + wall_thickness), 1.5*wall_thickness])
                  circle(d=wall_thickness, $fn=24);
        }
}

module Hook() {
    // hex connector
    h = min(spindle_depth - 2*wall_thickness - 2, 15);
    translate([0,hook_diameter/2,0]) cylinder(d=hex_diameter-0.5, h=h,$fn=6);
    
    hull () {        
        translate([0,hook_diameter/2,0]) cylinder(r=arm_width/2, h=wall_thickness);
        translate([0,outside_diameter/2,0]) cylinder(r=arm_width/2, h=wall_thickness);
    }
    
    // Filament clips
    hole_diam = 3.5;
    r = 0.5*hole_diam + wall_thickness;
    translate([0, 0.5*outside_diameter, r])
        difference() {
            union() {
                rotate([0, 90])
                    cylinder(r=r, h=wall_thickness, center=true);
                translate([-0.5*wall_thickness, -r, -r])
                  cube([wall_thickness, 2*r, r]);
            }
            
            rotate([0, 90])
                cylinder(d=hole_diam, h=wall_thickness+1, center=true, $fn=24);
        }
}


difference() {

    union() {
        Hub();

        for (a = [1:num_arms]) {
            angle = a*(360/num_arms);
            rotate(a=angle, v=[0,0,1]) Arm();
            rotate(a=angle + 180/num_arms, v=[0,0,1]) Hook();
        } 
    }
// punch a hole back through the middle
cylinder(h=spindle_depth, r=inner_diameter/2 - wall_thickness);
}


