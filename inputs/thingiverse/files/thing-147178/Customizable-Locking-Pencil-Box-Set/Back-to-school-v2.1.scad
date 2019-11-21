/* Back to school by Bob Hamlet 9/15/13
 * Customizable locking pencil box set
 * http://www.thingiverse.com/thing:147178
 * v1.1 9/17/13 fixed tolerance issues found during print tests.
 *              rewrote the latch module for better parametrization.
 *              rewrote the hinge module for easier assembly.
 *              made design module produce more relief.
 *              added texture to key for better grip.
 * v1.2 9/20/13 changed ruler text settings.
 *              added error checking for preview_tab parameter.
 * v1.3 9/21/13 moved the textblock text down to be on the lid.
 * v2.0 9/23/13 revised picture module:
 *					 allows lid to be printed at less than 100% infill.
 *					 now shows picture in customizer!
 * V2.1 9/27/13 oops, I had to change the if for "Draw" because I changed the description to "Draw (Please be patient!)"
 */

use <utils/build_plate.scad>
use <write/Write.scad>
use <MCAD/screw.scad>
//use <Write.scad>

//preview[view:south,tilt:top diagonal]

///////////////////////////////User Input Section////////////////////////////

/* [Global] */

/* [Lid inside settings] */

//What custom features do you want inset into the lid of your pencil box?  Any text you wish to omit, just leave blank.
decor_inside = "none"; // [txpx:Text Left - Image Right,pxtx:Image Left - Text Right,tx:Text centered,px:Image centered,none:None]

//Choose your font
font = "write/knewave.dxf";//[write/BlackRose.dxf:Black Rose,write/braille.dxf:Braille,write/knewave.dxf:Knewave,write/Letters.dxf:Letters,write/orbitron.dxf:Orbitron]

//How tall do you want your letters?
Text_Height=5;//[4:10]

//Letter spacing you want?
Letter_Spacing=12;//[6:20]
space=Letter_Spacing/10;

//Line spacing you want?
Line_Spacing=12;//[1:40]
lspace=Line_Spacing/20;

/* [Lid inside content] */

// Load a 100x100 pixel image.(images will be stretched to fit)  Simple photos work best.  Don't forget to click the Invert Colors checkbox!
image = "image-surface.dat"; // [image_surface:100x100]

//Input up to 6 lines for inside text block:
tx1 = "Favorite 6";
tx2 = "Line Poem or";
tx3 = "Your Name";
tx4 = "Grade";
tx5 = "Classroom Number";
tx6 = "Your School";

/* [Lid outside] */

//You can cut your first and last name into the outside, on each side of the lock.
first = "";
last = "";

//Choose your font
font_out = "write/orbitron.dxf";//[write/BlackRose.dxf:Black Rose,write/braille.dxf:Braille,write/knewave.dxf:Knewave,write/Letters.dxf:Letters,write/orbitron.dxf:Orbitron]

//How tall do you want your letters?
Text_Height_out=8;//[4:10]

//Letter spacing you want?
Letter_Spacing_out=12;//[6:20]
space_out=Letter_Spacing_out/10;


/* [Customize body] */

//Set the outside length of your pencil box.
length=190;//[70:400]
//Set the outside depth of your pencil box.
depth=70;//[50:400]
//Set the total height of your pencil box.  The top of the box is set at 15mm.  Extra height is added to the body section.
height=40;//[40:150]

//Choose divider orientation.  Long is for the X direction.
long = 1;//[0,1,2]
//Short is for the Y direction.
short = 2;//[0,1,2,3]
//When you have 2 long dividers, picking yes here will put short dividers in the center section.
center = 0;//[1:Yes,0:No]

/* [Design key] */

//Do you want to draw a custom shape, use the MakerBot logo, or use letters?
key_shape = "Maker Bot Logo";//[Maker Bot Logo,Letters,Draw (Please be patient!)]

//Enter 1 or 2 characters to use for your key.
keytext = "MB";

//Do you want your pencil box, or your key to read forward?
read = 1;//[0:Key,1:Pencil Box]

//Choose your font
font_key = "write/orbitron.dxf";//[write/BlackRose.dxf:Black Rose,write/braille.dxf:Braille,write/knewave.dxf:Knewave,write/Letters.dxf:Letters,write/orbitron.dxf:Orbitron]

//To start a new shape, press the 'Revert to Default' button below the canvas to draw in the circular key top.  To revert to the "Easter" bunny?
shape = [[[49.99,0.00000000],[49.90133642,3.13952598],[49.60573507,6.26666168],[49.11436254,9.36906573],[48.42915806,12.43449436],[47.55282581,15.45084972],[46.48882429,18.40622763],[45.24135262,21.28896458],[43.81533400,24.08768371],[42.21639628,26.79133975],[40.45084972,29.38926261],[38.52566214,31.87119949],[36.44843137,34.22735530],[34.22735530,36.44843137],[31.87119949,38.52566214],[29.38926261,40.45084972],[26.79133975,42.21639628],[24.08768371,43.81533400],[21.28896458,45.24135262],[18.40622763,46.48882429],[15.45084972,47.55282581],[12.43449436,48.42915806],[9.36906573,49.11436254],[6.26666168,49.60573507],[3.13952598,49.90133642],[0.00000000,49.99],[-3.13952598,49.90133642],[-6.26666168,49.60573507],[-9.36906573,49.11436254],[-12.43449436,48.42915806],[-15.45084972,47.55282581],[-18.40622763,46.48882429],[-21.28896458,45.24135262],[-24.08768371,43.81533400],[-26.79133975,42.21639628],[-29.38926261,40.45084972],[-31.87119949,38.52566214],[-34.22735530,36.44843137],[-36.44843137,34.22735530],[-38.52566214,31.87119949],[-40.45084972,29.38926261],[-42.21639628,26.79133975],[-43.81533400,24.08768371],[-45.24135262,21.28896458],[-46.48882429,18.40622763],[-47.55282581,15.45084972],[-48.42915806,12.43449436],[-49.11436254,9.36906573],[-49.60573507,6.26666168],[-49.90133642,3.13952598],[-49.99,0.00000000],[-49.90133642,-3.13952598],[-49.60573507,-6.26666168],[-49.11436254,-9.36906573],[-48.42915806,-12.43449436],[-47.55282581,-15.45084972],[-46.48882429,-18.40622763],[-45.24135262,-21.28896458],[-43.81533400,-24.08768371],[-42.21639628,-26.79133975],[-40.45084972,-29.38926261],[-38.52566214,-31.87119949],[-36.44843137,-34.22735530],[-34.22735530,-36.44843137],[-31.87119949,-38.52566214],[-29.38926261,-40.45084972],[-26.79133975,-42.21639628],[-24.08768371,-43.81533400],[-21.28896458,-45.24135262],[-18.40622763,-46.48882429],[-15.45084972,-47.55282581],[-12.43449436,-48.42915806],[-9.36906573,-49.11436254],[-6.26666168,-49.60573507],[-3.13952598,-49.90133642],[0.00000000,-49.99],[3.13952598,-49.90133642],[6.26666168,-49.60573507],[9.36906573,-49.11436254],[12.43449436,-48.42915806],[15.45084972,-47.55282581],[18.40622763,-46.48882429],[21.28896458,-45.24135262],[24.08768371,-43.81533400],[26.79133975,-42.21639628],[29.38926261,-40.45084972],[31.87119949,-38.52566214],[34.22735530,-36.44843137],[36.44843137,-34.22735530],[38.52566214,-31.87119949],[40.45084972,-29.38926261],[42.21639628,-26.79133975],[43.81533400,-24.08768371],[45.24135262,-21.28896458],[46.48882429,-18.40622763],[47.55282581,-15.45084972],[48.42915806,-12.43449436],[49.11436254,-9.36906573],[49.60573507,-6.26666168],[49.90133642,-3.13952598],[-50.00000000,-50.00000000],[50.00000000,-50.00000000],[50.00000000,50.00000000],[-50.00000000,50.00000000]],[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99],[100,101,102,103]]]; //[draw_polygon:100x100]

/* [Customize ruler] */

//How long do you want your ruler?
rule_length = 127;//[76.2:3"-7cm,101.6:4"-10cm,127:5"-12cm,152.4:6"-15cm,177.8:7"-17cm,203.3:8"-20cm,228.7:9"-22cm]

//What type of ruler may I interest you in?
rule_type = "inpro";//[inpro:Inches and protractor,cmpro:Centimeters and protractor,incm:Inches and centimeters]

//Do you want decorations or text on your ruler?
rule_decor = "txdes";//[tx:Text,des:Design from the key,txdes:Both text and design,none:Plain and boring!]

//You can emboss two text strings onto the ruler.
firstrule = "";
lastrule = "";

//Choose your font
rulefont = "write/knewave.dxf";//[write/BlackRose.dxf:Black Rose,write/braille.dxf:Braille,write/knewave.dxf:Knewave,write/Letters.dxf:Letters,write/orbitron.dxf:Orbitron]

//How tall do you want your letters?
Text_Height_rule=5;//[4:10]

//Letter spacing you want?
Letter_Spacing_rule=10;//[6:20]
space_rule=Letter_Spacing_rule/10;

/* [Printer platform setup] */

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 300; //[50:400]
//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 150; //[50:400]

//This lists the parts that will be exported to your new thing when you click "Create Thing".  Changing this box has no effect on your items, but you can view them as they will print here.  To see an assembled collection, select the Slicing and printing tab.
part = "lid"; // [lid,body,key,ruler,lid-dualstrusion,latch-dualstrusion]


/* [Slicing and printing] */


//Input your nozzle diameter.
noz=.4;
//What layer height will you slice this at?  The thinner the better if you put an image in the top.
layer_height = 0.2;

//The lower the layer height, the more layers you can use.  More layers means more even shading for the image.
number_of_layers = 16; // [5:20]
//Do you want to include helper disks at the corners to help prevent lifting?
helper_disks=0;//[1:Yes,0:No]

/* [Hidden] */
t=.01;//used for differences
preview_tab = "";//default for when you push the create thing button.  Runs exportpart module.
wall = noz*4.1;//should give good infill to walls
x = length;
y = depth;
z = height*1;
xin = x-2*wall;
yin = y-2*wall;
zin = z-2*wall;
rout = 10;//rounded corners for pencil box
rin = rout-wall;
key = 10+wall;//radius for screw head
tol = 2*noz;//added parameter in v1.1
lckshft = 4;//added parameter in v1.1
lock = key+wall+tol;//v1.1 added changed noz to tol
lay = layer_height;
xflat = x-2*rout;//available area for text/images
yflat = y-rout-lock-lckshft-wall-tol;//available area for text/images
sq = xflat/2 > yflat ? yflat : xflat/2;//gives the smaller of the xflat/2 or yflat
sqdiff = xflat/2 > yflat ? (xflat/2-yflat)/2 : 0;//extra move for longer pencil box
min_height = layer_height*2;// base (white) will always be 2 layers thick
imageht = layer_height*number_of_layers+min_height;
lockcen = y/2-lckshft-wall-tol;//added parameter in v1.1
liddist = 15;



///////////////////////Program Begins Here///////////////////////////

display (preview_tab);//main function call.  runs customizer display based on tab selected.

module display (preview_tab = "") {
	if (preview_tab == "Lid inside settings") {
		lid();
		//latch();
		bot();
	}else if (preview_tab == "Lid outside"){
		translate([0,0,0])rotate([200,0,0]){
			lid();
			latch();	
		}	
	}else if (preview_tab == "Lid inside content"){
		translate([0,0,0])rotate([35,0,0]){
			lid();
			//latch();	
		}
	}else if (preview_tab == "Customize body"){
		body();
		bot();
	}else if (preview_tab == "Design key"){
		translate([0,y/2+key,y/2+key*2])rotate([240,0,0]){
			%lid();
			latch();	
		}
		key();
		bot();
	}else if (preview_tab == "Customize ruler"){
		ruler();
		bot();
	}else if (preview_tab == "Printer platform setup"){
		exportpart();
		bot();
	}else if (preview_tab == "Slicing and printing"){
		assembly();
	}else if (preview_tab == ""){
		exportpart (50);//Input a larger number here to smooth things out.
							 //Slows down the process, 50 is good for final, 20 for rough.
							 //The value here is used when you "create thing".
	}else{//added error check to alert the user to a preview_tab error.
		rotate([35,0,0]){
			color("red")translate([0,20,0])write("Customizer error,",font="write/knewave.dxf",h=8);
			translate([0,10,0])write("Please make sure",font="write/knewave.dxf",h=8);
			write("the tab is visible,",font="write/knewave.dxf",h=8);
			translate([0,-10,0])write("and try again.",font="write/knewave.dxf",h=8);
		}
	}
}//display

//This will orient and export all parts when "Create Thing" button is pushed.
module exportpart(fn) {
	if (part == "lid"){
		lid(fn=fn);
		latch(fn=fn);
	}else if (part == "lid-dualstrusion"){
		lid(fn=fn);
	}else if (part == "latch-dualstrusion"){
		latch(fn=fn);
	}else if (part == "body"){
		body(fn=fn);
	}else if (part == "key"){
		key(fn=fn);
	}else if (part == "ruler"){
		ruler(fn=fn);
	}else {
	}
}//exportpart

module assembly() {
	rotate([0,0,-15]){
		body();
		translate([0,y/2+18,z-15])
			rotate([90,0,0])
				translate([0,y/2+3,0]){
					lid();
					latch();
				}
		translate([x/2+key,-y/2-rule_length/3,0])
			key();
		translate([0,-y/2-rule_length/3,0])
			ruler();
	}//rotate
}//assembly

module bot(){
	build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
}//bot

////////////////////////////////Lid Section///////////////////////////

module lid(fn=20) {
	if (decor_inside == "txpx"){
		union(){
			translate([sq/2+sqdiff,-.5*rin-wall,0])
				picture();
			translate([-sq/2-sqdiff,-.5*rin-wall,0])
				txblock();
			difference(){
				boxtop(fn=fn);
				translate([sq/2+sqdiff,-.5*rin-wall,0])
					cube(sq-t,center=true);
			}
		}
	}else if (decor_inside == "pxtx"){
		union(){
			translate([-sq/2-sqdiff,-.5*rin-wall,0])
				picture();
			translate([sq/2+sqdiff,-.5*rin-wall,0])
				txblock();
			difference(){
				boxtop(fn=fn);
				translate([-sq/2-sqdiff,-.5*rin-wall,0])
					cube(sq-t,center=true);
			}
		}
	}else if (decor_inside == "px"){
		union(){
			translate([0,-.5*rin-wall,0])
				picture();
			difference(){
				boxtop(fn=fn);
				translate([0,-.5*rin-wall,0])
					cube(sq-t,center=true);
			}
		}
	}else if (decor_inside == "tx"){
		union(){
			translate([0,-.5*rin-wall,0])
				txblock();
			boxtop(fn=fn);
		}
	}else{
		boxtop(fn=fn);
	}

}//lid

module boxtop(fn=20) {
	difference() {//v1.1 revised entire section for tolerance. added new parameters.
		union() {
			translate([0,lockcen,0])
				cylinder(r=lock,h=liddist/2,$fn=fn);
			translate([0,lockcen,liddist/2])
				cylinder(r1=lock,r2=lckshft+wall+tol,h=liddist/2,$fn=fn);//builds the lock externals
			hinge(1,15,0,fn);//add hinge
			if (preview_tab == "Lid inside content" || preview_tab == "Lid outside"){
				%case(liddist,fn);//15mm slice for the lid of the pencil box
				translate([-sq/2-sqdiff,yflat/2+wall,0])
					rotate([180,0,0])
						write(first,font=font_out,t=wall,h=Text_Height_out,space=space_out,center=true);
				translate([sq/2+sqdiff,yflat/2+wall,0])
					rotate([180,0,0])
						write(last,font=font_out,t=wall,h=Text_Height_out,space=space_out,center=true);
			}
			difference(){//add case with decor
				case(liddist,fn);//15mm slice for the lid of the pencil box
				translate([-sq/2-sqdiff,yflat/2+wall,0])
					rotate([180,0,0])
						write(first,font=font_out,t=wall,h=Text_Height_out,space=space_out,center=true);
				translate([sq/2+sqdiff,yflat/2+wall,0])
					rotate([180,0,0])
						write(last,font=font_out,t=wall,h=Text_Height_out,space=space_out,center=true);
			}
		}
		union() {
			translate([0,lockcen,-t])
				cylinder(r=key+tol,h=liddist/10+t,$fn=fn);
			translate([0,lockcen,liddist/10])
				cylinder(r1=key+tol,r2=lckshft+tol,h=4*liddist/10,$fn=fn);
			translate([0,lockcen,5*liddist/10])
				cylinder(r=lckshft+tol,h=liddist/10,$fn=fn);
			translate([0,lockcen,6*liddist/10])
				cylinder(r1=key/2+tol,r2=lckshft+tol/2,h=4*liddist/10,$fn=fn);
		}//subtracts the lock hollows and creates ridges to keep the latch in place
	}
}//boxtop

module latch(fn=20) {
	difference(){
		union(){
			translate([0,lockcen,0])
				cylinder(r=key,h=liddist/10,$fn=fn);
			translate([0,lockcen,t])
				cylinder(r=lckshft,h=liddist+10-t,$fn=fn);
			translate([0,lockcen,liddist/10])
				cylinder(r1=key,r2=lckshft,h=4*liddist/10,$fn=fn);
			translate([0,lockcen,6*liddist/10])
				cylinder(r1=lckshft,r2=lckshft+1,h=liddist/10,$fn=fn);
			translate([0,lockcen,7*liddist/10])
				cylinder(r1=lckshft+1,r2=lckshft,h=2*liddist/10,$fn=fn);
			translate([0,lockcen,24])
				ball_groove2(4, -8, lckshft*2, 1,fn*4);//creates the screw threads
		}
		translate([0,lockcen,0])
			rotate([0,0,180])
				design(noz*2,fn);//cuts the design into the top of the latch
	}
}//latch

module picture() {
	union() {
		// 
		difference(){
    		translate([0,0,min_height])
				scale([sq/99,sq/99,imageht-min_height])
					surface(file=image,center=true,convexity=5);
		// - Cut off unwanted bottom portion
			translate([0,0,-imageht+min_height-t])
				linear_extrude(height=imageht-min_height+t)
					square(sq+t,center=true);
		// - Slice surface so it 2*noz wide slits for <100% printing
			for (i=[-sq/2+noz*2:noz*2:sq/2])
				translate([i,0,imageht/2])
					cube([t,sq+2,imageht+t],center=true);
		} // end difference
		// Make the white base (no frame)
		linear_extrude(height=min_height)square(sq,center=true);
	} // end union
}//picture

module txblock(){//v1.3 I moved the text down to be on the lid.
	translate([0,Text_Height*5*lspace,wall-t])
		write(tx1,font=font,t=wall,h=Text_Height,space=space,center=true);
	translate([0,Text_Height*3*lspace,wall-t])
		write(tx2,font=font,t=wall,h=Text_Height,space=space,center=true);
	translate([0,Text_Height*lspace,wall-t])
		write(tx3,font=font,t=wall,h=Text_Height,space=space,center=true);
	translate([0,-Text_Height*lspace,wall-t])
		write(tx4,font=font,t=wall,h=Text_Height,space=space,center=true);
	translate([0,-Text_Height*3*lspace,wall-t])
		write(tx5,font=font,t=wall,h=Text_Height,space=space,center=true);
	translate([0,-Text_Height*5*lspace,wall-t])
		write(tx6,font=font,t=wall,h=Text_Height,space=space,center=true);
}//txblock

module hinge(type,tall,rz,fn=20) {
	rotate([0,0,rz]){
		for (i=[0:1]){
			mirror([i,0,0]){
				if (type == 1){
					translate([sq/2+sqdiff,-y/2+wall/2-t,tall-6]){
						union(){
							hull(){
								cube([6-tol/2,wall,2],center=true);
								translate([0,-3-wall/2,6])
									rotate([0,90,0])
										cylinder(r=3,h=6-tol/2,center=true,$fn=fn);
							}
							translate([3-tol/4,-3-wall/2,6])
								rotate([0,90,0])
									cylinder(r1=3,r2=0,h=2,$fn=fn);
						}
					}
				}else{
					translate([sq/2+sqdiff+6,-y/2+wall/2-t,tall-6]){
						difference(){
							hull(){
								cube([6,wall,2],center=true);
								translate([0,-3-wall/2,6])
									rotate([0,90,0])
										cylinder(r=3,h=6,center=true,$fn=fn);
							}//hull
							translate([-3-t,-3-wall/2,6])
								rotate([0,90,0])
									cylinder(r1=3,r2=0,h=2+t,$fn=fn);
						}//difference
					}//translate
				}//if-else
			}//mirror
		}//for
	}//rotate
}//hinge

//////////////////////////////////////Body Section/////////////////////////

module body(fn=20) {
	difference(){
		union(){
			case(z-15,fn);
			hinge(0,z-15,180,fn);
			translate([0,-y/2+5.75+wall,(z-10)/2+t])
				cube([13,12,z-20-2*t],center=true);
			intersection(){
				translate([0,-y/2+5.75+wall,5])
					cube([13,12,10],center=true);
				translate([0,-y/2+rout+wall,rout/1.5])
					rotate([0,90,0])
						cylinder(r=rout,h=13,center=true,$fn=fn);			
			}
			if (long>0){
				translate([0,-(long-1)*yin/6,0]){
					for (i=[1:long])
						translate([0,(i-1)*yin/3,0])
							divider(xin,z-15,2,fn);
				}
				if (short>0){
					translate([-(short-1)*xin/6,-yin/(long+1)*(long/2),0])
						for (i=[1:short])
							translate([(i-1)*xin/3,0,0])
								rotate([0,0,90])
									divider(yin/(long+1),z-15,1,fn);
				}
			}
			if (long==2 && center==1 && short>0){
				translate([-(short-1)*xin/6,0,0])
						for (i=[1:short])
							translate([(i-1)*xin/3,0,0])
								rotate([0,0,90])
									divider(yin/(long+1),z-15,0,fn);
			}
			if (long==0 && short>0){
				translate([-(short-1)*xin/6,0,0])
						for (i=[1:short])
							translate([(i-1)*xin/3,0,0])
								rotate([0,0,90])
									divider(yin/(long+1),z-15,2,fn);
			}
		}
		catch(z-15,fn);
	}
}//body

module case(tall,fn=20) {
	union(){
		translate([xin/2-5,yin/2-5,0])disk(10,fn);
		translate([xin/2-5,-yin/2+5,0])disk(10,fn);
		translate([-xin/2+5,yin/2-5,0])disk(10,fn);
		translate([-xin/2+5,-yin/2+5,0])disk(10,fn);
		translate([0,0,z/2]){
			difference(){
				minkowski(){
					cube([x-rout*2-1,y-rout*2-1,z-rout*3.5], center=true);
					rotate([90,0,0])
						cylinder(r=rout,h=1,center=true,$fn=fn);
					rotate([0,90,0])
						cylinder(r=rout,h=1,center=true,$fn=fn);
				}//minkowski
				translate([0,0,-z])
					cube([x,y,z],center=true);
				translate([-t,-t,tall])
					cube([4*t+x,4*t+y,z],center=true);
				difference(){
					minkowski(){
						cube([xin-rin*2-1,yin-rin*2-1,zin-rin*3.5], center=true);
						rotate([90,0,0])
							cylinder(r=rin,h=1,center=true,$fn=fn);
						rotate([0,90,0])
							cylinder(r=rin,h=1,center=true,$fn=fn);
					}//minkowski
					translate([0,0,-zin])
						cube([xin,yin,zin],center=true);
					translate([0,0,zin])
						cube([xin,yin,zin],center=true);
				}//difference
			}//difference
		}//translate
	}
}//case

module catch(zht,fn=20){
	union(){
		translate([0,-lockcen,zht-11])
			cylinder(r=lckshft+tol/2,h=12,$fn=fn);
		translate([0,-lockcen,zht+.5])
			rotate([0,0,125])
				ball_groove2(4, -10.5, lckshft*2, 1.2,fn*4);//creates the screw threads	
	}
}//catch

module divider(wide,deep,rounds,fn){
	hull(){
		translate([-wide/2,-wall/2,rin])
			cube([wide+t,wall,deep-rin-t]);//top portion
		if (rounds>0){
			translate([-wide/2+rin-t,wall/2,rin+wall-t])
				rotate([90,0,0])
					cylinder(r=rin,h=wall,$fn=fn);
			if (rounds>1){
			translate([wide/2-rin+t,wall/2,rin+wall-t])
				rotate([90,0,0])
					cylinder(r=rin,h=wall,$fn=fn);
			}else{
			translate([wide/2-rin,-wall/2,wall-t])
				cube([rin,wall,rin+t]);
			}
		}else{//square bottoms
		translate([wide/2-rin,-wall/2,wall-t])
			cube([rin,wall,rin+t]);
		translate([-wide/2,-wall/2,wall-t])
			cube([rin,wall,rin+t]);
		}
	}
}//divider

///////////////////////////////Shapes//////////////////////////

mshape=[[[10.00000000,0.00000000],[9.92114701,1.25333234],[9.68583161,2.48689887],[9.29776486,3.68124553],[8.76306680,4.81753674],[8.09016994,5.87785252],[7.28968627,6.84547106],[6.37423990,7.70513243],[5.35826795,8.44327926],[4.25779292,9.04827052],[3.09016994,9.51056516],[1.87381315,9.82287251],[0.62790520,9.98026728],[-0.62790520,9.98026728],[-1.87381315,9.82287251],[-3.09016994,9.51056516],[-4.25779292,9.04827052],[-5.35826795,8.44327926],[-6.37423990,7.70513243],[-7.28968627,6.84547106],[-8.09016994,5.87785252],[-8.76306680,4.81753674],[-9.29776486,3.68124553],[-9.68583161,2.48689887],[-9.92114701,1.25333234],[-10.00000000,0.00000000],[-9.92114701,-1.25333234],[-9.68583161,-2.48689887],[-9.29776486,-3.68124553],[-8.76306680,-4.81753674],[-8.09016994,-5.87785252],[-7.28968627,-6.84547106],[-6.37423990,-7.70513243],[-5.35826795,-8.44327926],[-4.25779292,-9.04827052],[-3.09016994,-9.51056516],[-1.87381315,-9.82287251],[-0.62790520,-9.98026728],[0.62790520,-9.98026728],[1.87381315,-9.82287251],[3.09016994,-9.51056516],[4.25779292,-9.04827052],[5.35826795,-8.44327926],[6.37423990,-7.70513243],[7.28968627,-6.84547106],[8.09016994,-5.87785252],[8.76306680,-4.81753674],[9.29776486,-3.68124553],[9.68583161,-2.48689887],[9.92114701,-1.25333234],[8.65021579,0.00000000],[8.58200625,1.08415952],[8.37845335,2.15122119],[8.04276724,3.18435682],[7.58024188,4.16727324],[6.99817158,5.08446927],[6.30573593,5.92148018],[5.51385506,6.66510582],[4.63501740,7.30361875],[3.68308275,7.82694925],[2.67306368,8.22684409],[1.62088881,8.49699668],[0.54315154,8.63314656],[-0.54315154,8.63314656],[-1.62088881,8.49699668],[-2.67306368,8.22684409],[-3.68308275,7.82694925],[-4.63501740,7.30361875],[-5.51385506,6.66510582],[-6.30573593,5.92148018],[-6.99817158,5.08446927],[-7.58024188,4.16727324],[-8.04276724,3.18435682],[-8.37845335,2.15122119],[-8.58200625,1.08415952],[-8.65021579,0.00000000],[-8.58200625,-1.08415952],[-8.37845335,-2.15122119],[-8.04276724,-3.18435682],[-7.58024188,-4.16727324],[-6.99817158,-5.08446927],[-6.30573593,-5.92148018],[-5.51385506,-6.66510582],[-4.63501740,-7.30361875],[-3.68308275,-7.82694925],[-2.67306368,-8.22684409],[-1.62088881,-8.49699668],[-0.54315154,-8.63314656],[0.54315154,-8.63314656],[1.62088881,-8.49699668],[2.67306368,-8.22684409],[3.68308275,-7.82694925],[4.63501740,-7.30361875],[5.51385506,-6.66510582],[6.30573593,-5.92148018],[6.99817158,-5.08446927],[7.58024188,-4.16727324],[8.04276724,-3.18435682],[8.37845335,-2.15122119],[8.58200625,-1.08415952],[1.03922016,-4.98408889],[1.03922016,3.94230886],[3.17470471,3.94230886],[3.17470471,-4.98408889],[3.22556776,-5.30522553],[3.37317807,-5.59492707],[3.60308651,-5.82483552],[3.89278806,-5.97244583],[4.21392469,-6.02330887],[4.53506133,-5.97244583],[4.82476287,-5.82483552],[5.05467132,-5.59492707],[5.20228163,-5.30522553],[5.25314468,-4.98408889],[5.25313781,3.48758619],[5.12903071,4.27116759],[4.76885787,4.97804659],[4.20787552,5.53902894],[3.50099653,5.89920177],[2.71741513,6.02330887],[-2.71741477,6.02330887],[-3.50099653,5.89920177],[-4.20787552,5.53902894],[-4.76885752,4.97804659],[-5.12903035,4.27116759],[-5.25313746,3.48758619],[-5.25314432,-4.98408889],[-5.20228128,-5.30522553],[-5.05467097,-5.59492707],[-4.82476252,-5.82483552],[-4.53506098,-5.97244583],[-4.21392434,-6.02330887],[-3.89278771,-5.97244583],[-3.60308616,-5.82483552],[-3.37317771,-5.59492707],[-3.22556740,-5.30522553],[-3.17470436,-4.98408889],[-3.17470436,3.94230886],[-1.03921980,3.94230886],[-1.03921980,-4.98408889],[-0.98835676,-5.30522553],[-0.84074645,-5.59492707],[-0.61083800,-5.82483552],[-0.32113646,-5.97244583],[0.00000018,-6.02330887],[0.32113681,-5.97244583],[0.61083836,-5.82483552],[0.84074680,-5.59492707],[0.98835711,-5.30522553]],[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49],[50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99],[100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148]]];

eggshape = [[[-30.607849,-48.473831],[-38.714745,-48.950043],[-40.559818,-48.486679],[-42.201851,-47.493645],[-47.306175,-42.282654],[-50.067959,-38.508476],[-47.496841,-39.749046],[-46.892071,-39.806171],[-46.653542,-39.556297],[-49.260830,-36.213120],[-49.681732,-34.902710],[-49.585598,-33.782043],[-49.138451,-33.165283],[-48.672112,-33.207165],[-46.200596,-35.658916],[-47.279457,-33.120216],[-47.321926,-32.230251],[-46.990898,-31.375122],[-45.878410,-30.094749],[-43.224831,-28.013985],[-42.217957,-27.615326],[-41.118553,-27.667067],[-40.805717,-27.398746],[-40.440659,-25.661360],[-39.173859,-13.378041],[-37.786060,-6.545761],[-36.585690,-3.203835],[-34.921036,-0.177278],[-32.697136,2.334522],[-31.352158,3.341671],[-28.276741,4.879042],[-24.862782,5.878342],[-21.320715,6.457005],[-16.227745,6.793123],[-6.193724,6.651176],[-3.917368,6.182596],[1.149520,4.628635],[3.496422,4.354591],[5.367534,4.861082],[8.187830,6.665401],[10.588829,7.390333],[11.411912,7.954811],[11.835903,9.095350],[12.399237,12.947439],[13.889902,16.162262],[13.933737,17.683546],[13.316607,19.065596],[11.898010,21.208532],[6.859921,27.302176],[5.617778,29.462534],[5.115950,31.361303],[3.388903,42.964180],[3.273381,46.066513],[3.726890,48.114418],[4.978456,49.315399],[7.242655,49.967201],[8.609360,50.079552],[9.707384,49.859634],[11.739238,48.611275],[14.175842,46.044868],[16.663437,42.226387],[17.125431,47.022690],[17.457367,48.010414],[17.989151,48.348061],[19.181324,47.905319],[24.528868,44.299988],[25.586594,43.349907],[26.602041,41.795021],[27.508392,39.332878],[29.795576,26.542974],[30.282230,24.476656],[31.117352,22.414083],[31.720629,21.625368],[32.642006,21.057058],[35.131134,20.683912],[36.914520,20.059973],[39.043831,18.184668],[42.450657,14.071085],[46.617176,8.405781],[48.564854,5.175398],[49.817593,2.084951],[50.067959,0.425432],[49.656380,-0.983798],[48.150597,-2.837172],[45.817619,-4.786176],[42.303886,-6.914544],[36.506889,-8.046309],[35.342590,-8.523187],[34.626579,-9.248261],[34.336266,-10.490269],[34.565552,-12.031119],[35.052368,-13.404231],[37.089733,-17.042198],[37.317879,-18.115067],[37.155357,-19.071182],[35.604301,-21.320902],[33.913990,-23.043991],[33.883816,-28.314064],[33.082306,-30.108660],[31.550901,-32.176041],[30.204401,-33.504837],[26.342428,-35.397213],[25.570063,-36.226906],[25.784672,-37.377975],[26.657942,-38.691196],[35.016315,-47.244415],[36.307613,-48.865204],[36.517559,-49.673759],[35.642605,-50.079552],[30.526541,-50.070801],[27.432796,-49.786285],[24.770382,-49.194931],[21.059244,-47.649162],[13.547039,-43.090836],[12.276370,-42.541962],[10.688703,-42.258522],[3.786492,-43.914528],[2.470330,-44.603432],[2.196272,-45.124454],[2.270218,-46.117500],[3.513528,-49.225983],[3.376098,-49.617065],[2.794866,-49.836327],[-5.766325,-50.020004],[-18.879635,-49.768524],[-25.214447,-49.130280],[-29.151905,-47.714996],[-30.600498,-48.472359]],[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127]]];

///////////////////////////////Other Parts//////////////////////////

module key(fn=20) {
	union(){
		difference(){
			union(){
				cylinder(r1=4+wall,r2=10,h=25,$fn=fn);
				translate([0,0,25-wall])cylinder(r=10,h=wall,$fn=fn);
				for (i=[0:20:340])rotate([0,0,i]){
					translate([1+4+wall,0,12.5])
					rotate([0,15,0])cylinder(r=2,h=24,center=true,$fn=fn);
				}
				disk(10,fn);
			}
			translate([0,0,-t])cylinder(r1=4,r2=3.7,h=20,$fn=fn);
		}
		translate([0,0,25])design(0,fn);
	}
}//key

module design (dist,fn){
rotate([0,180*read,0]){
	if(key_shape == "Draw (Please be patient!)"){
		difference(){
			scale([1/5,1/5])outset(shape,dist,fn);
			difference(){
				cube([20+t+dist,20+t+dist,1.5*wall],center=true);
				cylinder(r=9.99-dist,h=1.5*(wall+t),center=true,$fn=100);
			}
		}
	}else if(key_shape == "Maker Bot Logo"){
		outset(mshape,dist,fn);
	}else if(key_shape == "Letters"){
		if (keytext == "Easter"){
			scale([1/6.5,1/6.5])outset(eggshape,dist,fn);
		}else if (keytext != "Easter" && keytext != ""){
			translate([0.85,0,0]){
				minkowski(){
					write(keytext,font=font_key,t=1.5*wall,h=10,space=1.2,center=true);
					cube([dist,dist,t],center=true);
				}
			}
		}else {
			write("Easter",font=font_key,t=1.5*wall,h=3,space=1.2,center=true);
		}
	}
}
}//design

module outset(shape,dist,fn){
	minkowski(){
		linear_extrude(height=1.5*wall,center=true,convexity=10)
			polygon(points=shape[0], paths=shape[1]);
		cube([dist,dist,t],center=true);
	}
}//outset

rule = [[[2.82842712,3.17157288],[2.35114101,2.76393202],[1.81596200,2.43597390],[1.23606798,2.19577393],[0.62573786,2.04924664],[0.,2.],[-0.62573786,2.04924664],[-1.23606798,2.19577393],[-1.81596200,2.43597390],[-2.35114101,2.76393202],[-2.82842712,3.17157288],[-15.,1.],[-15.,0.],[15.,0.],[15.,1.]],[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]]];

module ruler(fn=20){
	if (rule_type == "inpro"){
		translate([0,-rule_length/4,0]){
			union(){
				pro(fn);
				inch();
				deg();
			}
		}
	}else if (rule_type == "cmpro"){
		translate([0,-rule_length/4,0]){
			union(){
				pro(fn);
				cm();
				deg();
			}
		}
	}else if (rule_type == "incm"){
		union(){
			straight();
			translate([0,-15,0])
				inch();
			translate([0,15,0])
				cm(180);
		}
	}

}//ruler

module straight(){
	union(){
		translate([-rule_length/2-wall/2,0,0])
			rotate([90,0,90])
				linear_extrude(height=rule_length+wall,convexity=10)
					polygon(points=rule[0], paths=rule[1]);
		if (rule_decor == "tx" || rule_decor == "txdes"){
			translate([-rule_length/4,0,1.6])
				cube([len(firstrule)*Text_Height_rule*space_rule,6,3.2],center=true);
			translate([-rule_length/4,0,3.5])
				write(firstrule,font=rulefont,t=wall,h=Text_Height_rule,space=space_rule,center=true);
			translate([rule_length/4,0,1.6])
				cube([len(lastrule)*Text_Height_rule*space_rule,6,3.2],center=true);
			translate([rule_length/4,0,3.5])
				write(lastrule,font=rulefont,t=wall,h=Text_Height_rule,space=space_rule,center=true);
		}
		translate([rule_length/2,-15,0])
			disk(10);
		translate([-rule_length/2,-15,0])
			disk(10);
		translate([rule_length/2,15,0])
			disk(10);
		translate([-rule_length/2,15,0])
			disk(10);
	}
}//straight

module pro(fn=20){
	difference(){
		union(){
			hull(){
				difference(){
					cylinder(r=rule_length/2+wall,h=wall,$fn=2*fn);
					translate([0,-rule_length/2-wall-t/2,0])
						cube(rule_length+2*wall+t,center=true);
				}
				difference(){
					cylinder(r=rule_length/2+wall-wall/.1763,h=2*wall,$fn=2*fn);
					translate([0,-rule_length/2-wall-t+2*wall/.1763/2,0])
						cube(rule_length+2*wall+t,center=true);
				}//creates a 10 degree bevel for the tick marks
			}
			if (rule_decor == "tx" || rule_decor == "txdes"){
				translate([-(rule_length/2-wall/.1763)/2,6+2*wall/.1763/2,2*wall])
					write(firstrule,font=rulefont,t=wall,h=Text_Height_rule,space=space_rule,center=true);
				translate([(rule_length/2-wall/.1763)/2,6+2*wall/.1763/2,2*wall])
					write(lastrule,font=rulefont,t=wall,h=Text_Height_rule,space=space_rule,center=true);
			}
			translate([rule_length/2,0,0])
				disk(10);
			translate([-rule_length/2,0,0])
				disk(10);
		}
		if (rule_decor == "des" || rule_decor == "txdes"){
			translate([0,rule_length/4,2*wall])
				mirror([1,0,0])
					design(noz*2,fn);
		}
		translate([0,0,wall/4])
			rotate([0,0,45])
				cube(wall/2+t,center=true);
	}
}//pro

module deg(){
	rotate([0,0,170])protick(2);
	rotate([0,0,175])protick(4);
	for (i=[15:15:175]){
		rotate([0,0,i])protick(6,str(i));
		rotate([0,0,i-5])protick(4);
		rotate([0,0,i-10])protick(2);
	}
}//deg

module inch(rz=0){
	rotate([0,0,rz]){
		translate([-rule_length/2,0,0]){
			tick(6);
			translate([rule_length,0,0])tick(6);
			translate([rule_length-6.35,0,0])tick(2);
			translate([rule_length-12.7,0,0])tick(3.5);
			translate([rule_length-19.05,0,0])tick(2);
			for (i=[25.4:25.4:rule_length-25.4]){
				translate([i,0,0])tick(6,str(i/25.4));
				translate([i-6.35,0,0])tick(2);
				translate([i-12.7,0,0])tick(3.5);
				translate([i-19.05,0,0])tick(2);
			}
		}
	}
}//inch

module cm(rz=0){
	rotate([0,0,rz]){
		translate([-rule_length/2,0,0]){
			tick(6);
			for (i=[10:10:rule_length]){
				translate([i,0,0])tick(5,str(i/10));
				translate([i-5,0,0])tick(2.5);
			}
		}
	}
}//cm

module protick (lng,text=""){
	translate([rule_length/2-lng/2+wall,0,1.5*wall-t])
		rotate([0,10,0])
			cube([lng,wall/2,wall],center=true);
	translate([rule_length/2-lng/2-4*wall,3,1.5*wall-t])
		//rotate([0,10,0])
			rotate([0,0,-90])
				write(text,font=rulefont,t=wall,h=5);
}//protick

module tick(lng,text=""){
	translate([-wall/4,0,wall/2-t])
		rotate([10,0,0])
			cube([wall/2,lng,wall]);
	//translate([-2*wall,3,wall/1.5-t])
	translate([-wall/4,0,1.5*wall-t])
		//rotate([10,0,0])
			translate([-.75*len(text),lng+wall/2,0])
				write(text,font=rulefont,t=wall,h=5);
}//tick

module disk(rad,fn=20){
	translate([0,0,layer_height/2])
		cylinder(h=layer_height*helper_disks,r=rad,center=true,$fn=fn);
}//disk