// 8.5 x 11 paper holder

/* [Frame Dimensions] */

// Assembled or plated or individual parts?
part = 0; //[0:Preview, 1:Plate, 2:Center, 3:Left arm, 4:Right arm]

in = 25.4*1;
// Thickness of holder in mm
thick = 2;

// Paper width in inches or mm (use one)
widthInches = 5;
widthMM = 0;
// Paper height in inches or mm (use one)
heightInches = 3;
heightMM = 0;
// Paper thickness in inches or mm (use one)
thicknessInches = .125;
thicknessMM = 0;
// Arm width in inches or mm (use one)
armInches = .5;
armMM = 0;
band = armInches*in+armMM;

x=widthInches*in+widthMM;
y=heightInches*in+heightMM;
z=thicknessInches*in+thicknessMM;

r = x/y;
angle=atan(r);

xi = x-band/2;
yi=y-band/2;
xi=x;
yi=y;

diag = sqrt(xi*xi+yi*yi);

// Radius of center screw in mm
sr = 3;
// Gap for spacing between parts (tune for your printer)
gap=0.4;

spacing = 1.1*band;

module arm() {
intersection() {
	rotate([0,0,angle]) cube([band,2*y,z+3*thick], center=true);
	difference() {
		cube([x+2*thick,y+2*thick,z+2*thick],center=true);
		cube([x,y,z], center=true);
		translate([0,0,z/2]) cube([x-2,y-2,z+thick], center=true);
		translate([0,0,-(z/2+thick)-.1]) cylinder(r1=sr, r2=sr+thick, h=thick+.2);
		}
	}
}

module X () {
	arm();
	mirror([1,0,0]) arm();
	}

module plug(r, h) {
	//echo(r,h);
	cylinder(r1=r, r2=r+h, h=h, center=true);
	}

module centerCut() {
	translate([0,0,-z/2-thick/2]) {
		rotate([0,0,90-angle]) {
			cube([2*band,band/3,thick+1], center=true);
			translate([band,0,0]) plug(band/5,thick+1);
			translate([-band,0,0]) plug(band/5,thick+1);
			}
		rotate([0,0,90+angle]) {
			cube([2*band,band/3,thick+1], center=true);
			translate([band,0,0]) plug(band/5,thick+1);
			translate([-band,0,0]) plug(band/5,thick+1);
			}
		plug(band/2,thick+1);
		}
	}

module centerHole() {
	translate([0,0,-z/2-thick/2]) {
		rotate([0,0,90-angle]) {
			cube([2*band+2*gap,band/3+2*gap,thick+1], center=true);
			translate([band,0,0]) plug(band/5+gap,thick+1);
			translate([-band,0,0]) plug(band/5+gap,thick+1);
			}
		rotate([0,0,90+angle]) {
			cube([2*band+2*gap,band/3+2*gap,thick+1], center=true);
			translate([band,0,0]) plug(band/5+gap,thick+1);
			translate([-band,0,0]) plug(band/5+gap,thick+1);
			}
		plug(band/2+gap,thick+1);
		}
	cube([x,gap,band], center=true);
	cube([gap,y,band], center=true);;
	}

module center() {
	intersection () {
		X();
		centerCut();
		}
	}

module anArm() {
    ht=z+2*thick;
	intersection() {
		difference() {
			X();
			centerHole();
			}
		translate([0,0,-ht/2]) cube([x/2+thick,y/2+thick,ht]);
		}
	}

module plate() {
	translate([-spacing/2,-band,0]) rotate([0,0,90]) center();
	rotate([0,0,angle]) anArm();
	translate([spacing,0,0]) rotate([0,0,angle]) anArm();
	translate([-spacing,0,0]) mirror([1,0,0]) rotate([0,0,angle]) anArm();
	translate([-2*spacing,0,0]) mirror([1,0,0]) rotate([0,0,angle]) anArm();
	}

module preview() {
	center();
	difference() {
			X();
			centerHole();
			}
		}

translate([0,0,z/2+thick]) {
	if (part==0) preview();
	if (part==1) plate();
	if (part==2) center();
	if (part==3) anArm();
	if (part==4) mirror([1,0,0]) anArm();
	}