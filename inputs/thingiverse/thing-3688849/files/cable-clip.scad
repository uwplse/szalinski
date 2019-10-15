$fn=100;
diameter=48;
thickness=3;

difference(){
    union(){
    hull(){
    cylinder(10,diameter/2,diameter/2);
    translate([(diameter/2)-thickness,-diameter/2,0]) cube([thickness,diameter,10]);
    }    
    translate([(diameter/2)-thickness,-(diameter+18)/2,0]) cube([thickness,diameter+18,10]);
    }
    hull(){
    translate([0,0,-1]) cylinder(20,(diameter/2)-thickness,(diameter/2)-thickness);
    translate([(diameter/2)+thickness,-(diameter/2)+thickness,0]) cube([thickness,((diameter/2)-thickness)*2,10]);
    }
    translate([0,((diameter/2)+(thickness)+(thickness/2)),5]) rotate([0,90,0]) cylinder(5000,1.5,1.5);
    translate([0,-((diameter/2)+(thickness)+(thickness/2)),5]) rotate([0,90,0]) cylinder(5000,1.5,1.5);
}
