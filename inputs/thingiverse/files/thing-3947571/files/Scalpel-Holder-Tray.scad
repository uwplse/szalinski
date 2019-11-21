// Design by John Bloom-Edmonds

//Render Resolution (Higher number = Smoother surface)
$fn=100;

//Base width in mm
base_width = 50.8;
//Base length in mm
base_length = 101.6;
//Base height in mm
base_height = 15.875;

//Scalpel handle width in mm
cutout_width = 8;

//Optional Magnet Cutout (in mm) *Put 0 for no magnets* 
magnet_diameter = 32;

module base_tray(){
    difference(){
        
        translate([0,0,base_height/2])
        minkowski(){
            cube([base_width,base_length,base_height],center=true);
            sphere(1.5);
        }
        
        minkowski(){
        translate([0,base_length/4-1,base_height/2+2])
            cube([base_width-1,base_length/2,base_height+2],center=true);
            sphere(1);
        }
        
        translate([0,-base_length/4-1,base_height+6])rotate([0,90,0])
            cylinder(base_width+5,base_height+5,base_height+5,center=true);
            
        minkowski(){    
        translate([base_width/3,-base_length/2,base_height/2+3])
            cube([cutout_width,base_length,base_height+2],center=true);
            sphere(1);
        }
        
        minkowski(){    
        translate([-base_width/3,-base_length/2,base_height/2+3])
            cube([cutout_width,base_length,base_height+2],center=true);
            sphere(1);
        }
        
        minkowski(){    
        translate([0,-base_length/2,base_height/2+3])
            cube([cutout_width,base_length,base_height+2],center=true);
            sphere(1);
        }  
    }
};
base_tray();

if (magnet_diameter>0){
    difference(){
        
        union(){
            base_tray();
            translate([0,0,-3.175/2])
                cube([base_width+3,base_length+3,3.175],center=true);
            }
            
    translate([0,base_length/4,-1.75])
        cylinder(3.175,magnet_diameter/2+0.25,magnet_diameter/2+0.25,center=true);
    translate([0,-base_length/4,-1.75])
        cylinder(3.175,magnet_diameter/2+0.25,magnet_diameter/2+0.25,center=true);
    }
};
