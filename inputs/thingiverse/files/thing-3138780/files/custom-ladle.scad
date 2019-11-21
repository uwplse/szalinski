//Custom Ladle for various kitchen uses
// All measurements below in mm

//Height of ladle shaft
h=15; 
//Diameter of handle hoop
d=40;
//Double Thickness of ladle body
w=10;
//Length of Handle
l=60;
//Thickness of ladle scoop
a=50;
//Depth of ladle scoop
b=15;
//Width of ladle scoop
c=70; 
$fn=150;

module loop(){
difference(){
translate([0,0,h/2])
    cylinder(h=h,d=d,center=true);
translate([0,0,h/2])
    cylinder(h=h+1,d=d-w,center=true);
translate([0,-d/2,0])
    cube(d,center=true);
}
    }
module shaft(){
translate([0,-l/2,h/2])
    cube([w/2,l,h],center=true);
}
module scoop(){
translate([-(a/2)+(w/4),-l-(b/2),(c/2)])
    cube([a,b,c],center=true);
}

difference(){
union (){
translate([(d/2)-w/4,0,0])
    loop();
shaft();
scoop();
}

translate([-(a/2.25),-l,c/2])
resize(newsize=[a-5,b*1.75,c-3])
    sphere(d=a);

translate([-(a/2.25),-l,c/2])
    cube([a*.66,l,2],center=true);
translate([-(a/2.25),-l,(c/2)+5])
    cube([a*.5,l,2],center=true);
translate([-(a/2.25),-l,(c/2)-5])
    cube([a*.5,l,2],center=true);
translate([-(a/2.25),-l,(c/2)+10])
    cube([a*.5,l,2],center=true);
translate([-(a/2.25),-l,(c/2)-10])
    cube([a*.5,l,2],center=true);
}