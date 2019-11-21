// EarthWoArtTag2 1v2
// By: William Ha
// Date: 2016-02-24
// Description: cool text tag - Earth w/o ART ver 2

use <text_on\text_on.scad>

$fn=100;

H=4;    // text height above base plate
t=1;    // base plate thickness
r=50;   // plate radius
t_r=40;  // text radius
t_size=10;   // text size (those on the rim)
font="Liberation Mono:style=bold";

color("DeepSkyBlue") {
    text_on_circle("THE EARTH",r=t_r,size=t_size,extrusion_height=H,font=font,spacing=1.5);
    rotate(45) text_extrude("art+art",size=t_size-1,extrusion_height=H,font=font);
    rotate(-45) translate([0,0,0]) text_extrude("art art",size=t_size-1,extrusion_height=H,font=font);
    text_on_circle("IS JUST 'EH'",r=t_r,size=t_size,extrusion_height=H,font=font,spacing=1.2, rotate=180);
}
    
color("yellow")
    translate([0,0,-H/2-t]) cylinder(r=r,h=t,$fn=100);