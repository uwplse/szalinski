//change
entireheight=50;
quality = 100;
//do not change
$fn = quality;
abcdefg = entireheight;

spacefiller();
difference(){
    filledstorage();
    negativestorage();
}
//"spacefiller" makes the item print faster
module spacefiller(){
    translate([14,5.5,0])
    cylinder(r = 2, h = entireheight, center = true);
    translate([4.7,14.5,0])
    cylinder(r = 2.5, h = entireheight, center = true);
}
module negativestorage() {
    //changable, must be same as module "filledstorage"
    quarterdiam = 28.76;
    pennydiam = 23.55;
    nickeldiam = 25.71;
    dimediam = 22.4;
    abcdefg = 500; // do not change the "+2"
    //do not change
    translate([pennydiam,-3,+3])
    penny();
    translate([dimediam*0.75,dimediam*0.75,+3])
    dime();
    translate([-3,nickeldiam,+3])
    nickel();
    translate([0,0,+3])
    quarter();
}
module filledstorage(){
    //changable, must be same as module "negativestorage"
    quarterdiam = 28.76;
    pennydiam = 23.55;
    nickeldiam = 25.71;
    dimediam = 22.4;
    height = entireheight;
    //do not touch
    //quarter
    translate([0,0,0])
    cylinder(r = quarterdiam/2, h = height,center = true);
    //penny
    translate([pennydiam,-3,0])
    cylinder(r = pennydiam/2, h = height,center = true);
    //nickel
    translate([-3,nickeldiam,0])
    cylinder(r = nickeldiam/2, h = height,center = true);
    //dime
    translate([dimediam*0.75,dimediam*0.75,0])
    cylinder(r = dimediam/2, h = height,center = true);
}
module quarter() {
    diameter = 24.26;
    height = abcdefg;
    cylinder(r = (diameter/2)+0.5, h = height, center = true, $fn = quality);
}
module dime(){
    diameter = 17.9;
    height = abcdefg;
    cylinder(r = (diameter/2)+0.5, h = height, center = true, $fn = quality);
}
module nickel() {
    diameter = 21.21;
    height = abcdefg;
    cylinder(r = (diameter/2)+0.5, h = height, center = true, $fn = quality);
}
module penny() {
    diameter = 19.05;
    height = abcdefg;
    cylinder(r = (diameter/2)+0.5, h = height, center = true, $fn = quality);
}