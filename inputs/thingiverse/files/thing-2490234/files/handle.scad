// Parametric handle

//Overall length of the handle
length = 100;
//Outside diameter of the handle
od = 16;
//Inside diameter of the handle
id = 7.6;
//Space between the bottom of the handle and the internal cavity
bottom_thickness = 5;
//Depth of the knurling along the length of the handle
knurl_depth = 1;
//Diamater of the base of the handle. This can make it easier to print. (0: disabled)
base_dia = 20;
//Height of the base of the handle
base_height = 3;
//Chamfer along the top of the handle
top_chamfer = 2;
//chamfer around the base
base_chamfer = 2;
$fn = 48;

module chamfer_cut(major, minor){
    rotate_extrude(angle=360)
    translate([major,0,0])
    rotate([0,0,180])
    difference(){
        square([minor,minor]);
        translate([minor, minor,0])
        circle(r=minor);
    }
}

module chamfer(major, minor){
    translate([0,0,minor])
    rotate_extrude(angle=360)
    translate([major+minor,0,0])
    rotate([0,0,180])
    difference(){
        square([minor,minor]);
        circle(r=minor);
    }
}

union(){
    difference(){
        cylinder(h=length, d=od);
        union(){
            //Knurl
            for (rot = [0:3]){
                linear_extrude(height = length, twist = 10 * length, slices = 20)
                    rotate([0,0,90 * rot])
                        translate([od/2,0,0])
                            circle(r = knurl_depth, center=true, $fn=8);
            }
            for (rot = [0:3]){
                linear_extrude(height = length, twist = -1 * 10 * length, slices = 20)
                    rotate([0,0,90 * rot])
                        translate([od/2,0,0])
                            circle(r = knurl_depth, center=true, $fn=8);
            }
            //Internal hole to accept tool
            translate([0, 0, bottom_thickness])
            cylinder(h = length, d = id);
            //Top Chamfer
            translate([0,0,length])
                chamfer_cut(od/2, top_chamfer);
        }
    }
    //Base.
    cylinder(h = base_height, d=base_dia);
    translate([0,0,base_height]){
        cylinder(h=base_chamfer, d=od);
        chamfer(od/2, base_chamfer);
    }
}