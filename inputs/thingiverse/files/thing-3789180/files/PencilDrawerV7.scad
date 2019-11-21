/* [ dimensions of box (mm)] */
width=177;
depth=80;
height=57;
// How thick the wall should be (leave enough room for the groove
wall=2.6;//[1.0:0.1:10]

/* [Dimension of cutout on bottom to fit drawer sides] */
// a special slice to handle drawers with rounded edges
drawerSlope=19;
// to handle where the edge sticks out into the drawer
drawerLip=2;
// slanted bottom just on 2 sides to make it easier to get things out
bottomSlope=6;

/* [ dimensions of rabbit and grooves to join the boxes ] */
// the depth of the groove (shouldn't be larger than "wall" 
groove=2.5;
// the angle to make sure they do not pull apart
grooveAngle=11;
// this depends on the printer, makes the rabbit this much smaller than the groove
shrinkage=0.33;
// how far apart to place the rabbits and grooves
grooveSeparation=35;

/* [ customize each box, rabbits match grooves] */
cutoutBottomLeft=false;
cutoutBottomRight=false;

topRabbit=false;
topGroove=true;

bottomRabbit=true;
bottomGroove=false;

rightRabbit=true;
rightGroove=false;

leftRabbit=false;
leftGroove=false;

/* [Hidden] */
small=0.01;
numGroovesOnWidth=(width-(cutoutBottomLeft?drawerSlope:wall))/grooveSeparation;
numGroovesOnHeight=(depth-wall)/grooveSeparation;

module buildGroove(reduce=0)
{
    translate([reduce/2,reduce/2,-(reduce?0:small)])
    linear_extrude(height=height*.8-1*reduce+(reduce?0:2*small))
    {
        polygon([
        [0,0],
        [(groove-reduce/2)*sin(grooveAngle),groove-reduce],
        [(groove-reduce)-(groove-reduce/2)*sin(grooveAngle),groove-reduce],
        [groove-reduce,0]    
        ]);
        
        if (reduce>0)
        {
            translate([(groove-reduce/2)*sin(grooveAngle),groove-reduce-small])
            square([(groove-reduce)-(groove-reduce/2)*sin(grooveAngle)*2,reduce]);
        }
    }

}
//!buildGroove();

module endBoxBasic(reduce,endSlope=false)
{
    wid=width-reduce*2;
    dep=depth-reduce*2;
    hei=height-reduce+(reduce?small:0);
    slope=drawerSlope-reduce/(reduce?sqrt(2):1);
    difference()
    {
        cube([wid,dep,hei]);
        
        if (endSlope)
        {
            translate([0,wid,0])
            rotate([90,0,0])
            linear_extrude(height=wid+2*small)
            polygon([[-small,-small],
                      [slope+small+(reduce?reduce*sin(25):0),-small],
                      [slope+small,drawerLip],
                      [-small,slope+drawerLip]
            ]);
            
            translate([7,0,0])
            rotate([0,-7,0])
            translate([-5,-small,0])
            cube([5,dep+2*small,hei*2]);
        
        }        
    }
}
module endBox(endSlope)
{
    difference()
    {
        endBoxBasic(0,endSlope);
        
        translate([wall,wall,wall])
        difference()
        {
            endBoxBasic(wall,endSlope);
            
            // the slopes on the bottom of the container that run full width
            translate([-small+200/2,0,0])
            rotate([45,0,0])
            cube([200,2*bottomSlope,2*bottomSlope],center=true);
            
            translate([-small+200/2,depth-wall*2,0])
            rotate([45,0,0])
            cube([200,2*bottomSlope,2*bottomSlope],center=true);
        }
        
        translate([(width-2*wall)/2+wall,(depth-2*wall)/2+wall,height-2*wall])
        linear_extrude(height=2*wall+small, 
            scale=[width/(width-4*wall),depth/(depth-4*wall)])
        square([width-4*wall,depth-4*wall],center=true);
    }
}
difference()
{
    if ( !cutoutBottomRight)
    {
        endBox(cutoutBottomLeft);
    }
    else
    {
        translate([width,0,0])
        mirror([1,0,0])
        endBox(true);
    }
    
    if (topGroove)
    for(i=[1:numGroovesOnWidth])
    {
        translate([width-grooveSeparation*i-groove/2,depth-groove+small,0])
        buildGroove(0);
    }
    
    if (bottomGroove)
    for(i=[1:numGroovesOnWidth])
    {
        translate([width-grooveSeparation*i+groove/2,groove-small,0])
        rotate([0,0,180])
        buildGroove(0);
    }
    
    if (rightGroove)
    for(i=[1:numGroovesOnHeight])
    {
        translate([width-groove+small,grooveSeparation*i+groove/2,0])
        rotate([0,0,-90])
        buildGroove(0);
    }
    
    if (leftGroove)
    for(i=[1:numGroovesOnHeight])
    {
        translate([groove-small,grooveSeparation*i-groove/2,0])
        rotate([0,0,90])
        buildGroove(0);
    }
}


if (topRabbit)
    {
    for(i=[1:numGroovesOnWidth])
    {
        translate([width-grooveSeparation*i+groove/2,depth+groove-small,0])
        rotate([0,0,180])
        buildGroove(shrinkage);
    }
}
if (bottomRabbit)
    {
    for(i=[1: numGroovesOnWidth])
    {
        translate([width-grooveSeparation*i-groove/2,-groove+small,0])
        buildGroove(shrinkage);
    }
}
if (rightRabbit)
    {
    for(i=[1:numGroovesOnHeight])
    {
        translate([width+groove-small,grooveSeparation*i-groove/2,0])
        rotate([0,0,90])
        buildGroove(shrinkage);
    }
}
if (leftRabbit)
    {
    for(i=[1:numGroovesOnHeight])
    {
        translate([-groove+small,grooveSeparation*i+groove/2,0])
        rotate([0,0,-90])
        buildGroove(shrinkage);
    }
}