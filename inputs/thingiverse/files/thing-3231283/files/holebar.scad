/* [Model] */
// (quality of round edges; higher the better)
quality = 32;

/* [Bar] */
// (width of bar in millimeters)
width = 10;
// (length of bar in millimeters)
length = 100;
// (height of bar in millimeters)
height = 4;

/* [Holes] */
// (number of holes)
holes = 10;
// (hole diameter in millimeters)
diameter = 3;
// (add countersink to each hole)
countersink = 1; //[1:Yes, 0:No]

holebar(width,length,height,holes,diameter,(countersink == 1 ? true : false),true,$fn=quality);

module holebar(width,length,height,holes,diameter,countersink,center)
{
    if (center) {
        translate([-width/2,-length/2,-height/2])
            holebar_(width,length,height,holes,diameter,countersink);
    } else {
        holebar_(width,length,height,holes,diameter,countersink);
    }
}

module holebar_(width,length,height,holes,diameter,countersink) {
    difference() {
        base(width,length,height);
        for (i = [0 : holes-1]) {
            translate([width/2,i * (length / (holes-1)),-height/2])
                cylinder(d=diameter,h=height*2);
            if (countersink) {
                translate([width/2,i * (length / (holes-1)), height-diameter/2])
                    cylinder(r1=diameter/2, r2=diameter+diameter/2, h=diameter);
            }
        }    
    }
}

module base(width,length,height) {
    cube([width,length,height]);
    translate([width/2,0])
        cylinder(d=width,h=height);
    translate([width/2,length])
        cylinder(d=width,h=height);
}