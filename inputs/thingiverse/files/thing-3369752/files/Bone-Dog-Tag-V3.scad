$fa=1;
$fs=1;
bone_height = 5;//set this to how thick you want the tag
front_line1="Spot";
front_line2="12345";
back_line1="9999999999";
back_line2="9999999999";
font_face="Calibri";
font_thickness=3;
font_size_front=10;
font_size_back=9;

//front text
module t(t){
 translate([-1,(-len(t)*3.45),bone_height-1.75])
   rotate([0, 0, 90])
    linear_extrude(height = font_thickness)
      text(t, font_size_front, font = str(font_face), $fn = 24);
}

//back text
module tb(t){
 translate([1,(len(t)*3),bone_height-3.5])
   rotate([180, 0, -90])
    linear_extrude(height = font_thickness)
      text(t, font_size_back, font = str(font_face), $fn = 24);
}

module bone(pet_name){
    //bone
    //left side of bone
    difference()
    {
        union()
        {
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
            //tag attachment reinforcement
            translate([-11.5,0,0]) cylinder(r=6.75, h=bone_height);
        }
        t(front_line1);
        translate([12,0,0]) t(front_line2);
        translate([-1,0,0]) tb(back_line1);
        translate([12,0,0]) tb(back_line2);
    }
}

difference()
{
    //tag
    bone(pet_name);
    //tag attachment
    translate([-11.5,0,-1]) cylinder(r=2.75, h=((bone_height)+2));
}