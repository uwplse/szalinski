use <quickthread.scad>;

/* [Printer] */
//Curve facets
$fn=64;
//Nozzle Diameter
n=0.4;

/* [Thread] */
//Thread depth (inches)
td=0.25;
//Thread Diameter Extra (Inches)
threadDiaExtra=0.02;

/* [Phone] */
//Phone Mount Height (Device Width)
ph=70;
//Phone Length (Not really used)
pl=145;
//Phone Thickness
pt=8.5;
//Phone Curve Diameter Front
pcdf=2;
//Phone Curve Diameter Rear
pcdr=5;

/* [Mount] */
//Mount top thickness
mtt=2;
//Mount top width
mtw=10;
//Mount crop angle
mca=5;
//Mount Back Layers (x*nozzle)
mbl=3;

mbt=n*mbl;//Mount Back Thickness

/* [Base] */
//Base x
bx=40;
//Base z
bz=10;

by=pt+(mbt*2);//Base y

triodMountPrintRotated();
//tripodMount();

module triodMountPrintRotated(){
    rotate([0,-90-mca,0])translate([mtw/2,0,-ph-mtt-bz])tripodMount();
}

module tripodMount(){
    translate([0,0,bz]){
        difference(){
            union(){
                translate([-bx/2,-by/2,0])cube([bx,by,ph+mtt]);
                translate([0,0,-bz])base();
            }
            translate([-(bx+2)/2,-by-pt/2+pcdf/2,pcdf/2])cube([bx+2,by,ph-pcdf]);
            for(s=[0,1])rotate([0,0,s*180])translate([mtw/2,0,(ph+mtt)])rotate([0,-mca,0])translate([0,-by/2-1,-(ph+mtt)*2])cube([bx*2,by+2,(ph+mtt)*2]);
            phone();
        }
    }
}

module base(){
    difference(){
        translate([-bx/2,-by/2,0])cube([bx,by,bz]);    
        translate([0,0,-0.01])isoThread(dInch=0.25+threadDiaExtra, hInch=td, tpi=20, internal=true, $fn=60); //Tripod thread
    }
}

module phone(){
    translate([0,0,ph/2])hull(){
    for (x=[-1,1]){
        for (z=[-1,1]){
            translate([x*((pl/2)-pcdf/2),-1*((pt/2)-pcdf/2),z*((ph/2)-pcdf/2)])sphere(d=pcdf);
            translate([x*((pl/2)-pcdr/2),((pt/2)-pcdr/2),z*((ph/2)-pcdr/2)])sphere(d=pcdr);
        }
    }
    }
}