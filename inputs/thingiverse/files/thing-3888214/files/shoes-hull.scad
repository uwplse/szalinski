shape="soft";// [soft,mid,hard]
slit = 5; //[1:15]
COLOR="Orange"; // [Navy,Green,Orange,Gray]

color(COLOR)

difference(){ 
intersection() {
    difference() {
    linear_extrude(height = 60, center = true, convexity = 10)
hull(){
translate([-45,3,0])circle(33,$fa = 1);
translate([-8,1,0])circle(50.5,$fa = 1);
translate([20,-24,0])circle(30,$fa = 1);     
translate([172,-1.5,0])circle(42.5,$fa = 1);
}
linear_extrude(height = 65, center = true, convexity = 10)
hull(){
translate([28.5,62,0])circle(15.5,$fa = 1);
translate([80,54,0])circle(33,$fa = 1);
translate([150,54,0])circle(15,$fa = 1);
}

linear_extrude(height = 65, center = true, convexity = 10)
hull(){
translate([24,-70,0])circle(15,$fa = 1);
translate([98,-190,0])circle(151,$fa = 1);
translate([154,-59,0])circle(15,$fa = 1);
}
}

translate([-81.5,0,-20])    
difference(){
union() {
rotate([90,0,0])translate([120,192,0])cylinder(r=195,h=120,center=true,$fa=1);
rotate([90,0,0])translate([203,97.5,0]) cube([186,200,120],center=true);
}    
union() {
rotate([90,0,0])translate([103,221,0])cylinder(r=202,h=130,center=true,$fa=1);
rotate([90,-3.6,0])translate([203,112.5,0]) cube([200,200,130],center=true);
 rotate([90,0,0])translate([-26.5,62.5,0]) cube([60,60,130],center=true);
    rotate([90,0,0])translate([286.5,172.5,0]) cube([200,200,130],center=true);
}
}
}
for(i = [0: slit*3 :290])
    translate([i,0,-23]) 
    rotate(a=45, v=[0,1,0])
    scale(v=[1,200,1])
    cube(slit*0.75,center=true);
}