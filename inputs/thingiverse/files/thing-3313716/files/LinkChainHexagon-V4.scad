actualLinkLen=34;
actualLinkWid=15;

linkLen=actualLinkLen;
linkWid=actualLinkWid-actualLinkWid/6;

pairsInRow=2;
columns=5;

small=0.01;
$fn=30;

vertSegLen=linkWid/3;
slopeSegLen=vertSegLen/cos(30);
diameter=linkWid/3;
longSegLen=linkLen-diameter-vertSegLen*cos(60)*2;

module elbow(len1,len2,angle)
{
    
    //translate([0,0,-len1])

    {

        difference()
        {
            translate([0,0,-small])
            rotate([0,0,60])
            cylinder(d=diameter, h=1.5*len1,$fn=6);
            
            translate([0,0,1*len1])
            rotate([0,(180-angle)/2,0])
            translate([0,0,1*len1+small])
            cube([3*diameter, 3*diameter, 2*len1],center=true);
        }
        
        translate([0,0,len1])
        rotate([0,-angle,0])
        translate([0,0,-len2])
        difference()
        {
            translate([0,0,-small])
            rotate([0,0,60])
            cylinder(d=diameter, h=1.5*len2,$fn=6);
        
            translate([0,0,1*len2])
            rotate([0,(180-angle)/2*-1,0])
            translate([0,0,1*len2+small])
            cube([3*diameter, 3*diameter, 2*len2],center=true);
        }

    }
}
//!elbow(longSegLen/2,slopeSegLen/2,120);
module makeQuarterLink()
{
    elbow(longSegLen/2,slopeSegLen/2,120);

    translate([slopeSegLen/2*sin(60),0,longSegLen/2+slopeSegLen/2*cos(60)])
    rotate([0,60,0])
    elbow(slopeSegLen/2,vertSegLen/2,150);
}
//!makeQuarterLink();
module makeFullLink()
{
    rotate([90,-60,0])
        {
        makeQuarterLink();

        translate([linkWid,0,0])
        mirror()
        makeQuarterLink();

        mirror([0,0,1])
        {
            makeQuarterLink();
            
            translate([linkWid,0,0])
            mirror()
            makeQuarterLink();
        }
    }
}
//!makeFullLink();

module makePairInRow()
{
    makeFullLink();
    
    translate([diameter*1.23,linkLen-2.1*diameter,0])
    mirror()
    makeFullLink();
}
module makeRow(NumPairInRow)
{
    for (i=[0:NumPairInRow-1])
    {
        translate([diameter*1.23,(linkLen-2.1*diameter)*i*2,0])
        makePairInRow();
    }
}
module makeBottomCrossLink()
{

    translate([linkLen*.54,-linkWid/2-linkLen/2+diameter/2,linkWid*.45])
    rotate([0,asin((linkWid-2*diameter)/longSegLen),0])
    rotate([0,60,90])
    makeFullLink();
}
module makeTopCrossLink()
{

    translate([linkLen*.51,-linkWid/2-linkLen/2+diameter/2,linkWid*.45])
    rotate([0,-asin((linkWid-2*diameter)/longSegLen),0])
    rotate([0,60,90])
    makeFullLink();
}


for (row=[1:columns])
{
    if (row > 1)
    {
        if ((row % 2) == 0)
        {
            translate([linkLen*0.48*(row-2),
                (linkLen-2.1*diameter)*2*pairsInRow+linkWid/2-diameter/2,
                0])
            makeTopCrossLink();
        } 
        else
        {
            translate([linkLen*.48*(row-2),0,0])
            makeBottomCrossLink();
        }
    }
    
    translate([(row-1)*linkLen*0.48,0,0])
    makeRow(pairsInRow);   
    
}

    // just for measuring
//translate([0,0,-linkWid/6])
//cube([5,5,actualLinkWid]);
//translate([0,-actualLinkLen/2,0])
//cube([5,actualLinkLen,5]);