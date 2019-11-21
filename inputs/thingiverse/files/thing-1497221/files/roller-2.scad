$fn = 50;
radius = 35/2;
hole = 8.4/2;
height = 30/2;
lenght = 5;

rotate_extrude(){
    translate([radius/4+hole, 0, 0]){
        difference(){
            square([radius/2,height],center=true);
            translate([lenght,0,0]){
                circle(r=radius/2);
            }
        }
    }
}