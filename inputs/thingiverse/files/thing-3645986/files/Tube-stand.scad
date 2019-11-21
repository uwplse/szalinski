//48.90, 51.45mm
wall_thickness = 1.5;    //Wall thickness
od=51.90;                //Outer diameter of tube       
id=48.90;                //Inner diameter of tube
difference(){                               //Comment to remove outer ring
    cylinder (10, d=od+wall_thickness);
    translate([0,0,2]){
    cylinder (8, d=od);
}}
difference(){                               // Comment to remove inner ring
    cylinder (10, d1=id,d2=id-1);
    translate([0,0,2]){
    cylinder (8, d=id-(2*wall_thickness));
}}

cube([65,65,2],center=true);                //Comment to remove base