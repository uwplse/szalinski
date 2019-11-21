// washer dimentions
od = 21;
id = 14;
h = 1;

$fa=.5;
$fs = .5;

difference(){
    cylinder(r=od/2,h=h,center=true);
	cylinder(r=id/2,h=h+1,center=true);
}