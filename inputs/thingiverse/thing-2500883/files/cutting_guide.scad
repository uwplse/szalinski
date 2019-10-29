// Length of the cutting guide
length = 160;
// Inner cutout for the screws
inner = 8.5;
// Thickness of the walls
walls = 3.5;
// Height of the cutting guide
height = 5;

/* [Guide] */
// Enable guide
guide = "enabled"; // [enabled: Enabled, disabled: Disabled]
// Width of the triangular guide
guideWidth = 8;
// Height of the triangular guide
guideHeight = 2;

/* [Ruler] */
ruler = "enabled"; // [enabled: Enabled, disabled: Disabled]
// Depth of the intendation
indentationDepth = 1.2;
// Inner width of intendation
indentationInner = 1;
// Outer width of intendation
indentationOuter = 1;
// Space between intendations
steps = 5;

/* [Hidden] */
$fn = 50;
innerRadius = inner / 2;
outerRadius = innerRadius + walls;
offsetY = guideWidth / 2 + walls;
offsetY = innerRadius + guideWidth / 2 + walls / 2;

difference() {
    hull() {
        translate([0, length / 2 - outerRadius, 0])
            cylinder(r = outerRadius, h = height);

        translate([0, -length / 2 + outerRadius, 0])
            cylinder(r = outerRadius, h = height);
    }

    hull() {
        translate([0, length / 2 - innerRadius - walls, -1])
            cylinder(r = innerRadius, h = height + 2);

        translate([0, offsetY, -1])
            cylinder(r = innerRadius, h = height + 2);
    }
    
    hull() {
        translate([0, -offsetY, -1])
            cylinder(r = innerRadius, h = height + 2);

        translate([0, -length / 2 + outerRadius, -1])
            cylinder(r = innerRadius, h = height + 2);
    }
    
    if(ruler == "enabled") {
        for(i=[0:1:(length / 2 / steps - outerRadius / steps)]) {
            hull() {
                translate([-outerRadius + indentationDepth, steps * i - indentationInner / 2, -1])
                    cube([0.1, indentationInner, height + 2]);
            
                translate([-(outerRadius + indentationDepth), steps * i - indentationOuter / 2, -1])
                    cube([0.1, indentationOuter, height + 2]);
            }
        }

        for(i=[0:-1:-(length / 2 / steps - outerRadius / steps)]) {
            hull() {
                translate([-outerRadius + indentationDepth, steps * i - indentationInner / 2, -1])
                    cube([0.1, indentationInner, height + 2]);
            
                translate([-(outerRadius + indentationDepth), steps * i - indentationOuter / 2, -1])
                    cube([0.1, indentationOuter, height + 2]);
            }
        }
    }
}

if(guide == "enabled") {
    hull() {
        translate([-outerRadius, -guideWidth / 2, height - 0.1])
            cube([outerRadius * 2, guideWidth, 0.1]);
        
        translate([-outerRadius, 0.05, height + guideHeight - 0.1])
            cube([outerRadius * 2, 0.1, 0.1]);
    }
}