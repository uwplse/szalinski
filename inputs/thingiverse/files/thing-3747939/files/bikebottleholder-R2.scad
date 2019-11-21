//globals

n=2;   //number of turns
angle=n*360; //360,320
a=0.0001;  //this determines the od of spiral 0.04
thk=2;
$fn=100;

clip_od=78;
clip_id=70;

function sr(t=1) =a*t*t;  //Archimedean spiral
function sx(t)=sr(t) *cos(t);
function sy(t)=sr(t) *sin(t);

module 2d_spiral(){
union(){
for (t=[1:1:angle]){
 hull(){   
translate([sx(t),sy(t),0]) circle(thk,center=true);
translate([sx(t+1),sy(t+1),0]) circle(thk,center=true);
}
}
}
}



module 2d_spiral_angle(a=0.002,p0=0,p1=360, thk=2){
angle=p1;    
translate([-sx(p0,a),-sy(p0,a),0])    
union(){
for (t=[p0:1:angle]){
 hull(){   
translate([sx(t,a),sy(t,a),0]) circle(thk,center=true);
translate([sx(t+1,a),sy(t+1,a),0]) circle(thk,center=true);
}
}
}
}


module hollow(od=25,id=20,len=62){

 translate([0,0,0])
 difference(){
   translate([0,0,0])
         cylinder(r=od/2,h=len, $fn=100); 
 translate([3,0,0]) cylinder(r=id/2,h=len, $fn=100); 
   }
 }




module 2d_clip(){
 translate([10,-0]) scale(1.1)
mirror([1,0]) {
brace(); mirror([0,1]) brace();
}
 
 translate([-30,51,0]) rotate([0,0,-60])  
 scale(2) 2d_spiral_angle(a=0.002,p0=280,p1=360, thk=1);
 almond(); 
 translate([-33,-124,0]) square([6,180]);

}

module brace(){
translate([-28,-18,0]) 
scale(2) 2d_spiral_angle(a=0.002,p0=280,p1=360, thk=1);
}


module almond(){
2d_spiral();mirror([0,1,0]) 2d_spiral();
    brace(); mirror([0,1]) brace();  
}



module mid(){
intersection(){
linear_extrude(height=120) scale(0.85) 2d_clip();
//center();
translate([11,40,50]) rotate([90,0,0]) hollow(od=clip_od,id=clip_id,len=150);
}}

module bottle_clip(){
difference(){
union(){
mid();
//bottom stop plate    
translate([-15,-97,50]) rotate([90,0,0]) cylinder(r=20,h=6);

}
//cut back 
translate([-66.5,-110,30]) cube([40,200,40]);
//cut bottom
translate([-30,-141,30]) cube([40,40,40]);

translate([-50,-50,50]) rotate([0,90,0]) cylinder(r=3,h=40);
translate([-50,-50+65,50]) rotate([0,90,0]) cylinder(r=3,h=40);
translate([-24,-50+65,50]) rotate([0,90,0]) cylinder(r=4.5,h=4);
translate([-24,-50,50]) rotate([0,90,0]) cylinder(r=4.5,h=40);

}
//add side posts
translate([-26.4,-101,60])  cube([6,141,10]);
translate([-26.4,-101,30]) cube([6,141,10]);
}

bottle_clip();
