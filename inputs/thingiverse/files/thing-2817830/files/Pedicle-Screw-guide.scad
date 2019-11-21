echo ("Copyright 2018 Nevit Dilmen");
echo ("Creative Commons Attribution Share Alike");
// Ineterpedincular distance
$InterP=44;
// Angle of screw
$Aci=20;
// Hole diameter
$delik=3;
// Body size
$tup=10;

difference (){
difference (){
difference (){
difference (){
difference (){
union(){
union(){
union(){
translate([-$InterP, 0, 0])
sphere(5);

union(){
translate([$InterP, 0, 0])
sphere(5);

scale([1,1.5,1])
rotate_extrude()
translate([$InterP, 0, 0])
circle(r = 3);
}}

translate([-$InterP, 0, 0])
rotate([90,0,-$Aci])
cylinder($tup,d=$delik+3);
}
translate([$InterP, 0, 0])
rotate([90,0,$Aci])
cylinder($tup,d=$delik+3);
}
translate([0, $InterP*1.5, 0])
cube($InterP*3, center=true);
}

translate([$InterP, 0, 0])

sphere(3);
}

translate([-$InterP, 0, 0])

sphere(3);
}

translate([$InterP, 0, 0])
rotate([90,0,$Aci])
cylinder($tup*2,d=$delik);
}

translate([-$InterP, 0, 0])
rotate([90,0,-$Aci])
cylinder($tup*2,d=$delik);
}
