/*    
parametric round font  - PRF
Copyright (C) 2013  Michał Liberda (yru)


    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

contact me on zephyru.com or yru@o2.pl
see videos on yru2501 yt channel
*/

// preview[view:south, tilt:top]

//roundess to width heigth
lr=40;//[10:50]
//width in percent of heigth
whratio=80;//[10:300]
//point sharpness ratio
psn=0;//[0:100]
//middle point height ratio
mph=40;//[10:60]
//cutout ratio
ctr=30;//[10:80]
//finish quality - roundness n/o faces
sths=18; //[6:50]
//depth
dpt=2;
fsz=10/1;
//preview spacing
psc=10;

yan_A(lh=fsz,lst=sths,ld=dpt,ptn=psn/100,mpha=mph/100,ctra=(lr/100)*ctr/50,lrr=lr/100,wr=whratio/100);
translate([psc,0,0]) yan_B(lh=fsz,lst=sths,ld=dpt,ptn=psn/100,mpha=mph/300+.3,ctra=(lr/100)*ctr/50,lrr=lr/100,wr=whratio/100);
translate([psc*2,0,0]) yan_C(lh=fsz,lst=sths,ld=dpt,ptn=psn/100,mpha=mph/100,ctra=(lr/100)*ctr/50,lrr=lr/100,wr=whratio/100);



module yan_C(wr=0.6,lh=10,lrr=0.2,lst=7,ptn=0.3,mpha=0.5,ctra=0.2,ld=2){
lri=lh*lrr;
lw=lh*wr;
vsp=lh-lri;
hsp=(lw-lri)/2;
vspB=lh;
lwc=lw-(lri*(1-ctra));


vsAu=vsp/2;
vsAl=lh/2-lh*(1-mpha)+lri/2;
vsBu=lh/2-lh*(1-mpha);
vsBl=-vsp/2;


//%translate([-lw/2,vsAu,0]) cube([lw,vsAu*2,1]);

difference(){
union(){
hull(){
translate([hsp,vsAu,0]) cylinder(r=lri/2,h=ld,$fn=lst);
translate([hsp,vsBl,0]) cylinder(r=lri/2,h=ld,$fn=lst);
translate([-hsp,vsAu,0]) cylinder(r=lri/2,h=ld,$fn=lst);
translate([-hsp,vsBl,0]) cylinder(r=lri/2,h=ld,$fn=lst);
}


} 

difference(){
union(){
translate([0,-lh*(mpha)/2,-.1]) cube([lw,lh*(mpha),ld+1]);
hull(){
translate([hsp,vsAu,-.1]) cylinder(r=lri/2*ctra,h=ld+1,$fn=lst);
translate([hsp,vsBl,-.1]) cylinder(r=lri/2*ctra,h=ld+1,$fn=lst);
translate([-hsp,vsAu,-.1]) cylinder(r=lri/2*ctra,h=ld+1,$fn=lst);
translate([-hsp,vsBl,-.1]) cylinder(r=lri/2*ctra,h=ld+1,$fn=lst);
}
}
}
}
}


module yan_B(wr=0.6,lh=10,lrr=0.2,lst=7,ptn=0.3,mpha=0.5,ctra=0.2,ld=2){
lri=lh*lrr;
lw=lh*wr;
vsp=lh-lri;
hsp=(lw-lri)/2;
vspB=lh;
lwc=lw-(lri*(1-ctra));
barh=((lri*(1-ctra))/2);

vsAu=vsp/2;
vsAl=lh/2-lh*(1-mpha)+barh+(lri/2)*(ctra);
vsBu=lh/2-lh*(1-mpha)-(lri/2)*(ctra);
vsBl=-vsp/2;


//%translate([-lw/2,vsAu,0]) cube([lw,vsAu*2,1]);

difference(){
union(){
hull(){
translate([hsp*(ptn*0.6+0.4),vsAu,0]) cylinder(r=lri/2,h=ld,$fn=lst);
translate([hsp*(ptn*0.6+0.4),vsAl,0]) cylinder(r=lri/2,h=ld,$fn=lst);
translate([-lw/2,lh/2-lh*(1-mpha),0]) cube([lw/100,lh*(1-mpha),ld]);
}

hull(){
translate([hsp,vsBl,0]) cylinder(r=lri/2,h=ld,$fn=lst);
translate([hsp,vsBu,0]) cylinder(r=lri/2,h=ld,$fn=lst);
translate([-lw/2,-lh/2,0]) cube([lw/100,lh*(mpha),ld]);
}

} 

difference(){
union(){
hull(){
translate([hsp*(ptn*0.6+0.4),vsAu,-.5]) cylinder(r=(lri/2)*ctra,h=ld+1,$fn=lst);
translate([hsp*(ptn*0.6+0.4),vsAl,-.5]) cylinder(r=(lri/2)*ctra,h=ld+1,$fn=lst);
translate([-lw/2+((lri/2)*(1-ctra)),-(vsAu-vsAl+lri*ctra)/2+vsAu/2+vsAl/2,0]) cube([lw/100,(vsAu-vsAl+lri*ctra),ld]);
}
hull(){
translate([hsp,vsBu,-.5]) cylinder(r=(lri/2)*ctra,h=ld+1,$fn=lst);
translate([hsp,vsBl,-.5]) cylinder(r=(lri/2)*ctra,h=ld+1,$fn=lst);
translate([-lw/2+((lri/2)*(1-ctra)),-(vsBu-vsBl+lri*ctra)/2+vsBu/2+vsBl/2,0]) cube([lw/100,(vsBu-vsBl+lri*ctra),ld]);
}
}
}
}
}


module yan_A(wr=0.6,lh=10,lrr=0.2,lst=7,ptn=0.3,mpha=0.5,ctra=0.2,ld=2){
lri=lh*lrr;
lw=lh*wr;
vsp=lh-lri;
hsp=(lw-lri)/2;
vspB=lh;
lwc=lw-(lri*(1-ctra));

difference(){
union(){
hull(){
for(i=[1,-1]){
translate([i*hsp*ptn,vsp/2,0]) cylinder(r=lri/2,h=ld,$fn=lst);
}
translate([-lw/2,-lh*.495,0]) cube([lw,lh/100,ld]);
}
} 

difference(){
hull()
for(i=[1,-1]){
translate([i*hsp*ptn,vsp/2,-.05]) cylinder(r=(lri/2)*ctra,h=ld+.1,$fn=lst);
translate([-lwc/2,-lh*.495-0.15,0]) cube([lwc,lh/100,ld]);
}
translate([-lw/2,-lh*(.495-mpha)-0.05,-1]) cube([lw,(lri*(1-ctra))/2,ld+2]);
}

}}

