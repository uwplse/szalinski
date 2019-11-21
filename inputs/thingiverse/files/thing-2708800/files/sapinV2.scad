fn=6;


// create 2d vector shape: circle
function circv(r=1,fn=32)=
[for(i=[0:fn-1])
[r*cos(360*i/fn),r*sin(360*i/fn)]
];

// create 2d vector shape: star
function starv(r1=1,r2=2,fn=32)=
[for(i=[0:(2*fn-1)])
(i%2==0)?
[r1*cos(180*i/fn),r1*sin(180*i/fn)]:
[r2*cos(180*i/fn),r2*sin(180*i/fn)]
];


// display a 2d vector shape
module dispv(v){
indi=[[for(i=[0:len(v)-1])i]];
polygon(points=v,paths=indi);
}
ep=10;
// etoile(nbdepointe,dia intérieur,diaextérieur,epaisseur,angle,decalageentretoiseN-1,0si dernierétage
translate([125,0,0])etoile(6,27,60,ep,35,14,1);
translate([10,0,0])etoile(6,26,49,ep,25,14,1);
translate([-75,0,0])etoile(6,20,36,ep,30,7,2);
translate([-145,0,0])etoile(6,15,28,ep,30,7,0);
translate([ 0,60,000])entretoise(ep);

module entretoise(epais)
{
e=10; //epaisseur de pate
h=20; //ecart entre les plateaux
l=6; //largeur du tenon
a=12; //largeur des aillettes
cercle1=4;
linear_extrude(.6)
difference(){
    hull() {
        translate([0,0]) circle(cercle1);
        translate([0,e]) circle(cercle1);
        translate([-a,e]) circle(cercle1);
        translate([-a,e+h]) circle(cercle1);
        translate([0,e+h]) circle(cercle1);
        translate([0,e+h+e]) circle(cercle1);
        translate([l,e+h+e]) circle(cercle1);
        translate([l,e+h]) circle(cercle1);
        translate([l+a,e+h]) circle(cercle1);
        translate([l+a,e]) circle(cercle1);
        translate([l,e]) circle(cercle1);
        translate([l,0]) circle(cercle1);
    }
polygon([[0,0],[0,e],[-a,e],
    [-a,e+h],[0,e+h],[0,e+h+e],[l,e+h+e],[l,e+h],
    [l+a,e+h],[l+a,e],[l,e],[l,0]]);
}

cercle=1;
linear_extrude(epais)
difference(){
    hull() {
        translate([0,0]) circle(cercle);
        translate([0,e]) circle(cercle);
        translate([-a,e]) circle(cercle);
        translate([-a,e+h]) circle(cercle);
        translate([0,e+h]) circle(cercle);
        translate([0,e+h+e]) circle(cercle);
        translate([l,e+h+e]) circle(cercle);
        translate([l,e+h]) circle(cercle);
        translate([l+a,e+h]) circle(cercle);
        translate([l+a,e]) circle(cercle);
        translate([l,e]) circle(cercle);
        translate([l,0]) circle(cercle);
    }
polygon([[0,0],[0,e],[-a,e],
    [-a,e+h],[0,e+h],[0,e+h+e],[l,e+h+e],[l,e+h],
    [l+a,e+h],[l+a,e],[l,e],[l,0]]);
polygon([[-1,-1],   [-1,e-1],    [-a-1,e-1],[-a-1,-1]]);
polygon([[-1,e+h+1],[-1,e+h+e+1],[-a-1,e+h+e+1],[-a-1,e+h+1]]);
polygon([[l+1,-1],   [l+1,e-1],    [l+a+1,e-1],[l+a+1,-1]]);
polygon([[l+1,e+h+1],[l+1,e+h+e+1],[l+a+1,e+h+e+1],[l+a+1,e+h+1]]);
}

}


module etoile(nb,et1,et2,epais,ang,dec1,dec2)
{
//etoile et decoupe
et11=starv(et1,et2,nb);
et12=starv(et1-1,et2-2,nb);
et21=starv(et1+1,et2+1,nb);
et22=starv(et1-2,et2-2,nb);

linear_extrude(.6)
    difference(){
//v0=starv(et1+1,et2+1,nb);
rotate([0,0,ang])translate([00,0,0])dispv(et21);

//v0=starv(et1-2,et2-2,fn);
rotate([0,0,ang])translate([00,0,0])dispv(et22);
}

linear_extrude(epais)
    difference(){
//v0=starv(et1,et2,nb);
rotate([0,0,ang])translate([00,0,0])dispv(et11);

//v0=starv(et1-2,et2-2,fn);
rotate([0,0,ang])translate([00,0,0])dispv(et12);
}




if (dec2==1){
difference(){
linear_extrude(epais)translate([dec1,0,0])square([15,8.2],center=true);
linear_extrude(epais)translate([dec1,0,0])square([14,7.2],center=true);
}
difference(){
linear_extrude(epais)translate([-dec1,0,0])square([15,8.2],center=true);
linear_extrude(epais)translate([-dec1,0,0])square([14,7.2],center=true);
}
}

if (dec2==1){
difference(){
linear_extrude(2)difference(){
rotate([0,0,ang])translate([00,0,0])dispv(et21);
translate([0,200/2+5,0])square([200,200],center=true);
translate([0,-200/2-5,0])square([200,200],center=true);
}
linear_extrude(2)translate([dec1,0,0])square([11,8.2],center=true);
linear_extrude(2)translate([-dec1,0,0])square([11,8.2],center=true);
}
}

if (dec2==2){
difference(){
linear_extrude(epais)translate([0,0,0])square([15*2,8.2],center=true);
linear_extrude(epais)translate([0,0,0])square([14*2,7.2],center=true);
}
}

if (dec2==2){
difference(){
linear_extrude(2)difference(){
rotate([0,0,ang])translate([00,0,0])dispv(et21);
translate([0,200/2+5,0])square([200,200],center=true);
translate([0,-200/2-5,0])square([200,200],center=true);
}
linear_extrude(2)translate([0,0,0])square([15*2,8.2],center=true);
}
}

if (dec2==0){
difference(){
linear_extrude(epais)translate([0,0,0])square([15,8.2],center=true);
linear_extrude(epais)translate([0,0,0])square([14,7.2],center=true);
}
}

if (dec2==0){
difference(){
    linear_extrude(2)
difference(){
rotate([0,0,ang])dispv(et21);
translate([0,100/2+5,0])square([100,100],center=true);
translate([0,-100/2-5,0])square([100,100],center=true);
}
linear_extrude(2)square([15,8.2],center=true);
}
}
}


