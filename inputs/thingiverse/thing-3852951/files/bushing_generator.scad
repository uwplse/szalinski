//number of fragments
$fn=50;//[25,50,100,150,200]
//height of the bushing lip
lip_height=1.5;
//diameter of the bushing lip
lip_diameter=10;
//height of the bushing barrel
barrel_height=12;
//outer diameter of the bushing barrel
barrel_diameter=7;
//inner diameter of the bushing
inner_diameter=4;
//set screw hole diameter
set_screw_diameter=2;
//set screw hole height
set_screw_height=6;
//number of set screw holes
set_screw_holes=1;//[0,1,2,4]
difference(){
    difference(){
        union(){
            //lip
            cylinder(h=lip_height,d=lip_diameter);
            //barrel
            translate([0,0,lip_height]){
                cylinder(h=barrel_height,d=barrel_diameter);
                }
            }

    //inner diameter
    cylinder(h=(barrel_height+lip_height),d=inner_diameter);
    }
    if (set_screw_holes == 1){
        translate([0,0,set_screw_height]){
            rotate([90,0,0]){
                cylinder(h=(barrel_diameter/2),d=set_screw_diameter);
            }
        }
    }
    if (set_screw_holes == 2){
        translate([0,(barrel_diameter/2),set_screw_height]){
            rotate([90,0,0]){
                cylinder(h=barrel_diameter,d=set_screw_diameter);
            }
        }
    }
    if (set_screw_holes == 3){
        translate([0,(barrel_diameter/2),set_screw_height]){
            rotate([90,0,0]){
                cylinder(h=barrel_diameter,d=set_screw_diameter);
            }
        }
    }
    if (set_screw_holes == 4){
        union(){
            translate([0,(barrel_diameter/2),set_screw_height]){
                rotate([90,0,0]){
                    cylinder(h=barrel_diameter,d=set_screw_diameter);
                }
            }
            translate([-(barrel_diameter/2),0,set_screw_height]){
                rotate([90,0,90]){
                    cylinder(h=barrel_diameter,d=set_screw_diameter);
                }
            }
        }
    }
}