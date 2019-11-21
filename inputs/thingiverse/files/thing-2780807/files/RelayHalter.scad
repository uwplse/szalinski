// preview[tilt:top]


//Breite der Hutschienen-Clips
DickeHalter = 5; //[1:0.5:50]

//Wandstärke
wandstaerke = 2; //[0.5:0.1:20]

//Länge der Befestigungsschraube
schraubenlaenge = 12; //[1:0.5:50]
//Durchmesser der Befestigungsschraube
schraubendurchmesser = 3; //[0:0.1:10]

/* [Board Dimensions] */
//8er Relay Abmessungen X
outerX = 141;
//8er Relay Abmessungen Y
outerY = 52;
//8er Relay Abmessungen Lochabstand X
holeX = 132;
//8er Relay Abmessungen Lochabstand Y
holeY = 44;

/* [Hidden] */
randhoehe = schraubenlaenge+wandstaerke+3;


translate([0,0,0]) difference(){
    casehelper(wandstaerke,outerX,outerY,randhoehe, holeX,holeY, schraubenlaenge, schraubendurchmesser);
    color("red") translate([15,15,-0.1]) cylinder(d=DickeHalter,h=wandstaerke+0.2, $fn=100);
    color("red")translate([15,35,-0.1]) cylinder(d=DickeHalter,h=wandstaerke+0.2, $fn=100);
    color("red")translate([outerX-15,15,-0.1]) cylinder(d=DickeHalter-0.1,h=wandstaerke+0.2, $fn=100);
    color("red")translate([outerX-15,35,-0.1]) cylinder(d=DickeHalter-0.1,h=wandstaerke+0.2, $fn=100);
}
translate([0,outerY+wandstaerke+25,0])  rotate([0,0,-90]) klemmblock(DickeHalter,wandstaerke);
translate([50,outerY+wandstaerke+25,0]) rotate([0,0,-90]) klemmblock(DickeHalter,wandstaerke);



module klemmblock(h,w){
    color ("purple") translate([5,0,0]) linear_extrude(height=h){ polygon(b); }
    color ("purple")translate([0,0,0]) cube([5,42,h]);
    color("red")translate([0,10,h/2]) rotate([0,-90,0]) cylinder(d=h,h=w, $fn=100);
    color("red")translate([0,30,h/2]) rotate([0,-90,0]) cylinder(d=h,h=w, $fn=100);
}

module casehelper(t, l, b, h, x, y, screwlength, screwdia){
    difference(){
        color ("green") cube([l+2*t,b+2*t,h]);
        color ("blue") translate([t,t,t]) cube([l,b,h]);
    }
    color ("orange") translate([t+(l-x)/2,t+(b-y)/2,t]) abstandshalterhelper(x,y, screwlength, screwdia);
}

module case(l, b, h){
    cube([l,b,h]);
}

module abstandshalterhelper(x,y,length, dia){
    translate([0,0,0]) abstandshalter(dia+3,dia,length);
    translate([x,0,0]) abstandshalter(dia+3,dia,length);
    translate([x,y,0]) abstandshalter(dia+3,dia,length);
    translate([0,y,0]) abstandshalter(dia+3,dia,length);
}

module abstandshalter(outDia, inDia, height){
    difference(){
        cylinder(d=outDia, h=height, $fn=100);
        translate([0,0,-0.1]) cylinder(d=inDia, h=height+0.2);
    }
}

b = [
//Obere Kante und Sprung nach außen
[0,0],[0,42],[10.5,42],
//Hebel-Bedienung
[11,43],[8,44],[8,45],[13.5,44],
//Haken mit Steigung für verschienede Hutschienendicken
[13.25,39],[11.5,38],[11,38],[10.75,40],
//Sprung nach Innen mit Rundung und Sprung nach außen (Schiene ist 1.5mm dick)
[1,40],[0.75,39.75],[0.75,39.5],[1,39.25],[9.5,39.25],
//Schienen auflagefläche (Schiene ist 35mm breit)
[9.5,35],[8,34],[2,34],[2,9],[8,9],[9.5,8],[9.5,4.75],
//fester Haken
[10.75,4.75],[11.25,6.5],[11.75,6.5],[13.5,5.5],
//abgerundete Kante
[13.5,2],[13,1],[11,0]];