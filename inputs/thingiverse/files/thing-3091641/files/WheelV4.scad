outerDia=89;
insideSmallDia=33.7;
wheelWidth=18.3;
wheelThickness=3;
bevelSize=4.1;
axelDia=12.8;
tabOverhang=2.6;
tabWidth=11.4;
tabHeight=7.8;
tabLen=31.0;
slotWidth=5.5;
numberOfRibs=12;
ribsFractionOfHeight=0.7;

$fn=50;
small=0.01;

module outerTire()
{
    linear_extrude(height=wheelWidth-bevelSize)
    circle(d=outerDia);

    translate([0,0,wheelWidth-bevelSize-small])
    linear_extrude(height=bevelSize,scale=(outerDia-2*bevelSize)/outerDia)
    circle(d=outerDia);
}


module rawPeg()
{
    translate([0,0,-tabLen+(wheelWidth-bevelSize)+small])
    cylinder(d=axelDia, h=tabLen);

    translate([0,0,-tabLen+(wheelWidth-bevelSize)])
    linear_extrude(height=tabHeight, scale=(axelDia+tabOverhang*2)/axelDia)
    circle(d=axelDia);
}

 
module chevron()
{   
    w=0.45;
    translate([0,-axelDia*.4,0])
    rotate([0,0,45])
    translate([-w/2,-w/2,-tabLen+(wheelWidth-bevelSize)-small])
    cube([slotWidth*sqrt(2)*1.1/2,w,tabHeight*2.4+slotWidth/2]);
    
    translate([0,-axelDia*.4,0])
    rotate([0,0,135])
    translate([-w/2,-w/2,-tabLen+(wheelWidth-bevelSize)-small])
    cube([slotWidth*sqrt(2)*1.1/2,w,tabHeight*2.4+slotWidth/2]);
}

module fullPeg()
{
    intersection()
    {
        difference()
        {
            rawPeg();
            
            translate([-slotWidth/2,-insideSmallDia/2*.8,-tabLen+(wheelWidth-bevelSize)-small])
            cube([slotWidth,insideSmallDia*.8,tabHeight*2.4]);
            
            translate([0,0,(-tabLen+(wheelWidth-bevelSize))+tabHeight*2.4])
            rotate([90,0,0])
            cylinder(d=slotWidth, h=insideSmallDia*.8,center=true);
        }
        translate([-insideSmallDia*.8/2,-tabWidth/2,-100/2])
        cube([insideSmallDia*.8,tabWidth,100]);
    }

    chevron();
    #mirror([0,1,0])chevron();
    //translate([0,axelDia*.2,0]) chevron();
    //translate([0,axelDia*.4,0]) chevron();
    //translate([0,axelDia*.6,0]) chevron();
}


//outer rim that hits the ground
difference()
{
    outerTire();
    
    translate([0,0,-small])
    linear_extrude(height=wheelWidth-bevelSize)
    circle(d=outerDia-2*wheelThickness);
}
//inner ring closer to the axel
translate([0,0,small])
difference()
{
    cylinder(d=insideSmallDia+2*wheelThickness, h=wheelWidth-bevelSize);
    translate([0,0,-small])
    cylinder(d=insideSmallDia, h=wheelWidth-bevelSize);
}
// some extra strength at the base
translate([0,0,-wheelThickness+wheelWidth-bevelSize+small])
linear_extrude(height=wheelThickness, scale=(axelDia+wheelThickness)/axelDia)
circle(d=axelDia);
// now some ribs
for (i=[0:numberOfRibs-1])
{
    rotate([0,0,360/numberOfRibs*i])
    translate([insideSmallDia/2+small,0,2*small+(wheelWidth-bevelSize)*(1-ribsFractionOfHeight)])
    cube([(outerDia-insideSmallDia-wheelThickness-2*small)/2,wheelThickness,(wheelWidth-bevelSize)*ribsFractionOfHeight]);
}
fullPeg();