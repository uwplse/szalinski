base_width=10;
base_height=50;
base_thickness=3;
base_arm_lenght=15;

hole_diameter=4;
hole_border=3;

holder_width=25;
holder_height=20;
holder_thickness=10;

profile_width=15;
profile_height=10;
profile_thickness=1.6;
profile_border=3;

strip_space_width=11;

screw_hole_diameter=7;
screw_hole_depth=2;

spacing=0.2;
$fn=50;

Assembly();

module Assembly(){
    translate ([20,0,0]) holder();
    translate ([-20,0,0])base();
    };

module holder(){
    difference(){
        cube([holder_width,holder_height,holder_thickness],center = false);
        difference(){
            cube([hole_border+hole_diameter/2,hole_border+hole_diameter/2,holder_thickness], center=false);
            translate([hole_diameter/2+hole_border,hole_diameter/2+hole_border,0])cylinder(r=hole_diameter/2+hole_border,h=holder_thickness,center = false);
        }
        translate([holder_width-profile_width-profile_border,holder_height-profile_thickness-profile_border,0,]) cube([profile_width,profile_thickness,holder_thickness],center = false);
        translate([holder_width-profile_thickness-profile_border,holder_height-profile_height-profile_border,0,]) cube([profile_thickness,profile_height,holder_thickness],center = false);
            translate([holder_width-strip_space_width-profile_border,holder_height-profile_border,0,]) cube([strip_space_width,profile_border,holder_thickness],center = false); 
        translate([hole_border+(hole_diameter/2),hole_border+(hole_diameter/2),0,]) cylinder(r=hole_diameter/2,h=holder_thickness,center = false);
        translate([hole_diameter/2+hole_border,hole_diameter/2+hole_border,holder_thickness/2])cylinder(r=hole_diameter/2+hole_border,h=holder_thickness/2,center = false);        
        translate([hole_diameter/2+hole_border,0,holder_thickness/2])cube ([hole_diameter/2+hole_border,hole_diameter/2+hole_border,holder_thickness/2],center = false); 
        translate([0,hole_diameter/2+hole_border,holder_thickness/2])cube ([hole_diameter/2+hole_border,hole_diameter/2+hole_border,holder_thickness/2],center = false); 
        }
               

    };
module base(){
    union(){
/*Base*/    
        difference(){
        cube([base_width,base_height,base_thickness],center = false);
/*Hole1*/
        translate([hole_diameter/2+hole_border,hole_diameter/2+hole_border,base_thickness-screw_hole_depth])cylinder(r2=screw_hole_diameter/2,r1=hole_diameter/2,h=screw_hole_depth,center = false);
        translate([hole_diameter/2+hole_border,hole_diameter/2+hole_border,0])cylinder(r=hole_diameter/2,h=base_width/2,center = false); 
/*Hole1*/
        translate([hole_diameter/2+hole_border,base_height-(hole_diameter/2+hole_border),base_thickness-screw_hole_depth])cylinder(r2=screw_hole_diameter/2,r1=hole_diameter/2,h=screw_hole_depth,center = false);
        translate([hole_diameter/2+hole_border,base_height-(hole_diameter/2+hole_border),0])cylinder(r=hole_diameter/2,h=base_width/2,center = false); 
        }
/*Arm*/            
        translate([base_width,base_height/2-(base_width/2),base_thickness]) rotate([0,-90,0]){ 
          difference(){
                cube([base_arm_lenght,base_width-spacing,hole_diameter+2*hole_border]);
              translate([base_arm_lenght-(2*hole_border+hole_diameter),0,0]) difference(){
            translate([hole_border+hole_diameter/2-spacing,0,0]) cube([hole_border+(hole_diameter/2)+2*spacing,2*hole_border+hole_diameter,base_width], center=false);
            translate([base_arm_lenght-(2*hole_border+hole_diameter),hole_diameter/2+hole_border,0])cylinder(r=hole_diameter/2+hole_border,h=holder_thickness,center = false);
        }
                translate([base_arm_lenght-(hole_border+(hole_diameter/2)),hole_border+(hole_diameter/2),0,]) cylinder(r=hole_diameter/2,h=holder_thickness,center = false);
              translate([base_arm_lenght-(hole_diameter+2*hole_border),0,holder_thickness/2])cube ([hole_diameter+2*hole_border,hole_diameter+2*hole_border,holder_thickness/2],center = false);
        
                };
            
        };
        };
    };

