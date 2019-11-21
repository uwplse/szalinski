// preview[view:south west, tilt:top diagonal]

/* [General] */
add_text = "Yes"; // [Yes,No]
text = "DAD";
// Add mid-shaft "nub"
add_nub = "Yes"; // [Yes,No]
head_type="Round"; // [Square,Round]

/* [Fine tuning] */
text_size=4; // [0:.1:10]
text_thickness=2; // [0:.1:10]
text_direction="Vertical"; // [Vertical,Horizontal]
text_offset=0; // [-50:1:50]
head_diameter=10; // [4:1:20]
head_height=14; // [4:.5:20]
shaft_height=70; // [30:1:140]
shaft_diameter=5; // [1:.1:20]
spike_height=6.5; // [0:.5:20]
nub_position="Middle"; // [Middle,Top,Bottom]
nub_thickness=3; // [0:1:20]
// Ball Imprint Diameter (Real Golf Ball = 42.7mm)
ball_diameter = 24; // [10:1:80]

/* [Hidden] */
$fn=50;
total_height=shaft_height+spike_height+head_height;

translate([total_height,0,0]) rotate([90,0,270]) {

total_height=shaft_height+spike_height+head_height;

if(add_text=="Yes")
{
  translate([text_direction=="Horizontal"?0:text_size/2,0,spike_height+shaft_height-2+text_offset])
    rotate([270,90+(text_direction=="Horizontal"?90:0),0]) linear_extrude(height=text_thickness+2) text(text,size=text_size,font="Helvetica:style=Bold",spacing=1,halign=text_direction=="Horizontal"?"center":"left");
}
translate([0,0,spike_height]) cylinder(d=shaft_diameter,h=shaft_height);
translate([0,0,.8])
cylinder(d1=1.4,d2=shaft_diameter,h=spike_height-.8);
translate([0,0,.8]) sphere(d=1.4);
translate([0,0,spike_height+shaft_height]) cylinder(d1=shaft_diameter,d2=head_diameter,h=head_height-4);
difference() {
  union(){
translate([0,0,shaft_height+spike_height+head_height-4]) cylinder(d=head_diameter,h=4);
    if(head_type=="Square")
    {
      translate([0,0,shaft_height+spike_height+head_height-2]) cube([head_diameter,head_diameter,4],center=true);
    }
  }
translate([0,0,total_height+(ball_diameter/2)-4]) rotate([0,90,0]) sphere(d=ball_diameter,$fn=100);
}
if(add_nub=="Yes"&&nub_thickness>0)
{
  nubd=(nub_thickness>=5)?(nub_thickness/2)+1:2.5;
  translate([0,0,spike_height+(nub_position=="Top"?shaft_height:(nub_position=="Bottom"?0:shaft_height/2))]) donut(thickness=nub_thickness,d=nubd);
}
}

module box(w,h,r=2)
{
  minkowski(){
  translate([r,r,r])
    cube(w-r*2,h-r*2);
  sphere(r=r);
  }
}

module donut(d=4,thickness=1) {
rotate_extrude(angle=360) {
  translate([d,0,0]) {
    translate([-1*(d/2),0,0])
    square([d,thickness],center=true);
    circle(d=thickness);
  }
}
}
