$fa=1;
$fs=1;
bone_height = 5;//set this to how thick you want the tag
pet_name="Jacen";
phone_number="06.01.23.45.67";
font_face="Arial";
font_thickness=3;

module t(t){
 translate([-1,(-len(t)*3.8),bone_height])
   rotate([0, 0, 90])
    linear_extrude(height = font_thickness)
      text(t, 10, font = str(font_face), $fn = 16);
}
//bone
//left side of bone
translate([-12,-40,0]) 
{
    translate([24,0,0]) cylinder(h=bone_height, r=14);
    cylinder(h=bone_height, r=14);
};
//right side of bone
translate([-12,40,0]) 
{
    translate([24,0,0]) cylinder(h=bone_height, r=14);
    cylinder(h=bone_height, r=14);
};
//center of bone
translate([-15,-40,0]) cube([30,80,bone_height]);
t(pet_name);
translate([12,8,0]) t(phone_number);
//tag attachment
difference(){
    translate([-16,0,0]) cylinder(r=10, h=bone_height);
    //prevents non-manifold
    translate([-16,0,-1]) cylinder(r=6, h=((bone_height
    )+2));
}