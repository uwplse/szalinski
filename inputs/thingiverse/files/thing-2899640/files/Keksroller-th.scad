$fn=100;
dm=40;
innendm=24;
hoehe=60;
teig=5;
steg=4;
segmente=3;
schnitte=hoehe/2;
piksdm=5;
pikspin=1;
randbreite=3;

rolltol=1;
griffb=10;
griffl=80;

deckelh = 5;
verbinder=15;
verbnase=3;

anzscharten= round(hoehe/8);


module piks() {   
    translate([dm/2-teig-1,0,0]) rotate([0,90,0]) cylinder(d1=piksdm,d2=pikspin,h=teig+1);
}

module ring() {
rotate_extrude($fn=100) translate([dm/2-teig+.1,0,0]) polygon( points=[[0,0],[teig,-steg/2],[teig,steg/2]] );
}

module roller() {
difference() {
union() {
cylinder(d=dm-2*teig,h=hoehe);
difference()
    { translate([0,0,-randbreite/2+.6]) cylinder(d=dm-.4,h=randbreite);
      translate([0,0,randbreite/2+.6]) ring();  
    }
difference()
    { translate([0,0,hoehe-randbreite/2-.6]) cylinder(d=dm-.4,h=randbreite);
      translate([0,0,hoehe-randbreite/2-.6]) ring();  
    }

for(i=[0:segmente-1])
    rotate([0,0,i*360/segmente])
    {
      linear_extrude(height = hoehe, center = false, convexity = 10, twist = -(180/segmente), slices = schnitte, scale = 1.0)
      translate([dm/2-teig-.3,0,0]) polygon( points=[[0,-steg/2],[teig+.3,0],[0,steg/2]] );
            linear_extrude(height = hoehe, center = false, convexity = 10, twist = (180/segmente), slices = schnitte, scale = 1.0)
      translate([dm/2-teig-.3,0,0]) polygon( points=[[0,-steg/2],[teig+.3,0],[0,steg/2]] );
    }
}
    for(j=[1:anzscharten-1]) translate([0,0,hoehe/anzscharten*j]) ring();
    translate([0,0,-randbreite]) cylinder(d=innendm,h=hoehe+2*randbreite);    
}
    
for(i=[0:segmente-1])
    rotate([0,0,i*360/segmente])
    {
      translate([0,0,hoehe/6]) rotate([0,0,360/segmente/3]) piks();
      translate([0,0,hoehe/6]) rotate([0,0,360/segmente/3*2]) piks();
      translate([0,0,hoehe/4*2]) rotate([0,0,360/segmente/2]) piks();
      translate([0,0,hoehe/6*5]) rotate([0,0,360/segmente/6]) piks();
      translate([0,0,hoehe/6*5]) rotate([0,0,-360/segmente/6]) piks();
      translate([0,0,hoehe/4*2]) rotate([0,0,360/segmente]) piks();
    }
}

module griff() {
grifft = innendm-rolltol;
translate([0,0,-griffb]) cylinder(d=grifft,h=hoehe-deckelh-verbinder+griffb);
translate([0,-grifft/2,-griffb]) cube([dm,grifft,griffb]);
hull() {
translate([dm,-grifft/2,-griffb]) rotate([0,-45,0]) cube([sin(45)*(hoehe+griffb),grifft,griffb]);
translate([dm*3/2,0,hoehe/2]) rotate([0,90,0]) scale([.8,1,1]) cylinder(d=grifft,h=1.8*griffb);
}
difference() {
translate([dm*3/2,0,hoehe/2]) rotate([0,90,0]) scale([.8,1.15,1]) union() { translate([0,0,griffb]) sphere(d=grifft); translate([0,0,griffb]) cylinder(d=grifft,h=griffl-griffb); translate([0,0,griffl]) sphere(d=grifft); }
translate([0,-50-grifft/2,0]) cube([200,50,100]);    
translate([0,grifft/2,0]) cube([200,50,100]);    
}
buchse();
}

module deckel() {
translate([0,0,hoehe-deckelh-verbinder]) { 
 translate([0,0,verbinder]) cylinder(d=innendm-rolltol,h=deckelh+2*randbreite);
 difference() { 
 cylinder(d=innendm-rolltol-verbnase,h=deckelh+2*randbreite+verbinder);
 translate([innendm/4+2,-innendm/2,0]) cube([innendm,innendm,verbinder]);
 translate([-innendm/4+2,-innendm/2,0]) cube([innendm/2-4,innendm,verbinder]);
 translate([-innendm/4-innendm-2,-innendm/2,0]) cube([innendm,innendm,verbinder]);
}
 translate([-innendm/4+2,0,verbnase]) rotate([90,0,0]) scale([0.7,1,1]) cylinder(d=verbnase,h=innendm-8,center=true);
 translate([innendm/4-2,0,verbnase]) rotate([90,0,0]) scale([0.7,1,1]) cylinder(d=verbnase,h=innendm-8,center=true);
}
translate([0,0,hoehe+randbreite]) cylinder(d=innendm+5,h=randbreite);
}

module buchse () {
translate([0,0,hoehe-deckelh-verbinder]) { difference() {
 translate([0,0,0]) cylinder(d=innendm-rolltol,h=2*verbnase);
 translate([innendm/4-2-.5,-innendm/2,0]) cube([innendm,innendm,verbinder]);
 translate([-innendm/4-innendm+2+.5,-innendm/2,0]) cube([innendm,innendm,verbinder]);

 translate([-innendm/4+2,0,2.2*verbnase]) rotate([90,0,0]) scale([0.9,1,1]) cylinder(d=verbnase,h=innendm+8,center=true);
 translate([innendm/4-2,0,2.2*verbnase]) rotate([90,0,0]) scale([0.9,1,1]) cylinder(d=verbnase,h=innendm+8,center=true);
 translate([-innendm/4+2,0,verbnase]) rotate([90,0,0]) scale([0.9,1,1]) cylinder(d=verbnase,h=innendm+8,center=true);
 translate([innendm/4-2,0,verbnase]) rotate([90,0,0]) scale([0.9,1,1]) cylinder(d=verbnase,h=innendm+8,center=true);
}
}
}


deckel();
translate([0,0,0]) griff();
translate([0,0,randbreite/2]) roller();
