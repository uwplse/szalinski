// The size of the fan.
fan_size = 70; //[40:40mm, 50:50mm, 60:60mm, 70:70mm, 80:80mm, 92:92mm, 120:120mm, 140:140mm]

// The size of the hole you want to put it in.
aperture_size = 92; //[40:40mm, 50:50mm, 60:60mm, 70:70mm, 80:80mm, 92:92mm, 120:120mm, 140:140mm]

// Save plastic on larger adapters.
make_gaps = 1;//[0:No, 1:Yes, 2:Yes+Extra]

// Prevent screw holes from being too close together
rotate_inner_holes = 1;//[0:No, 1:Yes]

fanScrewDist = fanSize2ScrewDist(fan_size);
apertureScrewDist = fanSize2ScrewDist(aperture_size);
rad = min(fan_size, aperture_size);

if(fan_size != aperture_size)
if(fan_size == 40)
{
    if(aperture_size == 50)
    {
        fanPlate(fanScrewDist, apertureScrewDist, rad, 15);
    }
    else
    {
        fanPlate(fanScrewDist, apertureScrewDist, rad);
    }
}
else if(fan_size == 50)
{
    if(aperture_size == 40)
    {
        fanPlate(fanScrewDist, apertureScrewDist, rad, 19);
    }
    else if(aperture_size == 60)
    {
        fanPlate(fanScrewDist, apertureScrewDist, rad, 13);
    }
    else
    {
        fanPlate(fanScrewDist, apertureScrewDist, rad);
    }
}
else if(fan_size == 60)
{
    if(aperture_size == 50)
    {
        fanPlate(fanScrewDist, apertureScrewDist, rad, 16);
    }
    else if(aperture_size == 70)
    {
        fanPlate(fanScrewDist, apertureScrewDist, rad, 11);
    }
    else
    {
        fanPlate(fanScrewDist, apertureScrewDist, rad);
    }
}
else if(fan_size == 70)
{
    if(aperture_size == 60)
    {
        fanPlate(fanScrewDist, apertureScrewDist, rad, 12);
    }
    else if(aperture_size == 80)
    {
        fanPlate(fanScrewDist, apertureScrewDist, rad, 8.5);
    }
    else
    {
        fanPlate(fanScrewDist, apertureScrewDist, rad);
    }
}
else if(fan_size == 80)
{
    if(aperture_size == 70)
    {
        fanPlate(fanScrewDist, apertureScrewDist, rad, 10);
    }
    else if(aperture_size == 92)
    {
        fanPlate(fanScrewDist, apertureScrewDist, rad, 7);
    }
    else
    {
        fanPlate(fanScrewDist, apertureScrewDist, rad);
    }
}
else if(fan_size == 92)
{
    if(aperture_size == 80)
    {
        fanPlate(fanScrewDist, apertureScrewDist, rad, 8);
    }
    else
    {
        fanPlate(fanScrewDist, apertureScrewDist, rad);
    }
}
else if(fan_size == 120 || fan_size == 140)
{
    fanPlate(fanScrewDist, apertureScrewDist, rad);
}

if(fan_size == aperture_size)
    cube([1, 1, 1], true);


module fanPlate(innerLength, outerLength, diameter, rot = 0)
{
    rot = rot * rotate_inner_holes;
    sideLength = max(innerLength, outerLength) + 13;
        
    rotA = (innerLength > outerLength)?rot:0;
    rotB = (innerLength < outerLength)?rot:0;

    difference()
    {
        translate([0, 0, -2.5])
        linear_extrude(height=5)
        difference()
        {
            roundedSquare2D(sideLength, 6);
            circle(diameter/2, true, $fn=96);
            gaps2D(diameter/2, sideLength, max(rotA, rotB));
        }

        rotate(rotA)
        for(x=[1, -1])
        for(y=[1, -1])
        {
            translate([x*outerLength/2, y*outerLength/2, -3])
            rotate(x*y*45)
            linear_extrude(6)
            oblong2D(2.5, 1);
        }
        
        rotate(rotB)
        for(x=[1, -1])
        for(y=[1, -1])
        {
            translate([x*innerLength/2, y*innerLength/2, 0])
            rotate(x*y*45)
            screwSlot();
        }
    }
}

module roundedSquare2D(sideLen, radius)
{
    innerSideLen = sideLen - 2*radius;
    union()
    {
        square([innerSideLen, sideLen], true);
        square([sideLen, innerSideLen], true);
        for(x=[1, -1])
        for(y=[1, -1])
            translate([x*innerSideLen/2, y*innerSideLen/2, 0])
            circle(radius, true, $fn=96);
    }
}

module gaps2D(rad, len, rot)
{
    if(make_gaps > 0)
    if(rad+4 < (len-7)/1.8)
    difference()
    {
        square(len-7, true);
        union()
        {
            if(make_gaps == 1)
              circle(rad+3.5, true, $fn=96);
            else if(make_gaps == 2)
              circle(rad-0.1, true, $fn=96);

            rotate(45+rot/2)
            {
                //square([2*len, 13+rot*0.9], true);
                //square([13+rot*0.9, 2*len], true);
                w = 14 + rot*(2*3.141592*rad/360);
                square([2*len, w], true);
                square([w, 2*len], true);
            }
        }
    }
}

module screwSlot()
{
    translate([0, 0, 0.5])
    union()
    {
        translate([0, 0, -3.5])
        linear_extrude(height=4)
        oblong2D(2.8,2);
    
        translate([0, 0, 0])
        linear_extrude(height=3)
        oblong2D(4.1,2);
    }
}

module oblong2D(radius, length)
{
    union()
    {
        translate([-length/2, 0, 0])
            circle(radius, true, $fn=96);
        translate([length/2, 0, 0])
            circle(radius, true, $fn=96);
        square([length, radius*2], true);
    }
}

function fanSize2ScrewDist(fan_size)=
(fan_size ==  40)? 32.0:
(fan_size ==  50)? 40.0:
(fan_size ==  60)? 50.0:
(fan_size ==  70)? 61.5:
(fan_size ==  80)? 71.5:
(fan_size ==  92)? 82.5:
(fan_size == 120)?105.0:
(fan_size == 140)?125.0:0;
