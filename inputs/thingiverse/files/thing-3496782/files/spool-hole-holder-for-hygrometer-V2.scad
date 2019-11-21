//Halterung für Hygrometer/Thermometer
//20190316 P. de Graaff

spoolhole=51;

//Fassung
translate([0,0,2])difference(){
    translate([0,0,-0.1])cylinder(d=60,h=2.1,$fn=150);
    translate([0,0,-1])cylinder(d=46,h=5,$fn=150);
}
difference(){
    translate([0,0,-0.1])cylinder(d=60,h=2,$fn=150);
    translate([0,0,-1])cylinder(d=42,h=5,$fn=150);
}

translate([0,0,0])difference(){
    rotate([180,0,0])cylinder(d2=spoolhole-2,d1=spoolhole+0.2,h=20,$fn=150);
    translate([0,0,1])rotate([180,0,0])cylinder(d=spoolhole-4,3,h=50,$fn=150);
    translate([0,0,-10])for (j=[0:30:360]){
    translate([0,0,-35])rotate([0,0,0+j])cube([60,5,40]);
    }
}
//Winkel berechnen
b=sqrt(20*20+(spoolhole-spoolhole-2)*(spoolhole-spoolhole-2));
echo(b);
gamma=acos(20/b);
echo(gamma);
for(alpha=[0:30:360]){
    rotate([0,0,-9+alpha])translate([(spoolhole-2)/2-0.3,0,-20])rotate([0,gamma/2+1,0])cylinder(d1=1,d2=1.5,h=20,$fn=50);
}