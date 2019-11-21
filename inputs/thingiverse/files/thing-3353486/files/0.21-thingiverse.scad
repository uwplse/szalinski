// flue pipe

/* [tube] */

outerDiameter = 25;
innerDiameter = 23;
 
/* [outcut] */

labiumWidth = 16;
outCut = 4;
flueWidth = 0.8;
 
/* [other] */
 
// total length of future pipe
totalLength = 220;
minWallThickness = 1.2;
floorThickness = 2;
// 1 for yes
connector = 0;    
 
/* [air tube] */

outerTube = 11;
innerTube = 8;


// proportions, are most likely good like that
lengthFlue = totalLength / 8;
tubeInsert = outerTube + 2.5;       // length
pipeInsert = innerDiameter * 0.1 + 5; // length
height = floorThickness
    + lengthFlue
    + labiumWidth / 2
    + tubeInsert; 
soundingLength = height - pipeInsert - floorThickness;

// announcing sounding length
echo(str("the sounding length inside the model in mm: ", soundingLength));

// announcing tube length
echo(str("tube needed (in mm): ", totalLength - soundingLength));
    
// calculations, don't touch in production use
ground = (lengthFlue + floorThickness)*-1;
airSupplyX = -innerDiameter/2 - outCut;
labium_polygon_points = 
    [[0,-outerDiameter/2],
    [innerDiameter/2, -outerDiameter],
    [-outCut, -outerDiameter],
    [-outCut, 0],
    [innerDiameter/2,0]];

// logic
difference(){
    union(){
        basicShapeRound(height); 
        outer_traverse_flue();
        high_cut_up_connector();
    };
    union(){
        inner_traverse_flue(); 
        airSupplySpacerTraverse(x=airSupplyX);
        labium_cut();
        airdome();
    };
};

// version number
vertical_version_number ("0.21");

module basicShapeRound(height)
translate ([0, 0, ground]) union(){
    difference(){   
	    cylinder(height, d=(outerDiameter + 2* minWallThickness), $fn=(30+outerDiameter)); 
        union(){
        	translate ([0, 0, floorThickness]) 
                cylinder(height, d=innerDiameter, center=false, $fn=(10+outerDiameter));
        	translate ([0, 0, (height - pipeInsert)]) 
                cylinder(height, d=outerDiameter, center=false, $fn=(10+outerDiameter));
        };
    };
};

module airSupplySpacerTraverse(x=0){
    translate ([x, - outerDiameter/2, (ground-0.1)]) 
    cylinder (tubeInsert, d=outerTube, center=false, $fn=(20+outerTube));
};

// straight loft and accesoires 

module traverse_flue_loft(upperDiameter, lowerDiameter, loftCeiling, loftFloor){
    union(){
        // tube
        hull($fn=(20+outerTube)){
        	translate([airSupplyX, - outerDiameter/2, loftFloor]) 
                cylinder(h=0.01, d=lowerDiameter, center=true);
        	translate([airSupplyX, - outerDiameter/2, labiumWidth*0.5])
                sphere(d=lowerDiameter);
        }
        // flue
        hull($fn=(20+outerTube)){ 
            translate ([-outCut, - outerDiameter/2, labiumWidth*-0.45]) 
                rotate([0, 90, 0]) cylinder (0.01, d=upperDiameter);
            translate ([-outCut, - outerDiameter/2, labiumWidth*0.45]) 
                rotate([0, 90, 0]) cylinder (0.01, d=upperDiameter);
            translate([airSupplyX, - outerDiameter/2, 0])
                sphere(d=lowerDiameter);
        };
    };
}

module outer_traverse_flue(){
    traverse_flue_loft(    
        upperDiameter = (flueWidth + 2 * minWallThickness), 
        lowerDiameter = (outerTube + 2 * minWallThickness),
        loftCeiling = 0,
        loftFloor = ground
    );
}

module inner_traverse_flue(){
    traverse_flue_loft(
        upperDiameter = flueWidth, 
        lowerDiameter = innerTube, 
        loftCeiling = 0.1, 
        loftFloor = (ground-0.1)
    ); 
}

module high_cut_up_connector(){
    difference(){
        union(){
            hull(){
                translate ([-outCut - minWallThickness, - outerDiameter/2, labiumWidth*0.45]) 
                    rotate([0, 90, 0]) cylinder (minWallThickness, minWallThickness, minWallThickness);
                translate ([-outCut - minWallThickness, - outerDiameter/2, labiumWidth*-0.45]) 
                    rotate([0, 90, 0]) cylinder (minWallThickness, minWallThickness, minWallThickness);
                translate ([-outCut - minWallThickness,  0, ground])
                    cube(minWallThickness);
                translate ([-outCut - minWallThickness, 0, labiumWidth*0.45]) 
                    rotate([0, 90, 0]) cylinder (minWallThickness, minWallThickness, minWallThickness);
            };
            if (connector == 1) 
            hull(){
                translate([airSupplyX, - outerDiameter/2, ground]) 
                    cylinder(h=0.01, d=innerTube, center=true);
                translate([airSupplyX * 0.7 , - outerDiameter/2, 0])
                    cylinder(h=0.01, d=innerTube, center=true); 
                translate ([-outCut - minWallThickness, - outerDiameter/2, labiumWidth*0.45]) 
                    rotate([0, 90, 0]) cylinder (minWallThickness, minWallThickness, minWallThickness);
                translate ([0, 0, ground]) 
                    cylinder (0.01, innerDiameter/2 - minWallThickness);
            };
        };
        cylinder(2 * height, innerDiameter/2 + 0.1, innerDiameter/2 + 0.1, true);
    };
};

module airdome(){
    translate ([airSupplyX, - outerDiameter/2, labiumWidth*0.5])
        sphere (outerTube/2);
};


module labium_cut(){
    translate ([0 ,0,-labiumWidth/2])
        linear_extrude(labiumWidth, $fn=50) 
            polygon(points = labium_polygon_points);
};

module vertical_version_number (number)
translate ([outerDiameter*0.5 - 0.3 + minWallThickness, outerDiameter*0.05, -lengthFlue])
rotate ([90,-90,90])
linear_extrude(1) 
text(text=str(number), size=outerDiameter*0.15);



echo(version = version());
