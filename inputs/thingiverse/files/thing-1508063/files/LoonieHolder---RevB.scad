// Choose 1 complete print, 2 for Spring, 3 for Clip, 0 to see assembeled
ForPrinting=0;
// Coin Diameter
CDia=26.48;
// Coin Thickness
CThick=1.92;
// Printer Tolerance, select a bit less than normal for a snap fit
PrintTol=0.2;
// Smallest clean (and Strong) wall2 or 3 times extrude width)
MinPrintWidth=1.2;
// How much sprinyness you want
SpringFactor=5;
// How far past center to hang over
ClipHangOver=6.5;
// Key Ring Size
KeyRingDia=5;
// Remaining variables are calculations
SpringThick=MinPrintWidth*SpringFactor;
SpringHeight=CThick;

$fn=120;

if (ForPrinting==1)
{
    translate([0,CDia+SpringThick+MinPrintWidth,CThick/2])rotate([0,0,-45])FacePlate();
    translate([0,-CDia-SpringThick-MinPrintWidth,CThick/2])rotate([0,0,-45])FacePlate();
    translate([0,0,CThick/2])color("blue")rotate([0,0,-45])SpringRing(PrintTol);
}
else if (ForPrinting==2)
{
    translate([0,0,CThick/2])color("blue")rotate([0,0,-45])SpringRing(PrintTol);
}
else if (ForPrinting==3)
{
    translate([0,0,CThick/2])rotate([0,0,-45])FacePlate();
}
else
{
    rotate([0,0,-45])translate([0,0,-CThick])FacePlate();
    rotate([180,0,45])translate([0,0,-CThick])color("green")FacePlate();
    color("blue")rotate([0,0,-45])SpringRing(PrintTol);
    color("red")DrawCoin();
}

module DrawCoin(){
    cylinder(d=CDia,h=CThick,center=true);
}

module SpringRing(Tol){
    difference(){
        union(){
            cylinder(d=CDia+SpringThick,h=CThick,center=true);
            translate([0,0,-CThick/2])cube([(CDia+SpringThick)/2,(CDia+SpringThick)/2,CThick]);
            translate([(CDia+SpringThick)/2,(CDia+SpringThick)/2,0])cylinder(d=KeyRingDia+MinPrintWidth*2+Tol*2+MinPrintWidth*2,h=CThick,center=true);
        }
        union(){
            cylinder(d=CDia,h=CThick*2,center=true);
            rotate([0,0,135])translate([-(CDia+SpringThick)/2,ClipHangOver,-CThick])cube([CDia+SpringThick,CDia+SpringThick,CThick*2]);
            translate([(CDia+SpringThick)/2,(CDia+SpringThick)/2,0])cylinder(d=KeyRingDia+MinPrintWidth*2+Tol*2,h=CThick*2,center=true);
        }
    }
}

module FacePlate(){
    difference(){
        union(){
            cylinder(d=CDia+SpringThick,h=CThick,center=true);
            translate([0,0,-CThick/2])cube([(CDia+SpringThick)/2+MinPrintWidth,(CDia+SpringThick)/2+MinPrintWidth,CThick]);
            //translate([(CDia+SpringThick)/2,(CDia+SpringThick)/2,CThick/4])cylinder(d=KeyRingDia+MinPrintWidth*6+PrintTol*4,h=CThick*1.5,center=true);
            translate([(CDia+SpringThick)/2,(CDia+SpringThick)/2,CThick/4])cylinder(d=KeyRingDia+MinPrintWidth*2+PrintTol*2+MinPrintWidth*2,h=CThick*1.5,center=true);
            
            difference(){
                translate([0,0,-CThick/2])cube([(CDia+SpringThick)/2+MinPrintWidth+PrintTol,(CDia+SpringThick)/2+MinPrintWidth+PrintTol,CThick*1.5]);
                translate([-MinPrintWidth,-MinPrintWidth,-CThick])cube([(CDia+SpringThick)/2+MinPrintWidth+PrintTol,(CDia+SpringThick)/2+MinPrintWidth+PrintTol,CThick*3]);
            }
            
        }
        union(){
            cylinder(d=CDia*.5,h=CThick*2,center=true);
            rotate([0,0,135])translate([-(CDia+SpringThick)/2,ClipHangOver+SpringThick*.5,-CThick])cube([CDia+SpringThick,CDia+SpringThick,CThick*2]);
            translate([(CDia+SpringThick)/2,(CDia+SpringThick)/2,0])cylinder(d=KeyRingDia,h=CThick*6,center=true);
            translate([0,0,CThick])SpringRing(0);
            translate([0,0,CThick])SpringRing(PrintTol*2);
            rotate([0,0,135])translate([-(CDia*.5)/2,0,-CThick])cube([CDia*.5,CDia*2,CThick*2]);
        }
    }
}
