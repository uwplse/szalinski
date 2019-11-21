// 
// Twisted key fob 
// version 1.3   6/29/2015
// by daozenciaoyen
//

// preview[view:south, tilt:top]

/* [Main] */
text_line_1 = "twisted" ;
text_line_2 = "key fob" ;
text_line_3 = "custom" ;
text_line_4 = "print" ;
show_lines = 4 ; // [0:4] 
initial_text_angle = 0 ; // [0:5:360]

/* [Font] */
font_family_choice = 3 ; // [1:Liberation Sans,2:Montserrat,3:Open Sans,4:Oswald]
font_family_choice = 3+0 ;

// Not all combinations exist
font_style = "Bold" ; // [Regular, Bold, Italic, Bold Italic]
adjust_length = 10 ; // [-30:5:100]
text_center_horizontal = .2 ; // [-1.3:0.1:1.3]

/* [Shape] */
center_slope_length_percent = 25 ; // [0:5:100]
center_scale = 0.7 ; // [0.3:.1:1.5]
center_twist = 180 ; // [-360:5:360]
text_surface_height = 0.5 ; // [0.3:0.1:1.6]
text_surface_twist = 0 ; // [-360:5:360]
ring_stretch = 1.2 ; // [0.8:0.2:1.4]
full_ring = "No" ; // [Yes,No]

/* [Advanced] */
facets = 24 ; // [8:36]
ring_slice = 17 ; // [-20:20]
text_size = 13 ; // [10:30]
text_scale_width = 1 ; // [0.5:0.1:3]
text_scale_height = 2.3 ; // [0.5:0.1:3.5]
text_inner_z_adjust = 0 ; // [-5:10]

/* [Hidden] */
font_family_text_array = 
    ["Liberation Sans","Montserrat","Open Sans","Oswald"] ;
font_family_size_array = [0.8,1,0.9,0.7] ;
font_family = font_family_text_array[font_family_choice-1] ;
font_width_adjust = font_family_size_array[font_family_choice-1] ;
font = str(font_family,":style=",font_style) ;
ext_height = 40 ;
text_surface_scale = center_scale + text_surface_height ;
adjust = ext_height / 2 + text_inner_z_adjust ;
text_angle = 360 / show_lines ;
center_length1_p1 = center_slope_length_percent / 100 ;
char_width = text_size * text_scale_width * font_width_adjust ; 
text1 = str("",text_line_1) ; 
text2 = str("",text_line_2) ; 
text3 = str("",text_line_3) ; 
text4 = str("",text_line_4) ; 
text_length = max(len(text1),len(text2),len(text3),len(text4)) ;
text_width = text_length * char_width ;
center_length = text_width + adjust_length ;
center_length1 = center_length * center_length1_p1 ;
center_length2 = center_length - center_length1 ;
text_adjust_sign = adjust_length < 0 ? -1 : 1 ;
text_right_adjust = (center_length - text_width) / 2 *
  text_center_horizontal * text_adjust_sign ;
twist1 = center_twist * center_length1_p1 ;
twist2 = center_twist * (1 - center_length1_p1) ;
outer_ring_slice = 18 ;
model_scale = 0.3 ;
angle1 = (show_lines < 3) ? 90 : 0 ; // not used
angle1 = initial_text_angle ;
ring_size = 8 * 3 * 2 * ring_stretch;
ff = 0.001 ;

module ring()
{
  scale([3,3,3])
      rotate_extrude(convexity = 10, $fn = facets)
      translate([6, 0, 0])
      scale([1,3,1])
      circle(r = 2, $fn = facets);
}

module ring_slice(ring_slice)
{
  projection(cut=true) 
    translate([0,0,ring_slice]) 
    rotate([90,0,0]) 
    ring() ;
}

module center_section(length,scale,twist,ring_slice)
{
  rotate([0,90,0])
  linear_extrude(height=length, center=true, 
    convexity=10, twist=twist, slices=facets, scale=[scale,scale]) 
    ring_slice(ring_slice) ;
}

module draw_text(x_rot,text)
{
  rotate([x_rot,0,0])
  translate([text_right_adjust,0,adjust])
  linear_extrude(height = ext_height, center = true, 
    convexity = 10, scale=[text_scale_width,text_scale_height])
  text(text, font = font, size=text_size, 
    valign="center", halign="center") ;
}

// the main union
scale([model_scale,model_scale,model_scale])
union()
{
  // ring
  if (full_ring=="Yes")
  {
    translate([-center_length/2-ring_slice*ring_stretch,0,0]) 
      scale([ring_stretch,1,1])
      ring() ;
  }
  else
  {
    translate([-center_length/2,0,0])
      scale([ring_stretch,1,1])
      rotate([-90,0,90])
        difference()
        {
          translate([0,0,ring_slice]) 
            rotate([90,0,0]) 
            ring() ;
          translate([0,0,-ring_size/2-ff]) 
            cube([ring_size,ring_size,ring_size],
            center=true) ;
        } 
  }
    
  // center section 1
  rotate([90,0,0]) 
    translate([-center_length/2+center_length1/2,0,0]) 
    center_section(center_length1+ff*2,center_scale,twist1,ring_slice) ;

  // center section 2
  rotate([90-twist1,0,0]) 
    translate([center_length1/2,0,0]) 
    scale([1,center_scale,center_scale]) 
    center_section(center_length2,1,twist2,ring_slice) ;
    
  // end cap
  translate([center_length/2-ff,0,0])
  scale([ring_stretch,center_scale,center_scale])
  rotate([-90,twist1+twist2,90])
    difference()
    {
      translate([0,0,ring_slice]) 
        rotate([90,0,0]) ring() ;
      translate([0,0,ring_size/2]) 
        cube([ring_size,ring_size,ring_size],
        center=true) ;
    } 

  intersection()
  {
    // text
    union()
    {
      if (show_lines > 0) {
        draw_text(angle1,text1) ;
      }
      if (show_lines > 1) {
        draw_text(angle1+text_angle,text2) ;
      }
      if (show_lines > 2) {
        draw_text(angle1+text_angle*2,text3) ;
      }
      if (show_lines > 3) {
        draw_text(angle1+text_angle*3,text4) ;
      }
    }
    // text surface
    if (show_lines > 0) {
      translate([text_right_adjust,0,0])
        scale([1,text_surface_scale,text_surface_scale])
        center_section(center_length,1,text_surface_twist,
            outer_ring_slice) ;
    }
  }
}