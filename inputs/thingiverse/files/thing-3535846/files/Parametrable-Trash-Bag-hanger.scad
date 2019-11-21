
/* test 14/02/2019 imprimer a 0,3, 40% infill  */

// All values are in mm
door_thickness = 23;
hanger_width = 25;//[10:40]
hanger_thickness = 3*1;
part_side = 0;//[1:left, 0:right]

// from https://wiki.phormix.com/pub/index.php?title=OpenSCAD_Modules  
module beveled_rect_top(w,d,h,r){
    union() {
        translate([r,d-r,h/2]) cylinder(r = r, h = h, center = true);
        translate([w-r,d-r,h/2]) cylinder(r = r, h = h, center = true);
        translate([r,d-r, 0]) cube([w-(r*2),r,h]);
        translate([0, 0, 0]) cube([w,d-r,h]);
    }
}

color ("red") translate([part_side?85+door_thickness+hanger_thickness:0,0,part_side?hanger_width:0]) rotate([0,part_side?180:0,0]) 
linear_extrude (height=hanger_width)
polygon(points=[[0,-8],[0,-13],
		[10,-13],[20,-hanger_thickness*1.5],[70,-hanger_thickness*1.5],
		[71,-11], [76,-27],[85,-40], [85,30], [85+door_thickness,30], [85+0.90*door_thickness,-62],
        [85+0.90*door_thickness+hanger_thickness,-62], [85+door_thickness+hanger_thickness, 30 +hanger_thickness],
        [85-hanger_thickness, 30 + hanger_thickness], [85-hanger_thickness,-10], [78, -10], [79,0], [6,0], [7,-10], 
        [hanger_thickness, -13+hanger_thickness], [hanger_thickness, -8]]);
        
translate([part_side?59:33,-14,0]) cube([16,14,5], false);
color("blue") translate([part_side?75:49,-14,12]) 
    rotate([0,180,0]) polyhedron(
        points=[[0,0,12], [16,0,12], [16,0,0], [0,0,0], [0,5,0], [16,5,0]],
        faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
    );
               
translate([part_side?85+door_thickness:0,-8,hanger_width]) rotate ([0,90,0]) beveled_rect_top(hanger_width,8, hanger_thickness, 4);
translate([part_side?0.1*door_thickness+hanger_thickness:85+0.9*door_thickness+hanger_thickness,-62,hanger_width]) rotate ([180,90,0]) beveled_rect_top(hanger_width,8, hanger_thickness, 4);