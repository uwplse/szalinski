include <write/Write.scad> 

//start of parameters

// preview[view:north, tilt:bottom]

Text = "PLA";
Plate_width=58; //[20:250]
Plate_Height =15;//[10:250]
Plate_thickness=2;//[:10]
Text_Height=12;//[1:60]
Text_depth=.8;
Plate_Border=2;//[1:25]





Font = "orbitron.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/braille.dxf":Braille,"write/BlackRose.dxf":BlackRose,"write/knewave.dxf":knewave]



// Number of clips on the bracket
clipNumber = 2;		//[1:50]		
// Distance between clip centers
clipSpacing = 30;	//[1:100]	
// Diameter of the clip inside face		
clipInnerDiameter = 16.5;//[5:100]
// Width (height) of clip
clipWidth = 15;		//[5:100]		
// Thickness of clip walls
clipWallThickness = 2;	//[2:10]
// Amount of clip ring to remove from top (valid between 0 and 180)
clipOpeningAngle = 100;//[0:180]	
	
part="back"; //[back,text]


/* [hidden] */
//End of parameters
Backing ="clip";//[none,foot,pin]
//Foot = "yes";// [yes,no]
Foot_angle = 45; // [5:45]
pin_length=14; // [5:45]
pin_diameter=1;// [1:5]
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
module back(Plate_thickness,Plate_Height,Plate_width,Backing,Foot_angle,pin_length,pin_diameter){

hull(){
translate([Plate_width/2,Plate_Height/2,0])cylinder(h=Plate_thickness,r=5);
translate([-Plate_width/2,Plate_Height/2,0])cylinder(h=Plate_thickness,r=5);
translate([-Plate_width/2,-Plate_Height/2,0])cylinder(h=Plate_thickness,r=5);
translate([Plate_width/2,-Plate_Height/2,0])cylinder(h=Plate_thickness,r=5);
}
if ( Backing=="foot") {
translate([-Plate_width/2,-Plate_Height/2-5,Plate_thickness])rotate([-Foot_angle,0,0])cube([Plate_width,Plate_thickness,Plate_Height]);
}

if ( Backing=="clip") {
// Create clips
translate([-(clipSpacing*(clipNumber-1)+clipWidth)/2,0,0])
 for (clipPos = [0:clipNumber-1]) {
	translate([clipPos*clipSpacing,0,(clipInnerDiameter/2)+Plate_thickness+1]) rotate([90,0,90]) roundClip();
}

}



}

if ( part=="back") {
difference() {
back(Plate_thickness,Plate_Height,Plate_width,Backing,Foot_angle,pin_length,pin_diameter);

translate([0,0,-.1])label(Text_Height+.1,Plate_Border,Font,Plate_thickness,Plate_Height,Plate_width,Text,Text_depth+.1);
}
}

if ( part=="text") {
label(Text_Height,Plate_Border,Font,Plate_thickness,Plate_Height,Plate_width,Text,Text_depth);

}


// Round clip
module roundClip() {
difference() {
	cylinder(r = (clipInnerDiameter/2 + clipWallThickness), h = clipWidth);
	translate([0,0,-1]) cylinder(r = clipInnerDiameter/2, h = clipWidth + 2);
	translate([0,0,-1]) union () {
		rotate([0,0,clipOpeningAngle/4-0.05]) intersection() {
			rotate([0,0,clipOpeningAngle/4]) cube([clipInnerDiameter+clipWallThickness+1,clipInnerDiameter+clipWallThickness+1,clipWidth+2]);
			rotate ([0,0,-clipOpeningAngle/4]) translate([-(clipInnerDiameter+clipWallThickness+1),0,0]) cube([clipInnerDiameter+clipWallThickness+1,clipInnerDiameter+clipWallThickness+1,clipWidth+2]);
			cylinder(r=clipInnerDiameter+clipWallThickness+1,h=clipWidth+2);
		}

		rotate([0,0,-clipOpeningAngle/4+0.05]) intersection() {
			rotate([0,0,clipOpeningAngle/4]) cube([clipInnerDiameter+clipWallThickness+1,clipInnerDiameter+clipWallThickness+1,clipWidth+2]);
			rotate ([0,0,-clipOpeningAngle/4]) translate([-(clipInnerDiameter+clipWallThickness+1),0,0]) cube([clipInnerDiameter+clipWallThickness+1,clipInnerDiameter+clipWallThickness+1,clipWidth+2]);
			cylinder(r=clipInnerDiameter+clipWallThickness+1,h=clipWidth+2);
		}
	}
}

rotate([0,0,clipOpeningAngle/2]) translate([0,clipInnerDiameter/2+clipWallThickness,0]) cylinder(r = clipWallThickness, h = clipWidth);
//#rotate([0,0,clipOpeningAngle/2]) translate([0,clipInnerDiameter/2+clipWallThickness*2,0]) cylinder(r = clipWallThickness, h = clipWidth);

rotate([0,0,-clipOpeningAngle/2]) translate([0,clipInnerDiameter/2+clipWallThickness,0]) cylinder(r = clipWallThickness, h = clipWidth);
}







