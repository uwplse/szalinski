// polybowl template

radius=10;
sides=6;
thickness=2;
bodyHeight=30;
bodyTwist=180;
bodyFlare=1.2;
baseHeight=3;
rimHeight=3;
extrudeResolution=5*bodyHeight;
//extrudeResolution works well at 2 * bodyHeight

/////////////////////////////////////////////////////////
//RENDERS

//rim
translate([0,0,baseHeight + bodyHeight])
    rotate(-bodyTwist)
        scale(bodyFlare)
            linear_extrude(height=rimHeight)
                polyShape(radius, sides, thickness, solid=false);

//base
linear_extrude(height=baseHeight)
    polyShape(radius, sides, thickness);

//body
translate([0,0,baseHeight])
    linear_extrude(height=bodyHeight, twist=bodyTwist, slices=extrudeResolution, scale=bodyFlare)
    //"height" is the height, "twist" is the rotation (in degrees) of the object as it extrudes, "slices" is the number of layers the make up the twist, "scale" is a multiplier of how much the object flares in or out as it extrudes.
        polyShape(radius, sides, thickness, solid=false);

////////////////////////////////////////////////////////
//MODULES

module polyShape(solid)
{
    difference()
    {
        offset(r=5, $fn=48)
            circle(r=radius, $fn=sides);
        
        if (solid==false)
        {
            offset(r=5-thickness, $fn=48)
                circle(r=radius, $fn=sides);
        }
    }
}