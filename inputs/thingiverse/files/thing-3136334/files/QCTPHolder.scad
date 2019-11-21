//[mm]
gapSize = 3;

module wedge()
{
    difference(){
        cube([24.9,6.2,28.6]);
        translate([0,0,-0.1])rotate(60)cube([10,10,30]);
        translate([24.9,0,-0.1])rotate(30,[0,0,1])cube([10,10,30]);
        roundEdge();
    }
}

module base()
{
    $fn=100;
    translate([0,9.2,0])linear_extrude(3,true)resize([36,22.8])offset(r=5)square([36,22.8],true);  
    difference()
    {   
        translate([-18,6.2,3])cube([36,6,28.6]);
        translate([18,0,3])
        rotate(90)
        roundEdge();
        translate([-18,20,3])
        rotate(-90)
        roundEdge();
    }
}

module roundEdge()
{
    difference()   
    {
        translate([0,-0.2,22.4])cube([30,6.5,6.5]);
        $fn=100;
        translate([-1,6.2,22.4])rotate(90,[0,1,0])cylinder(35,6.2,6.2);
    }
}

module holder()
{
    translate([-12.45,-9.2,3])wedge();
    translate([0,-9.2,0])base();
    translate([12.45,9.2,3])rotate(180)wedge();
}

module gap()
{
    translate([0,-gapSize/2,-0.2])cube([40,gapSize,24.2-gapSize/2]);
    $fn=100;
    translate([0,0,24-gapSize/2])rotate(90,[0,1,0])cylinder(40,gapSize/2,gapSize/2);
}



difference()
{
    holder();
    translate([-20,0,0])gap();
}