// Zach Arnold
// MSE4777 Miter Box
// Customizable material sizes and angle of cut

bladeWidth = 0.8; //Put saw blade width here
materialHeight = 20; //Height of the material
materialWidth = 20; //Width of the material
cutAngle = 45; //Between 60* and 0*
miterBoxLength = 40; //Change the length to make the cuts fit
cutAngle2 = 90;

difference ()
{
    miterBox();
    bladePosition();
}

module material ()
{
    cube([miterBoxLength, materialWidth, materialHeight+5]);
}

module miterBox ()
{
    difference ()
    {
        cube([miterBoxLength, materialWidth + 10, materialHeight + 10]);
        translate([0,5,5])
            material();
    }
}

module blade ()
{
    cube([bladeWidth, materialWidth + 100, materialHeight + 7.5], center = true);
}

module bladePosAngle ()
{
    rotate([0,0,cutAngle])
        blade();
}

module bladeNegAngle ()
{
    rotate([0,0,-cutAngle])
        blade();
}

module bladePosition ()
{
    translate([miterBoxLength/2,(materialWidth + 10)/2,((materialHeight+7.5)/2)+2.5])
        blade();
 
    translate([(miterBoxLength/2),(materialWidth + 10)/2,((materialHeight+7.5)/2)+2.5])
        bladePosAngle();
    
    translate([(miterBoxLength/2),(materialWidth + 10)/2,((materialHeight+7.5)/2)+2.5])
        bladeNegAngle();
}