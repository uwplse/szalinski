// measured from the vise
vise_jaw_width = 125; 

// measured from the vise
vise_jaw_height = 21;

// how far to extend the "walls" of the jaw around the top, bottom, and sides of the vise jaw
surround_depth = 5;

// is the measured distance the vise jaw extends past the vise body
overlap = 1.26;

// desired value. The printed thickness of the face will be the greater of soft_jaw_face_thickness and cutout_guide_radius + 1.5
soft_jaw_face_thickness = 6;

// desired value 
soft_jaw_wall_thickness = 3;

// controls how deep the guides are cut into the face of the soft jaws. 3mm is good for holding small round stock. If you want to hold stock bigger than about 3/8", increase the guide radius. 
cutout_guide_radius = 3; 

// controls the angles at which the guides are cut into the face of the soft jaws. You might print one face with a guide at [0] and the other face with guides at [45,90].
cutout_angles = [45,90];

// inserts some slop at certain dimensions to allow for printer spooge
fudge_factor = 0.5;

magnet_diameter = 10;
magnet_depth = 4;
magnet_count = 3;

guide_radius = 3;
guide_angles = [45, 90];


mOff = vise_jaw_width/magnet_count;
gOff = vise_jaw_width/len(guide_angles);
jDepth = max(soft_jaw_face_thickness, 
  magnet_depth + 
  (len(guide_angles) > 0 ?  guide_radius : 0) +
  1.5
);

difference() {
  translate([
    soft_jaw_wall_thickness + fudge_factor,
    -vise_jaw_height/2-soft_jaw_wall_thickness-fudge_factor,
    0])
    difference() {
      cube([
        vise_jaw_width + fudge_factor*2 + soft_jaw_wall_thickness*2, 
        vise_jaw_height + fudge_factor*2 + soft_jaw_wall_thickness*2, 
        jDepth + surround_depth]);
      translate([soft_jaw_wall_thickness, soft_jaw_wall_thickness, jDepth]) 
        cube([vise_jaw_width + fudge_factor*2, vise_jaw_height + fudge_factor*2, surround_depth+1]);
      for (step = [magnet_count-1 : 0]) {
        translate([soft_jaw_wall_thickness + fudge_factor + mOff*(step+0.5), vise_jaw_height/2 + soft_jaw_wall_thickness, jDepth - magnet_depth])
          cylinder(r=magnet_diameter/2, h=magnet_depth+1, center=false);
      }
    }
    for (i = [len(guide_angles)-1:0])
      translate([gOff*(i+0.5),0])
        rotate([0,90,guide_angles[i]])
          cylinder(r=guide_radius, h=2*vise_jaw_width, center=true, $fn=4);
}