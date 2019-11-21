//lens cover inputs
//inside diameter of cover in millimeters
d=62.5;


//desired thickness of cover
h=2.5;

//height of rim (must be greater than h)
rh=5;

//desired thickness of rim
rt=2.5;


//default calculations (do not alter)
rh1=rh+h;
r=d/2;
r1=r+rt;
difference() {
cylinder(rh1,r=r1,true,$fn=100);
translate([0,0,h]) cylinder(10000000000,r=r,true,$fn=100);}