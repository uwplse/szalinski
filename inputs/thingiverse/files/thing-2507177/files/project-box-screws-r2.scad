//Procedural Project Box Screws

//40mm x 60 board size

inside_width = 45;
inside_length = 70;
inside_height = 12.5;
thickness = 2;                  //Wall thickness
radius = 1;                     //Fillet radius. Should not be larger than thickness
screw_dia = 3;                  //Diameter of the screw you intend to use
screw_loose_dia = 3.0;
extra_lid_thickness = 0;        //Extra lid thickness above thickness. 
                                //You may want to tweak this to account for large chamfer radius.

outside_width = inside_width + thickness * 2;
outside_length = inside_length + thickness * 2;
od = screw_dia * 2.5;

module box_screw(id, od, height){
    difference(){
        union(){
            cylinder(d=od, h=height, $fs=0.2);
            translate([-od/2, -od/2, 0])
                cube([od/2,od,height], false);
            translate([-od/2, -od/2, 0])
                cube([od,od/2,height], false);
        }
        cylinder(d=id, h=height, $fn=6);
    }
}

module rounded_box(x,y,z,r){
    translate([r,r,r])
    minkowski(){
        cube([x-r*2,y-r*2,z-r*2]);
        sphere(r=r, $fs=0.1);
    }
}

module main_box(){
    difference(){
        //cube([outside_width, outside_length, inside_height + thickness * 2]);
        difference(){
            rounded_box(outside_width, outside_length, inside_height + thickness + 2, radius);
            translate([0,0,inside_height + thickness])
            cube([outside_width, outside_length, inside_height + thickness * 2]);
        }
        translate([thickness, thickness, thickness])
        cube([inside_width, inside_length, inside_height + thickness]);
    }
    od = screw_dia * 2.5;
    
    translate([od/2+thickness,od/2+thickness, 0])
        box_screw(screw_dia, od, inside_height);
    
    translate([thickness+inside_width-od/2, od/2+thickness, 0])
        rotate([0,0,90])
            box_screw(screw_dia, od, inside_height);
    
    translate([thickness+inside_width-od/2, -od/2+thickness+inside_length, 0])
        rotate([0,0,180])
            box_screw(screw_dia, od, inside_height);
    
    translate([od/2 + thickness, -od/2+thickness+inside_length, 0])
        rotate([0,0,270])
            box_screw(screw_dia, od, inside_height);
}

module lid(){
    difference(){
        union(){
        //Lid.
        difference(){
            rounded_box(outside_width, outside_length, thickness * 4, radius);
            translate([0,0, thickness + extra_lid_thickness])
                cube([outside_width, outside_length, inside_height + thickness * 4]);
        }
        //Lip
        lip_tol = 0.5;
        lip_width = inside_width - lip_tol;
        lip_length = inside_length - lip_tol;
        translate([(outside_width - lip_width)/2,(outside_length - lip_length)/2, thickness * 0.99])
            difference(){
                cube([lip_width, lip_length, 2]);
                translate([thickness, thickness, 0])
                    cube([lip_width-thickness*2, lip_length-thickness*2, 2]);
        }
        
        intersection(){
            union(){
            translate([od/2 + thickness, od/2 + thickness, thickness])
                box_screw(screw_dia, od, thickness);
            translate([inside_width - od/2 + thickness, od/2 + thickness, thickness])
                rotate([0,0,90])
                    box_screw(screw_dia, od, thickness);
            translate([inside_width - od/2 + thickness, inside_length - od/2 + thickness, thickness])
                rotate([0,0,180])
                    box_screw(screw_dia, od, thickness);
            translate([od/2 + thickness, inside_length - od/2 + thickness, thickness])
                rotate([0,0,270])
                    box_screw(screw_dia, od, thickness);
            }
            translate([thickness + lip_tol, thickness + lip_tol, 0])
            cube([lip_width-lip_tol,lip_length-lip_tol,20]);
        }

        }
        
        union(){
            translate([od/2 + thickness, od/2 + thickness, thickness])
                cylinder(h = thickness * 4, d = screw_loose_dia, center=true, $fs=0.2);
            translate([inside_width - od/2 + thickness, od/2 + thickness, thickness])
                cylinder(h = thickness * 4, d = screw_loose_dia, center=true, $fs=0.2);
            translate([inside_width - od/2 + thickness, inside_length - od/2 + thickness, thickness])
                cylinder(h = thickness * 4, d = screw_loose_dia, center=true, $fs=0.2);
            translate([od/2 + thickness, inside_length - od/2 + thickness, thickness])
                cylinder(h = thickness * 4, d = screw_loose_dia, center=true, $fs=0.2);
        }
    }
}

main_box();
translate([-outside_width-2,0,0])
    lid();


