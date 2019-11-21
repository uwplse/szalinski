// GuSty Gundam Stand by skytale

/* [Gundam Gunpla Stand] */
// Height:
height = 65; // [40:150]
// Diameter:
diameter = 60; // [50:100]
// Mount type:
mount = 2; // [1:cylinder, 2:prism]

/* [Misc Parameters] */
baseHeight = 5;
mountHeight = 4.5;
cylinderDiameter = 3;

prismWidth = 4.5;
prismEdgeRadius = 1;

cornerRadius = 1.5;

poleBaseDiameter = 18;
poleMiddleDiameter = 10;
poleTopDiameter = 5;
poleMiddleHeight = 10;

transitionHeight = 10;

/* [Hidden] */
fn = 40;

base();
translate([0,0,baseHeight]) pole();
if(mount == 1) translate([0,0,baseHeight + height - transitionHeight]) cylinderMount();
if(mount == 2) translate([0,0,baseHeight + height - transitionHeight]) prismMount();


module base() {
	cylinder(baseHeight - cornerRadius,diameter/2,diameter/2,$fn = fn);
	cylinder(baseHeight, diameter/2-cornerRadius, diameter/2-cornerRadius,$fn = fn);
	translate([0,0,baseHeight-cornerRadius]) rotate_extrude(convexity = 10) translate([diameter/2 - cornerRadius, 0, 0]) circle(r = cornerRadius, $fn = 100);
}

module pole() {
	cylinder(poleMiddleHeight,poleBaseDiameter/2,poleMiddleDiameter/2,$fn = fn);
	translate([0,0,poleMiddleHeight]) cylinder(height-poleMiddleHeight-transitionHeight, poleMiddleDiameter/2, poleTopDiameter/2, $fn = fn);
}


module cylinderMount() {
	cylinder(transitionHeight, poleTopDiameter/2, cylinderDiameter/2, $fn = fn);
	translate([0,0,transitionHeight]) cylinder(mountHeight, cylinderDiameter/2, cylinderDiameter/2, $fn = fn);
}

module prismMount() {
	translate([0,0,transitionHeight]) hull() {
		translate([0,0,(mountHeight-prismEdgeRadius)/2]) cube([prismWidth, prismWidth, mountHeight - prismEdgeRadius], center=true);
		translate([-prismWidth/2 + prismEdgeRadius, +prismWidth/2 - prismEdgeRadius, mountHeight-prismEdgeRadius]) sphere(prismEdgeRadius, $fn = fn);
		translate([+prismWidth/2 - prismEdgeRadius, +prismWidth/2 - prismEdgeRadius, mountHeight-prismEdgeRadius]) sphere(prismEdgeRadius, $fn = fn);
		translate([+prismWidth/2 - prismEdgeRadius, -prismWidth/2 + prismEdgeRadius, mountHeight-prismEdgeRadius]) sphere(prismEdgeRadius, $fn = fn);
		translate([-prismWidth/2 + prismEdgeRadius, -prismWidth/2 + prismEdgeRadius, mountHeight-prismEdgeRadius]) sphere(prismEdgeRadius, $fn = fn);
		translate([0,0,-transitionHeight]) cylinder(transitionHeight, poleTopDiameter/2, poleTopDiameter/2, $fn = fn);
	}

}