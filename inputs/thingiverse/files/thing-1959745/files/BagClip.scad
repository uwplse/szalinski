length = 120; // [20:300]
// one of the two measures of sturdiness, this is the thickness of the main clip when laid on its side on the table.
clipThickness=16; //[7:40]
// the other measures of sturdiness, this is the top to bottom thickness of the main clip when laid on its side on the table.
clipHeight=12; // [4:40]
// this will essentially be used to set the thickness of the gap between model and support for the custom support at the back of the hinge.
layerHeight = 0.3;
// this allows you to tailor how thickly the hinge meshes together. A thin mesh will allow you to separate the two parts.
meshHeight=3; //[1:8]
// this is really about the tolerance of your printer and partly about how much stuff you intend to try to crush in the clip. It raises the head of the clip above it's default position.
clipClearance=.7;
// this lets you set the thickness of the hinge outer cylinder.
hingeGapAt=3; //[1:10]
// this lets you rotate the top part of the clip, thus letting you control how well you'll be able to fill your print bed.
topRotation=5.5; //[0:179]

module fillet(r, h) {
    difference() {
        cube([r + 0.01, r + 0.01, h], center = true);

        translate([r/2, r/2, 0])
            cylinder(r = r, h = h + 1, center = true);

    }
}



module arc(radiusID, radiusOD, height, angleR){
    translate([0,0,meshHeight])
//    rotate_extrude(angle=angleR)
//    polygon([[radiusID,0],[radiusOD,0],[radiusOD,clipHeight-(meshHeight*2)],[radiusID,clipHeight-(meshHeight*2)]]);

    intersection() {
        rotate_extrude()
        polygon([[radiusID,0],[radiusOD,0],[radiusOD,height],[radiusID,height]]);
        linear_extrude(height)
        polygon([[0,0],[radiusOD,0],[radiusOD,radiusOD],[radiusOD*cos(angleR)/sin(angleR),radiusOD]]);

    }

}


module clipBase() {
    difference() {
        union() {
            translate([length/2+clipThickness/4,-clipThickness/4,clipHeight/2])
            cube([length+clipThickness/2,clipThickness/2,clipHeight],center=true);
            cylinder(h=meshHeight-layerHeight,r=clipThickness/2);
            translate([0,0,clipHeight-(meshHeight-layerHeight)])
            cylinder(h=meshHeight-layerHeight,r=clipThickness/2);
            translate([length+clipThickness/2+1,-clipThickness/4+(clipThickness/2+2)/2-1,clipHeight/2])
            difference() {
                union() {
                    translate([0,clipClearance/2,0])
                    cube([1,clipThickness+clipClearance,clipHeight],center=true);
                    translate([-1,-clipThickness/2+0.5,0])
                    cube([1,1,clipHeight],center=true);
                    translate([-1+0.25,-clipThickness/2+0.25+1,0])
                    rotate([0,0,90])
                    fillet(0.5,clipHeight);

                }
                translate([0,-clipThickness/2+0.5,0])
                rotate([0,0,90])
                fillet(1,clipHeight+0.1);
            }
            translate([length+clipThickness/2-1.5,clipThickness/2+clipClearance,0])
            difference() {
                linear_extrude(clipHeight)
                polygon([[-1.5,0],[3,0],[3,3],[2,3],[-1.5,0.5]]);
                translate([2.5,2.5,clipHeight/2])
                rotate([0,0,180])
                fillet(1,clipHeight+0.1);
            }
        }
        translate([0,0,-0.05])
        cylinder(h=clipHeight+0.1,r=clipThickness/2-hingeGapAt);
        translate([length+clipThickness/2-1.99,-clipThickness/2+1.25,clipHeight/2])
    cube([4,0.5,clipHeight+0.1],center=true);

    }
    translate([clipThickness/2,0,clipHeight/4+clipHeight/2])
    rotate([0,90,0])
    linear_extrude(length)
    polygon([[0.2,0],[clipHeight/2-0.2,0],[clipHeight/4,clipThickness/4-0.2]]);
}
module clipTop() {
    difference() {
        rotate([0,0,topRotation])
        difference(){
            translate([length/2+clipThickness/4,+clipThickness/4,clipHeight/2])
            cube([length+clipThickness/2,clipThickness/2,clipHeight],center=true);
            translate([clipThickness/2-0.99,-0.01,clipHeight/4+clipHeight/2])
            rotate([0,90,0])
            linear_extrude(length+1)
            polygon([[0,0],[clipHeight/2,0],[clipHeight/4,clipThickness/4]]);
            translate([length+clipThickness/2-0.5,0.5,0])
            rotate([0,0,90])
            translate([0,0,clipHeight/2])
            fillet(1,clipHeight+1);
    //        translate([length+clipThickness/2-0.5,clipThickness/2-0.5,0])
    //        rotate([0,0,180])
    //        translate([0,0,clipHeight/2])
    //        fillet(1,clipHeight+1);
        }
        translate([0,0,-0.01])
        cylinder(h=meshHeight,r=clipThickness/2+0.5);
        translate([0,0,clipHeight-meshHeight+0.01])
        cylinder(h=meshHeight,r=clipThickness/2+0.5);

    }
    cylinder(h=clipHeight,r=clipThickness/2-hingeGapAt-0.5);
}
$fn=100;

clipBase();
clipTop();

// customSupport
rotate([0,0,114+topRotation/2])
arc(clipThickness/2-hingeGapAt,clipThickness/2,clipHeight-(meshHeight*2),145-topRotation);

