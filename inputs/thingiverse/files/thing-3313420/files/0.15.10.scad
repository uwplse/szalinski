
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
    + labiumWidth / sqrt(2)
    + tubeInsert; 
    
// calculations, don't touch in production use
ground = (lengthFlue + floorThickness)*-1;
airSupplyX = (ground + tubeInsert) / sqrt(2);
airSupplyY = - outerDiameter/2;
soundingLength = height - pipeInsert - floorThickness;
labium_polygon_points = 
    [[airSupplyY - 2*minWallThickness,0],
    [airSupplyY - 2*minWallThickness, outCut*2],
    [airSupplyY, outCut],
    [airSupplyY + 2*minWallThickness, outCut*2],
    [airSupplyY + 2*minWallThickness,0]];

// announcing sounding length
echo(str("the sounding length inside the model in mm: ", soundingLength));

// logic
difference(){
    union(){
        basicShape15(height); 
        outer_45_flue();
    };
    union(){
        inner_45_flue(); 
        airSupplySpacer(x=airSupplyX);
        labium_cut();
    };
};

// version number
vertical_version_number ("0.15.10");

echo(version = version());


// modules/support

module vertical_version_number (number)
translate ([outerDiameter*0.5 - 0.3 + minWallThickness, outerDiameter*0.05, -lengthFlue])
rotate ([90,-90,90])
linear_extrude(1) 
text(text=str(number), size=outerDiameter*0.15);


module labium_cut(){
    translate([-outCut/sqrt(2), 0, -outCut/sqrt(2)])
    rotate([0, 45, 0])
        translate ([-labiumWidth/2,0,0])
            rotate([90, 0, 90])
                linear_extrude(labiumWidth, $fn=50) 
                    polygon(points = labium_polygon_points);
};

module flueLoft45(upperDiameter, lowerDiameter, loftCeiling, loftFloor){
    union(){
        // tube
        hull($fn=(20+outerTube)){
        	translate([airSupplyX, airSupplyY, loftFloor]) 
                cylinder(h=0.01, d=lowerDiameter, center=true);
        	translate([airSupplyX, airSupplyY, (ground + tubeInsert)])
                cylinder(h=0.01, d=lowerDiameter, center=true);
        }
        // straight flue
        hull($fn=(20+outerTube)){
            translate([-outCut/sqrt(2), 0, -outCut/sqrt(2)]) rotate([0, 45, 0]) hull(){               
                translate ([labiumWidth*-0.45, airSupplyY, loftCeiling]) 
                    cylinder (0.01, d=upperDiameter);
                translate ([labiumWidth*0.45, airSupplyY, loftCeiling]) 
                    cylinder (0.01, d=upperDiameter);
            };       
            translate ([airSupplyX, airSupplyY, (loftFloor + tubeInsert)]) 
                cylinder (0.01, d=lowerDiameter);
        };
    };
}

module outer_45_flue(){
    flueLoft45(    
        upperDiameter = (flueWidth + 2 * minWallThickness), 
        lowerDiameter = (outerTube + 2 * minWallThickness),
        loftCeiling = 0,
        loftFloor = ground
    );
}

module inner_45_flue(){
    flueLoft45(
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
  
module airSupplySpacer(x=0){
    translate ([x, airSupplyY, (ground-0.1)]) 
    cylinder (tubeInsert, d=outerTube, center=false, $fn=(20+outerTube));
}

module basicShape15(height)
translate ([0, 0, ground]) union(){
    difference(){   
	    union(){
            cylinder(height, d=(outerDiameter + 2* minWallThickness), $fn=(30+outerDiameter)); 
            translate ([0, 0, -ground]) rotate([90, 0, 0])
                cylinder(outerDiameter/2 + minWallThickness, outerDiameter/2, labiumWidth/sqrt(2));
        };
        union(){
        	translate ([0, 0, floorThickness]) 
                cylinder(height, d=innerDiameter, center=false, $fn=(10+outerDiameter));
        	translate ([0, 0, (height - pipeInsert)]) 
                cylinder(height, d=outerDiameter, center=false, $fn=(10+outerDiameter));
            translate ([0, 0, -ground]) rotate([90, 0, 0])
                cylinder(innerDiameter/2, innerDiameter/2, labiumWidth/sqrt(2) - minWallThickness);
        };
    };
};