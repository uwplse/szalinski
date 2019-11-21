union(){
    translate([0,2.125,0]){
    rotate([90,0,0]){
        difference(){
            union(){
                cube([11,26.5,4.25]);
                translate([5.5,26.5,0]){
                    cylinder(d=11,h=4.25, center=false,$fn=50);
                }
            }      
            translate([5.5,26.3,-0.2]){  
                cylinder(d=5,h=4.5,center=false,$fn=50);
            }
        }
    }
}
translate([0,-12.4,0]){
    cube([11,24.8,4.25]);

}
}
