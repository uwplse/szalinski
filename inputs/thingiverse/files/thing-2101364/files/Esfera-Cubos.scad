cube([50,25,05]);
translate([50,50,50]) {
 union(){
    sphere(50);
    cube(50, Center=true);
    }
}
