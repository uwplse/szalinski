// Customizable Halloween Lantern
// Author Mathias Dietz
// http://3dprintapps.de


//width and length
wid=55; // [45:180]
//height:width factor
h_factor=1.55; // [1.3:0.1:3]
h=wid*h_factor;

//wall width
wallwidth=10; // [13:thin,10:medium,7:thick]
wall=wid/wallwidth; //[5:20]
cross=wall-1;  // [5:20]

//wall thickness
th=2; //[2:0.5:5]

//Handle
handle=1; //[1:yes,0:no]

echo("High:",h);
echo("Wall:",wall);

cube([wid,wid,th]);
difference(){
 translate([wid/2,wid/2,0]) cylinder(r=21,h=th+3);
 translate([wid/2,wid/2,th/2]) cylinder(r=20,h=th+3);
}

//corners
translate([wid-wall,0,0]) cube([wall,th,h]);
translate([0,0,0]) cube([wall,th,h]);
translate([0,wid-th,0]) cube([wall,th,h]);
translate([wid-wall,wid-th,0]) cube([wall,th,h]);

translate([wid-th,0,0]) cube([th,wall,h]);
translate([wid-th,wid-wall,0]) cube([th,wall,h]);
//door
translate([0,0,0]) cube([th,wall,h]);
translate([0,wid-wall,0]) cube([th,wall,h]);


//cross
ch=sqrt((wid-wall)*(wid-wall) + (h-wall-th-th)*(h-wall-th-th)); 
ab=(h-wall-th-th)/(ch);
cangle=90-asin(ab);
off=wall*sin(cangle);
echo("Angle:",cangle);
translate([0,0,off+th*2]) rotate([0,cangle,0])  cube([cross,th,ch]);
translate([wid-cross,0,th*2]) rotate([0,-cangle,0])  cube([cross,th,ch]);

translate([0,wid-th,th*2+off]) rotate([0,cangle,0])  cube([cross,th,ch]);
translate([wid-cross,wid-th,th*2]) rotate([0,-cangle,0])  cube([cross,th,ch]);

translate([wid-th,0,th*2+off]) rotate([-cangle,0,0])  cube([th,cross,ch]);
translate([wid-th,wid-cross,th*2]) rotate([cangle,0,0])  cube([th,cross,ch]);

translate([0,0,th*2+off]) rotate([-cangle,0,0])  cube([th,cross,ch]);
translate([0,wid-cross,th*2]) rotate([cangle,0,0])  cube([th,cross,ch]);

//quer bottom
translate([0,0,0]) cube([wid,th,wall]);
translate([0,wid-th,0]) cube([wid,th,wall]);
translate([wid-th,0,0]) cube([th,wid,wall]);
translate([0,0,0]) cube([th,wid,wall]); //door
//quer oben
rl=wall/5;
difference(){
    union(){
translate([0,0,h-wall]) cube([wid,th,wall]);
translate([0,wid-th,h-wall]) cube([wid,th,wall]);
    }
    translate([wid/2,wid+1,h-wall/2]) rotate([90,0,0]) cylinder(r=rl+0.15,h=wid+3,$fn=60);
}



translate([wid-th,0,h-wall]) cube([th,wid,wall]);
translate([0,0,h-wall]) cube([th,wid,wall]);

//roof sticks
mh=wid/15;
translate([wid/2-5,0,h]) cube([10,th,mh]);
translate([wid/2-5,wid-th,h]) cube([10,th,mh]);


 
 //root
translate([wid*1.25,0,-h]) difference(){
 translate([wid/2,wid/2,h])  rotate([0,0,45]) cylinder(h=wid/2.5,r1=wid/1.25,r2=00,$fn=4);
translate([wid/2-5,0-0.1,h]) cube([10.1,th+0.2,mh+5]);
translate([wid/2-5,wid-th-0.1,h]) cube([10.1,th+0.2,mh+5]);
    #translate([wid/2,wid/2,h]) cylinder(r1=wid/4,r2=th/2,h=wid/2.5);
}


//Griff
if ( handle == 1){
rd=wall/2;
br=(wid/1.25*2) * sin(45)+7;
echo(br);
translate([-8,-5-rd,0]) union(){
translate([0,0,rd])  rotate([0,90,0]) cylinder(r=rd,h=br,$fn=60);
  cube([th,br,rd*2]);
translate([br-th,0,0]) cube([th,br,rd*2]);

translate([0,br-rl,rd])  rotate([0,90,0]) cylinder(r=rl,h=15,$fn=60);
translate([br-15,br-rl,rd])  rotate([0,90,0]) cylinder(r=rl,h=15,$fn=60);
}
}



