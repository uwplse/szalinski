
width = 15;
height = 80;
thickness = 1;
lower_height = 20;
paper_holder = true;

module holder() {
    translate([-4,0,height]) cube([2,2,10]);
    translate([2,0,height]) cube([2,2,10]);
    translate([-4,0,height+10]) cube([8,2,5]);
}

difference (){
    cylinder(r1=1,r2=width/2, h=lower_height);
    translate([-width/2,-width,0]) cube([width,width,lower_height]);
    translate([-width/2,thickness,0]) cube([width,width,lower_height]);
}

module plate() {
    translate([-width/2,0,lower_height]) cube([width, thickness, height-width/2]);
    translate([0,thickness,height+lower_height-width/2]) rotate([90,0,0]) cylinder(r=width/2, h=thickness);
}

difference() {
    plate();
    if (paper_holder) {
        holder();
    }
}
