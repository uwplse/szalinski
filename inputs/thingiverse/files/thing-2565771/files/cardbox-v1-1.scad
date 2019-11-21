// generate the pocket/box 
GENERATE_BOX=true;

// generate the closing cover
GENERATE_COVER=true;

// SD-card box for four cards
// Box(25,34,9,undef,1.6,1);

// inner width of the box
innerWidth = 40;

// inner length of the box
innerLength = 60; 

// inner height of the box
innerHeight = 10;

// front height of the 
frontHeight = undef; //[1:100]

// thickness of the walls
wallThickness=1.5;  

// number of pockets in the box
pocketCount=1; // [1:10]

// number of segments for round objects
fragments = 64; // [16,32,64]

//Box(88, 57, 5,undef,1.6,1);

Box(innerWidth,innerLength,innerHeight,frontHeight,wallThickness,pocketCount);

/*
  Bevel edge added to the front wall of the pocket
  and substracted from the closing cover.
*/
//bevelEdge(30,3); // @Test
module bevelEdge(length, thickness) {
    difference() {
        cube([length,thickness,thickness]);
        translate([0,0,thickness])
            rotate([30,0,0])
                translate([0,0,-2*thickness])
                    cube([length,thickness,thickness*2]);
    }
}

module quadCylinder(height, radius) {
    rotate([0,90,0])
    intersection() {
        translate([-1*radius,0,0]) cube([radius,radius,height]);
        cylinder ( h = height, r=radius, $fn=fragments);
    }
}

/*
    inner side wall of the box.

    +------------ length ---------+

      .---------------------------+    +
     /                            |    | height
    |                             |    |
    +-----------------------------0    +

*/
//innerSideWall(40,10,0.8); // @Test
module innerSideWall(length,height,thickness) {
    union() {
        cube([thickness, length - height , height ]);
        
        translate([0,length - height ,0])
            rotate([0,90,0])
                intersection() {
                    cylinder(   r = height, 
                                h = thickness,
                                $fn = fragments);
                    translate([-1 * height , 0, 0])
                    cube(height,height,thickness);
                }
    }
}

/*
    outer side wall of the box.

    +------------ length -------+

    +---------------------------+._     +
    |                              \    | 
    |     __                    O  |    |height
    |    /  \                      /    | 
    +---+    +------------------0 ´     +
*/
// outSidewall(5,1,0.1,false);  // @Test
module outSidewall(length,height,thickness,leftSide) {
    
    difference() {
        union() {        
            // round half at the bottom
            
            intersection() {
                translate([0,0,height /2 ]) 
                    rotate([0,90,0]) 
                        cylinder(  h=thickness,
                                   d=height,
                                   $fn=fragments);
                translate([0,-1*height/2,0])
                    cube([thickness,height/2,height]);
            }
            cube([thickness,length, height]);
        }

        // side hole
        translate([-0.025,0,0.5*height])
            rotate([0,90,0]) 
                cylinder(   d= 0.5 * height + 0.1, 
                            h=thickness+0.05,
                            $fn=fragments);

        // half round cut for opening (shift -0.025 left because of rounding problems)
        translate([-0.025,length*0.80,0])
            rotate([0,90,0]) {
                if (leftSide) {
                    cylinder(   d1= height + thickness, 
                                d2= height, 
                                h=thickness * 1.05,  // for rounding problems a bit thicker
                                $fn=fragments);
                } else {
                    cylinder(   d1= height, 
                                d2= height + thickness, 
                                h=thickness * 1.05,  // for rounding problems a bit thicker
                                $fn=fragments);
                }
            }
    }

}

module closingSnapSpheres(innerLength,innerHeight,totalWidth,wallThickness) {
    union() {
        // radius is maximum 0.2 plus space (0.1)
        radius=max(wallThickness/2, 0.2)+0.1;

        // create closing snap ball
        // left
        translate([0,innerLength*0.75,0.65*(innerHeight+wallThickness*2)])
        sphere(r=radius,$fn=fragments);
        
        // right
        translate([totalWidth,innerLength*0.75,0.65*(innerHeight+wallThickness*2)])
        sphere(r=radius,$fn=fragments);
    }
}

//Box(20,25,4,5,0.8,1);  // @Test
module Box( innerWidth, 
            innerLength, 
            innerHeight,
            frontHeight,
            wallThickness, 
            pocketCount) {
    // calculate some sizes we need more than once

    // calculate total width, we need them more than once
    totalWidth = pocketCount * (innerWidth + wallThickness) + wallThickness;

    // total total height 
    totalHeight = innerHeight + 2 * wallThickness;

    // calculate the position of the upper corner of the box (length of innerSideWall)
    upperCorner = innerLength+wallThickness; 

    // set a good default value for front height if not provided.
    frontHeight = (frontHeight==undef ?  totalHeight / 1.3 : frontHeight);
     

    if (GENERATE_BOX) {
        // create the side walls (and inner walls if more than one pocket)
        for(box=[0:(pocketCount)]) {
            translate([box*(innerWidth+wallThickness),0,wallThickness])
                innerSideWall(upperCorner,innerHeight,wallThickness);
        }

        // round half at the bottom
        intersection() {
            translate([0,0,totalHeight /2 ]) 
                rotate([0,90,0]) 
                    cylinder(  h=totalWidth,
                               d=totalHeight,
                               $fn=fragments);
            translate([0,-1*totalHeight/2,0])
                cube([totalWidth,totalHeight/2,totalHeight]);
        }

        // back side
        cube([totalWidth,upperCorner,wallThickness]);

        // front side
        translate([0,0,innerHeight + wallThickness]) 
            cube([totalWidth,frontHeight,wallThickness]);
        // add bevelEdge to the front side
        translate([0,frontHeight,innerHeight + wallThickness]) 
            bevelEdge(totalWidth,wallThickness);

        // create hinge axis to snap on
        // left side    
        translate([0,0,0.5*(innerHeight+wallThickness*2)])
        rotate([0,-90,0]) 
        {
            cylinder(d=0.5*(innerHeight+wallThickness*2), h=wallThickness*1.3,$fn=fragments);
            cylinder(d=0.75*(innerHeight+wallThickness*2), h=0.1,$fn=fragments);
        }
        // right side    
        translate([totalWidth,0,0.5*(innerHeight+wallThickness*2)])
        rotate([0,90,0]) 
        {
            cylinder(d=0.5*(innerHeight+wallThickness*2), h=wallThickness*1.3,$fn=fragments);
            cylinder(d=0.75*(innerHeight+wallThickness*2), h=0.1,$fn=fragments);
        }
        
        // create closing snap ball
        closingSnapSpheres(innerLength,innerHeight,totalWidth,wallThickness);
    }

    if (GENERATE_COVER) {

        translate([0,-2 * totalHeight, totalHeight])
            rotate([180,0,0])
                // snap on cover
                difference() {
                    // create the cover 
                    union() {
                        // left side
                        translate([-1*(0.1+wallThickness),0,0])
                            outSidewall(upperCorner,totalHeight,wallThickness,true);

                        // right side
                        translate([(totalWidth + 0.1),0,0])
                            outSidewall(upperCorner,totalHeight,wallThickness,false);

                        // top 
                        translate([-0.1, frontHeight + 0.1, totalHeight - wallThickness]) 
                            difference() {
                                cube([totalWidth + 0.2, upperCorner - frontHeight - 0.1,wallThickness]);
                                // substract the bevelEdge
                                bevelEdge(totalWidth + 0.2,wallThickness);
                            }

                        translate([-0.1 - wallThickness, innerLength+wallThickness, 0])
                            cube([totalWidth + 0.2 + 2 * wallThickness, wallThickness, totalHeight]);
                    }
                    
                    // generate the two closing snap holes
                    closingSnapSpheres(innerLength,innerHeight,totalWidth,wallThickness);
                }
    }    

} 


