heightpump=16;
radiusoutcyl=25;
radiushole=15;
radiusholebig=19;
radiusoutcylbig=30;
heightscrewcube=20;
widthscrewcube=22;
screwdistancefromborder=4;
tuberadius=2.2;
tubeposition=2;
skirtthickness=3;
skirtradius=radiushole-2;
screwradius=1.55;
separazione=-10;
enterangle=35;
//rotor
radiusmotorshaft=2.55;
h_uppershaft=0;
distancefromcenter=10;
numberofnuts=5;
thickness_rotor=3;
radiusrotorshaft=4.5;
boxscrew=radiusrotorshaft+2;

//rotor
difference(){
union(){
rotate([0,0,45])
translate([0,radiusrotorshaft,-heightpump/2+h_uppershaft+heightpump-boxscrew/2])cube([radiusrotorshaft*2,boxscrew,boxscrew],center=true);
translate([0,0,h_uppershaft/2]) cylinder(h=heightpump+h_uppershaft,r=radiusrotorshaft,$fn=40,center=true);
translate([0,0,-heightpump/2]){
cylinder(h=thickness_rotor,r=radiushole-1,$fn=100);
}
}
translate([0,0,-heightpump/2]){    
for (a =[0:360/numberofnuts:360]){    
    rotate([0,0,a]) 
translate([0,distancefromcenter,h_uppershaft/2]) cylinder(h=heightpump+h_uppershaft,r=screwradius,$fn=40,center=true);
}
}
cylinder(h=(heightpump+h_uppershaft)*2,r=radiusmotorshaft,$fn=40,center=true);
rotate([0,0,45])
translate([0,5,-heightpump/2+h_uppershaft+heightpump-boxscrew/2])
 rotate([90,0,0])
    color("blue") cylinder(h=10,r=screwradius-0.1,center=true,$fn=20);
}


