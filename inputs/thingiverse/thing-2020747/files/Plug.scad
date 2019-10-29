$fn=50;

id=19;
od=22;
wide=4/2;
height=12;
difference(){
    union(){
        cylinder(h = height, r=id/2, center = true);
        translate([0,0,-height/2-wide/2]) cylinder(h = wide, r=od/2, center = true);
    }
    translate([0,0,wide]) cylinder(h = height-wide, r=(id/2)-2, center = true);
}