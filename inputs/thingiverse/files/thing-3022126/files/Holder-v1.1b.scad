

//Radius of the x/y-axis bearing box
radius = 12/2 + 0.2;
//Length of the bearing box
bearingLen = 35;
//Thickness of holder
holderT = 2;
offs = holderT;
//Space from bottom to axis center
offset = offs + radius;
//Side-length
boxsize = 40;
//Height-Distance between the x and y axis
axisDist = 18;
//The total height of the block
totalHeight = 2*offset + axisDist;
//Distance between the screw holes
screwDistance = 32;
//Radius(!) of the screwholes
screws = 3/2 + 0.1;
//
arretDep = 0.3;

arretLen = 4;
arretWid = 1;

bearingOffs = bearingLen - 2*(arretLen + arretWid);

echo("Total Height: ",totalHeight," mm");

//Full:
mainBody();

//Middle Part(s)
translate([50,0,-offset-axisDist/2]) {
    difference() {
        mainBody();
        
        translate([-0.5,-0.5,-1])
            cube([boxsize+1,boxsize+1, axisDist/2+offset+1]);
        translate([-0.5,-0.5,offset+axisDist])
            cube([boxsize+1,boxsize+1, offset+axisDist/2+1]);
    }
}

//End Part(s)
translate([100,0,0]) {
    //translate([0,boxsize,offset]) {
        //rotate([0,0,0]){
            difference() {
                mainBody();
                translate([-0.5,-0.5,offset])
                    cube([boxsize+1,boxsize+1, totalHeight]);
            }
        //}
    //}
}

module mainBody() {
    difference() {
    color(c=[0, 1, 1] ) {
        cube([boxsize,boxsize, totalHeight]);}
        
        //Screwholes
        translate([4,4,-0.5]) rotate([0,0,90])
            cylinder(70,screws,screws, center=false, $fn=50);
        translate([boxsize-4,4,-0.5]) rotate([0,0,90])
            cylinder(70,screws,screws, center=false, $fn=50);
        translate([4,boxsize-4,-0.5]) rotate([0,0,90])
            cylinder(70,screws,screws, center=false, $fn=50);
        translate([boxsize-4,boxsize-4,-0.5]) rotate([0,0,90])
            cylinder(70,screws,screws, center=false, $fn=50);
        
        //Air vent hole
        translate([boxsize/2,boxsize/2,-0.5]) rotate([0,0,0])
            cylinder(7.5,19.5,18, center=false, $fn=150);
        translate([boxsize/2,boxsize/2,totalHeight+.5]) rotate([180,0,0])
            cylinder(7.5,19.5,18, center=false, $fn=150);
        
        translate([boxsize/2,boxsize/2,5-0.5]) rotate([0,0,0])
            cylinder(50,18,18, center=false, $fn=150);
        
        //Big hole
        translate([boxsize/2,boxsize+0.5,offset]) rotate([90,90,0])
            cylinder(boxsize+1,radius,radius, center=false, $fn=100);
        translate([-0.5,boxsize/2,offset+axisDist]) rotate([0,90,0])
            cylinder(boxsize+1,radius,radius, center=false, $fn=100);
    }

    //Holder for Axis
    translate([0,boxsize/2,offset+axisDist]) rotate([0,0,0])
        axisHolder();
    translate([boxsize/2,0, offset]) rotate([0,0,90])
        axisHolder();
}

module axisHolder() {
    color(c=[0, 0, 1] ) {
    difference() {
        union() {
            difference() {
                union() {
                    //Holder for bearing
                    translate([0,0,0]) rotate([0,90,0])
                        cylinder((boxsize-arretWid)/2,radius+holderT,radius+holderT, center=false, $fn=150);
                    translate([boxsize,0,0]) rotate([0,-90,0])
                        cylinder((boxsize-arretWid)/2,radius+holderT,radius+holderT, center=false, $fn=150);
                }
                
                //Bigger Hole
                translate([-.5,0,0]) rotate([0,90,0])
                    cylinder(boxsize+1,radius,radius, center=false, $fn=100);
            }
            //Locking for bearing
            translate([(boxsize-arretWid)/2,0,0]) rotate([0,-90,0])
                cylinder(1,radius,radius, center=false, $fn=150);
            translate([boxsize-(boxsize-arretWid)/2,0,0]) rotate([0,+90,0])
                cylinder(1,radius,radius, center=false, $fn=150);
        }
        //Smaller Hole
        translate([-.5,0,0]) rotate([0,90,0])
            cylinder(boxsize+1,radius-arretDep,radius-arretDep, center=false, $fn=100);
    }}
    
    color(c=[1, 0, 0, 0.2] ) {
        //translate([2.5,0,0]) rotate([0,90,0]) cylinder(35,radius,radius, center=false, $fn=100);
    }
}


//translate([60,10,0]) cube([10,10,9]);