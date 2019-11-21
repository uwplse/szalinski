//Halterung für Hygrometer/Thermometer
//20190316 P. de Graaff

spoolhole=53;

//Fassung
translate([0,0,2])difference(){
    translate([0,0,-0.1])cylinder(d=60,h=2.1,$fn=150);
    translate([0,0,-1])cylinder(d=46,h=5,$fn=150);
}
difference(){
    translate([0,0,-0.1])cylinder(d=60,h=2,$fn=150);
    translate([0,0,-1])cylinder(d=42,h=5,$fn=150);
}
difference(){
    rotate([180,0,0])cylinder(d=spoolhole+0.2,h=2,$fn=150);
    translate([0,0,-3])cylinder(d=42,h=5,$fn=150);
}
//untere Halterung
translate([0,0,-1])difference(){
    rotate([180,0,0])cylinder(d2=spoolhole-2,d1=spoolhole+0.2,h=20,$fn=150);
    translate([0,0,1])rotate([180,0,0])cylinder(d=spoolhole-5,3,h=50,$fn=150);//-4 vielleicht zu dünn
    translate([0,0,-10])for (j=[0:30:360]){
    translate([0,0,-35])rotate([0,0,0+j])cube([60,5,40]);
    }
}
//Gleiter
//Winkel berechnen
b=sqrt(20*20+(spoolhole-spoolhole-2)*(spoolhole-spoolhole-2));
echo(b);
gamma=acos(20/b);
echo(gamma);
for(alpha=[0:30:360]){
    rotate([0,0,-9+alpha])translate([(spoolhole-2)/2-0.3,0,-21])rotate([0,gamma/2-0.2,0])cylinder(d=1,h=19.05,$fn=50);
}

//Wulst
difference(){
    translate([0,0,-19.75])rotate_extrude($fn=300)translate([(spoolhole-1)/2,0,0])intersection(){
        square([1.5,2.5],center=true);
        translate([-2.3,0,0])circle(r=3,$fn=100);
        translate([2.3,0,0])circle(r=3.5,$fn=100);
    }
    translate([0,0,-10])for (j=[0:30:360]){
    translate([0,0,-35])rotate([0,0,0+j])cube([60,5,40]);
    }
}
    