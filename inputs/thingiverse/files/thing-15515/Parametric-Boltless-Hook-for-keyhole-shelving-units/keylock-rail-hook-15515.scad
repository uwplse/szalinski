// for precise messurement points see the supplied pictures

//diameter of the large round part of the key hole,make smaller then real (for clearaces)
key_big = 11;
//diameter of the small offshoot from the main key cylinder,make smaller then real (for clearaces)
key_small = 6;

//distance from one key hole to the same point in the next key hole, make slightly bigger then real (for clearaces)
key_spacing = 39;
//thickness of the material the key holes are kut out of, make slightly bigger then real (for clearaces)
key_thickness = 1.25;

//the distance the hook extends from the support, poke should be bigger then hook
poke = 30;
//total hight if hook tip, hook width will = half this, hook should be smaller then poke
hook = 20;
//thickness of lugs and support bar
support_thickness = 4;


//turning the numbers into what object needs

hookStart = support_thickness*2+key_thickness;
angle = atan ( hook / poke);
hype = poke + hook;
KBR = key_big/2;
KSR = key_small/2;
 
module wedge()  {
	translate([0,-key_small,0]) difference() {
		cube([poke,key_small,hook]);
		rotate(a=[0,-angle,0])translate([0,-1,0])cube([hype,key_small+2,hook]);
	}	}

module betterjoints() {
	intersection(){
		translate([0,-KSR,0])cube([key_spacing,key_small,support_thickness*2+key_thickness]);
		cylinder(h= support_thickness*2+key_thickness ,r1 = KBR , r2 = KBR,$fn=36);
	}
}

translate([-KBR- key_spacing/2,-KBR,0]) {		//to centre item on the build platform


translate([KBR,KBR - KSR,hookStart]) {		//hook and support bar making section
	cube([hook/2,key_small,poke]);
	rotate(a=[0,270,180]) wedge();
	translate([poke,0,0])rotate(a=[0,0,180]) wedge();
	translate([0,0,-support_thickness]) cube([key_spacing,key_small,support_thickness]);
	}

translate([KBR,KBR,0]) {								//post 1
	cylinder(h= hookStart + poke, r1 = KSR ,r2 = KSR,$fn=36);
	cylinder(h= support_thickness ,r1 = KBR , r2 = KBR,$fn=36);
	betterjoints();
	translate([key_spacing,0,0]){						//post 2
		cylinder(h= hookStart, r1 = KSR ,r2 = KSR,$fn=36);
		cylinder(h= support_thickness ,r1 = KBR , r2 = KBR,$fn=36);
		betterjoints();
		}
	}
}