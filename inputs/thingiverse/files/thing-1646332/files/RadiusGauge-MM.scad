// Radius Gauge
//
// This radius gauge has five gauging surfaces, 90 and 180 degree convex and
// 45, 90 and 180 degree concave.
//
// To configure for a specific size, you need to set three variables:
//   - number - The radius of the curves, without units
//   - unit - The unit text to appear on the gauge
//   - scale - The scale factor to apply to the number.  For metric, use 1
//             and for inches, use 25.4.  For fractional inches, you can also
//             use a fraction of 25.4, e.g. 25.4/32 for 32nds.
//

// Metric
// Radius, in mm
Radius = 10;
number = Radius;
unit = "mm";
scale = 1;

// Other Settings
// Thickness, in mm
Thickness = 2;
// Text depth, in mm
TextDepth = 1;
// Hole diameter, in mm
HoleDiameter = 8;
// Number of curve facets
CurveResolution = 180; // [6:360]


radius = number * scale;
diameter = radius * 2;
minimumWidth = .75 * 25.4;
width = max(diameter, minimumWidth);

holeRadius = HoleDiameter/2;

holeOffset = max( radius - sqrt(pow(radius-2*holeRadius,2)/2), 2*holeRadius);

$fn=CurveResolution;

difference() {
    union() {
        translate([radius, radius, 0]) {
            cylinder(Thickness, radius, radius);
        }
        translate([radius,0,0]) {
            cube([1.5*width, width, Thickness]);
        }
        translate([0,radius,0]) {
            cube([width, width + radius + (width-radius)/3, Thickness]);
        }

        translate([1.5*width+radius,0,0])
            rotate([0,0,45])
                cube([sqrt(width*width/2),sqrt(width*width/2),Thickness]);

        translate([0,width + 2 * radius + (width-radius)/3,0])
            rotate([0,0,-45])
                cube([sqrt(width*width/2),sqrt(width*width/2),Thickness]);

        translate([width/2,2*width+radius,0])
            cylinder(Thickness,radius,radius);
        
        translate([(width-diameter)/2,1.5*width,0])  
            cube([radius*2,width/2 + radius,Thickness]);

        translate([width,width,0])
            cube([radius,radius,Thickness]);
    }
    
    translate([width+radius,width+radius,0])
        cylinder(Thickness,radius,radius);
    
    translate([0,width+radius,0])
        cylinder(Thickness,radius,radius);
    
    translate([2*width + radius,width/2,0])
        cylinder(Thickness,radius,radius);
        
    translate([holeOffset + holeRadius, 2*width/3,Thickness-TextDepth])
        linear_extrude(Thickness)
            text("C42",width/4,font="Agency FB");
    
    translate([holeOffset + holeRadius + 1.2,width/3,Thickness-TextDepth])
        linear_extrude(Thickness)
            text(str(number,unit),width/4);
    
    translate([holeOffset, holeOffset, 0])
        cylinder(Thickness,holeRadius,holeRadius);

}
