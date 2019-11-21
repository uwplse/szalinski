$fn=60/1;

//Fan Size
fan_size=40;           //[40:40mm, 50:50mm, 60:60mm, 80:80mm]
//Generate Extension?
extension=1;           //[1:Yes, 0:No]
//Fan Screw Spacing (choose Fan Size here)
screw_spacing=32;      //[32:40mm, 40:50mm, 50:60mm, 72:80mm]
//Fan Screw Hole Radius (use 2 for #6 (default), 1.7 for M3)
fan_screw=2;
//Mount Screw Hole Radius, Both Parts (use 2 for #6 (default), 1.7 for M3)
mount_screw=2;
//Extension Screw Hole Radius (use 2 for #6 (default), 1.7 for M3)
extension_screw=2;
//Mount Tab Position from Y Axis
mount_position=15;
//Mount Tab Length (from edge of plate to center of cylinder)
mount_length=12;
//Extension Length (from flat end to center of cylinder)
extension_length=20;
//Plate Mount Angle
mount_angle=90;        //[90:Parallel to Plate, 0:Perpendicular to Plate]
//Extension Mount Angle
extension_mount_angle=90; //[90:Parallel to Extension, 0:Perpendicular to Extension]
//Full Plate (default) or Two Screw Option
full_plate=1;          //[0:Two Screws, 1:Full Plate]
//





//Derived Variables
fanscrewmargin=fan_size/2-screw_spacing/2; //margin from edge of fan to center of fan screw hole

//Fan Bracket
module holes(){

//Fan Screw Holes
if(full_plate==1){
translate ([fanscrewmargin,fanscrewmargin,-0.1])
cylinder (r=fan_screw, h=3.2);

translate ([fan_size-fanscrewmargin,fanscrewmargin,-0.1])
cylinder (r=fan_screw, h=3.2);
}

translate ([fanscrewmargin,fan_size-fanscrewmargin,-0.1])
cylinder (r=fan_screw, h=3.2);

translate ([fan_size-fanscrewmargin,fan_size-fanscrewmargin,-0.1])
cylinder (r=fan_screw, h=3.2);

//Mount screw hole
translate ([mount_position+5,fan_size+mount_length,5])
rotate ([0,mount_angle,0])
cylinder (r=mount_screw, h=10.2, center=true);

//Fan opening
translate ([fan_size/2,fan_size/2,-0.1])
cylinder (r=fan_size/2*0.875, h=3.2);
}

module solids(){

//Fan Plate
if(full_plate==0){
translate ([2,fan_size*0.75+2,0])
minkowski(){
cube ([fan_size-4,fan_size*0.25-4,1.5]);
cylinder (r=2, h=1.5);
}
} else{
translate ([2,2,0])
minkowski(){
cube ([fan_size-4,fan_size-4,1.5]);
cylinder (r=2, h=1.5);
}
}

//Mount Cylinder and Tab
translate ([mount_position,fan_size-2,0])
cube ([10,mount_length+2,3]);

translate ([mount_position+5,fan_size+mount_length,5])
rotate ([0,mount_angle,0])
cylinder (r=5, h=10, center=true);
}

//Part Repositioning for Two Screw Option
if(full_plate==0){
translate ([0,-fan_size*0.75,0])
difference(){
solids();
holes();
} 
} else{
difference(){
solids();
holes();
}
}

//Extension
module eholes(){

//Screw Hole
translate ([fan_size+10,4,-0.1])
cylinder (r=extension_screw, h=3.2);

//Cylinder Screw Hole
translate ([fan_size+10,extension_length,5])
rotate([0,extension_mount_angle,0])
cylinder (r=mount_screw, h=10.2, center=true);

}
module esolids(){

//Extension Plate
translate ([fan_size+7, 2, 0])
minkowski(){
cube ([6,extension_length-4,1.5]);
cylinder (r=2, h=1.5);
}

//Small Cube to clean up merge with Cylinder
translate ([fan_size+5, extension_length-2,0])
cube ([10,2,3]);

//Extension Cylinder
translate ([fan_size+10,extension_length,5])
rotate ([0,extension_mount_angle,0])
cylinder (r=5, h=10, center=true);
}
if(extension==1){
difference(){
esolids();
eholes();
}
}

