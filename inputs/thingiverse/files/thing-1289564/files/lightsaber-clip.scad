item_diameter=42;

/* [Grip] */
grip_thickness = 6;
grip_height=20;
grip_gap=38;

/* [Clip] */
clip_height=60;
clip_gap=8;
clip_thickness=4;


/* [Hidden] */
fudge = 0.01;

color([1,0,0]) clip();
color([0,1,0]) grip();

module clip(){
  // Cmd-8 for side-view
  width=20;
  top_thickness = clip_thickness + 4;

  translate([-clip_thickness, width/2, 0])
    rotate(a=90, v=[1, 0, 0])
    linear_extrude(height=width){
      // joint side
      square([clip_thickness, clip_height]);

      // joint side bottom nub
      translate([clip_thickness/2, clip_height])
        circle(r=clip_thickness/2, $fn=16);

      // body side
      body_side_height = clip_height - top_thickness;
      rotate(2)
        translate([clip_thickness + clip_gap, 0]){
          translate([0, top_thickness])
            #square([clip_thickness, body_side_height]);

            //body side bottom nub
            translate([clip_thickness/2, clip_height])
            circle(r=clip_thickness/2, $fn=16);
        }


      top_curve_r = clip_gap / 2 + fudge;
      // "top" bridge
      difference(){
        color([0,1,0])
          square([clip_thickness + clip_gap + clip_thickness, top_thickness + top_curve_r]);

        color([1,0,0])
          translate([clip_thickness + top_curve_r, top_thickness + top_curve_r])
          circle(r=top_curve_r);
      }

    }
}

module grip(){
// Cmd-4 for top-view
item_r = item_diameter / 2;
outer_r = item_r + grip_thickness;
    


translate([-outer_r,0])
linear_extrude(height=grip_height){
    
    difference(){
        //outer
        circle(r=outer_r);
        //inner (hole)
        circle(r=item_r);

        //grip_gap
        translate([-item_r,0])
        square([item_diameter, grip_gap], center=true);

    }
}

}
