diameter = 25;
width = 25;
length = 50;
opening = 0.8;

rotate([0,0,0]){
    difference(){
        union(){
            translate([0,diameter*-0.1,0]) cylinder(h=width,d=diameter*1.2,$fn=200);
            translate([0,diameter*-0.6,width*0.5]) cube([length,diameter*0.2,width],center=true);
        }    
        union(){
            translate([0,diameter*0.25,width*0.5]) cube([diameter*opening,diameter*0.5,width],center=true);
            cylinder(h=width,d=diameter,$fn=200);
        }
    }    
}