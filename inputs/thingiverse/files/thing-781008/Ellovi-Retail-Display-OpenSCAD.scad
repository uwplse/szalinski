//Change these

holesx = 4;
holesy = 6;


$fn=50;

tubewidth = 14;
tubeheight = 21;
tubedepth = 9;

spacing = 6;


 module hole() {
difference() {
translate([0,0,5]) cube([tubewidth+spacing,tubeheight+spacing,tubedepth+2], center = true);
translate([0,0,2]) resize([tubewidth,tubeheight,tubedepth]) oval(tubewidth,tubeheight,tubedepth);
}  
 }

module oval(w,h, height, center = false) {
  scale([1, h/w, 1]) cylinder(h=height, r=w, center=center);
}

for ( w = [1 : holesx] )
{
translate([0,w * (tubeheight+spacing), 0])
for ( d = [1 : holesy] )
{
        translate([d * (tubewidth+spacing), 0, 0]) hole();
}

}