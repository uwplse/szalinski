ForPrinting=0; //1=for printing, 0=for display
CDia=26.48;
CThick=1.92;
PrintTol=0.2;
MinPrintWidth=1.2;
SpringFactor=5;
SpringThick=MinPrintWidth*SpringFactor;
SpringHeight=CThick;
ClipHangOver=6.5;
KeyRingDia=5;

$fn=120;

if (ForPrinting==1)
{
    translate([0,CDia+SpringThick+MinPrintWidth,CThick/2])rotate([0,0,-45])FacePlate();
    translate([0,-CDia-SpringThick-MinPrintWidth,CThick/2])rotate([0,0,-45])FacePlate();
    translate([0,0,CThick/2])color("blue")rotate([0,0,-45])SpringRing(PrintTol);
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
            translate([(CDia+SpringThick)/2,(CDia+SpringThick)/2,CThick/4])cylinder(d=KeyRingDia+MinPrintWidth*6+PrintTol*4,h=CThick*1.5,center=true);
            
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
