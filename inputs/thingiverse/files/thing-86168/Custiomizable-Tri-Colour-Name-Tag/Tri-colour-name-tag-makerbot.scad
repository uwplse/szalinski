include <write/Write.scad> 

//start of parameters

// preview[view:north, tilt:bottom]

Line1Text = "Jhack";
Line2Text = "The Geek Of the Year";
Plate_width=85; //[20:250]
Plate_Height =25;//[10:250]
Plate_thickness=2;//[1:10]
Text_Height_1=12;//[1:60]
Text_Height_2=6;//[1:60]
Text_depth=.8;
Text1_Dist_top=6;//[4:100]
Text2_Dist_top=20;//[4:100]
Plate_Border_1=1;//[1:25]
Plate_Border_2=1;//[1:25]
//if magnets is selected for backing the magent depth will over ride plate thickness
Backing ="magents";//[none,foot,magents]
//Foot = "yes";// [yes,no]
Foot_angle = 45; // [5:45]
magent_diameter=8;//[1:30]
magent_depth=5;//[1:30]

//Font = "orbitron.dxf";//["Letters.dxf":Basic,"orbitron.dxf":Futuristic,"braille.dxf":Braille]

//Font2 = "orbitron.dxf";//["Letters.dxf":Basic,"orbitron.dxf":Futuristic,"braille.dxf":Braille]

Font = "orbitron.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/braille.dxf":Braille,"write/BlackRose.dxf":BlackRose,"write/knewave.dxf":knewave]

Font2 = "orbitron.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/braille.dxf":Braille,"write/BlackRose.dxf":BlackRose,"write/knewave.dxf":knewave]


part="back"; //[back,text1,text2]

//End of parameters


module label(Text_Height,Plate_Border,Font,Plate_thickness,Plate_Height,Plate_width,Text,Text_depth,top_dist) {
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
translate([0,Plate_Height/2-top_dist,Text_depth/2])rotate([0,180,0])write(Text,h=Text_Height,t=Text_depth, font = Font,center=true);
}
}
}

module back(Plate_thickness,Plate_Height,Plate_width,Backing,Foot_angle,magent_diameter,magent_depth,Text_depth){
if (Backing=="magents"){
difference() {
hull(){
translate([Plate_width/2,Plate_Height/2,0])cylinder(h=magent_depth+Text_depth*2,r=5);
translate([-Plate_width/2,Plate_Height/2,0])cylinder(h=magent_depth+Text_depth*2,r=5);
translate([-Plate_width/2,-Plate_Height/2,0])cylinder(h=magent_depth+Text_depth*2,r=5);
translate([Plate_width/2,-Plate_Height/2,0])cylinder(h=magent_depth+Text_depth*2,r=5);
}

#translate([Plate_width/2-magent_diameter,0,Text_depth*2])cylinder(h=magent_depth,r=magent_diameter/2+.2);
#translate([-Plate_width/2+magent_diameter,0,Text_depth*2])cylinder(h=magent_depth,r=magent_diameter/2+.2);
}

} else
{
hull(){
translate([Plate_width/2,Plate_Height/2,0])cylinder(h=Plate_thickness,r=5);
translate([-Plate_width/2,Plate_Height/2,0])cylinder(h=Plate_thickness,r=5);
translate([-Plate_width/2,-Plate_Height/2,0])cylinder(h=Plate_thickness,r=5);
translate([Plate_width/2,-Plate_Height/2,0])cylinder(h=Plate_thickness,r=5);
}
if ( Backing=="foot") {
translate([-Plate_width/2,-Plate_Height/2-5,Plate_thickness])rotate([-Foot_angle,0,0])cube([Plate_width,Plate_thickness,Plate_Height]);
}

}
}

if ( part=="back") {
difference() {
back(Plate_thickness,Plate_Height,Plate_width,Backing,Foot_angle,magent_diameter,magent_depth,Text_depth);

translate([0,0,-.1])label(Text_Height_1+.1,Plate_Border_1,Font,Plate_thickness,Plate_Height,Plate_width,Line1Text,Text_depth+.1,Text1_Dist_top);

translate([0,0,-.1])label(Text_Height_2+.1,Plate_Border_2,Font2,Plate_thickness,Plate_Height-Plate_Border_1*2,Plate_width-Plate_Border_1*2,Line2Text,Text_depth+.1,Text2_Dist_top);

}
}

if ( part=="text1") {
label(Text_Height_1,Plate_Border_1,Font,Plate_thickness,Plate_Height,Plate_width,Line1Text,Text_depth,Text1_Dist_top);

}

if ( part=="text2") {
label(Text_Height_2,Plate_Border_2,Font2,Plate_thickness,Plate_Height-Plate_Border_1*2,Plate_width-Plate_Border_1*2,Line2Text,Text_depth,Text2_Dist_top);
}







