/* [tube] */

outerDiameter = 25;
innerDiameter = 23;
 
/* [outcut] */

labiumWidth = 16;
outCut = 4;
flueWidth = 0.8;
 
/* [other] */
 
// sounding length below the labium
lengthFlue = 24;
minWallThickness = 1.2;
floorThickness = 2;
 
/* [air tube] */

outerTube = 11;
innerTube = 8;


// proportions, are most likely good like that
tubeInsert = outerTube + 2.5;       // length
pipeInsert = innerDiameter * 0.1 + 5; // length
height = floorThickness
    + lengthFlue
    + outCut 
    + innerDiameter *0.4
    + labiumWidth *0.4; 
    
// calculations, don't touch in production use
labium_angle = labiumWidth * 360 / outerDiameter / PI;
ground = (lengthFlue + floorThickness)*-1;
soundingLength = height - pipeInsert - floorThickness;
airSupplyY = labium_angle > 60 ? 
    1/cos(30) * (outerDiameter*-0.5 - minWallThickness) + labiumWidth * tan(30) * 0.5 : 
    sqrt((outerDiameter+2*minWallThickness)*(outerDiameter+2*minWallThickness) 
    - labiumWidth*labiumWidth)/-2; 
labium_polygon_points = 
    [[0,0],
    [0, outCut - 2*airSupplyY],
    [airSupplyY, outCut],
    [2*airSupplyY, outCut - 2*airSupplyY],
    [2*airSupplyY,0]];
labium_plus_points = 
    [[2*airSupplyY, outCut - 2*airSupplyY],
    [2*airSupplyY + minWallThickness, outCut - 2*airSupplyY + 2*minWallThickness],
    [airSupplyY + minWallThickness, outCut + 2*minWallThickness],
    [airSupplyY, outCut]];

// announcing sounding length
echo(str("the sounding length inside the model in mm: ", soundingLength));

// flueLength warning
if (lengthFlue < outerTube * 2)
    echo("lengthFlue is too short");

// logic
difference(){
    union(){                    // fusion plus
        basicShapeFlat(height); 
        straight_flue_fill();
        straight_labium_fill();
        outer_straight_flue();
    };
    union(){                    // fusion minus
        straight_labium_cut();
        inner_straight_flue(); 
        airSupplySpacer();
    };
};

// version number
version_number ("0.5.2");

echo(version = version());

// modules/support

module basicShapeFlat(height)
translate ([0, 0, ground]) union(){
    difference(){
        union(){
            intersection(){
                rotate ([0, 0, 30]) 
                    cylinder_outer(height, (outerDiameter*0.5+minWallThickness), 6);
                translate ([0,0,(height/2)]) 
                    cube ([outerDiameter*2, (sqrt(3)*(outerDiameter*0.5+minWallThickness)), height], center = true);
            };
            cylinder(height, d=(outerDiameter + 2* minWallThickness), $fn=(30+outerDiameter)); 
        };
        union(){
            translate ([0, 0, floorThickness]) 
                cylinder(height, d=innerDiameter, center=false, $fn=(10+outerDiameter));
            translate ([0, 0, (height - pipeInsert)]) 
                cylinder(height, d=outerDiameter, center=false, $fn=(10+outerDiameter));
            translate([outerDiameter*-1, airSupplyY - outerDiameter - minWallThickness, -0.1])
                cube([outerDiameter*2, outerDiameter, floorThickness + lengthFlue + 0.2]);
        };
    };
}

module cylinder_outer(height,radius,fn){  	//from https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/undersized_circular_objects
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);
}
   
module airSupplySpacer(x=0){
    translate ([x, airSupplyY, (ground-0.1)]) 
    cylinder (tubeInsert, d=outerTube, center=false, $fn=(20+outerTube));
}

module version_number (number)
translate ([outerDiameter*0.5 + minWallThickness, outerDiameter*-0.25, -lengthFlue])
    rotate ([90,0,90]) linear_extrude(1) 
        text(text=str(number), size=outerDiameter*0.13);


module straight_labium_cut(){
    intersection(){
        translate ([-labiumWidth/2,0,0])
            rotate([90, 0, 90])
                linear_extrude(labiumWidth, $fn=50) 
                    polygon(points = labium_polygon_points);
        translate([labiumWidth*-0.25, 2*airSupplyY - labiumWidth*0.25, 0]) 
            minkowski(){
                cube([labiumWidth/2, -2*airSupplyY, -2*airSupplyY]);
                cylinder(r=labiumWidth/4,h=-2*airSupplyY);
            }
    }
};

module straight_labium_fill(){
    intersection(){
        translate ([-labiumWidth/2,0,0])
            rotate([90, 0, 90])
                linear_extrude(labiumWidth, $fn=50) 
                    polygon(points = labium_plus_points);
        cylinder(outerDiameter, d=outerDiameter);
    }
}

module curvedFlueLoft(upperDiameter, lowerDiameter, loftCeiling, loftFloor){
    union(){
        // tube
        hull($fn=(20+outerTube)){
        	translate([0, airSupplyY, loftFloor]) 
                cylinder(h=0.01, d=lowerDiameter, center=true);
        	translate([0, airSupplyY, (ground + tubeInsert)])
                cylinder(h=0.01, d=lowerDiameter, center=true);
        }
        // straight flue
            hull($fn=(20+outerTube)){
            translate ([labiumWidth*-0.45, airSupplyY, loftCeiling]) 
                cylinder (0.01, d=upperDiameter);
            translate ([labiumWidth*0.45, airSupplyY, loftCeiling]) 
                cylinder (0.01, d=upperDiameter);
            translate ([0, airSupplyY, (loftFloor + tubeInsert)]) 
                cylinder (0.01, d=lowerDiameter);
        };
    };
}

module outer_straight_flue(){
    curvedFlueLoft(    
        upperDiameter = (flueWidth + 2 * minWallThickness), 
        lowerDiameter = (outerTube + 2 * minWallThickness),
        loftCeiling = 0,
        loftFloor = ground
    );
}

module inner_straight_flue(){
    curvedFlueLoft(
        upperDiameter = flueWidth, 
        lowerDiameter = innerTube, 
        loftCeiling = 0.1, 
        loftFloor = (ground-0.1)
    ); 
}

module straight_flue_fill(){
translate ([0, 0, ground])
    intersection(){
        cylinder(height, d=(outerDiameter + 2* minWallThickness));
        translate([labiumWidth*-0.5, airSupplyY  - minWallThickness, 0])
            cube([labiumWidth, 2*minWallThickness, floorThickness + lengthFlue]);
    } 
}