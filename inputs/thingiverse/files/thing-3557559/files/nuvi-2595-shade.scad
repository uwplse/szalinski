module prism(l, w, h){
 polyhedron(
     points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
     faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
  );
}

// main object       
rotate([-90,0,0]) {
difference() {
    difference() {
        union() {
            difference() {
                // base cube
                cube([140,50,14],center=true);
                // cutting away two walls and inside of cube
                translate([0,0,-2]) cube([22,50,12],center=true);
            }
            translate([-70,-25,7]) prism(140,50,30);
        }
        // spacer for the holding bracket
        translate([-69,-25,-9]) cube([138,49,100]); 
    }
    // opening for operating on/off switch
    translate([-55,25,1]) {
        rotate([90,0,0]) linear_extrude(height=2) 
        hull() {
            circle($fn=30,d=8);
            translate([25,0,0]) circle($fn=30,d=8);
        }
    }

}  
// parts where the GPS slides in
translate([-70,-25,-7]) cube([6,50,1]);
translate([64,-25,-7]) cube([6,50,1]);
translate([-70,-25,7]) cube([6,50,1]);
translate([64,-25,7]) cube([6,50,1]);
// add some stiffness to the big part
translate([-70,23,7]) cube([140,1,1]);
translate([-70,23,20]) cube([140,1,1]);
translate([-70,23,35]) cube([140,1,1]);

}