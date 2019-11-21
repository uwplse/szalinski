$fn=32;

start = 40;
end = 70;
step = 5;

wall = 2;
width = 20;
height = 15;

textDepth = 0.5;
text = "0.05";

pad=3/4*locx(0,end+step);

intersection(){

	for(i=[start:step:end]){
		translate([locx(0,i),0,locz(0,i)])
		rotate([0,i,0]){
			difference(){
				object();
				translate([textDepth,width/2,height/8]) rotate([90,0,270]) linear_extrude(height = 10) text(str(i),halign="center",size=3/4*height);
			}
		}
	}
	
	cube([locx(0,end+step),width,locz(0,end+step)]);
}

/// pad text
translate([0,0,-wall]) difference(){
	cube([pad-wall,width,wall]);
	translate([pad/2,width/8,wall/4]) linear_extrude(height = 10) {
		text(text = text, size = 3/4*width, halign="center");
	}
}

module object(){
	d=width/3;
	difference(){
		u(){
			cube([wall+d/2,width,height]);
			t([wall+d/2,d/2,0]) cylinder(d=d,h=height);
			t([wall+d/2,width-d/2,0]) cylinder(d=d,h=height);
		}
		t([wall+d/2,width/2,0]) cylinder(d=d,h=height);
	}
}

function locx(x,ang) = (ang <= start)? x : locx(x+height*sin(ang-step),ang-step);

function locz(z,ang) = (ang <= start)? z : locz(z+height*cos(ang-step),ang-step);

module t(v=[0,0,0]){translate(v) children();}
module r(a=[0,0,0]){rotate(a) children();}
module tr(v=[0,0,0],a=[0,0,0]){t(v) r(a) children();}
module rt(a=[0,0,0],v=[0,0,0]){r(a) t(v) children();}
module u(){union() children();}