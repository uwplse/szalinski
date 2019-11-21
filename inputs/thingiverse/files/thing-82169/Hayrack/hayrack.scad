// Height from top of wall to bottom of hayrack
main_height = 95;

// Thickness of wall where rack will be mounted
wall_width = 20;

// Height of wooden bar
bar_height = 6;

// Width of wooden bar
bar_width = 6;

// Length of wooden bar fixation
fixation_height = 18;

// Thickness
depth = 5;

/* [Hidden] */
fixation_width=3;

module fixation () {
  linear_extrude(height=depth)polygon(points=[
	[0,0],
	[-wall_width,0],
   [-wall_width+0.8, -fixation_height],
   [-wall_width-fixation_width-bar_width-fixation_width,-fixation_height],
   [-wall_width-fixation_width-bar_width-fixation_width,-fixation_height+fixation_width],
   [-wall_width-fixation_width-bar_width-fixation_width/2, -fixation_height+fixation_width+fixation_width*0.25],
   [-wall_width-fixation_width-bar_width,-fixation_height+fixation_width],
   [-wall_width-fixation_width,-fixation_height+fixation_width], // Point 8
   [-wall_width-fixation_width,-fixation_height+fixation_width+bar_height],
   [-wall_width-fixation_width-bar_width-fixation_width/2,-fixation_height+fixation_width+bar_height],
   [-wall_width-fixation_width-bar_width-fixation_width,-fixation_height+fixation_width+bar_height+fixation_width/2],
   [-wall_width-fixation_width-bar_width-fixation_width,-fixation_height+fixation_width+bar_height+fixation_width],
   [-wall_width-fixation_width,-fixation_height+2*fixation_width+bar_height],
   [-wall_width-fixation_width,fixation_width],
   [0, fixation_width],
]);
}



module rack () {
  lower_curve_radius = 10;
  lower_curve_center = [fixation_width*1.8+lower_curve_radius,-main_height+16.8,0];
  inner_hook_center = [8.26,-main_height+78.97,0];
  inner_hook_radius = 72.18;
  outer_hook_center = [7.51, -main_height+74.03,0];
  outer_hook_radius = 74.41; 

  hook_x = 81.7;
  hook_y = 69; //main_height - 26.2;

  linear_extrude(height=depth)polygon(points=[
	[0,fixation_width],
   [0,-main_height],
   [fixation_width*2,-main_height],
   [fixation_width*1.5,fixation_width]
]);

  intersection(){
    difference() {
      translate([0,-main_height,0])cube([hook_x, hook_y, depth]);
        
      translate([0,0,-0.5])translate(inner_hook_center)cylinder(r=inner_hook_radius,depth+1, $fn=80);
    }
    translate(outer_hook_center)cylinder(r=outer_hook_radius, depth, $fn=80);
  }
  translate(lower_curve_center)difference(){
    translate([-lower_curve_radius,-lower_curve_radius,0])cube([lower_curve_radius,lower_curve_radius,depth]);
    translate([0,0,-0.5])cylinder(r=lower_curve_radius, h=depth+1);
  }
}



fixation();
rack();