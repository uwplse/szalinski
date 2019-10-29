//Diameter of the stylus
stylusDiameter=10.5;

//Tolerance (to OD and ID)
tolerance=0.2;

penAdapter();

module penAdapter(mountDiameter=22, mountHeight=15)
{

    difference () {
    
        cylinder(r=mountDiameter/2-tolerance, h= mountHeight, $fn=50);

        union () {
            stylusMount();
            space();
            m3Hole();
        }
    }
} 


module stylusMount (mountHeight=15) {

    translate([0,0,-1]) cylinder(r=stylusDiameter/2+tolerance, mountHeight+2, $fn=50);      
}

module space (mountDiameter=22, mountHeight=15, spaceSize=2) {
    
    translate([0,mountDiameter/2,mountHeight/2-1]) cube(size = [spaceSize, mountDiameter, mountHeight+10], center=true);
}

module m3Hole (mountHeight=15,mountDiameter=22) {
    
        rotate([90,0,0]) translate([0,mountHeight/2,0]) cylinder(r=2.6/2, mountDiameter/2, $fn=20);
}