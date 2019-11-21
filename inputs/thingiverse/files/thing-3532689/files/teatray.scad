// External depth of insert tray
depth  = 178.5;             // [150:0.5:200]
// Height of insert tray below the lip
height = 39;                // [30:0.5:50]
// Width of each cubby
cubby_width = 67.3;         // [47.3:0.25:87.3]
// Thickness of exterior walls and floor
wall_thickness = 4;         // [1:4]
// Thickness of interior walls
int_wall_thickness = 2;     // [1:4]
// Height of interior walls
int_wall_height = height;   // [0:0.5:50]
// Depth over overhang
overhang_depth  = 13.3;     // [10:0.1:15]
// Height of overhang lip, set to 0 for no lip 
overhang_lip = 0;           //[0:0.1:15]
// Thickness of overhang and lip
overhang_thickness = 2;     // [1:0.1:4]
// Number of cubby columns
cubby_cols = 3;             // [1:1:10]
length = cubby_cols*cubby_width + (cubby_cols-1)*int_wall_thickness + 2*wall_thickness;

module overhang(){
    cube([length, overhang_depth + wall_thickness, overhang_thickness]);
    if(overhang_lip > 0){
        translate([0,overhang_depth + wall_thickness, 0.001-overhang_lip]){
            cube([length, overhang_thickness, overhang_lip]);
        }
        translate([length,overhang_depth+wall_thickness,0]){
            rotate([0,-90,0]){
                intersection(){
                    cube([overhang_thickness, overhang_thickness, length]);
                    cylinder(r=overhang_thickness,h=length,$fn=128);
                }
            }
        }
    }
}

bevel_h = 0.3;
module intwall(x,y,z){
    scale([x,y,z]){
        union(){
            cube([1,1,1-bevel_h]);
            translate([y > x ? 0.5 : 0,
                       x > y ? 0.5 : 1,
                       1-bevel_h]){
                scale([1/( (y > x) ? (2*bevel_h) : 1),
                        1/( (x > y) ? (2*bevel_h) : 1),
                        1]){
                    rotate([(y > x) ? 90 : 0, (x > y) ? 90 : 0,0]){
                        cylinder(r=bevel_h,h=1,$fn=128);
                    }
                }
            }
        }
    }
}

union(){
    difference(){
        cube([length, depth, height]);
        translate([wall_thickness, wall_thickness, wall_thickness]){
            cube([length - (2*wall_thickness), 
                  depth - (2*wall_thickness),
                  height]);
        }
        
    }
    for(offset = [wall_thickness + cubby_width:cubby_width + int_wall_thickness:length-wall_thickness - 1]){
        translate([offset, 0, 0]){
            intwall(int_wall_thickness, depth, int_wall_height);
        }
    }
    translate([0,(depth - int_wall_thickness)/2, 0]){
        intwall(length, int_wall_thickness, int_wall_height);
    }
    
    translate([0, wall_thickness, height - overhang_thickness]){
        mirror([0,1,0]){
            overhang();
        }
    }

    translate([0,depth - wall_thickness, height - overhang_thickness]){
        overhang();
    }
}
