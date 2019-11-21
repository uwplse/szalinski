in2mm=25.4;

//Note, work out angle then work backwards.
//Rises 1/4 inch in space of 1.75" + 2mm.
//1.8287in.
//tan=0.25/1.8287
//angle=7.78 close enough


hhi=0.083;
hdi=0.279;
sdi=0.138;
angle=8;
countx=3;
county=4;
template=1;
feet=1;

footdist=12;

hh=hhi*in2mm;
hd=hdi*in2mm;
sd=sdi*in2mm;

if(feet==1){
translate([-85,10,0])foot(footdist,angle);
translate([-85,50,0])foot(footdist,angle);
}

for(i=[0:1:countx-1]){
    for(j=[0:1:county-1]){

translate([32*i+15,32*j,0])pp();
    }
}

r=1.75*in2mm+2;

if(template==1){
difference(){
translate([-30-r*cos(30),0,0])cube([20+r*cos(30),20+r*3,2]);
for(i=[0:1:3]){
    translate([-20,r*i+10,-1])cylinder(4,2,2);
}
for(i=[0:1:2]){
    translate([-20-r*cos(30),r*(i+0.5)+10,-1])cylinder(4,2,2);
    translate([-20-r/2*cos(30)*cos(30),r*(i+0.5)+10,-1])cylinder(4,15,15);

}
}
}

module foot(fd,a){
  fh=in2mm*fd*tan(a);
  difference(){
  intersection(){
  rotate([-a,0,0])
    translate([-10,-10,-10])cube([20,20,fh+10]);
  translate([-20,-40,0])cube([40,80,80]);
  }
  translate([0,0,-0.01])cylinder(hh+0.02,sd,hd);
translate([0,0,hh])cylinder(50,hd,hd);
}
}

module pp(){
difference(){
intersection(){
translate([0,0,7])
rotate(-[-angle,0,0])
difference(){
translate([-15,0,-30])cube([30,30,60]);
translate([-1.75*in2mm/2-1,0,0])cylinder(3*in2mm,1.75*in2mm/2,1.75*in2mm/2);
translate([1.75*in2mm/2+1,0,0])cylinder(3*in2mm,1.75*in2mm/2,1.75*in2mm/2);
d=(1.75*in2mm+2)*cos(30);
translate([0,(1.75*in2mm+2)*cos(30),-d*tan(angle)])cylinder(3*in2mm,1.75*in2mm/2,1.75*in2mm/2);
}
translate([-20,-40,0])cube([40,80,80]);
}
translate([0,20,-0.01])cylinder(hh+0.02,sd,hd);
translate([0,20,hh])cylinder(50,hd,hd);

}
}



//cylinder(10,5,5);