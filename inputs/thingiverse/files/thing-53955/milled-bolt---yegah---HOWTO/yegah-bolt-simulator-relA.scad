/*    
milled bolt for yegah - yru's exstruder - golem's accessible heart  http://www.reprap.org/wiki/Yegah
also used in YRUDS - http://www.thingiverse.com/thing:38874
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

DIY or buy from me :)
contact me on 3fx.eu or yru@o2.pl
see videos on yru2501 yt channel
thanks for heavy testing goes to Krzysztof Dymianiuk - mojreprap.pl
*/

//thingiverse customizer friendly see: 

//bolt type
boltn=0;  // [0:default M6 socket head,1:user specified params]
//show mill tool
showtool=0;  // [0,1]
//show cross section
schowcs=0; // [0,1]
//mill depth
mdep=2; 
//head diameter to mill axis offset coeficient
moff=.8;  
//number of teeth
nt=26; // [5:50]
//tool diameter
tdia=4;
//mill V inset
toolvi=0; 
//user bolt head length
ubolthl=6; 
//user bolt head diameter
ubolthd=9.7;
//user bolt shaft diameter
uboltsd=6; 
//user bolt head socket
uboltimbu=5.5; 
boltt=[ //imbu,headlen,shaft dia, headdia
[5.5,6,6,9.7],
[uboltimbu,ubolthl,uboltsd,ubolthd],
];
bolt_length=20;

rotate([90,0,0]) yegahbolt(ybt=boltt[boltn],tvia=toolvi);
module yegahbolt(ybt=[5.5,6,6,9.7],tvia=0){
difference(){
union(){ 
translate([0,0,.1]) cylinder(r=ybt[1]/2,$fn=33,h=bolt_length);
cylinder(r=ybt[3]/2,$fn=63,h=ybt[2]);
}//union ends
translate([0,0,-.1]) cylinder(r=ybt[0]/2,$fn=6,h=ybt[2]/1.5);
translate([0,0,ybt[2]/2]) for(i=[0:360/nt:359.9]) rotate([0,0,i]) translate([ybt[3]/2-mdep,moff*ybt[3]/2,0]) rotate([0,90,0]) mtool(tvi=tvia,,mtd=tdia);
if(schowcs==1) translate([0,0,-ybt[2]/2]) cube(center=true,[ybt[2]*2,ybt[2]*2,ybt[2]*2]);
}
if(showtool==1) color("blue") translate([0,0,ybt[2]/2]) translate([ybt[3]/2-mdep,moff*ybt[3]/2,0]) rotate([0,90,0]) mtool(tvi=tvia,mtd=tdia);
}

module mtool(tvi=4,mtd=4){
render() difference(){ 
cylinder(r=mtd/2,$fn=33,h=10); 
if(tvi>0) translate([0,0,-0.01]) cylinder(r=mtd/2-.01,r2=.1,$fn=33,h=tvi);
}
}