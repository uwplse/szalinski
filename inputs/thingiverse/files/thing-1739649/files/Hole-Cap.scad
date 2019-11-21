
tube_height=8;
hole_radius=6;
tube_thickness=1.5;
tube_flare=1;
gap_width=2;
cap_height=2;
cap_radius=9;

$fn=100;

difference(){
    cylinder(h=tube_height, r1=hole_radius+tube_flare, r2=hole_radius);
    translate([0,0,-0.5])
        cylinder(h=tube_height+1, r=hole_radius-tube_thickness);
    
    translate([-hole_radius-tube_flare,-gap_width/2,0])
        cube([(hole_radius+tube_flare)*2,gap_width,tube_height]);

    translate([-gap_width/2,-hole_radius-tube_flare,0])
        cube([gap_width,(hole_radius+tube_flare)*2,tube_height]);
    
    rotate_extrude(){
        translate([hole_radius+tube_flare-cap_height,0,0]){
            
            difference(){
            square(cap_height);
            translate([0,cap_height,0])
                circle(cap_height);
            }
        }
    }    
    
}



translate([0,0,tube_height])
    difference(){
        cylinder(h=cap_height, r=cap_radius);


        rotate_extrude(){
                translate([cap_radius-cap_height,0,0]){
                   difference(){
                    square(cap_height,0);
                    circle(r=cap_height);
                   }
                }
        }
        
    }
