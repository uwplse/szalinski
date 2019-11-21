/**
 * Shelf Post Tablet Clip
 * for any 41mm Modular Shelf
 *
 * by Thinkyhead. CCA License.
 *
 * Clips onto a cylindrical shelf leg and secures with a zip tie.
 * The clip can slide, yet also keep the device in place.
 */

/* [Band] */

// (mm)
band_diameter = 41;       // [10:0.5:100]
// (mm)
band_thickness = 2;       // [2:0.125:4]
// (mm)
band_width = 5;           // [4:0.5:10]
// (degrees)
band_gap = 60;            // [40:90]

/* [Clip] */

// (mm)
clip_width = 50;          // [10:100]
// (mm)
clip_height = 5;          // [4:0.5:40]
// (mm)
clip_groove_size = 7;     // [1:0.5:20]
// (mm)
clip_groove_bezel = 3;    // [0:0.25:5]
// (mm)
clip_wall = 1.5;          // [1:0.25:4]
// (mm)
clip_bottom = 1.5;        // [1:0.25:4]

clip_v_alignment = 1;     // [0:Center, 1:Bottom, 2:Top]
                          // >3 offset down, <0 offset up

/* [Extras] */

ziptie_size = 0;          // [0:Small, 1:Large]

// (mm)
clip_extension = 0;       // [0:40]
clip_shape = 3;           // [0:None, 1:Bevel, 2:Rounded, 3:Bevel+Rounded]

/* [Plate] */
print_count = 1;          // [1:8]
arrange_for_printing = 0; // [0:No, 1:Yes]

/* [Hidden] */

zip_size_arr = [[1.6, 2.8], [2.5, 3.7]];
ziptie_hole = zip_size_arr[ziptie_size]; // Ziptie hole width, height

// Pre-calculated values
mount_r = band_diameter / 2;
mount_outer = mount_r+band_thickness;

clip_groove_cutout = clip_height-clip_bottom;
clip_outer = clip_groove_size + clip_extension + clip_wall * 2;

als = [0, (clip_height - band_width) / 2, -(clip_height - band_width) / 2];
sel_yoff = (clip_v_alignment >= 0 && clip_v_alignment <= 2) ? als[clip_v_alignment] : (als[1] - (clip_v_alignment - (clip_v_alignment >= 0 ? 2 : 0)));
max_y = als[1] + band_width / 2;
min_y = als[1] - clip_height + band_width / 2;

clip_y_offs = max(min(sel_yoff, max_y), min_y);

rotate([0,arrange_for_printing && clip_v_alignment == 2 ? 180 : 0,0]) many_mounts();

module many_mounts() {
  spx = max(band_diameter*1.75, clip_width + 1);
  spy = mount_outer * 2 + clip_outer * 2 + 10;
  xyr_a = [
    [0,0,0],[mount_r,10,180],[spx,0,0],[spx+mount_r,10,180],
    [0,spy,0],[mount_r,spy+10,180],[spx,spy,0],[spx+mount_r,spy+10,180]
  ];
  for (i=[0:print_count-1]) {
    xyr = xyr_a[i];
    translate([xyr[0],xyr[1]]) rotate([0,0,xyr[2]]) tablet_mount();
  }
}

//
// The whole assembled clip
//
module tablet_mount() {
  offs1 = [0, -mount_outer-clip_groove_size/2, clip_y_offs];
  offs2 = [0, -mount_outer-clip_outer/2+band_thickness, clip_y_offs];
  offs = offs1[1] < offs2[1] ? offs1 : offs2;
  translate(offs) difference() {
    union() {
      translate(-offs) mount_band();
      rotate([0,90]) {
        if (clip_shape >= 2) {
          intersection() {
            rounded_cube([clip_height,clip_outer,clip_width], r=2, $fn=72, center=true);
            rotate([0,90]) rounded_cube([clip_width,clip_outer,clip_height], r=clip_wall, $fn=144, center=true);
          }
        } else {
          rounded_cube([clip_height,clip_outer,clip_width], r=2, $fn=72, center=true);
        }
      }
    }
    clip_cut = clip_groove_cutout + 8;
    translate([0,-clip_extension/2,clip_cut/2-clip_height/2+clip_bottom]) rotate([0,90]) rounded_cube([clip_cut,clip_groove_size,clip_width+1], r=min(clip_groove_bezel,clip_groove_size/3), $fn=72, center=true);
    if (clip_extension >= 2.5) {
      slide_over = 1.5;
      cut_r = min(clip_extension/2,clip_height-clip_bottom) - slide_over / 2;
      translate([0,(clip_groove_size+clip_wall-slide_over)/2,clip_height/2]) rotate([0,90]) cylinder(r=cut_r, h=clip_width+1,center=true, $fn=max(10, cut_r*2));
    }
    if (clip_shape == 1 || clip_shape == 3) {
      for(x=[-1,1]) translate([x*(clip_width)/2,0,clip_height/2+clip_bottom]) rotate([0,x*-45]) cube([clip_height*1.414,clip_outer+1,clip_height*2],center=true);
    }
  }
}

//
// Mounting band part
//
module mount_band() {
  difference() {
    $fn=180;
    union() {
      cylinder(r=mount_outer, h=band_width, center=true);
      for (a=[-1,1]) rotate([0,0,a*(band_gap/2+5.5)]) translate([0,mount_outer-band_thickness/2])
        scale([1,2.2]) cylinder(r=band_thickness, h=band_width, center=true);
    }
    cylinder(r=mount_r, h=band_width+3, center=true);
    for (a=[-band_gap/2:band_gap/2]) rotate([0,0,a]) translate([0,mount_r+band_thickness/2])
      cube([1,band_thickness+10,band_width+2], center=true);
    for (a=[-1,1]) rotate([0,0,a*(band_gap/2+6)]) translate([0,mount_r+band_thickness/2+band_thickness])
      cube([5,ziptie_hole[0],ziptie_hole[1]], center=true);
  }
}

// Helpers
module rounded_cube(size=[1,1,1], r=0, center=false) {
  d = r * 2;
  w = d > size[0] ? 1 : size[0]-d;
  h = d > size[1] ? 1 : size[1]-d;
  // %cube(size, center=center);
  minkowski() {
    cube([w, h, size[2]], center=center);
    cylinder(r=r, h=0.01, center=true);
  }
}
