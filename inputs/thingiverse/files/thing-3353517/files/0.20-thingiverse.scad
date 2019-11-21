/* [tube] */

outerDiameter = 25;
innerDiameter = 23;
 
/* [outcut] */

labiumWidth = 16;
outCut = 4;
flueWidth = 0.8;
 
/* [other] */
 
// of future pipe
totalLength = 220;      
corpus_angle = 3.14;
minWallThickness = 1.2;
floorThickness = 2;
 
/* [air tube] */

outerTube = 11;
innerTube = 8;

// proportions, are most likely good like that
lengthFlue = totalLength / 8;
tubeInsert = outerTube + 2.5;       // length
pipeInsert = innerDiameter * 0.1 + 5; // length
height = floorThickness
    + lengthFlue
    + labiumWidth /2
    + tubeInsert; 
    
// calculations, don't touch in production use
ground = (lengthFlue + floorThickness)*-1;
airSupplyY = - outerDiameter/2;
soundingLength = height - pipeInsert - floorThickness;
labium_polygon_points = 
    [[airSupplyY - 2*minWallThickness, -outCut],
    [airSupplyY - 2*minWallThickness, outCut],
    [airSupplyY, 0],
    [airSupplyY + 2*minWallThickness, outCut],
    [airSupplyY + 2*minWallThickness, -outCut]];

// logic
rotate([0, 45, 0])
difference(){
    union(){
        basicShape20(height, corpus_angle); 
        outer_straight_flue_20();
        vertical_version_number_20 ("0.20", corpus_angle);
    };
    union(){
        inner_straight_flue_20(); 
        airSupplySpacer();
        straight_labium_cut_20();
    };
};

// modules
module basicShape20(height, corpus_angle)
rotate ([0, corpus_angle, 0])
translate ([0, 0, ground]) union(){
    difference(){   
        union(){
        union(){
            intersection(){
                rotate ([0, 0, 30]) 
                    cylinder_outer(height, (outerDiameter*0.5+minWallThickness), 6);
                translate ([0,0,(height/2)]) 
                    cube ([outerDiameter*2, (sqrt(3)*(outerDiameter*0.5+minWallThickness)), height], center = true);
            };
            cylinder(height, r=(outerDiameter/2 + minWallThickness), $fn=(30+outerDiameter)); 
        }; 
            translate ([0, 0, -ground]) rotate([90, 0, 0])
                cylinder(outerDiameter/2 + minWallThickness, outerDiameter/2, labiumWidth/sqrt(2));
        };
        union(){
            translate ([0, 0, floorThickness]) 
                cylinder(height, r=innerDiameter/2, center=false, $fn=(10+outerDiameter));
            translate ([0, 0, (height - pipeInsert)]) 
                cylinder(height, r=outerDiameter/2, center=false, $fn=(10+outerDiameter));
            translate ([0, 0, -ground]) rotate([90, 0, 0])
                cylinder(innerDiameter/2, innerDiameter/2, labiumWidth/sqrt(2) - minWallThickness);
        };
    };
}

module cylinder_outer(height,radius,fn){  	//from https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/undersized_circular_objects
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);
}
   
module airSupplySpacer(x=0){
    translate ([x, airSupplyY, (ground - 0.1 - tubeInsert)]) 
    cylinder (2*tubeInsert, r=outerTube/2, center=false, $fn=(20+outerTube));
}

module straight_labium_cut_20(){
    translate ([-labiumWidth/2,0,0])
        rotate([90, 0, 90])
            linear_extrude(labiumWidth, $fn=50) 
                polygon(points = labium_polygon_points);
}
 
module straight_flue_loft_20(upperDiameter, lowerDiameter, loftCeiling, loftFloor){
    union(){
        // tube
        hull($fn=(20+outerTube)){
            translate([0, airSupplyY, loftFloor]) 
                cylinder(h=0.01, r=lowerDiameter/2, center=true);
            translate([0, airSupplyY, (ground + tubeInsert)])
                cylinder(h=0.01, r=lowerDiameter/2, center=true);
        }
        // straight flue
            hull($fn=(20+outerTube)){
            translate ([labiumWidth*-0.45, airSupplyY, loftCeiling]) 
                cylinder (0.01, r=upperDiameter/2);
            translate ([labiumWidth*0.45, airSupplyY, loftCeiling]) 
                cylinder (0.01, r=upperDiameter/2);
            translate ([0, airSupplyY, (loftFloor + tubeInsert)]) 
                cylinder (0.01, r=lowerDiameter/2);
        };
    };
}

module outer_straight_flue_20(){
    straight_flue_loft_20(    
        upperDiameter = (flueWidth + 2 * minWallThickness), 
        lowerDiameter = (outerTube + 2 * minWallThickness),
        loftCeiling = -outCut,
        loftFloor = ground
    );
}

module inner_straight_flue_20(){
    straight_flue_loft_20(
        upperDiameter = flueWidth, 
        lowerDiameter = innerTube, 
        loftCeiling = 0.1 - outCut, 
        loftFloor = (ground -0.1)
    ); 
}

module vertical_version_number_20 (number, corpus_angle = 0)
    rotate ([0, corpus_angle, 0])
        translate ([outerDiameter*-0.5 +0.3 - minWallThickness, 0, -lengthFlue])
            rotate ([90,-90,-90])
                linear_extrude(1) 
union(){
    text(text=str("pipe: ", number), size=outerDiameter*0.18, valign = "bottom", font = "Open Sans:style=SemiBold");
    text(text=str("angle: ", corpus_angle, "\u00B0"), size=outerDiameter*0.18, valign = "top", font = "Open Sans:style=SemiBold");
}
