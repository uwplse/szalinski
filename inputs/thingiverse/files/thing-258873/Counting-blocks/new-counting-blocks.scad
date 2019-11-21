N = 5; // [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
block_width = 10; // [5:30]
// Rotate digits so they are always ascending when viewed right-side up
digits_always_ascending = "no"; // [no,yes]
dgts_asc = (digits_always_ascending=="yes"?1:0);
recess_highest_digit = "yes"; // [no,yes]
recess_hghst = (recess_highest_digit=="yes"?1:0);
// Digit size as percentage of block width
digit_size = 50; // [30:90]
digit_frac = digit_size/100;
// Digit depth as percentage of block width
digit_depth = 10; // [5:25]
digit_d = digit_depth/100;
// Chamfer as percentage of block width
chamfer_percentage = 10; // [0:20]
chamfer_frac = chamfer_percentage/100;

/* [Hidden] */
eps = 1e-5;

include <write/Write.scad>;

for (i=[1:N]) translate([(i-(N+1)/2)*block_width , 0, 0]) cuisinaire_block(block_width, i, (N+1-i), recess_hghst*(i==N?1:0), recess_hghst*(i==1?1:0));

module cuisinaire_block (width, top_digit, front_digit, top_recess, front_recess) {
  difference() {
    render() chamfered_box(width, width, width, chamfer=chamfer_frac*width);
    union() {
      if (len(str(top_digit)) > 0) {
	translate([0, 0, -0.5*digit_d*width+eps+width/2])
	  render() w(s=str(top_digit), ht=digit_frac*width, th=digit_d*width, inv=top_recess);
	translate([0, 0, -(-0.5*digit_d*width+eps+width/2)]) rotate([180, 0, 0])
	  render() w(s=str(top_digit), ht=digit_frac*width, th=digit_d*width, inv=top_recess);
      }
      if (len(str(front_digit)) > 0) {
	translate([0, 0.5*digit_d*width-eps-width/2, 0]) rotate([0, dgts_asc*180, 0]) rotate([90, 0, 0])
	  render() w(s=str(front_digit), ht=digit_frac*width, th=digit_d*width, inv=front_recess);
	translate([0, -(0.5*digit_d*width-eps-width/2), 0]) rotate([0, dgts_asc*180, 0]) rotate([-90, 0, 0]) 
	  render() w(s=str(front_digit), ht=digit_frac*width, th=digit_d*width, inv=front_recess);
      }
    }	
  }
}

module w (s, ht, th, inv) {
  if (inv==0) {
    write(s, center=true, h=ht, th=t);
  }
  else {
    difference() {
      cube([(block_width*(1-2*chamfer_frac)+ht)/2,(block_width*(1-2*chamfer_frac)+ht)/2,th],center=true);
      write(s, center=true, h=ht, th=t+eps);
    }
  }
}

module chamfered_box (width, length, height, chamfer=1) {
  difference() {
    cube([width, length, height], center=true);
    for (i=[-1,1], j=[-1,1]) {
      translate([i*(width/2-chamfer/2), 0, j*(height/2-chamfer/2)])
	rotate([0, -90+atan2(i, j), 0]) translate([max(max(length,height),width)/2, 0, 0])
	cube(max(max(length,height),width), center=true);
      translate([i*(width/2-chamfer/2), j*(length/2-chamfer/2), 0])
	rotate([0,  0, 90-atan2(i,j)]) translate([max(max(length,height),width)/2, 0, 0])
	cube(max(max(length,height),width), center=true);
      translate([0, i*(length/2-chamfer/2), j*(height/2-chamfer/2)])
	rotate([90-atan2(i,j), 0,  0]) translate([0, max(max(length,height),width)/2, 0])
	cube(max(max(length,height),width), center=true);
    }		
  }
}
