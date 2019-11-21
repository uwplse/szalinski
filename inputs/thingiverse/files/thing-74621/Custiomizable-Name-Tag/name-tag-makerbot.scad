include <write/Write.scad> 

//start of parameters

// preview[view:north, tilt:bottom]

Text = "Claudia";
Plate_width=58; //[20:250]
Plate_Height =15;//[10:250]
Plate_thickness=2;//[1:10]
Text_Height=12;//[1:60]
Text_depth=.8;
Plate_Border=2;//[1:25]
Foot = "yes";// [yes,no]
Foot_angle = 45; // [5:45]

Font = "orbitron.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/braille.dxf":Braille,"write/BlackRose.dxf":BlackRose,"write/knewave.dxf":knewave]


part="back"; //[back,text]

//End of parameters

module label(Text_Height,Plate_Border,Font,Plate_thickness,Plate_Height,Plate_width,Text,Text_depth) {
color("red") {
union() {
difference() {
hull(){
translate([Plate_width/2,Plate_Height/2,0])cylinder(h=Text_depth,r=5);
translate([-Plate_width/2,Plate_Height/2,0])cylinder(h=Text_depth,r=5);
translate([-Plate_width/2,-Plate_Height/2,0])cylinder(h=Text_depth,r=5);
translate([Plate_width/2,-Plate_Height/2,0])cylinder(h=Text_depth,r=5);
}
hull(){
translate([Plate_width/2-Plate_Border,Plate_Height/2-Plate_Border,0])cylinder(h=Text_depth,r=5);
translate([-Plate_width/2+Plate_Border,Plate_Height/2-Plate_Border,0])cylinder(h=Text_depth,r=5);
translate([-Plate_width/2+Plate_Border,-Plate_Height/2+Plate_Border,0])cylinder(h=Text_depth,r=5);
translate([Plate_width/2-Plate_Border,-Plate_Height/2+Plate_Border,0])cylinder(h=Text_depth,r=5);
}


}
translate([0,0,Text_depth/2])rotate([0,180,0])write(Text,h=Text_Height,t=Text_depth, font = Font,center=true);
}
}
}
module back(Plate_thickness,Plate_Height,Plate_width,Foot,Foot_angle){

hull(){
translate([Plate_width/2,Plate_Height/2,0])cylinder(h=Plate_thickness,r=5);
translate([-Plate_width/2,Plate_Height/2,0])cylinder(h=Plate_thickness,r=5);
translate([-Plate_width/2,-Plate_Height/2,0])cylinder(h=Plate_thickness,r=5);
translate([Plate_width/2,-Plate_Height/2,0])cylinder(h=Plate_thickness,r=5);
}
if ( Foot=="yes") {
translate([-Plate_width/2,-Plate_Height/2-5,Plate_thickness])rotate([-Foot_angle,0,0])cube([Plate_width,Plate_thickness,Plate_Height]);
}
}

if ( part=="back") {
difference() {
back(Plate_thickness,Plate_Height,Plate_width,Foot,Foot_angle);

translate([0,0,-.1])label(Text_Height+.1,Plate_Border,Font,Plate_thickness,Plate_Height,Plate_width,Text,Text_depth+.1);
}
}

if ( part=="text") {
label(Text_Height,Plate_Border,Font,Plate_thickness,Plate_Height,Plate_width,Text,Text_depth);

}








