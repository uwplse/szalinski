$fn=120;

BlechDicke=3;
BlechRundMin=4;
BlechRundMax=4.7;
BlechX=45;
BlechY=45;
SchraubeD=3.5;
SchraubeKopfD=7;
SchraubeKopfH=3;
SchraubeMutterD=6.7;
SchraubeMutterH=2.5;
TraegerDicke=5;
TraegerLaenge=115;
HeizPlatteHoehe=20;


module Binder()
{
    difference()
    {
        cylinder(h=3,d=25,center=true);
        cylinder(h=3,d=19,center=true);
    }
}

module Befestigungsplatte()
{
    difference()
    {
        union()
        {
            translate([-BlechRundMax*2,-BlechY+BlechRundMax,-BlechDicke]) cube([10,BlechY-BlechRundMax*2,BlechDicke],false);
            translate([BlechRundMax,-BlechY+BlechRundMax,-BlechDicke]) rotate([0,0,-45]) cube([10,sqrt(BlechY*BlechY+BlechX*BlechX)-BlechRundMax*2,BlechDicke],false);
            translate([BlechRundMax,BlechRundMax-5,-BlechDicke]) cube([BlechX-BlechRundMax*2,10,BlechDicke],false);
            hull()
            {
                translate([0,0,-BlechDicke]) cylinder(h=BlechDicke*2-0.2,r1=BlechRundMax,r2=BlechRundMax,center=false);
                translate([BlechX,0,-BlechDicke]) cylinder(h=BlechDicke*2-0.2,r1=BlechRundMax,r2=BlechRundMax,center=false);
                translate([0,-BlechY,-BlechDicke]) cylinder(h=BlechDicke*2-0.2,r1=BlechRundMax,r2=BlechRundMax,center=false);
            }
        }
        union()
        {
            translate([0,0,0]) cylinder(h=20,d=SchraubeD,center=true);
            translate([BlechX,0,0]) cylinder(h=20,d=SchraubeD,center=true);
            translate([0,-BlechY,0]) cylinder(h=20,d=SchraubeD,center=true);
            translate([0,0,-BlechDicke-0.1]) cylinder(h=SchraubeKopfH,r1=SchraubeKopfD/2,r2=SchraubeD/2,center=false);
            translate([BlechX,0,-BlechDicke-0.1]) cylinder(h=SchraubeKopfH,r1=SchraubeKopfD/2,r2=SchraubeD/2,center=false);
            translate([0,-BlechY,-BlechDicke-0.1]) cylinder(h=SchraubeKopfH,r1=SchraubeKopfD/2,r2=SchraubeD/2,center=false);
        }
    }
}

module Traeger()
{
    difference()
    {
        hull()
        {
            translate([-BlechRundMax*2,TraegerLaenge-BlechY-BlechRundMax*4,0]) cube([BlechRundMax,BlechRundMax,TraegerDicke],false);
            translate([BlechRundMax,TraegerLaenge-BlechY-BlechRundMax*4,0]) cube([BlechRundMax,BlechRundMax,TraegerDicke],false);
            translate([-BlechRundMax,-BlechY-BlechRundMax,0]) cylinder(h=TraegerDicke,r1=BlechRundMax,r2=BlechRundMax,center=false);
            translate([BlechRundMax,-BlechY-BlechRundMax,0]) cylinder(h=TraegerDicke,r1=BlechRundMax,r2=BlechRundMax,center=false);
            translate([BlechX+BlechRundMax,-BlechRundMax/2,0]) cylinder(h=TraegerDicke,r1=BlechRundMax,r2=BlechRundMax,center=false);
            translate([BlechX+BlechRundMax,BlechRundMax/2,0]) cylinder(h=TraegerDicke,r1=BlechRundMax,r2=BlechRundMax,center=false);
        }
        union()
        {
            translate([0,0,0]) cylinder(h=20,d=SchraubeD,center=true);
            translate([BlechX,0,0]) cylinder(h=20,d=SchraubeD,center=true);
            translate([0,-BlechY,0]) cylinder(h=20,d=SchraubeD,center=true);
            translate([0,0,TraegerDicke-SchraubeMutterH]) cylinder(d=SchraubeMutterD,h=SchraubeMutterH,$fn=6);
            translate([BlechX,0,TraegerDicke-SchraubeMutterH]) cylinder(d=SchraubeMutterD,h=SchraubeMutterH,$fn=6);
            translate([0,-BlechY,TraegerDicke-SchraubeMutterH]) cylinder(d=SchraubeMutterD,h=SchraubeMutterH,$fn=6);
       }
    }
    difference()
    {
        hull()
        {
           translate([-BlechRundMax,TraegerLaenge-BlechY-BlechRundMax*4+TraegerDicke-1,TraegerDicke/2]) rotate([0,-90,0]) cylinder(h=TraegerDicke,r1=TraegerDicke/2,r2=TraegerDicke/2,center=false);
           translate([BlechRundMax*2,TraegerLaenge-BlechY-BlechRundMax*4+TraegerDicke-1,TraegerDicke/2]) rotate([0,-90,0]) cylinder(h=TraegerDicke,r1=TraegerDicke/2,r2=TraegerDicke/2,center=false);
    
            translate([-BlechRundMax-22,TraegerLaenge-BlechY-BlechRundMax*4+HeizPlatteHoehe,TraegerDicke/2+HeizPlatteHoehe]) sphere(TraegerDicke/2); 
            translate([BlechRundMax*2-22,TraegerLaenge-BlechY-BlechRundMax*4+HeizPlatteHoehe,TraegerDicke/2+HeizPlatteHoehe]) sphere(TraegerDicke/2); 
            translate([(0.5*BlechRundMax-22),TraegerLaenge-BlechY-BlechRundMax*3.5+HeizPlatteHoehe,TraegerDicke/2+HeizPlatteHoehe]) sphere(TraegerDicke/2); 
        }
        translate([0.5*BlechRundMax-22,TraegerLaenge-BlechY-BlechRundMax*3.5+HeizPlatteHoehe-16,TraegerDicke/2+HeizPlatteHoehe]) rotate([-45,0,0]) cylinder(h=26,d=15,center=false);
    }
    difference()
    {
        hull()
        {
            translate([-BlechRundMax-22,TraegerLaenge-BlechY-BlechRundMax*4+HeizPlatteHoehe,TraegerDicke/2+HeizPlatteHoehe]) sphere(TraegerDicke/2); 
            translate([BlechRundMax*2-22,TraegerLaenge-BlechY-BlechRundMax*4+HeizPlatteHoehe,TraegerDicke/2+HeizPlatteHoehe]) sphere(TraegerDicke/2); 
            translate([0.5*BlechRundMax-22,TraegerLaenge-BlechY-BlechRundMax*3.5+HeizPlatteHoehe,TraegerDicke/2+HeizPlatteHoehe]) sphere(TraegerDicke/2); 
            translate([-BlechRundMax-22,TraegerLaenge-BlechY-BlechRundMax*4+HeizPlatteHoehe+7.5,TraegerDicke/2+HeizPlatteHoehe+15]) sphere(TraegerDicke/2); 
            translate([BlechRundMax*2-22,TraegerLaenge-BlechY-BlechRundMax*4+HeizPlatteHoehe+7.5,TraegerDicke/2+HeizPlatteHoehe+15]) sphere(TraegerDicke/2); 
            translate([0.5*BlechRundMax-22,TraegerLaenge-BlechY-BlechRundMax*3.5+HeizPlatteHoehe+7.5,TraegerDicke/2+HeizPlatteHoehe+15]) sphere(TraegerDicke/2); 
        }
        translate([0.5*BlechRundMax-22,TraegerLaenge-BlechY-BlechRundMax*3.5+HeizPlatteHoehe-13.9,TraegerDicke/2+HeizPlatteHoehe]) rotate([-33,0,0]) cylinder(h=26,d=15,center=false);
        translate([0.5*BlechRundMax-22,TraegerLaenge-BlechY-BlechRundMax*3.5+HeizPlatteHoehe-1.5,TraegerDicke/2+HeizPlatteHoehe+13]) rotate([-26,0,0]) Binder();
        translate([0.5*BlechRundMax-22,TraegerLaenge-BlechY-BlechRundMax*3.5+HeizPlatteHoehe-5,TraegerDicke/2+HeizPlatteHoehe+6]) rotate([-26,0,0]) Binder();
    }
    difference()
    {
        hull()
        {
            translate([-BlechRundMax-22,TraegerLaenge-BlechY-BlechRundMax*4+HeizPlatteHoehe+7.5,TraegerDicke/2+HeizPlatteHoehe+15]) sphere(TraegerDicke/2); 
            translate([BlechRundMax*2-22,TraegerLaenge-BlechY-BlechRundMax*4+HeizPlatteHoehe+7.5,TraegerDicke/2+HeizPlatteHoehe+15]) sphere(TraegerDicke/2); 
            translate([0.5*BlechRundMax-22,TraegerLaenge-BlechY-BlechRundMax*3.5+HeizPlatteHoehe+7.5,TraegerDicke/2+HeizPlatteHoehe+15]) sphere(TraegerDicke/2); 
            translate([-BlechRundMax-22,TraegerLaenge-BlechY-BlechRundMax*4+HeizPlatteHoehe+10,TraegerDicke/2+HeizPlatteHoehe+30]) sphere(TraegerDicke/2); 
            translate([BlechRundMax*2-22,TraegerLaenge-BlechY-BlechRundMax*4+HeizPlatteHoehe+10,TraegerDicke/2+HeizPlatteHoehe+30]) sphere(TraegerDicke/2); 
            translate([0.5*BlechRundMax-22,TraegerLaenge-BlechY-BlechRundMax*3.5+HeizPlatteHoehe+10,TraegerDicke/2+HeizPlatteHoehe+30]) sphere(TraegerDicke/2); 
        }
        translate([(0.5*BlechRundMax-22),TraegerLaenge-BlechY-BlechRundMax*3.5+HeizPlatteHoehe-3,TraegerDicke/2+HeizPlatteHoehe+14]) rotate([-10,0,0]) cylinder(h=25,d=15,center=false);
        translate([(0.5*BlechRundMax-22),TraegerLaenge-BlechY-BlechRundMax*3.5+HeizPlatteHoehe+1,TraegerDicke/2+HeizPlatteHoehe+20]) rotate([-10,0,0]) Binder();
        translate([(0.5*BlechRundMax-22),TraegerLaenge-BlechY-BlechRundMax*3.5+HeizPlatteHoehe+2.3,TraegerDicke/2+HeizPlatteHoehe+28]) rotate([-10,0,0]) Binder();
    }
    hull()
    {
            translate([0,TraegerLaenge-BlechY-BlechRundMax*4+TraegerDicke,TraegerDicke+1]) cylinder(h=TraegerDicke/2,d=TraegerDicke,center=true);
            translate([0,10,TraegerDicke+1]) cylinder(h=TraegerDicke/2,d=TraegerDicke,center=true);
     }   
    hull()
    {
            translate([0,TraegerLaenge-BlechY-BlechRundMax*4+TraegerDicke,TraegerDicke+1]) cylinder(h=TraegerDicke/2,d=TraegerDicke,center=true);
            translate([BlechX-TraegerDicke,10,TraegerDicke+1]) cylinder(h=TraegerDicke/2,d=TraegerDicke,center=true);
     }   
   hull()
    {
        translate([0,TraegerLaenge-BlechY-BlechRundMax*4+TraegerDicke-1,TraegerDicke+1]) rotate([0,0,0]) cylinder(h=TraegerDicke/2,d=TraegerDicke+2,center=true);
        translate([BlechRundMax*2-22-5,TraegerLaenge-BlechY-BlechRundMax*4+HeizPlatteHoehe,TraegerDicke/2+HeizPlatteHoehe]) rotate([0,-135,-90]) cylinder(h=TraegerDicke/2,d=TraegerDicke+2,center=true);
     }   
}

translate([100,0,BlechDicke]) Befestigungsplatte();
Traeger();
