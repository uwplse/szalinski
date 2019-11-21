$fn=50;
condomLength=61;
condomWidth=60;
condomHeight=5; 
numberOfCondoms=2;
tolerance=0.15;
wall=2;
lowerBox();
translate([condomLength + wall *2 +10,0,0])
upperBox();
module upperBox()
{
    difference()
    {
    //upper box box
        cube([condomLength + wall * 4 + tolerance * 2,condomWidth + wall * 4 + tolerance * 2, wall * 2 + condomHeight * numberOfCondoms]);
        //lower box
        translate([wall+tolerance, wall+tolerance,wall])
            cube([condomLength + wall * 2 + tolerance * 2,condomWidth + wall * 2 + tolerance * 2, wall + condomHeight * numberOfCondoms +0.01]);
        
        translate([condomLength/2 + wall *2+tolerance,-0.01,((wall + condomHeight * numberOfCondoms)/2)*2+wall])
        scale([condomLength/(wall + condomHeight * numberOfCondoms),1,2])
        rotate([-90,0,0])
        cylinder(wall+0.22,(wall + condomHeight * numberOfCondoms)/2,(wall + condomHeight * numberOfCondoms)/2);
        
        translate([condomLength/2 + wall *2+tolerance,wall*3 + tolerance*2+condomWidth,((wall + condomHeight * numberOfCondoms)/2)*2+wall])
        scale([condomLength/(wall + condomHeight * numberOfCondoms),1,2])
        rotate([-90,0,0])
        cylinder(wall+0.02,(wall + condomHeight * numberOfCondoms)/2,(wall + condomHeight * numberOfCondoms)/2);
    }
}
module lowerBox()
{
    difference()
    {
        //lower box
        cube([condomLength + wall * 2,condomWidth + wall * 2, wall + condomHeight * numberOfCondoms]);

        //condom
        translate([wall,wall,wall])
        cube([condomLength,condomWidth, condomHeight * numberOfCondoms+0.01]);
    }
}