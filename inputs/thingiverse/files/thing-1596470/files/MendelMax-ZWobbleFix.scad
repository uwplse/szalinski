/* [General] */
// Tolerance for inner diameters
tolerance = 0.5;

/* [Threaded rod] */
// Rod diameter
rodDiameter = 8.0;
// Nut diameter
rodNutDiameter = 15.0;

/* [Guide/smooth rod] */
// Rod diameter
guideDiameter = 8.0;
// Distance to the threaded rod
guideDistance = 27.0;

/* [Base part] */
// Diameter
baseOuterDiameter = 30.0;
// Width of the tip
baseTipWidth = 16.0;
// Length of the tip
baseTipLength = 35.0;
// Height
baseHeight = 3.0;

/* [Container part] */
// Outer diamter of the cylinder
tensionerOuterDiameter = 20.0;
// Overall height
tensionerHeight = 25.0;
// Roof height
tensionerRoofHeight = 5.0;

mainPart();

module mainPart() {
    union() {
        basePart(baseOuterDiameter, baseHeight, baseTipWidth, baseTipLength, rodDiameter + tolerance, guideDiameter + tolerance, guideDistance);
        
        translate([0,0,baseHeight - 0.001])
        rotate([0, 0, -90])
            tensionPart(tensionerOuterDiameter, tensionerHeight + 0.001, tensionerRoofHeight, rodDiameter + tolerance, rodNutDiameter + tolerance);
    }
}

module basePart(baseOuterDiameter = baseOuterDiameter, baseHeight = baseHeight, baseTipWidth = baseTipWidth, baseTipLength = baseTipLength, rodDiameter = rodDiameter, guideDiameter = guideDiameter, guideDistance = guideDistance) {
    
    rodRadius = rodDiameter / 2;
    baseOuterRadius = baseOuterDiameter / 2;
    guideRadius = guideDiameter / 2;
    
    difference() {
        // Create base shape
        union() {
            cylinder(h = baseHeight, r1 = baseOuterRadius, r2 = baseOuterRadius, $fn = 90);
            
            translate([0,baseTipLength/2,0])
            trapezoid(w1 = baseOuterDiameter, w2 = baseTipWidth, h = baseHeight, d = baseTipLength);
        }
        
        // Cut out hole for rod
        translate([0,0,-0.5])
            cylinder(h = baseHeight + 1, r1 = rodRadius, r2 = rodRadius, $fn = 64);
        
        // Cut out hole for guide
        translate([0,guideDistance,-0.001])
            cylinder(h = baseHeight + 0.002, r1 = guideRadius, r2 = guideRadius, $fn = 64);
        translate([0,guideDistance + baseTipLength / 2,-0.001])
            box(guideDiameter, baseTipLength, baseHeight + 0.002);
    }
}

module tensionPart(tensionerOuterDiameter = tensionerOuterDiameter, tensionerHeight = tensionerHeight, tensionerRoofHeight = tensionerRoofHeight, rodDiameter = rodDiameter, rodNutDiameter = rodNutDiameter) {
    
    rodRadius = rodDiameter / 2;
    nutInlayHeight = tensionerHeight - tensionerRoofHeight;
    nutRadius = rodNutDiameter / 2;
    tensionerOuterRadius = tensionerOuterDiameter / 2;
    
    difference() {            
        cylinder(h = tensionerHeight, r1 = tensionerOuterDiameter / 2, r2 = tensionerOuterDiameter / 2, $fn = 80);
        
        // Cut out hole for rod
        translate([0,0,nutInlayHeight-0.001])
            cylinder(h = tensionerRoofHeight + 0.002, r1 = rodRadius, r2 = rodRadius, $fn = 64);
        translate([0,0,nutInlayHeight-0.001])
            cylinder(h = tensionerRoofHeight / 3 * 2 + 0.002, r1 = nutRadius, r2 = rodRadius, $fn = 6);
        
        // Cut out hole for the nut
        translate([0, 0, -0.001])
            cylinder(h=nutInlayHeight + 0.002, r1=nutRadius, r2=nutRadius, $fn = 6);
        translate([0, tensionerOuterRadius, -0.001])
            box(rodNutDiameter, tensionerOuterDiameter, nutInlayHeight / 2 + 0.002);
            
        rotate([90, 0, 0])
        translate([0, nutInlayHeight * 0.75 - 0.001, -tensionerOuterRadius])
            trapezoid(w1 = rodNutDiameter, w2 = 0.1, h = tensionerOuterRadius, d = nutInlayHeight / 2 + 0.002);
    }
}

/* 2d shapes */

module triangle(radius)
{
  o=radius/2; //equivalent to radius*sin(30)
  a=radius*sqrt(3)/2; //equivalent to radius*cos(30)
  polygon(points=[[-a,-o],[0,radius],[a,-o]],paths=[[0,1,2]]);
}

module rectangle(width, depth)
{
    polygon(points=[[-width/2,-depth/2],[width/2,-depth/2],[width/2,depth/2],[-width/2,depth/2]],paths=[[0,1,2,3]]);
}

/*
 * 3d shapes
 */

module box(width, depth, height)
{
    linear_extrude(height=height) 
        rectangle(width, depth);
}

module trapezoid(w1, w2, h, d) {
    linear_extrude(height=h) 
        polygon(points=[[-w1/2,-d/2],[w1/2,-d/2],[w2/2,d/2],[-w2/2,d/2]],paths=[[0,1,2,3]]);
}