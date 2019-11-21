
/* [Show] */
show="alle"; // [alle:alles,basis:Basis,fluegel:Flügel,blatt:Blatt]
// Radius Flügel
r= 50;
// Breite Flügel
d= 65;
// Flügelabstand
x=25;
y=10;
// Höhe Flügel
h= 3;
// Anzahl Flügel
c= 12;
// Dist
dist= 0.4;
//Basis Radius
r2=25;
//Basis Höhe
h2=10;

a=360/c; 
fn=50;

module fluegel (h=h)  {
    linear_extrude(h) intersection() {
    translate ([d/2,0,-h/2]) circle(r=r,$fn=fn);    
    translate ([-d/2,0,-h/2]) circle(r=r,$fn=fn);    
    }
    
}

module allefluegel(h=h) {
    union() {
        for (i=[0:1:c]) {
            echo(i," ",i*360/c);
            rotate([0,45,i*360/c]) translate([0,r2+x,0]) fluegel(h);   
        }
    }
}

module base() {
 difference() {    
    translate([0,0,-h2/2]) cylinder(r=r2,h=h2,$fn=fn);
    translate([0,0,-h2]) cylinder(r=2,h=2*h2,$fn=fn);
    allefluegel(h+dist);
}
}

if (show=="alle") {
    color("brown") base();
    allefluegel();
    
} else if (show=="fluegel") {
    fluegel();
    
} else if (show=="basis") {
  base();  
    
} else if (show=="blatt") {    
  echo("");  
   
}