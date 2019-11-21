use <write/Write.scad>

/* [Hidden] */

$fn=20;


/* [Variables] */

layout = "print"; // ["print","top","bottom","pin"]
first_floor = 2;
last_floor = 7;

/* [Extras] */
radius = 20;
height = 15;
snap_size = 1;

n_floors = last_floor - first_floor + 1;

if(layout == "print")print();
if(layout == "top")top();
if(layout == "bottom")bottom();
if(layout == "pin")pinpeg(r=7/2,l=13,d=2.5-.1,nub=.4,t=1.8,space=.3);

module print(){
	top();

	translate([radius * 2.1,0,0])
	bottom();

	translate([radius * 3.5,0,0])
	pinpeg(r=7/2,l=13,d=2.5-.1,nub=.4,t=1.8,space=.3);
}

module bottom(){
	translate([0,0,height])
	rotate([180,0,0])
	difference(){
		cylinder(r = radius, h = height, $fn = n_floors);
		for(i = [first_floor:first_floor + n_floors - 1]){
			rotate([0,0,360 / n_floors * i])
			translate([radius * .6,0,0])
			sphere(r = snap_size);

			rotate([0,0,360 / n_floors * i + (n_floors-2)*180/n_floors/2 + 270])
			translate([sin((n_floors - 2) * 180 / n_floors / 2) * radius,0,height / 2])
			rotate([90,180,90])
			write(str(i),t=1,h=height * .8,center=true);
		}
	
		pinhole(r=3.5,l=13,nub=0.4,fixed=0,fins=1);
		
	}
}

module top(){
	translate([0,0,height])
	rotate([180,0,0])
	difference(){
		union(){
			cylinder(r = radius, h = height, $fn = n_floors);
			for(i = [first_floor:first_floor + n_floors - 1]){
				rotate([0,0,360 / n_floors * i])
				translate([radius * .6,0,0])
				sphere(r = snap_size);
			}
		}
		pinhole(r=3.5,l=13,nub=0.4,fixed=0,fins=1);
		
		rotate([0,0,360 / n_floors * ceil(n_floors / 2) + (n_floors-2)*180/n_floors/2 + 270])
		translate([sin((n_floors - 2) * 180 / n_floors / 2) * radius - .9,0,height / 3])
		rotate([90,0,90])
		linear_extrude(height = 1)
		scale(.5)
		car();

		//keychain
		translate([radius * 1.3, 0, height/2])
		rotate_extrude($fn = 50)
		translate([15,0])
		circle(r = 4);
	}
}

module car(){
	difference(){
		union(){
			//bottom of car
			hull(){
				//bottom left
				translate([-height * .8, height * .07, 0])
				circle(r = height * .125);
				//bottom right
				translate([height, height * .07, 0])
				circle(r = height * .125);
				//top left
				translate([-height * .8, height * .375, 0])
				circle(r = height * .125);
				//top right
				translate([height, height * .375, 0])
				circle(r = height * .125);
			}

			//top of car
			hull(){
				//bottom left
				translate([-height * .75, height * .375, 0])
				circle(r = height * .125);
				//bottom right
				translate([height / 1.25, height * .375, 0])
				circle(r = height * .125);
				//top left
				//translate([-height * .75, height * .75, 0])
				translate([-height * .5, height * .75, 0])
				circle(r = height * .125);
				//top right
				translate([height / 2.5, height * .75, 0])
				circle(r = height * .125);
			}		
		}
		//left wheel
		translate([-height / 2, 0, 0])
		circle(r = height * .3);
		//right wheel
		translate([height / 2, 0, 0])
		circle(r = height * .3);
	}

	translate([-height / 2, 0, 0])
	circle(r = height * .25);
	
	translate([height / 2, 0, 0])
	circle(r = height * .25);
}

module pin(r=3.5,l=13,d=2.4,slot=10,nub=0.4,t=1.8,space=0.3,flat=1)
translate(flat*[0,0,r/sqrt(2)-space])rotate((1-flat)*[90,0,0])
difference(){
	rotate([-90,0,0])intersection(){
		union(){
			translate([0,0,-0.01])cylinder(r=r-space,h=l-r-0.98);
			translate([0,0,l-r-1])cylinder(r1=r-space,r2=0,h=r-space/2+1);
			translate([nub+space,0,d])nub(r-space,nub+space);
			translate([-nub-space,0,d])nub(r-space,nub+space);
		}
		cube([3*r,r*sqrt(2)-2*space,2*l+3*r],center=true);
	}
	translate([0,d,0])cube([2*(r-t-space),slot,2*r],center=true);
	translate([0,d-slot/2,0])cylinder(r=r-t-space,h=2*r,center=true,$fn=12);
	translate([0,d+slot/2,0])cylinder(r=r-t-space,h=2*r,center=true,$fn=12);
}

module nub(r,nub)
union(){
	translate([0,0,-nub-0.5])cylinder(r1=r-nub,r2=r,h=nub);
	cylinder(r=r,h=1.02,center=true);
	translate([0,0,0.5])cylinder(r1=r,r2=r-nub,h=5);
}

module pinhole(r=3.5,l=13,d=2.5,nub=0.4,fixed=false,fins=true)
intersection(){
	union(){
		translate([0,0,-0.1])cylinder(r=r,h=l-r+0.1);
		translate([0,0,l-r-0.01])cylinder(r1=r,r2=0,h=r);
		translate([0,0,d])nub(r+nub,nub);
		if(fins)translate([0,0,l-r]){
			cube([2*r,0.01,2*r],center=true);
			cube([0.01,2*r,2*r],center=true);
		}
	}
	if(fixed)cube([3*r,r*sqrt(2),2*l+3*r],center=true);
}

module pinpeg(r=3.5,l=13,d=2.4,nub=0.4,t=1.8,space=0.3)
union(){
	pin(r=r,l=l,d=d,nub=nub,t=t,space=space,flat=1);
	mirror([0,1,0])pin(r=r,l=l,d=d,nub=nub,t=t,space=space,flat=1);
}
