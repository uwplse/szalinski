//Diameter of rack (mm)
outerDiam = 130; 
rimRad = outerDiam/2;
// mm
rimWidth = 3;
// mm
rackHeight = 2;
// mm 
gridSpacing = 10;
// mm
extrusionWidth = 0.37;
// Grid line thickness is grid width * extrusion width 
gridWidth = 4; 
// mm
pillarWidth = 5;
//mm
pillarHeight = 25;
numBars = floor(outerDiam/2/gridSpacing);
$fn = 50;

difference()
{
    union()
    {
        translate([0,0,rackHeight/2])
        {
            // Rim
            difference()
            {
                cylinder(d=outerDiam,h=rackHeight,center=true);
                cylinder(d=outerDiam-rimWidth,h=rackHeight,center=true);
            }
            
            // Central cross
            
            cube([gridWidth*extrusionWidth,outerDiam,rackHeight],center=true);
            cube([outerDiam,gridWidth*extrusionWidth,rackHeight],center=true);
            
            // Grid
            for(i=[1:numBars])
            {
                chord = 2*sqrt(pow(rimRad,2)-pow(i*gridSpacing,2))-1.5;
                translate([i*gridSpacing,0,0])
                cube([gridWidth*extrusionWidth,chord,rackHeight],center=true);
                translate([-i*gridSpacing,0,0])
                cube([gridWidth*extrusionWidth,chord,rackHeight],center=true);
                translate([0,i*gridSpacing,0])
                cube([chord,gridWidth*extrusionWidth,rackHeight],center=true);
                translate([0,-i*gridSpacing,0])
                cube([chord,gridWidth*extrusionWidth,rackHeight],center=true);
            
            }
        }  // translate
    // Pillars
    
    translate([0,rimRad-pillarWidth/2,pillarHeight/2])
    {
        cube([pillarWidth,pillarWidth,pillarHeight],center=true);
        translate([0,0,pillarHeight/2])
        cylinder(d=pillarWidth-1.3,h=2);
       
    }
    translate([(rimRad-pillarWidth/2)*cos(30),-(rimRad-pillarWidth/2)*sin(30),pillarHeight/2])
    {
        rotate([0,0,-30])
        {
            cube([pillarWidth,pillarWidth,pillarHeight],center=true);
        }
        translate([0,0,pillarHeight/2])
        cylinder(d=pillarWidth-1,h=2);
    }
    
    translate([-(rimRad-pillarWidth/2)*cos(30),-(rimRad-pillarWidth/2)*sin(30),pillarHeight/2])
    {
        rotate([0,0,210])
        {
            cube([pillarWidth,pillarWidth,pillarHeight],center=true);
        }
        translate([0,0,pillarHeight/2])
        cylinder(d=pillarWidth-1,h=2);
    }
    }  // Union
    translate([0,rimRad-pillarWidth/2,0])
    cylinder(d=pillarWidth-1,h=2);
    translate([-(rimRad-pillarWidth/2)*cos(30),-(rimRad-pillarWidth/2)*sin(30),0])
    cylinder(d=pillarWidth-1,h=2);
    translate([(rimRad-pillarWidth/2)*cos(30),-(rimRad-pillarWidth/2)*sin(30),0])
    cylinder(d=pillarWidth-1,h=2);
    difference()
    {
        cylinder(d=outerDiam+rimWidth,h=rackHeight);
        cylinder(d=outerDiam,h=rackHeight);
    }


} // Difference