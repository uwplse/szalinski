$fn=100;

//Stackable cover and support for things:
// Euro coin organizer by tmssngr "https://www.thingiverse.com/thing:532562"
// Euro Coin Organizer for 5ct, 10ct, 20ct (Remix) by Cuiso
//   https://www.thingiverse.com/thing:3057142

////////////////////
//MAIN PARAMETER "hmonedero" the height of the euro coin organizer, in milimeters 
hmonedero=40;

//parameter "holg" increase this if your pieces fit too tight 
holg=0.40;
///////////////////

hbase1=3;
hbase2=hbase1 + 4;
hcolum=hbase1 + hmonedero - 2;
dbase1=30;
dbase2=21.30;
dcolum=8+5; //screw 8
dbasetop=60;
longdispscrew=hcolum/3 + 2 + hbase1 - 3;
dscrew=dbase1 + 6;
hscrew=hbase1 + 3;
echo(hcolum/3);
echo(longdispscrew);

// coment the parts you dont want to print
base();
translate([(dbase1/2+dbasetop/2)*1.1,0,0]) top();
translate([0,(dbase1/2+dscrew/2)*1.1,0]) screw();

module screw(){
difference()
{
cylinder(d=dscrew, h=hscrew);
translate([0,0,-0.001])cylinder(d=dbase1+2*holg, h=hbase1+2*holg);
}
translate([0,0,hscrew-0.001])screw_cuiso(diameter=8, long=longdispscrew, p=1.25, base=0);
}

module top(){
difference(){
union(){cylinder(d=dbasetop, h=hbase1); cylinder(d=dbase2, h=hbase2);}
translate([0,0,hbase1])cylinder(d=dcolum+holg, h=hbase2 - hbase1 + 0.001);
translate([0,0,-0.001])cylinder(d=8+1, h=hbase1+0.002);
}
}

module base()
{
difference(){
union(){
cylinder(d=dbase1, h=hbase1);
cylinder(d=dbase2, h=hbase2);
cylinder(d=dcolum, h=hcolum);}
render()
translate([0,0,hcolum-hcolum/3+1.5])
nut_cuiso(diameter=8, long=hcolum/3, p=1.25, hol=0.9);
}
}


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//modules from threated-rod-and-nut-by-cuiso.scad
module screw_cuiso(diameter=10, long=15, p=1.5, base=1)
{
diam=diameter;
delta=6;
r=diam/2;
h=p*0.866;

pp=p/2;
pm=-p/2;
hh=r-h;

turns=long/p+1;

difference(){
translate([0,0,-p/2])
for(v = [0 : 1 : turns])
translate([0,0,p*v])
//render()
for(k = [0 : delta : 360 - delta])
{
kk=k+delta;
hull()
{

translate([0,0,k*p/360])
rotate([0,0,k])
polyhedron([[0,0,pp],[hh,0,pp],[r-h/8,0,p/16],[r-h/8,0,-p/16],[hh,0,pm],[0,0,pm]], [[0,1,2,3,4,5]]);

translate([0,0,kk*p/360])
rotate([0,0,kk])
polyhedron([[0,0,pp],[hh,0,pp],[r-h/8,0,p/16],[r-h/8,0,-p/16],[hh,0,pm],[0,0,pm]], [[0,1,2,3,4,5]]);

}
}
translate([0,0,-p/2])cube([diam,diam,p],center=true);
translate([0,0,long+p])cube([diam,diam,p*2],center=true);
if(base==1){
translate([0,0,-0.001]) //base
difference(){
cylinder(d2=diam+2*h, d1=diam-2*h+2*h, h=p/2, $fn=100);
cylinder(d2=diam-h, d1=diam-1*h-h, h=p/2+0.001, $fn=100);
}}

}
//#cylinder(d=diam, h=long, $fn=100);
}
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> for nut <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
module nut_cuiso(diameter=10, long=20, p=1.5, hol=1)
{
diam=diameter+hol;
delta=6;
r=diam/2;
h=p*0.866;

pp=p/2;
pm=-p/2;
hh=r-h;

turns=long/p+1;

cylinder(d=diam-2*(h-h/4), h=long,$fn=100);

difference(){
translate([0,0,-p/2])
for(v = [0 : 1 : turns])
translate([0,0,p*v])
//render()
for(k = [0 : delta : 360 - delta])
{
kk=k+delta;
hull()
{

translate([0,0,k*p/360])
rotate([0,0,k])
polyhedron([[0,0,pp],[hh,0,pp],[r,0,0],[hh,0,pm],[0,0,pm]], [[0,1,2,3,4]]);

translate([0,0,kk*p/360])
rotate([0,0,kk])
polyhedron([[0,0,pp],[hh,0,pp],[r,0,0],[hh,0,pm],[0,0,pm]], [[0,1,2,3,4]]);

}
}
translate([0,0,-p/2])cube([diam,diam,p],center=true);
translate([0,0,long+p])cube([diam,diam,p*2],center=true);
}
//#cylinder(d=diam, h=long);
}




