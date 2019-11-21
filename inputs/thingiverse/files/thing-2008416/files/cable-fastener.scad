echo(version=version());
cable_d = 5; //cable diameter
meat = 2; //wall thickness
height = 8; // height of object
width = 14; //this is actually the witdht before the holes begin
screw_d = 2; //diammeter of screws you will use
tolerance = 0.25; //added to holes size
two_screws = true;


translate([0, 0, size/2])
{


color("black")
difference() {
        cylinder (h = height, r=cable_d/2 + meat, center = true, $fn=100);
        cylinder (h = height, r=cable_d/2, center = true, $fn=100);
     translate([0, -cable_d/2 + meat, -height/2]) rotate([0,0,45]) cube(height, height, height);    
}

translate([0, -cable_d/2 - meat/2, 0]) cube([width-tolerance*2, meat, height], center=true);
    
difference() {
     translate([width/2, -cable_d/2 - meat/2, 0]) rotate([90,0,0])  cylinder (h = meat, r=height/2, center = true, $fn=100);
     translate([width/2 + screw_d/2, -cable_d/2 - meat/2, 0]) rotate([90,0,0])  cylinder (h = meat+tolerance, r=screw_d/2+tolerance/2, center = true, $fn=100);

}

if (two_screws)
{
difference() {
     translate([-width/2, -cable_d/2 - meat/2, 0]) rotate([90,0,0])  cylinder (h = meat, r=height/2, center = true, $fn=100);
     translate([-width/2-screw_d/2, -cable_d/2 - meat/2, 0]) rotate([90,0,0])  cylinder (h = meat+tolerance, r=screw_d/2+tolerance/2, center = true, $fn=100);

}
}

}