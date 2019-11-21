$fn = 100;

//Plate 
width = 200;
height = 60;
thickness = 3;
corner_radius = 5;
screw_offset = 10;
mounting_hole_screw_size=4;
connector_position=25;

//Fuse
fuse_diameter= 13;
fuse_position= 0;

//Switch
switch_width=28;
switch_height=13;
switch_position=-30;

//Mains Outlet
mains_width= 28;
mains_height= 20;
mains_position= 35;
mains_screw_size= 4;
mains_screw_distance=36;

//Label
text_position=-75;
text_size=10;
text="Reese";

//main
translate([0, 0, thickness/2]){
    rotate([-90, 0, 0]){
        difference(){
            plate();
            translate([connector_position, 0, 0]){
                connectors();
            }
            label();
        }
    }
}

// Text
module label(){
    translate([text_position, 0, -text_size/2]){
        rotate([90, 0, 0]){
            scale([1.5,1,1]){
                linear_extrude(thickness/2+1){
                    text(text, size="10", font="Lobster Two");
                }
            }
        }
    }
}


// Connectors
module connectors(){
    fuse();
    switch();
    mains();
}

// Switch
module switch(){
    translate([switch_position, 0, 0]){
        cube([switch_width, thickness+1, switch_height], center=true);
    }
    

}

// Fuse
module fuse(){
    translate([fuse_position, thickness/2+0.5, 0]){
        rotate([90, 0, 0]){
            cylinder(r=fuse_diameter/2, h=thickness+1);
        }
    }
}

// Mains outlet
module mains(){
    translate([mains_position, 0, 0]){
            cube([mains_width, thickness+1, mains_height], center=true);
            screw();
            mirror([mains_position, 0, 0]){
                screw();
            }
    }
    
    module screw(){
        translate([-mains_screw_distance/2, thickness/2+0.5, 0]){
            rotate([90, 0, 0]){
                cylinder(r=mains_screw_size/2, h=thickness+1);
            }
        }
    }
}
// Plate 
module plate(){
    difference(){
        hull(){
            corner();
            
            mirror([1, 0, 0]){
                corner();
            }
            mirror([0, 0, 1]){
                corner();
            }
            mirror([0, 0, 1]){
                mirror([1, 0, 0]){
                    corner();
                }
            }
        }
        screwholes();
    }
    
    module screwholes(){
        screwhole();
        mirror([1, 0, 0]){
            screwhole();
        }
        mirror([0, 0, 1]){
            screwhole();
        }
        mirror([0, 0, 1]){
            mirror([1, 0, 0]){
                screwhole();
            }
        }
        
        module screwhole(){
            translate([-(width/2)+screw_offset, thickness/2+0.5, (height/2)-screw_offset]){
                rotate([90, 0, 0]){                
                    cylinder(r=mounting_hole_screw_size/2, h=thickness+1);
                }
            }
        }
    }
    
    module corner(){
        translate([-(width/2)+(corner_radius), thickness/2, (height/2)-corner_radius]){
            rotate([90, 0, 0]){
                cylinder(r=corner_radius, h=thickness);      
            }
        }
    }
}