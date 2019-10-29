// Customizable Egg Holder

/* [parameter] */

//The diameter of the bottom of the egg.
egg_holder_outer_diameter=13.92;

egg_holder_wall_thickness=1.2;

egg_holder_height=3;

//The diameter of the Compact LED Light for CR2032.
base_inner_diameter=30.1;

base_wall_thickness=2;

base_height=5;


/* [Hidden] */


difference() {
    union() {
        //base
        difference() {
            cylinder(h=base_height, d=(base_inner_diameter+base_wall_thickness), $fn=50);
            translate([0,0,-0.05]) 
                cylinder(h=(base_height-0.95), d=base_inner_diameter,$fn=36);
        }
        
        //egg holder
        cylinder(h=(egg_holder_height+base_height), d=egg_holder_outer_diameter, $fn=36);
    }
    
    //egg holder hole
    translate([0,0,-0.05])
        cylinder(h=(egg_holder_height+base_height+0.1), d=(egg_holder_outer_diameter-egg_holder_wall_thickness), $fn=36);
    
    //support break
    translate([0,0,(base_height-2)])
        cylinder(h=0.2, d=(egg_holder_outer_diameter+2), $fn=36);
}
