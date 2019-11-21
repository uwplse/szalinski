// Helical Gears
// Catarina Mota
// catarinamfmota@gmail.com
// Creative Commons Attribution Share Alike
// 20091123


//GEAR PARAMETERS
doubleHelical=1; //int: 0=no, 1=yes (will make the gear 2x taller)

gearHeight=7; //gear depth

pitchDiam=45; //pitch diameter

shaftDiam=5; //shaft diameter

//TEETH PARAMETERS
teethNum=30; //number of teeth (int)

addendum=1;

dedendum=1;

toothWidth=1;

angle=30; //positive=right, negative=left

//CENTER SHAPE PARAMETERS
centerShape=1; //int: solid=1, star=2, circle=3

starNum=6; //number of lines for star shape (int)
starWidth=2; //width of star lines

circleNum=7; //number of circles (int)
circleDiam=7; //diameter of circles

//CENTER CIRCLE PARAMETERS
extrudeOut=0; //int: 0=no, 1=yes
extrudeOutHeight=3;
extrudeOutWidth=7; //in relationship to shaft

extrudeIn=1; //int: 0=no, 1=yes
//extrudeInDiam=pitchDiam/2-dedendum*2;
extrudeInRad=pitchDiam/2-dedendum*2;
extrudeInHeight=5;

//ROME (extrudeIn must be set to 0)
rome=0; //int: 0=no, 1=yes
romeDiam=pitchDiam/2; //pitch diameter for top gear
romeHeight=gearHeight; //top gear height
romeTeeth=teethNum*2/3;
romeAdd=2; //top gear addendum
romeDed=2; //top gear dedendum
romeToothWidth=2; //teeth width for top gear
romeAngle=5; //rotate top gear (angle)

//----------------------

gear();

//----------------------

//TOOTH
module tooth(heightGear, diamPitch) {

	toothHeight=addendum+dedendum*2;

	union(){
		translate([0,toothHeight/2,0]) rotateTooth(1);
		if (doubleHelical==1){
			translate([0,toothHeight/2,-heightGear+0.1]) rotateTooth(-1);
		}
	}

	module rotateTooth(direction){
		difference(){
			rotate([0,direction*angle,0])
			box(toothWidth,toothHeight,heightGear*1.5);

			translate([0,0,heightGear*0.75+dedendum/2])
			box(heightGear,toothHeight+0.5,dedendum+heightGear/2);

			translate([0,0,-heightGear*0.75-dedendum/2])
			box(heightGear,toothHeight+0.5,dedendum+heightGear/2);
		}
	}
}



//HELICAL
module helical(numTeeth, diamPitch, heightGear) {
	rootRad=diamPitch/2-dedendum;
	difference(){
	for (i = [1:numTeeth]) {
		translate([sin(360*i/numTeeth)*(rootRad-dedendum), cos(360*i/numTeeth)*(rootRad-dedendum), 0 ]){
			rotate([0,0,-360*i/numTeeth]) tooth(heightGear, diamPitch);
		}
	}
	translate([0,0,-gearHeight/2-1]) cylinder(heightGear+2, diamPitch/2-dedendum, diamPitch/2-dedendum);
	}
}

//SOLID
module solid(heightGear, diamPitch) {
	rootRad=diamPitch/2-dedendum;
	translate([0,0,-(heightGear*doubleHelical)+0.1*doubleHelical])
	cylinder(heightGear+(heightGear-0.1)*doubleHelical, rootRad, rootRad);
}

//STAR
module star() {
	starAngle=360/starNum;
	rootRad=diamPitch/2-dedendum;
	union(){
		for (s=[1:starNum]){
			translate([0,0,gearHeight/2-(gearHeight/2*doubleHelical)]){
				rotate([0, 0, s*starAngle]) dislocateBox(starWidth, (pitchDiam/2-dedendum*2)/2, gearHeight+(gearHeight*doubleHelical));
			}
		}
		translate ([0,0,-gearHeight*doubleHelical])
		tube(gearHeight+(gearHeight*doubleHelical), pitchDiam/2-dedendum, starWidth);
		translate ([0,0,-gearHeight*doubleHelical]){
			tube(gearHeight+(gearHeight*doubleHelical), pitchDiam/4+dedendum, starWidth);
			//cylinder(gearHeight+(gearHeight*doubleHelical), pitchDiam/4+dedendum, pitchDiam/4+dedendum);
		}
		translate([0,0,-gearHeight*doubleHelical])
		cylinder(gearHeight+(gearHeight*doubleHelical), shaftDiam/2+starWidth, shaftDiam/2+starWidth);
	}
}

//CIRCLE
module circle() {
	rootRad=pitchDiam/2-dedendum;
	difference(){
		solid(gearHeight-0.1*doubleHelical, pitchDiam);
		for (c=[1:circleNum]){
			translate([sin(360*c/circleNum)*(rootRad/2+shaftDiam/2), cos(360*c/circleNum)*(rootRad/2+shaftDiam/2), -gearHeight*doubleHelical]){
				cylinder(gearHeight+gearHeight*doubleHelical, circleDiam/2, circleDiam/2);
			}
		}
	}
}

//ROME
module romeGear(){
	translate([0,0,romeHeight/2+gearHeight]){
		rotate([0,0,romeAngle]){
			union(){
				helical(romeTeeth, romeDiam, romeHeight);
				translate ([0,0,-romeHeight/2]) solid(romeHeight, romeDiam);
			}
		}
	}
}

//GEAR
module gear(){

	difference () {

		union() {
			translate([0,0,gearHeight/2]) helical(teethNum, pitchDiam, gearHeight);

			if (centerShape==1)  solid(gearHeight, pitchDiam);

			if (centerShape==2) star();

			if (centerShape==3) circle();

			if (rome==1) romeGear();

			//extrudeOut around shaft
			if (extrudeOut==1) {
translate([0,0,-gearHeight*doubleHelical+0.1*doubleHelical])	cylinder(gearHeight-(extrudeInHeight*extrudeIn)+extrudeOutHeight+romeHeight*rome+gearHeight*doubleHelical-0.1*doubleHelical, extrudeOutWidth/2+shaftDiam/2, extrudeOutWidth/2+shaftDiam/2);
			}

		}

	//extrudeIn around shaft
		if (extrudeIn==1) {
			difference(){
				translate([0,0,gearHeight-extrudeInHeight+0.1*doubleHelical]) cylinder(extrudeInHeight, extrudeInRad, extrudeInRad);
				cylinder(gearHeight+extrudeOutHeight, (extrudeOutWidth+shaftDiam)/2*extrudeOut, (extrudeOutWidth+shaftDiam)/2*extrudeOut);
			}
		}

	//shaft
	translate([0,0,-gearHeight*doubleHelical]) cylinder(gearHeight+extrudeOutHeight+romeHeight+(gearHeight*doubleHelical), shaftDiam/2, shaftDiam/2);
	}
}

//----------------------

//SILLY WAY TO GET AROUND ROTATION AXIS

module dislocateBox(xBox, yBox, zBox){
	translate([0,yBox,0]){
		difference(){
			box(xBox, yBox*2, zBox);
			translate([-xBox,0,0]) box(xBox, yBox*2, zBox);
		}
	}
}

//----------------------

module box(w,h,d) {
	scale ([w,h,d]) cube(1, true);
}

module hollowBox(w,h,d,wall){
	difference(){
		box(w,h,d);
		box(w-wall*2,h-wall*2,d);
	}
}

module roundedBox(w,h,d,f){
	difference(){
		box(w,h,d);
		translate([-w/2,h/2,0]) cube(w/(f/2),true);
		translate([w/2,h/2,0]) cube(w/(f/2),true);
		translate([-w/2,-h/2,0]) cube(w/(f/2),true);
		translate([w/2,-h/2,0]) cube(w/(f/2),true);
	}
	translate([-w/2+w/f,h/2-w/f,-d/2]) cylinder(d,w/f, w/f);
	translate([w/2-w/f,h/2-w/f,-d/2]) cylinder(d,w/f, w/f);
	translate([-w/2+w/f,-h/2+w/f,-d/2]) cylinder(d,w/f, w/f);
	translate([w/2-w/f,-h/2+w/f,-d/2]) cylinder(d,w/f, w/f);
}

module cone(height, radius) {
		cylinder(height, radius, 0);
}

module oval(w,h,d) {
	scale ([w/100, h/100, 1]) cylinder(d, 50, 50);
}

module tube(height, radius, wall) {
	difference(){
		cylinder(height, radius, radius);
		cylinder(height, radius-wall, radius-wall);
	}
}

module ovalTube(w,h,d,wall) {
	difference(){
		scale ([w/100, h/100, 1]) cylinder(d, 50, 50);
		scale ([w/100, h/100, 1]) cylinder(d, 50-wall, 50-wall);
	}
}


module tearDrop(diam) {
	f=0.52;
	union(){
		translate([0,diam*0.70,depth/2]) rotate([0,0,135]) rightTriangle(diam*f,diam*f, depth);
		cylinder(depth,diam/2,diam/2);
	}
}

module hexagon(height, depth) {
	boxWidth=height/1.75;
		union(){
			box(boxWidth, height, depth);
			rotate([0,0,60]) box(boxWidth, height, depth);
			rotate([0,0,-60]) box(boxWidth, height, depth);
		}
}

module octagon(height, depth) {
	intersection(){
		box(height, height, depth);
		rotate([0,0,45]) box(height, height, depth);
	}
}

module dodecagon(height, depth) {
	intersection(){
		hexagon(height, depth);
		rotate([0,0,90]) hexagon(height, depth);
	}
}

module hexagram(height, depth) {
	boxWidth=height/1.75;
	intersection(){
		box(height, boxWidth, depth);
		rotate([0,0,60]) box(height, boxWidth, depth);
	}
	intersection(){
		box(height, boxWidth, depth);
		rotate([0,0,-60]) box(height, boxWidth, depth);
	}
	intersection(){
		rotate([0,0,60]) box(height, boxWidth, depth);
		rotate([0,0,-60]) box(height, boxWidth, depth);
	}
}

module rightTriangle(adjacent, opposite, depth) {
	difference(){
		translate([-adjacent/2,opposite/2,0]) box(adjacent, opposite, depth);
		translate([-adjacent,0,0]){
			rotate([0,0,atan(opposite/adjacent)]) dislocateBox(adjacent*2, opposite, depth);
		}
	}
}

module equiTriangle(side, depth) {
	difference(){
		translate([-side/2,side/2,0]) box(side, side, depth);
		rotate([0,0,30]) dislocateBox(side*2, side, depth);
		translate([-side,0,0]){
			rotate([0,0,60]) dislocateBox(side*2, side, depth);
		}
	}
}

module 12ptStar(height, depth) {
	starNum=3;
	starAngle=360/starNum;
	for (s=[1:starNum]){
		rotate([0, 0, s*starAngle]) box(height, height, depth);
	}
}