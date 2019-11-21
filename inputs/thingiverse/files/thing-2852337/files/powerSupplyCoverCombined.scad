

/* [Plug Options] */
//The width of the plug, in mm (The long way)
plugWidth=49;
//The height of the plug, in mm (The short way)
plugHeight=30;
//How far the angles on the plug should go, measured along the x axis from the right, in mm
plugChamfer=7;
//At 0, the plug will be in the bottom right corner, but not hitting the chamfer or the interior. This moves the plug left, in mm.
plugXOffset=5;
//Moves the plug up, in mm
plugZOffset=5;

/* [Case Options] */
//The thickness of the case, in mm
thickness=2;
//The width of the interior of the case, in mm
width=113;
//The height of the case, in mm
height=75;
//The interior depth of the case, in mm
depth=50;
//The radius of the fillets (Rounded edges), in mm. Set to 0 for square edges
filletR=2;

/* [Hole] */
//Whether or not to make the hole for a screw.
makeHole="Yes";//[Yes,No]
//The diameter of the hole
holeD=4;
//How high from the bottom of the case to center the hole
holeHeight=60;
//How far from the back of the case to center the hole
holeLocation=25;

/* [Hidden] */
nm=.1;
nm2=2*nm;
holeR=holeD/2;

module roundedCube(size,r,fn=20)
{
    width=size[0];
    depth=size[1];
    height=size[2];
    if(r==0)
        cube(size);
    else
    {
        hull()
        {
            for(x = [r,width-r])
                for(y = [r,depth-r])
                    for(z = [r,height-r])
                        translate([x,y,z])
                            sphere(r=r,$fn=fn);
        }
    }
}

module plug()
{
        hull()
        {
            cube([plugWidth-plugChamfer,plugHeight,thickness+nm2]);
            translate([0,plugChamfer,0])
                cube([plugWidth,plugHeight-2*plugChamfer,thickness+nm2]);
        };
}
difference()
{
    roundedCube([width+2*thickness,depth+thickness,height],filletR,fn=20);
    translate([thickness,thickness,thickness])
        roundedCube([width,depth+thickness,height],max(filletR-thickness,0),fn=20);
    translate([width-max(filletR+thickness)-plugWidth+thickness*2-plugXOffset,nm+thickness,max(filletR,thickness)+plugZOffset])
        rotate([90,0,0])
            plug();
    if(makeHole=="Yes")
        translate([-nm,depth-holeLocation+thickness,holeHeight])
            rotate([0,90,0])
                cylinder(r=holeR,h=width+nm2+2*thickness,$fn=20);
    
}
