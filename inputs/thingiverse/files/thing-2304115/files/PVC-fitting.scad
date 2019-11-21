$fa=0.5*1; // default minimum facet angle is now 0.5 deg
$fs=0.5*1; // default minimum facet size is now 0.5 mm

// PVC schedule 40 outer diameter: 3/4" -> 26.67mm, 1" -> 33.401mm, 1 1/4 -> 42.164mm
diaPVC=26.67; //[26.67, 33.401, 42.164]
//  number of ports
Nport=5; //[2, 3, 4, 5, 6, 7]
// thickness of walls in mm
wall=2; //[1, 2, 3, 4]
// Ngon circumscribing PVC pipe
Nsides=12; // [6, 8, 10, 12]
// tolerance offset
tolx=0.25; //[0, 0.125, 0.25, 0.375, 0.5]

diaNgon=diaPVC*1/cos(180/Nsides);// calculations to reduce to internal variables


module port(){
    sphere(d=diaPVC+wall);
    difference(){
        cylinder(d=diaNgon+wall*2,h=1.5*(diaPVC+wall));
        translate([0,0,diaNgon/2+wall])cylinder(d=diaNgon,h=(diaPVC)+2*wall+3*tolx,$fn=Nsides);
    }
}

module porthole(){
        translate([0,0,diaNgon/2+wall])cylinder(d=diaNgon,h=(diaPVC)+2*wall+tolx,$fn=Nsides);
    for(ndx=[1:360/(Nport-1):359]){
        rotate([90,0,ndx])translate([0,0,diaNgon/2+wall])cylinder(d=diaNgon,h=(diaPVC)+2*wall+tolx,$fn=Nsides);
    }
}

module hub(){
    difference(){
        union(){
            translate([0,0,-(1/2)*(diaNgon)-wall])
                cylinder(r=1.5*diaNgon+wall,h=wall);
                    for(ndx=[1:360/(Nport-1):359]){
                    rotate([90,0,ndx+90])cylinder(r=1.5*diaNgon,h=wall,center=true,$fn=4);
                
            }
        }
    translate([0,0,-(1/2)*(diaNgon)-wall])rotate([180,0,0])cylinder(r=1.5*diaNgon+3*wall,h=2*diaNgon);     
    }

}

module portassy(){
    port();
    for(ndx=[1:360/(Nport-1):359]){
        rotate([90,0,ndx])port();
    }
    hub();
}


difference(){
    portassy();
    porthole();
}
