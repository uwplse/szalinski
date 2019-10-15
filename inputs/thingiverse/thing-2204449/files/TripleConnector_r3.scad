part = "inside"; // [inside: Inner Corners, outside: Outer Corners, tee: Tee Connector]

// Size of extrusion
extrusionSize = 20;

// Diameter of screwholes
screwSize = 5.2;

// Thickness of material
thickness = 3;

// Size of corner struts
strutSize = 20;

/* [Hidden] */
$fn=30;
// Radius of outer corners
cornerRadius = thickness; // This could be a variable, but it makes things less clean

if (part == "inside") rotate([135,35.26439,0]) tripleBracket();
else if (part == "outside") tripleEnd();
else if (part == "tee") teeBracket();

module tripleBracket()
{
    union()
    difference()
    {
        union()
        {
            translate([0,extrusionSize/2,0]) cornerBracket();
            rotate([0,0,270]) translate([0,-extrusionSize/2,0]) cornerBracket();
            rotate([270,0,270]) translate([0,extrusionSize/2,0]) cornerBracket();
            
            // add triangle base for printing
            hull()
            {
                translate([0,thickness/2,0]) sideWall();
                rotate([0,0,270]) translate([0,-thickness/2,0]) sideWall();
                rotate([270,0,270]) translate([0,thickness/2,0]) sideWall();
            }
        }
        
        // remove corners again
        translate([-extrusionSize/2,extrusionSize/2,extrusionSize/2]) cube([extrusionSize, extrusionSize, 2*extrusionSize], center=true);
        translate([extrusionSize/2,extrusionSize/2,-extrusionSize/2]) cube([2*extrusionSize,extrusionSize,extrusionSize], center=true);
        translate([-extrusionSize/2,-extrusionSize/2,-extrusionSize/2]) cube([extrusionSize,2*extrusionSize,extrusionSize], center=true);
    }
}

module tripleEnd()
{
    union()
    {
        translate([extrusionSize/2,extrusionSize/2,0]) faceCover();
        translate([0,extrusionSize/2,extrusionSize/2]) rotate([0,90,0]) faceCover();
        translate([extrusionSize/2,0,extrusionSize/2]) rotate([-90,0,0]) faceCover();
        
        // adding small corner supports
        translate([0,extrusionSize-thickness/2,0]) sideWall(thickness,strutSize);
        translate([extrusionSize-thickness/2,0,0]) rotate([0,0,90]) sideWall(thickness,strutSize);
        translate([0,0,extrusionSize-thickness/2]) rotate([-90,0,0]) sideWall(thickness,strutSize);
        
        // final sharp corner
        translate([thickness/2,thickness/2,thickness/2]) cube([thickness,thickness,thickness], center=true);
    }
}

module teeBracket()
{
    difference()
    {
        
        // make the base
        translate([0,0,(extrusionSize+thickness)/2])hull()
        {
            translate([-(extrusionSize-cornerRadius)/2, -(3*extrusionSize)/2, 0]) cylinder(d=cornerRadius, h=extrusionSize+thickness, center=true);
            translate([-(extrusionSize-cornerRadius)/2, (3*extrusionSize)/2, 0]) cylinder(d=cornerRadius, h=extrusionSize+thickness, center=true);
            translate([(extrusionSize)/2, -(3*extrusionSize)/2, 0]) cylinder(d=cornerRadius, h=extrusionSize+thickness, center=true);
            translate([(extrusionSize)/2, (3*extrusionSize)/2, 0]) cylinder(d=cornerRadius, h=extrusionSize+thickness, center=true);
            translate([(3*extrusionSize)/2, -(extrusionSize)/2, 0]) cylinder(d=cornerRadius, h=extrusionSize+thickness, center=true);
            translate([(3*extrusionSize)/2, (extrusionSize)/2, 0]) cylinder(d=cornerRadius, h=extrusionSize+thickness, center=true);
        }
        
        // remove the extrusion spaces
        translate([0,0,extrusionSize/2+thickness+.05]) 
        {
            cube([extrusionSize+.1, 4*extrusionSize, extrusionSize+.1], center=true);
            cube([4*extrusionSize, extrusionSize+.1, extrusionSize+.1], center=true);
        }
        
        // remove the space for screw access
        translate([0, 0, (extrusionSize+thickness)/2])
        {
            translate([extrusionSize+thickness, -(extrusionSize+thickness), 0]) cube([extrusionSize, extrusionSize, extrusionSize-thickness], center=true);
            translate([extrusionSize+thickness, (extrusionSize+thickness), 0]) cube([extrusionSize, extrusionSize, extrusionSize-thickness], center=true);
        }
        
        // remove base screw holes
        translate([0,0,0]) counterSunk();
        translate([0,-extrusionSize,0]) counterSunk();
        translate([0,extrusionSize,0]) counterSunk();
        translate([extrusionSize,0,0]) counterSunk();
        
        translate([extrusionSize/2+thickness, -extrusionSize, extrusionSize/2+thickness]) rotate([0,-90,0]) counterSunk();
        translate([extrusionSize/2+thickness, extrusionSize, extrusionSize/2+thickness]) rotate([0,-90,0]) counterSunk();
        translate([extrusionSize, -(extrusionSize/2+thickness), extrusionSize/2+thickness]) rotate([-90,0,0]) counterSunk();
        translate([extrusionSize, (extrusionSize/2+thickness), extrusionSize/2+thickness]) rotate([90,0,0]) counterSunk();
        
    }
}
module cornerBracket()
{
    union()
    {
        translate([0, -(extrusionSize-thickness)/2, 0]) sideWall(thickness,strutSize);
        translate([0, (extrusionSize-thickness)/2, 0]) sideWall(thickness,strutSize);
        
        translate([extrusionSize/2, 0, -0.01]) faceCover();
        translate([-0.01, 0, extrusionSize/2]) rotate([0,90,0])faceCover();
    }
}

module faceCover()
{
    difference()
    {
        hull() // square pad
        {
            translate([-(extrusionSize-cornerRadius)/2,-(extrusionSize-cornerRadius)/2,thickness/2]) cylinder(d=cornerRadius,h=thickness,center=true);
            translate([(extrusionSize-cornerRadius)/2,-(extrusionSize-cornerRadius)/2,thickness/2]) cylinder(d=cornerRadius,h=thickness,center=true);
            translate([-(extrusionSize-cornerRadius)/2,(extrusionSize-cornerRadius)/2,thickness/2]) cylinder(d=cornerRadius,h=thickness,center=true);
            translate([(extrusionSize-cornerRadius)/2,(extrusionSize-cornerRadius)/2,thickness/2]) cylinder(d=cornerRadius,h=thickness,center=true);
        }
        
        // screw hole
        translate([0,0,thickness]) rotate([180,0,0]) counterSunk();
    }
}

module sideWall(thickness=thickness, extrusionSize=extrusionSize)
{
    hull()
    {
        translate([thickness/2, 0, thickness/2]) cube([thickness, thickness, thickness], center = true);
        translate([extrusionSize-thickness/2, 0, thickness/2]) cylinder(d=thickness, h=thickness, center=true);
        translate([thickness/2, 0, extrusionSize-thickness/2]) rotate([0,90,0]) cylinder(d=thickness, h=thickness, center=true);

    }
}
module counterSunk(holeSize = screwSize)
{
    hull()
    {
        translate([0,0,-1]) cylinder(d=holeSize*2,h=2,center=true);
        translate([0,0,holeSize/2]) cylinder(d=holeSize,h=.1,center=true);
    }     
    cylinder(d=holeSize,h=10);
}