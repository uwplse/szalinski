glasdurchmesser=80;//Durchmesser oberer Rand
deckelhoehe=0.6;//wie dick soll der Deckel sein
schrifthoehe=0.4;//wie erhaben soll die Schrift sein. Ein Layer
randhoehe=1.0;//hoehe des Deckelrandes von der Deckelhoehe aus
TextOben="mein Name";//Text auf dem Deckel
LinkeEckeOben=37;//Abstand des Textanfangs zum Mittelpunkt, um den Text zu zentrieren
SchriftGroesseOben=11;//Schriftgroesse oben, bei langen Namen verringern
TextUnten="";//Text auf Unterseite, negativ
LinkeEckeUnten=30;//Abstand des Textanfangs zum Mittelpunkt, um den Text zu zentrieren
SchriftGroesseUnten=16;//Schriftgroesse unten, bei langen Namen verringern
font1 = "Leckerli One"; // here you can select other font type
$fn=50;
//was soll gedruckt werden? 0/1
klammer_drucken=0;
deckel_drucken=1;

// scharnierhoehe bei Weizenglas 0
// bei Sprudelglas 1.5
scharnierhoehe=0;


if(deckel_drucken==1){
difference(){
  union(){
    translate([0,0,0])cylinder(r=glasdurchmesser/2+2,h=deckelhoehe);
    difference(){
      translate([0,0,deckelhoehe])cylinder(r=glasdurchmesser/2+2,h=randhoehe);
      translate([0,0,deckelhoehe-0.1])cylinder(r=glasdurchmesser/2,h=randhoehe+0.2);
    }
    translate([0,glasdurchmesser/2-0.5,0])cylinder(r=10,h=deckelhoehe+randhoehe);
    translate([-7,glasdurchmesser/2,0])cube([14,25,deckelhoehe]);
    translate([0,glasdurchmesser/2+23,0])cylinder(r=8,h=3);
    translate([-7,glasdurchmesser/2-6.5,0])cube([14,29,3]);
    translate([-7,glasdurchmesser/2-6.5,1.5])rotate([0,90,0])cylinder(r=1.5,h=14);
    rotate([0,0,45]){
      translate([LinkeEckeOben*-1,SchriftGroesseOben/2*-1,deckelhoehe]){
        schrift(TextOben,SchriftGroesseOben,schrifthoehe);
    }
  }
  }
  translate([-3.2,glasdurchmesser/2-8,-0.1])cube([6.4,31,deckelhoehe+3]);
  translate([-5.3,glasdurchmesser/2+3,-0.1])cube([0.6,20,deckelhoehe+3]);
  translate([4.7,glasdurchmesser/2+3,-0.1])cube([0.6,20,deckelhoehe+3]);
  translate([-2.4,glasdurchmesser/2,7])cube([4.8,10,10]);
  mirror()rotate([0,0,180]){
    translate([LinkeEckeUnten*-1,15/2*-1,0]){
      schrift(TextUnten,SchriftGroesseUnten,schrifthoehe);
    }
  }
}

difference(){
  union(){
    translate([4.1,glasdurchmesser/2+12,1.5])sphere(r=2.2);
    translate([-4.1,glasdurchmesser/2+12,1.5])sphere(r=2.2);
  }
  translate([-10,glasdurchmesser/2+10,-2])cube([20,7,2]);
  translate([-10,glasdurchmesser/2+10,3])cube([20,7,2]);
  translate([-2.7,glasdurchmesser/2+10,0])cube([5.4,7,3]);
  translate([-5.3,glasdurchmesser/2+3,-0.1])cube([0.6,20,deckelhoehe+3]);
  translate([4.7,glasdurchmesser/2+3,-0.1])cube([0.6,20,deckelhoehe+3]);
}
}

if(klammer_drucken==1){
translate([20,55,0])klammer();
//um die Lage zu pruefen
//translate([-3,glasdurchmesser/2-2,deckelhoehe+-3])rotate([8,0,0])rotate([0,90,0])klammer();
//translate([-3,glasdurchmesser/2+19,-11])rotate([115,0,0])rotate([0,90,0])klammer();
}

module klammer(){
  difference(){
    union(){
      rotate([0,0,40])rotate_extrude(angle=280,convexity = 10){
        translate([2,0,0]){
          square([3,6]);
        }
      }
      translate([1.5,1,0])cube([20,3,6]);
      translate([21,2.3,0])cylinder(r=2,h=6);
      translate([1.5,-4,0])cube([20,3,6]);
      translate([21,-2.3,0])cylinder(r=2,h=6);
      translate([-2-scharnierhoehe,14,0])rotate([0,0,0])cylinder(r=6,h=6);
      translate([-5,0,0])cube([7,12,6]);
    }
    translate([-2-scharnierhoehe,14,-1])sphere(r=2.5);
    translate([-2-scharnierhoehe,14,7])sphere(r=2.5);
    translate([0,0,-1])rotate([0,0,0])cylinder(r=2.5,h=8);
    translate([0.5,-1,-0.1])cube([18,2,6.2]);
  }
}


module schrift(zeichen,groesse,hoehe){
  color("red")linear_extrude(height = hoehe) {
    text(zeichen, font = font1, size = groesse, direction = "ltr",  spacing = 1 );
  }
}
