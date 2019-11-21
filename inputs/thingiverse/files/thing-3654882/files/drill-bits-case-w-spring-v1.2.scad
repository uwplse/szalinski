//Holes for drill bits. Format: [diameter1, length1],[diameter2, length2],... Use bigger length then bits really have
drills = [
			[1.5, 50 ],
			[2,   55 ],
			[2.5, 60 ],
			[3,   65],
			[3.2, 75],
			[3.5, 75],
			[4,   80],
			[4.5, 85],
			[5,   90],
			[5.5, 100],
			[6,   100],
];
//blade width
blade = 19;//[9:9mm,18:18mm,19:19mm,25:25mm]
//Text height: positive - humps, negative - hollows, 0 - no text
textHeight = 0.4;
mode = 0; //[0:Both parts, 1:Part 1, 2:Part 2, 3:Preview, 4:Text Only]

/*[Advanced]*/
side = 2;
wall = 2;
top = 1.5;
hingeR = 2;
hingeHoleD = 1;
gap = 0.5;
minfont = 3;
maxfont = 5;
holesShape = 1; //[0:Square, 1:Round]

/*[Hidden]*/
//dont edit this, dude
springThin = 1;
n = len(drills);
bot = 2*hingeR;;
width = sumw()+(n-1)*wall+side*2;
springWidth = blade+0.5;
hingeW = (width-springWidth)/2;
maxD = maxDia();
partLen = (maxLen()+side*2)/2;
height = maxDia() + bot + top+gap;
echo(width=width, length=(partLen*2), sumw());

module part1(){
	difference(){
		union(){
			cube([width, partLen - hingeR, height]);
			translate([0, partLen, height - hingeR]) hinge();
			translate([width-hingeW, partLen, height - hingeR]) hinge();
			if(textHeight > 0) translate([0,0,-textHeight])extrudedText();
		}
		union(){
			for(i = [0:1:n-1]){
				translate([side+sumw(i)+wall*i-drills[i][0]/2 , partLen, (height-top-hingeR*2)/2+top])
				if(holesShape == 0){
					cube([drills[i][0]+gap, partLen, drills[i][0]+gap], center = true);
				}else{
					rotate([-90,0,0]) cylinder(d = drills[i][0]+gap, h = drills[i][1], center = true, $fn = 32);
				}
			}
			if(textHeight < 0) extrudedText();
		}
	}
}
module extrudedText(){
	#for(i = [0:1:n-1]){
		linear_extrude(abs(textHeight)) 
			translate([side+ sumw(i) - drills[i][0] + i*wall, partLen/3*(1+(i+1)%2), 0])
				rotate([180,0,90]) text(str(drills[i][0]), size = min(maxfont,max(minfont,drills[i][0]+wall)));
	}
}
module part2(){
	difference(){
		union(){
			translate([0,hingeR,0]) cube([width, partLen - hingeR, height]);
			translate([hingeW, 0, height - hingeR]) scale([-1,-1,1]) hinge();
			translate([width, 0, height - hingeR]) scale([-1,-1,1]) hinge();
		}
		union(){
//			for(i = [0:1:n-1]){
			for(i = [0:1:n-1]){			
				translate([side + sumw(i) - drills[i][0]/2+ i*wall, 0, -50+top+gap+maxD/2+drills[i][0]/2]) cube([drills[i][0]+wall+0.05, drills[i][1],100], center = true);
			}
		}
	}
}
module hinge(w = 16){
	difference(){
		union(){
			translate([0,-hingeR*2,-hingeR])cube([hingeW/4,hingeR*2,hingeR*2]);
			translate([0,0,0])rotate([0,90,0])cylinder(r = hingeR, h = hingeW/4, $fn=32);
			translate([hingeW/2,-hingeR*2,-hingeR])cube([hingeW/4,hingeR*2,hingeR*2]);
			translate([hingeW/2,0,0])rotate([0,90,0])cylinder(r = hingeR, h = hingeW/4, $fn=32);
		}
		translate([0,0,0])rotate([0,90,0])cylinder(d = hingeHoleD, h = w, $fn=32);
	}
}
module springHole(){
	translate([width/2, 0, height-hingeR]) union(){
		#translate([0,0,hingeHoleD/2+springThin/2])cube([width - 2*hingeW,partLen*2*2/3,springThin], center = true);
		translate([0,0,hingeHoleD/2+hingeR/2]) cube([width - 2*hingeW,partLen*2/3,hingeR], center = true);
	}	
}
function sumw(n = -66) = (n==-66)?sumw(len(drills)-1):((n>0)?drills[n][0]+sumw(n-1):drills[0][0]);
function maxDia(n = -66) = (n==-66)?maxDia(len(drills)-1):((n>0)?max(drills[n][0], maxDia(n-1)):drills[0][0]);
function maxLen(n = -66) = (n==-66)?maxLen(len(drills)-1):((n>0)?max(drills[n][1], maxLen(n-1)):drills[0][1]);
module run(){
	if(mode == 0){
		union(){
			difference(){
				translate([0,-partLen,0])part1();
				springHole();
			}
			translate([0,2*hingeR+1,0])
				difference(){
					part2();
					springHole();
				}
		}
	}else if(mode == 1){
		difference(){
			translate([0,-partLen,0])part1();
			springHole();
		}
	}else if(mode == 2){
		difference(){
			part2();
			springHole();
		}
	}else if(mode == 3){
		difference(){
			union(){
				translate([0,-partLen,0])part1();
				part2();
			}
			springHole();
		}
	}else if(mode == 4){
		translate([0,-partLen,0])
			if(textHeight > 0) translate([0,0,-textHeight]) extrudedText();
			else extrudedText();
	}
}
rotate([0,180,0]) run();