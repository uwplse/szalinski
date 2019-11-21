
/* [Handle settings] */
//screwriver height
sdh=18;//[18:1:100]

//screwdriver diameter
sdd=20;//[20:0.5:50]

/* [Magnet settings] */
//magnet option
mo=1;//[0:No,1:Yes]

//magnet shape
mshape=0;//[0:round,1:square]

//magnet size (square side or circle diameter)
msize=10;//[5:0.5:10]

//magnet thickness
mt=2;//[1:0.5:6]

/* [Tuning] */
definition=40;//[40:Low,70:Medium,100:High]
//positve value will add gaps for bit and magnet
tolerance=0.15;
/////////

$fn=definition;

//screwdriver
module screwdriver(a){
    difference() {
        rotate([180,0,0])rotate_extrude() rotate([0,0,-90])
        hull() {
            translate([sdh-5.25,0,0]) square(5.25);
            square(1);
            translate([5,sdd/2-5,0]) circle(5);
            translate([sdh-13,sdd/2-5,0]) circle(5);
        }
        for(i=[0:360/7:360]) rotate([0,0,i]) translate([sdd/1.9,0,0]) scale([1,1.2,1]) cylinder(d=2*3.14*sdd/25,h=sdh);
            translate([0,0,sdh-0.2]) cylinder(d=7.4+2*tolerance,h=16,center=true,$fn=6);
        
        //magnet option
        translate([0,0,sdh-8-mt/2-tolerance]) if(a==1) {
            if(mshape==0) {
                cylinder(d=msize+4*tolerance,h=mt+4*tolerance,center=true);
            }
            else if(mshape==1) {
                cube([msize+4*tolerance,msize+4*tolerance,mt+2*tolerance],center=true);
            }
        }
        else {}
    }

}
screwdriver(mo);
