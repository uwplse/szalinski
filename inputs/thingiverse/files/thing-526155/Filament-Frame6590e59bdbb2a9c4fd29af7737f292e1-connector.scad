// 5/64ths
// 3/4
// 3/4

// Which part to print
part = "corner"; // [corner:Corner, beamRest:Beam rest]

// How round should the holes be?
ROUNDNESS=5; //[0:50]

units = "in"; //[in:Inches, mm:mm]

conversion = (units=="in")?25.4:1;


// This is the size of each of the legs of the beam
beamWidth = .75;

// This is the thickness of the beam (5/64)
thicknessOfBeam = 0.078125;

// how thick should the walls be? (5/64)
wallThickness = 0.078125;

// spacing between parts
printerTolerance = .006;

beamThickness = thicknessOfBeam * conversion;
beamSize = beamWidth * conversion;
// sorry, mm only
tolerance = printerTolerance * conversion;

thickness = wallThickness * conversion;

// depth of the pieces
pieceDepth = .75;
depth = pieceDepth * conversion;

// radius of the hole
holeSize = 0.09375;
holeRad = holeSize * conversion;

// The amount of overhang on the beam rest
overhang = 1;

module connector(connectorDepth = depth, support1 = false, support2 = false)
{
    difference(){
        linear_extrude(connectorDepth)
        {
                polygon(points=[[0,0], [beamSize + 2*(tolerance + thickness), 0],
            [beamSize + 2 * (tolerance + thickness), beamThickness + 2* (thickness + tolerance)],
            [2*(tolerance + thickness) + beamThickness, beamThickness + 2* (thickness + tolerance)],
            [2*(tolerance + thickness) + beamThickness, 2*(tolerance + thickness) + beamSize],
            [0,2*(tolerance + thickness) + beamSize],
            
            [thickness, thickness], [thickness + beamSize + 2 * tolerance, thickness],
            [thickness + beamSize + 2 * tolerance, thickness + 2 * tolerance + beamThickness],
            [thickness + 2 * tolerance + beamThickness, thickness + 2 * tolerance + beamThickness],
            [thickness + 2 * tolerance + beamThickness, 2 * tolerance + beamSize + thickness],
            [thickness, 2 * tolerance + beamSize + thickness]], paths=[[0,1,2,3,4,5], [6,7,8,9,10,11]]);
            
            if(support1)
            {
                translate([thickness + 2 * tolerance + beamThickness, thickness-.5, 0])
                    square(size=[.2, beamThickness+2*tolerance+1]);
                //translate([2*(thickness + tolerance) + beamThickness, thickness-.5, 0])
                 //   square(size=[.2, beamThickness+2*tolerance+1]);
            }
            if(support2)
            {
                translate([thickness-.5, thickness + 2 * tolerance + beamThickness, 0])
                    square(size=[beamThickness+2*tolerance+1, .2]);
                //translate([thickness-.5, 2 * (thickness + tolerance) + beamThickness, 0])
                //    square(size=[beamThickness+2*tolerance+1, .2]);
            }
        }
            
        if(holeRad > 0)
        {
            // holes
            translate([(beamSize + 2 * (tolerance + thickness))/2,-.5,connectorDepth/2])
                rotate([-90,0,0])cylinder(h=beamThickness + 2* (thickness + tolerance)+1, r=holeRad, $fn=ROUNDNESS);
                    
            translate([-.5,(beamSize + 2 * (tolerance + thickness))/2,connectorDepth/2])
                rotate([0,90,0])cylinder(h=beamThickness + 2* (thickness + tolerance)+1, r=holeRad, $fn=ROUNDNESS);
        }
    }
}
module angleBracket()
{
    cubeSize = beamSize + 2 * (tolerance+thickness);
translate([cubeSize,cubeSize,0])rotate([90,0,180])connector(support1 = true);
translate([0,0,0])rotate([0,-90,0])connector(support2 = true);
translate([cubeSize,0,0])rotate([0,0,90])connector();
    cube(size=[cubeSize, cubeSize, 2*thickness]);
}



module beamRest(length = 25)
{
    // sqrt(a * a + a * a) = sqrt(2) * a
    width = sqrt(2)*(depth+2*(thickness + tolerance));
    
    connector(connectorDepth=width);
    translate([beamSize + thickness + 2*tolerance,0,0]){
        cube(size=[length,2*(thickness+tolerance) + beamThickness, width]);
    }
    translate([beamSize + thickness+tolerance, -2*thickness, 0])
        cube(size=[length, 3*thickness, thickness]);
    
    translate([beamSize + thickness+tolerance, -2*thickness, width -thickness ])
        cube(size=[length, 3*thickness, thickness]);
    
    //crossbeam
    translate([beamSize + thickness+tolerance, -2*thickness, 0])
        cube(size=[thickness, thickness, width]);
}

module ring(id, od, depth)
{
    difference()
    {
        cylinder(r=od, h=depth, $fn=ROUNDNESS);
        translate([0,0,-1])cylinder(r=id, h=depth+2, $fn=ROUNDNESS);
    }
}

if(part == "beamRest")
{
    beamRest(length = overhang * conversion);
}

if(part == "corner" || pieceToPrint == "all")
{
    angleBracket();
}




