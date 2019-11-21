
snaps = 10;
level = 6;

side_length = 190; 

// Set the thickness of the tile, in mm
thickness = 4;
snap_thickness=4;
fill_pattern_thickness=0.9;
fill_canvas_thickness=0.3;

// Set the border thickness, in mm
border_width = 4;	
snap_width = 4;

radius = side_length/(sqrt(3)); 
border = radius-snap_width/(cos(60));
inside = border-border_width/(cos(60)); 

snaplen = side_length/snaps;

snap_trim = -0.2;
continuity = 0.9;
strength_width = 2;
bore = 1.5;
border_snap = false;

union(){
   border();
    snaps();   
    strength(sqrt(level));
   fill_maker(level);
}
module triangle() {
    polygon([[1,0],[sin(210),cos(210)],[sin(330),cos(330)]]);
}

module border() {
    linear_extrude(thickness, center=true)
    difference() {
        scale(border) triangle();
        scale(inside) triangle();
    }
}

module snaps() {
    
            cylinder_length = side_length-snap_thickness/cos(60);
    
    translate([0,0,-thickness/2])
    difference() {
        union() {
        linear_extrude(snap_thickness)
            difference() {
                scale(radius - snap_thickness/(2*cos(60))) triangle();
                scale(border) triangle();
            }
            
            for(i = [0:2]) 
                rotate([0,0,i*120]) 
            translate([-(radius- snap_thickness/(2*cos(60)))/2,cylinder_length/2,snap_thickness/2])
            rotate([90,0,0])
            cylinder(r = snap_thickness/2,h = cylinder_length,$fn=16);
        }
                    for(i = [0:2]) 
                rotate([0,0,i*120]) 
            translate([-(radius- snap_thickness/(2*cos(60)))/2,cylinder_length/2,snap_thickness/2])
            rotate([90,0,0])
                            cylinder(r = bore/2,h = cylinder_length,$fn=16);
          
            for(i = [0:2]) 
                rotate([0,0,i*120]) 
            translate([-(border)/2,0,0]) 
            scale([-1,1,1]) 
            for(i=[(border_snap?0:1):snaps-1])
                translate([0,snaplen*(i-snaps/2)+snap_trim/2,0])
                        cube([snap_width,snaplen/2*((i==snaps-1?3:1) - snap_trim/2),snap_thickness]);
            }
        }
        
    


module fill_maker(rec_level) { 
        union() {
            translate([0,0,-thickness/2 + fill_canvas_thickness]) {
                linear_extrude(fill_pattern_thickness) {
                    scale(inside) {
                        fill_sierpinski(rec_level);
                    }
                }
            }
            translate([0,0,-thickness/2]) {
                linear_extrude(fill_canvas_thickness) {
                    scale(inside) {
                        triangle();
                    }
                }
            }
        }
}

module fill_sierpinski(depth) {
    difference() {
        polygon([[1,0],[sin(210),cos(210)],[sin(330),cos(330)]]);
        sierpinski(depth);
    }
}
module sierpinski(rec_level) {     
    if(rec_level > 0) {
        scale(0.5) rotate([0,0,180]) union() {  
            scale(continuity*0.99) // https://github.com/openscad/openscad/issues/791
                        triangle();
            for(i = [0:2]) 
                rotate([0,0,i*120]) translate([-1,0]) rotate([0,0,180])     
                    sierpinski(rec_level-1);
        }
    }
}
module strength(rec_level) {
    if(rec_level>0) {
        scale([0.5,0.5,1]) 
         union() {
        linear_extrude(thickness, center=true) rotate([0,0,180]) difference() {
            scale(inside+strength_width/(cos(60)*2)) triangle();
                        scale(inside-strength_width/(cos(60)*2)) triangle();
             

        }
                 for(i = [0:2]) 
                rotate([0,0,i*120]) translate([inside,0])      
                    strength(rec_level-1);
    }
    }
}