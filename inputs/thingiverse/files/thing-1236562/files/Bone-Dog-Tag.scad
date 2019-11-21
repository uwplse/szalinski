$fa=1;
$fs=1;
bone_height = 5;//set this to how thick you want the tag
pet_name="Sammy";
phone_number="555-0212";
font_face="Consolas";
font_thickness=3;

module t(t){
 translate([-1,(-len(t)*3.8),bone_height])
   rotate([0, 0, 90])
    linear_extrude(height = font_thickness)
      text(t, 10, font = str(font_face), $fn = 16);
}
//bone
//left side of bone
translate([-12,-25,0]) 
{
    translate([24,0,0]) cylinder(h=bone_height, r=14);
    cylinder(h=bone_height, r=14);
};
//right side of bone
translate([-12,25,0]) 
{
    translate([24,0,0]) cylinder(h=bone_height, r=14);
    cylinder(h=bone_height, r=14);
};
//center of bone
translate([-15,-25,0]) cube([30,50,bone_height]);
t(pet_name);
translate([12,0,0]) t(phone_number);
//tag attachment
difference(){
    translate([-16,0,0]) cylinder(r=6, h=bone_height/2);
    //prevents non-manifold
    translate([-16,0,-1]) cylinder(r=3, h=((bone_height/2)+2));
}