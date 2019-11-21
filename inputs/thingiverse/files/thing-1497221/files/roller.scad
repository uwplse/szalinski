$fn = 50;
radius = 10;
hole = 2;
height = 9;
rotate_extrude(){
    translate([radius/2+hole, 0, 0]){
        difference(){
            square([radius,height],center=true);
            translate([radius/2,0,0]){
                circle(r=radius/2);
            }
        }
    }
}