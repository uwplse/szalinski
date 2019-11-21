// measured from the vise
vise_jaw_width = 125; 

// measured from the vise
vise_jaw_height = 21;

// measured from the vise
vise_jaw_depth = 12;

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

gOff = vise_jaw_width/len(cutout_angles);
jDepth = max(soft_jaw_face_thickness, 
  (len(cutout_angles) > 0 ?  cutout_guide_radius : 0) +
  1.5
);
rotate([90,0,0])
translate([0,vise_jaw_height/2 + soft_jaw_wall_thickness,0])
difference() {
  translate([
    soft_jaw_wall_thickness + fudge_factor,
    -vise_jaw_height/2-soft_jaw_wall_thickness-fudge_factor,
    0])
    difference() {
      cube([
        vise_jaw_width + fudge_factor*2 + soft_jaw_wall_thickness*2, 
        vise_jaw_height + fudge_factor*2 + soft_jaw_wall_thickness, 
        jDepth + vise_jaw_depth + fudge_factor + soft_jaw_wall_thickness]);
      translate([soft_jaw_wall_thickness, soft_jaw_wall_thickness, jDepth]) 
        cube([vise_jaw_width + fudge_factor*2, vise_jaw_height + fudge_factor*2 + 0.1, vise_jaw_depth + fudge_factor]);
      translate([soft_jaw_wall_thickness + overlap, soft_jaw_wall_thickness+overlap+fudge_factor, jDepth + vise_jaw_depth + fudge_factor-1]) 
        cube([vise_jaw_width + fudge_factor*2 - overlap*2, vise_jaw_height + fudge_factor*2 - overlap, soft_jaw_wall_thickness+2]);
    }
    for (i = [len(cutout_angles)-1:0])
      translate([gOff*(i+0.5),0])
        rotate([0,90,cutout_angles[i]])
          cylinder(r=cutout_guide_radius, h=2*vise_jaw_width, center=true, $fn=4);
}