magnum = 1; // 1, 2 or 3

tolerance = 0.1; //aditional tolerance extra on nozzle size
nozzle = 0.4; //printer nozzle size
neoRad = 15/2; //neodymium radius
neoHei = 15; //neodymium height

wall = 1.6;
wallh = 21; //has to be larger then height of magnet, i recomend atleast 6mm more 
thickness = 5; //off base plate under the magnet
supportoffset=10; //how far out should the outer angeld support wall go

segments=360; //detail of round things

module neo(){
	cylinder(h=neoHei,r=neoRad+(nozzle+tolerance)/2,$fn=segments);
}

module base(){
	union(){
		//L
		cube([40,20,neoHei+thickness]);
		translate([0,20,0])cube([20,20,neoHei+thickness]);
		//Wall
		translate([-wall,-wall,0])cube([40+wall*2,wall,neoHei+thickness+wallh]);
		translate([-wall,0,0])cube([wall,40,neoHei+thickness+wallh]);
		translate([-wall,40,0])cube([20+wall*2,wall,neoHei+thickness+wallh]);
		translate([20,20,0])cube([wall,20,neoHei+thickness+wallh]);
		translate([20+wall,20,0])cube([20,wall,neoHei+thickness+wallh]);
		translate([40,0,0])cube([wall,20,neoHei+thickness+wallh]);
		
		//supports
		difference(){
			union(){
				translate([-supportoffset-wall,-supportoffset-wall,0])cube([supportoffset+40+wall*2,supportoffset,neoHei+thickness+wallh]);
				translate([-supportoffset-wall,-wall,0])cube([supportoffset,40+wall*2,neoHei+thickness+wallh]);
			}
			a=supportoffset;
			b=neoHei+thickness+wallh;
			angle=90-atan(b/a);
			translate([-supportoffset-wall,-supportoffset*2-wall,0])translate([0,supportoffset,0])rotate([-angle,0,0])translate([0,-supportoffset,0])cube([supportoffset+40+wall*2,supportoffset,(neoHei+thickness+wallh)*2]);
			translate([-supportoffset*2-wall,-wall,0])translate([supportoffset,0,0])rotate([0,angle,0])translate([-supportoffset,-(40+wall*2)/2,0])cube([supportoffset,(40+wall*2)*2,(neoHei+thickness+wallh)*2]);
		}
		difference(){
			translate([20+wall,20+wall,0])cube([20,20,neoHei+wallh+thickness]);
			translate([wall+40,wall+40,0])cylinder(h=neoHei+wallh+thickness,r=20,$fn=segments);
		}
	}
}

module feet(num){
	difference(){
		base();
		if(num == 1){
			translate([11,11,thickness])neo();
		}
		if(num == 2){
			translate([24,10,thickness])neo();
			translate([10,24,thickness])neo();
		}
		if(num == 3){
			translate([11,11,thickness])neo();
			translate([30,10,thickness])neo();
			translate([10,30,thickness])neo();
		}
	}
}

module headBlock(){
	offset = nozzle+tolerance;
	headlen=40-offset*2;
	hheadlen=20-offset*2;
	nosewidth=6-offset;
	union(){
		translate([0,0,0])cube([headlen,hheadlen,wallh]);
		translate([0,hheadlen,0])cube([hheadlen,hheadlen+offset*2,wallh]);
		translate([hheadlen+offset*2,hheadlen/2-nosewidth/2,wallh])cube([hheadlen,nosewidth,6]);
		translate([hheadlen/2-nosewidth/2,hheadlen+offset*2,wallh])cube([nosewidth,hheadlen,6]);
	}
}

module head(num){
	difference(){
		translate([nozzle+tolerance,nozzle+tolerance,0])headBlock();
		if(num == 1){
			translate([11,11,0])neo();
		}
		if(num == 2){
			translate([24,10,0])neo();
			translate([10,24,0])neo();
		}
		if(num == 3){
			translate([11,11,0])neo();
			translate([30,10,0])neo();
			translate([10,30,0])neo();
		}
	}
}

module parts(){
	feet(magnum);
	translate([30,30])head(magnum);
}

parts();