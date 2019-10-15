//How Many Spokes Should There Be?
m=20; //[4:50]
//How Large Should The Center Hole Be?
h=2; //[1:12]
//How Many Sides Should The Center Hole Have?
c=6; //[3:12]
//How Large Are The Spokes?
a=1; //[1:8]
//What Is The radius Of The Wheel?
text_box=25;
//What Is The Height Of the Wheel?
l=3; //[3:20]
//Is There A Rim On The End?
rim="yes"; //[yes,no]
//How Much Lager Is The Toltal Rim Diameter? (Only Applys If There Is A Rim)
rd=1; //[1:5]

s=360/m;
difference() {
    cylinder(h=l,r=h+.5,$fn=50,center=true);
    cylinder(h=l+1,r=h,$fn=c,center=true);
}
for(r=[0:s:360]) {
    translate([0,0,0-a/2]) {
        rotate([0,0,r]) {
            difference() {
                cube([a,text_box-.5,a]);
                rotate([0,0,0-r]) {
                    cylinder(h=l+1,r=h,$fn=c,center=true);
                }
            }
        }
    }
}
difference() {
    cylinder(h=l,r=text_box, $fn=50,center=true);
    cylinder(h=l+1,r=text_box-1, $fn=50,center=true);
}
if(rim=="yes") {
    translate([0,0,l/3]) {
        difference() {
            cylinder(h=l/3,r=rd+text_box, $fn=50,center=true);
            cylinder(h=l+1,r=text_box-1, $fn=50,center=true);
        }
    }
    translate([0,0,0-l/3]) {
        difference() {
            cylinder(h=l/3,r=rd+text_box, $fn=50,center=true);
            cylinder(h=l+1,r=text_box-1, $fn=50,center=true);
        }
    }
}