
/* height */
he=10;// [5:20]
r1=4.75; // [1:10]
ecart=38;
r2=10;
hplaque=5;
rtrou=2.75;
rvis=4.75;
hvis=3;
hsphere=27.7;
rcyl=5.5;
$fn=70;
bend=60;
difference() {
union() {
translate([ecart/2,0,-he])cylinder(r1=r1,r2=r1,h=he);
translate([-ecart/2,0,-he])cylinder(r1=r1,r2=r1,h=he);

//translate([ecart/2,0,0])cylinder(r1=r2,r2=r2,h=hplaque);
translate([-ecart/2,0,0])cylinder(r1=r2,r2=r2,h=hplaque);
translate([r1/2,0,hplaque/2])cube([ecart+r1,r2*2,hplaque],true);
    translate([0,-r1,0]) rotate([-90,0,0]) linear_extrude(2*r1){ polygon([[ecart/2,0],[ecart/2,he-hvis-0.5],[ecart/2+r1+r2*0.7*cos(bend),0.7*r2*sin(bend)],[ecart/2+r1,0]]);};
}
union() {
    translate([ecart/2,0,-he])cylinder(r1=rtrou,r2=rtrou,h=he+hplaque);
    translate([-ecart/2,0,-he])cylinder(r1=rtrou,r2=rtrou,h=he+hplaque);
    
    translate([ecart/2,0,hplaque-hvis])cylinder(r1=rvis,r2=rvis,h=hvis);
    translate([-ecart/2,0,hplaque-hvis])cylinder(r1=rvis,r2=rvis,h=hvis);
}
}
translate([r1+ecart/2,0,0]) rotate([0,bend,0]){
translate([r2-rcyl,0,hsphere]) color("red") sphere(12.3);
translate([r2-rcyl,0,0])cylinder(r1=rcyl,r2=rcyl,h=hsphere);

difference() {cylinder(r1=r2,r2=r2,h=hplaque); translate([-r2/2,0,hplaque/2]) cube([r2,r2*2,hplaque],true);}
}
translate([r1+ecart/2,r2,0]) rotate([90,bend-90,0])  rotate_extrude(angle=bend) {square([hplaque,r2*2]);}


/*translate([0,12.7,hplaque]) difference() {
    translate([0,0,-4]) import("D:\\Userfiles\\ehubin\\Downloads\\RAM_Mount_Ball_Mount_Back_Connector.stl");
    translate([0,0,-50]) cube(100,center=true);
}*/