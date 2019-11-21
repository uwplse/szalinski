// by Les Hall
// started 2:06 AM Fri Jul 10 2015
// 


$fn = 12;
nozzle = 0.4;
postDiameter = 12;
numWyrms = 2;
wyrmSegments = 67;
wyrmLength = 67;
wyrmDiameter = 15;
wyrmRotations = 2;  // positive or negative for direction
wyrmPhase = 90;
wyrmRatio = 1.5;



thing();



module thing()
{
    difference()
    {
        wyrms(numWyrms, wyrmSegments, wyrmLength, 
            wyrmDiameter, wyrmRotations, wyrmPhase, 
            wyrmRatio);
    
        rotate(180, [0, 1, 0])
        cylinder(r = postDiameter/2 + wyrmDiameter, 
            h=wyrmDiameter);
    }
}



module wyrms(numWyrms, wyrmSegments, wyrmLength, 
    wyrmDiameter, wyrmRotations, wyrmPhase, 
    wyrmRatio)
{
    for (w = [0 : numWyrms-1], s = [0 : wyrmSegments-1])
    {
        segmentDiameter = 
            (wyrmSegments*(1+wyrmRatio) - s) / 
            (wyrmSegments*(1+wyrmRatio) ) * 
            wyrmDiameter;
        r = postDiameter/2 - nozzle + segmentDiameter/2;
        theta = wyrmRotations * 360 / numWyrms * sin(180 * s / wyrmSegments) + wyrmPhase;
        dL = wyrmLength / wyrmSegments;
        
        rotate(theta + 360 * w / numWyrms)
        translate([r, 0, 0])
        translate([0, 0, s * dL + wyrmDiameter * 0.33])
        rotate(atan2(r*theta, dL), [1, 0, 0])
        sphere(segmentDiameter/2);
    }    
}


