lowheight=1;
midheight=2;
highheight=3;
windowheight=.1;
narrowwall=.8;
thickwall=2.6;



$fn=50;
difference(){
    union(){

        minkowski(){
            cube([20,45,lowheight-.5]);
            cylinder(r=5,h=.5);
        }
        minkowski(){
            cube([20,30,midheight-.5]);
            cylinder(r=5,h=.5);
        }
        minkowski(){
            cube([20,15,highheight-.5]);
            cylinder(r=5,h=.5);
        }
    }
    union(){
        minkowski(){
            translate([thickwall,narrowwall,windowheight])cube([5,5,highheight+1]);
            cylinder(r=5,h=.5);
        }
        translate([20,0,0])cylinder(d=4,h=10,center=true);
    }
}