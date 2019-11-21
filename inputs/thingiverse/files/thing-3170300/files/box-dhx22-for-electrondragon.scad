// scatola dht22

spessore=1;
larghezza=24;
profondita=17;
profondita2=28;
altezza=44;
saltezza=5;
drientranza=6;
srientranza=0.5;
lrientranza=10;
dforo=3.5;

ascanso=23;

difference (){

difference () {
difference(){
linear_extrude(height = altezza)
polygon(points=[[0,0],[larghezza,0],[larghezza,profondita2],[2,profondita+3],[0,profondita]]);
    
translate([0,0,-spessore-saltezza])
linear_extrude(height = altezza)
polygon(points=[[spessore,spessore],[larghezza-spessore,spessore],[larghezza-spessore,lrientranza],[spessore,lrientranza]]);

translate([0,0,-spessore])
linear_extrude(height = altezza)
polygon(points=[[spessore,lrientranza],[larghezza-spessore,lrientranza],[larghezza-spessore,profondita2-spessore],[spessore+2,lrientranza+9],[spessore,profondita-spessore]]);
}

    
    
    translate([larghezza/2-5,-1,0])
    cube([12,5,5]);

    translate([-1,+spessore,0])
    cube([larghezza,profondita,10]);

    translate([-1,5.5+1,10])
    rotate([0,90,0])
    cylinder (d=11,h=larghezza-spessore+1,$fn=50);

    translate([-1,profondita,0])
    cube([larghezza-spessore+1,profondita,ascanso]);
    
    translate([0,profondita,ascanso])
    rotate([32,0,0])

    translate([-1,-profondita,-20])
    cube([larghezza-spessore+1,profondita,20]);
}

for (i=[0+drientranza/2:larghezza-drientranza/2*3:larghezza]) {

    translate ([i+2,lrientranza/2,0])
    union(){
    translate([0,0,altezza-saltezza/2])
    cylinder (d=drientranza,h=saltezza,$fn=50);
    translate([0,0,0])
    cylinder (d=dforo,h=altezza,$fn=50);
    
}
}
// sopra
for (i=[0+2:3:larghezza-2]) {
for (l=[lrientranza:3:profondita]) { 
    translate ([i,l,altezza-saltezza])
    cube([1.5,1.5,saltezza]);
}
}

// davanti
rotate([90,0,0])
for (i=[0+2:2.5:larghezza-2]) {
for (l=[10:2.5:altezza-5]) { 
    translate ([i,l,-3])
    cylinder(d=2,h=4,$fn=4);
}
}

//dietro
rotate([90,0,0])
for (i=[2:3:larghezza-2]) {
for (l=[ascanso+2.5:3:altezza-5]) { 
    translate ([i,l,-profondita2-5])
    cylinder(d=2,h=profondita2,$fn=4);
}
}

// sinistro
rotate([0,-90,0])
for (i=[10:2.5:altezza-5]) {
for (l=[2:2.5:profondita2-2]) { 
    translate ([i,l,-larghezza-1])
    cylinder(d=2,h=3,$fn=4);
}
}

rotate([0,-90,0])
for (i=[ascanso+2:2.5:altezza-5]) {
for (l=[2:2.5:profondita-2]) { 
    translate ([i,l,-2])
    cylinder(d=2,h=3,$fn=4);
}
}

}
