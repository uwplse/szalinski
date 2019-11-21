fanw=146;//bracket width
fanh=128;//bracket height
fant=2;//bracket thickness
fanet=5;//bracket edge thickness
fanew=4;//bracket edge width
faneh=2;//bracket edge height
fand=112; //fan diameter
holespace=106;//fan screw hole spacing
holed=5;//fan screw hole diameter

mscrewh=23;
mscrewd=17;
mbh=23;
mbw=10;
mholed=3.25;
mbh2o=86;

$fn=100;
//mountbs();
//mountbsw();
//mountb();
//fanhole();
bracket();
//plate();
module bracket(){
    difference() {
        plate();
        fanhole();
        fanshole();
    }
    mountbs();
}
module fanshole(){
    translate([(fanw-holespace)/2,(fanh-holespace)/2,0])fscrew();
    translate([(fanw-holespace)/2+holespace,(fanh-holespace)/2,0])fscrew();
    translate([(fanw-holespace)/2,(fanh-holespace)/2+holespace,0])fscrew();
    translate([(fanw-holespace)/2+holespace,(fanh-holespace)/2+holespace,0])fscrew();
    
}
module fanhole(){
    translate([fanw/2,fanh/2,fant/2])cylinder(h=fant, r1=fand/2, r2=fand/2, center=true);
    
}
module plate() {
    difference(){
        cube([fanw,fanh,fanet]);
        translate([fanew,faneh,fant])cube([fanw-2*fanew,fanh-2*faneh,fanet-fant]);
    }
}
module fscrew(){
    translate([0,0,fant/2])cylinder(h=fant,r1=holed/2,r2=holed/2,center=true);
}

module mountbs(){
    translate([0,mscrewh-mbw,fanet])mountb();
    translate([fanw-fanew,mscrewh-mbw,fanet])mountb();
    translate([0,mscrewh-mbw+mbh2o,fanet])mountb();
    translate([fanw-fanew,mscrewh-mbw+mbh2o,fanet])mountb();
}
module mountbsw(){
    translate([fanew/2,0,0])rotate([0,90,0])cylinder(h=fanew,r1=mholed/2,r2=mholed/2,center=true);
    
}
module mountb(){
    difference(){
        cube([fanew,mbw,mbh-fanet]);
        translate([0,mbw/2,mscrewd-fanet])mountbsw();
        
    }
}