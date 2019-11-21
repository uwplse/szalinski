// for dual extruders what features to show for each color
// show the hinges
//[Multiple Extruders]
hinges=1; // [0:Hide, 1:Show] 
//show the cubes
cubes=1;  // [0:Hide, 1:Show] 
//if showing text then the rest of it is not shown (hinges and cubes are hidden)
textFill=0;  //  [0:leave indent for text, 1:Show only text, 2:noText] 

//[main configurable parameters]
// the size in mm of one of the cubes
cubeSize=20; // [10:1:50]
// how big around the hinge pins are
hingeDiameter=5.0; //[3:0.1:10]
// the gap around the hinges to allow movement, technically half this amount as this is a diameter
hingeGap=0.6; //[0:0.05:2]
// the gap between cubes
spacing=0.5;  //[0.1:0.05:3]
//how deep the text is engraved into the cube
textDepth=1.5; //[0.1:0.5:3]

//[Text]
//top surface line1 (size is height in mm)
text1="THINGIVERSE";
text1_size=8;
//top surface line2
text2="TheFisherOne";
text2_size=8;
//bottom surface line1 left
text3="OPEN";
text3_size=6.5;
//bottom surface line1 right
text4="SCAD";
text4_size=6.5;
//bottom surface line2 left
text5="FIDGET";
text5_size=5.5;
//bottom surface line2 right
text6="CUBE";
text6_size=5.5;

// [Hidden]
//calculated values
holeDiameter=hingeDiameter+hingeGap;
//want to space the 2 hinge connectors evenly across the cube face
// so there are 3 gaps to fill
hingeOffset=(cubeSize-2*holeDiameter)/3;

// does not show up in the final, just enough space for an overlap when removing parts
xtra=0.01;
chamfer=hingeDiameter; // the size of the curved corners of the cubes
$fn=8;

// this makes a rounded corner 
module chamferTakeAway(radius,length)
{
    //line it up with the edge that needs to be chamfered
    rotate([0,0,180])translate([-radius,-radius,length/2])
    intersection()
    {
        // take only one quarter of the circle
        translate([radius,radius,0])cube([radius*2,radius*2,length*2],center=true);
        difference()
        {
            // remove a cylinder from a cube, to get the part that needs to be taken away
            cube([radius*2+2*xtra,radius*2+2*xtra,length+2*xtra],center=true);
            cylinder(r=radius, h=length+4*xtra,center=true);

        }
    }
}

// this makes a single cube with 3 chamfered corners but no allocation for the hinges
module solidCube()
{
    difference()
    {
        cube(cubeSize);
        chamferTakeAway(chamfer,cubeSize);
        translate([cubeSize,cubeSize,0])rotate([90,-90,0])chamferTakeAway(chamfer,cubeSize);
        translate([cubeSize,cubeSize,cubeSize])rotate([-90,90,90])chamferTakeAway(chamfer,cubeSize);
    }
}

// this makes a gap in the side of a cube for a single hinge connector to rotate in
// it is not the space for the pin itself
module spaceForHingeConnector()
{
    union()
    {
        translate([-xtra,-xtra,0])cube([holeDiameter+xtra,holeDiameter+xtra,holeDiameter]);
        translate([-xtra,holeDiameter/2,holeDiameter]) rotate([0,90,0]) cube([holeDiameter,holeDiameter,holeDiameter*1.5+xtra]);
        //cylinder(d=holeDiameter, h=holeDiameter+xtra);
        translate([holeDiameter/2,1.5*holeDiameter,0]) rotate([90,0,0]) cube([holeDiameter,holeDiameter,holeDiameter*1.5+xtra]);
        //cylinder(d=holeDiameter, h=holeDiameter+xtra);
    }
}

// this makes space for the hinge pin and the two connectors
module spaceForOneHinge()
{

    union()
    {
        translate([holeDiameter,holeDiameter,-xtra])cylinder(d=holeDiameter, h=cubeSize+2*xtra);
        translate([0,0,hingeOffset]) spaceForHingeConnector();
        translate([0,0,cubeSize-hingeOffset-holeDiameter]) spaceForHingeConnector();
    }
}
//this makes a single cube, with the space removed for the 2 hinges
module completeCube()
{
    if (cubes){
        rotate([90,0,0])difference(){
            solidCube();
            spaceForOneHinge();
            translate([cubeSize,cubeSize,0])rotate([90,-90,0])spaceForOneHinge();
        }
    }
}

//this makes a hinge, with 2 pins and 2 connectors
module hinge()
{
    if(hinges){
        cylinder(d=hingeDiameter, h=cubeSize); //pin1
        translate([2*holeDiameter+spacing,0,0])cylinder(d=hingeDiameter, h=cubeSize); //pin2
        translate([0,0,hingeOffset+holeDiameter/2])rotate([0,90,0])cylinder(d=hingeDiameter, h=holeDiameter+holeDiameter); //connector1
        translate([0,0,cubeSize-hingeOffset-holeDiameter/2])rotate([0,90,0])cylinder(d=hingeDiameter, h=holeDiameter+holeDiameter); //connector2
    };
}
//this makes a pair of cubes joined by a hinge
module pair()
{
    translate([cubeSize+spacing,0,0])completeCube();
    translate([cubeSize-holeDiameter,0,holeDiameter])rotate([90,0,0])hinge();
    translate([cubeSize,0,0])mirror()completeCube();
}
module cubeSet()
{
    // first make 4 pairs of cubes to make 8 cubes in total
    pair();
    translate([0,spacing*3+cubeSize*2,0])mirror([0,1,0]) pair();
    translate([0,2*cubeSize+2*spacing,cubeSize])rotate([0,180,90])pair();
    translate([2*cubeSize+spacing,0,0])mirror()translate([0,2*cubeSize+2*spacing,cubeSize])rotate([0,180,90])pair();
    // then add the 4 hinges that join the 4 pairs
    translate([holeDiameter, -holeDiameter,0])rotate([0,0,90])hinge();
    translate([2*cubeSize+spacing-holeDiameter, -holeDiameter,0])rotate([0,0,90])hinge();
    translate([holeDiameter, -holeDiameter+2*cubeSize+2*spacing,0])rotate([0,0,90])hinge();
    translate([2*cubeSize+spacing-holeDiameter, -holeDiameter+2*cubeSize+2*spacing,0])rotate([0,0,90])hinge();
}
module textSet()
{
    translate([cubeSize*1.6+spacing,cubeSize,textDepth])rotate([180,0,90])linear_extrude(height=textDepth+1) text(text=text1, size=text1_size, halign="center", valign="center");
    
    translate([cubeSize*0.4,cubeSize,textDepth])rotate([180,0,90])linear_extrude(height=textDepth+1) text(text=text2, size=text2_size, halign="center", valign="center");
    
    translate([cubeSize*1.4+spacing,2*cubeSize+2*spacing+hingeDiameter/2,cubeSize-textDepth])rotate([180,180,90])linear_extrude(height=textDepth+1) text(text=text3, size=text3_size, halign="center", valign="center");
    
    translate([cubeSize*1.4+spacing,-hingeDiameter/2,cubeSize-textDepth])rotate([180,180,90])linear_extrude(height=textDepth+1) text(text=text4, size=text4_size, halign="center", valign="center");
    
    translate([cubeSize*0.6+spacing,2*cubeSize+2*spacing+hingeDiameter/2,cubeSize-textDepth])rotate([180,180,90])linear_extrude(height=textDepth+1) text(text=text5, size=text5_size, halign="center", valign="center");
    
    translate([cubeSize*0.6+spacing,-hingeDiameter/2,cubeSize-textDepth])rotate([180,180,90])linear_extrude(height=textDepth+1) text(text=text6, size=text6_size, halign="center", valign="center");
}   
    
    

if (textFill==1)
{
    translate([0,cubeSize,cubeSize])rotate([0,180,0])intersection()
    {
        textSet();
        cubeSet();
    }
    //this post is there just to make sure that every layer has some of each color
    // had problems printing without this
    //translate([5,5,0])cylinder(r=2.5, h=cubeSize);
} else if(textFill==0) {
    translate([0,cubeSize,cubeSize])rotate([0,180,0])difference()
    {
        cubeSet();
        textSet();
    }
} else {
    cubeSet();
}
