//Customizable Rockwall Hold

//Tolerance (wiggle room (mm))
t=0.5;
//Bolt head diameter
B=25+t;

//bolt head height
h=8+t;
//bolt overall length
l=69.5+t;
//diameter
d=11+t;
$fn=50;

module bolt(){
    union(){
        translate([0,0,l-0.1])cylinder(h=h, r=B/2); //space for head
        cylinder(h=l, r=d/2); //bolt shaft
    }
}
//bolt();

difference(){
    hull(){
        sphere(r=l+h-.1);
        translate([35,35,0])sphere(r=l-h);
        rotate([0,0,240])translate([20,30,0])sphere(r=l-h);
        rotate([0,0,120])translate([30,30,0])sphere(r=l-h);
        rotate([0,0,20])translate([20,30,0])sphere(r=l-h);
        rotate([0,0,200])translate([30,30,0])sphere(r=l-h);
        rotate([0,0,280])translate([30,30,0])sphere(r=l-h);
        rotate([0,0,180])translate([70,30,0])sphere(r=l-h);
    }
    bolt();
    translate([0,0,-(0.5*l)])cube([4*l,4*l,2*l], center=true);
    translate([50,50,80])sphere(r=40);
    translate([-50,-50,80])sphere(r=35);
    translate([-50,50,80])sphere(r=37);
    translate([50,-50,80])sphere(r=40);
}
