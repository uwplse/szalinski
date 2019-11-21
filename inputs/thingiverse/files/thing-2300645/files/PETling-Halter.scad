// Petling-Halterung
// 06.05.2017, frank

PETLING_RADIUS=14;
KABELBINDER_HOEHE=10;
$fn=400;

//
// NO CHANGES BELOW THIS LINE
//
module vertikal()
{
    hull()
    {
        translate([0, -PETLING_RADIUS*1.5, 0])
        cube([3, PETLING_RADIUS*3, 25]);

        // Bälle oben
        translate([1.5,-((PETLING_RADIUS*1.5)),25])
        sphere(1.5);

        translate([1.5,((PETLING_RADIUS*1.5)),25])
        sphere(1.5);


        // Bälle unten
        //
        translate([1.5,-((PETLING_RADIUS*1.5)),-1.5])
        sphere(2);

        translate([1.5,((PETLING_RADIUS*1.5)),-1.5])
        sphere(2);
        
        
    }
    
    
}

module horizontal()
{
    hull()
    {
        translate([0,-(PETLING_RADIUS*1.5),0])
        rotate([0,90,0])
        cube([3, PETLING_RADIUS*3, PETLING_RADIUS*3.5]);
    
        
        translate([PETLING_RADIUS*3.5,-((PETLING_RADIUS*1.5)),-1.5])
        sphere(1.5);

        translate([PETLING_RADIUS*3.5,((PETLING_RADIUS*1.5)),-1.5])
        sphere(1.5);
        
        
        
        translate([1.5,-((PETLING_RADIUS*1.5)),-1.5])
        sphere(2);

        translate([1.5,((PETLING_RADIUS*1.5)),-1.5])
        sphere(2);

    }
}

module kabelbinder_loecher()
{
    translate([-2, -(PETLING_RADIUS), 10])
    cube([6,3,KABELBINDER_HOEHE]);
    
    translate([-2, (PETLING_RADIUS/2)+1.5, 10])
    cube([6,3,KABELBINDER_HOEHE]);
}

module petling_loch()
{
    translate([PETLING_RADIUS*2, 0, -5])
    linear_extrude(10)
        circle(PETLING_RADIUS);
}

difference()
{
    vertikal();
    kabelbinder_loecher();
}

difference()
 {
    horizontal();
    petling_loch();
 }