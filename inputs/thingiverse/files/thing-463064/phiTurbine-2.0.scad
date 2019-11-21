ga=180*(3-sqrt(5));
phi=((sqrt(5)+1)/2);

//number of blades
bladecnt=16; //[2:24]

//motor or generator shaft radius
rshaft=2.6;

module element(h,r){
//translate([0,0,h/2])scale([r/2,r/2,h/2])sphere(r=1);
cube([0.05,r,h]);
}


module blade1(h, angle, start, stop)
rotate([0,0,angle])
for ( i = [start*PI : 0.05 : stop*PI] )
{assign(r=exp(2*ln(phi)/PI*i),r1=exp(2*ln(phi)/PI*(i+0.1)))
hull(){
rotate([0,0,180*(i/PI)]) translate([r, 0, 0]) rotate([0,-22.5,0])element(h=h,r=2);
rotate([0,0,180*((i+0.1)/PI)]) translate([r1, 0, 0]) rotate([0,-22.5,0])element(h=h,r=2);
}}

module blade2(h, angle, start, stop)
rotate([0,0,angle])
for ( i = [start*PI : 0.05 : stop*PI] )
{assign(r=exp(2*ln(phi)/PI*i),r1=exp(2*ln(phi)/PI*(i+0.1)))
hull(){
rotate([0,0,-180*(i/PI)+180]) translate([r, 0, 0]) rotate([0,22.5,0])element(h=h,r=2);
rotate([0,0,-180*((i+0.1)/PI)+180]) translate([r1, 0, 0]) rotate([0,22.5,0])element(h=h,r=2);
}}


//cylinder(h=4.7,r1=48,r2=46,$fn=360);
//cylinder(h=6,r1=8.5,r2=6,$fn=128);

difference(){
union(){
for ( i = [1:bladecnt] ){
blade2(5,i*360/bladecnt,0,4.05);
blade1(5,i*360/bladecnt-180+22.5,3.9123,4.05);
//blade2(5,i*360/bladecnt+9,0,4.05);
}
cylinder(h=0.8,r=44,$fn=128);
cylinder(h=5,r1=8.5,r2=6,$fn=128);
difference(){
    cylinder(h=4.7,r=50,$fn=256);
    translate([0,0,-0.05])cylinder(h=4.8,r2=48,r1=49.2,$fn=256);
    }
}
difference(){
    translate([0,0,-0.05])cylinder(h=4.8,r=55,$fn=256);
    translate([0,0,-0.05])cylinder(h=4.8,r=50,$fn=256);
    }
    translate([0,0,-0.05])cylinder(h=5.1,r=rshaft,$fn=128);
    }























