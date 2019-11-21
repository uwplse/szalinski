upper_hole_position = 47.8;
lower_hole_position = 25.3;
hole_diam=3.5; // [3.5, 4.5, 5.5, 6.5]

panel_thickness =  2; // [1.5:2.3]
bracket_thickness = 2.5; // [2.5:10]

tolerance=0.2;//[0:0.1:1]

positions=7; //[2,3,4,5,6,7,8,9,10,11,12]
rows=1; // [1,2]
count=5; // [20]

hole_spacing = upper_hole_position - lower_hole_position;

function dim_b (p, rows) = (p / rows) * 3 + 1.20;
function dim_c (p, rows) = (p / rows) * 3 + 4.88;

echo(dim_c(positions,rows));
echo(dim_b(positions,rows));
// panel cutout dimensions
module single_pos(p = 4, rows=1, height=10, tolerance=0.2) {
    panel_width=(rows == 1 ? 4.21 : 7.11);
    clip_width=(rows==1 ? 3.05 : 4.06);
    nub_height=(rows==1 ? 5.51 : 8.71);
    nub_width=(rows==1 ? 3.18 : 1.98);

    cube([clip_width+tolerance, dim_c(p,rows)+tolerance, height], center=true);
    cube([panel_width+tolerance, dim_b(p,rows)+tolerance, height], center=true);
    color("red")translate([(nub_height+tolerance)/2 - (panel_width+tolerance)/2,0,0])cube([nub_height+tolerance, nub_width+tolerance, height], center=true);

}

rotate([0,0,180])
difference() {
    union() {
        cube([20,max(hole_spacing+20, (dim_c(positions,rows)+4)*count),panel_thickness], center=true);
        translate([-10 + (bracket_thickness/2),0,10])
        cube([bracket_thickness,max(hole_spacing+20, (dim_c(positions,rows)+4)*count),20], center=true);
    }
    rotate([0,90,0])
    translate([-10,-hole_spacing/2,-12])
    #for (sp = [0, hole_spacing]) {
        translate([0,sp,0])
        cylinder(d=hole_diam+tolerance, h=10, $fn=70);
    }
    translate([2, (count+1)*(-dim_c(positions,rows) - 2.5)/2,0])
    for (i = [1:count]) {
    translate([0,i*(dim_c(positions,rows) + 2.5),0])
        #single_pos(positions, rows=rows, tolerance=tolerance);
    }
}

