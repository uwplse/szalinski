// Written by Remi Vansnickt <>
//Feel free to tip me : https://www.thingiverse.com/Remivans/about
//Thingiverse : https://www.thingiverse.com/thing:3273050
//Licensed under the Creative Commons - Attribution - Non-Commercial - Share Alike license.

/* [Children bed parameter] */

//(mm)bar diameter
barDiameter=17;//[5:0.1:50]

//(mm) space beetween inner bar
barSpace=54;//[10:0.1:200]

//(mm) Height of output part ( barSpace/2 for uniforme top )
partHeight=27;//[5:0.5:200]

//(mm) Width of output part
partWidth=65;//[5:0.5:200]

//(mm) Height of bottom
floorHeight=1.3;//[0.3:0.1:5]

//(mm) Do you need space beetween part and bar
clearance=0;//[-2:0.1:2]

/* [Printer setting] */
//(mm) Height of first layer ( for removable brim inside hole)
PrinterFirstLayerHeight=0.3;//[0.1:0.01:0.5]

//(mm) Width of your Printer nozzle
PrinterNozzleWidth=0.4;//[0.1:0.05:1]

// number of wall
PartNumberWall=6;//[3:1:20]

cylinderPath=barSpace+barDiameter;
rPath=PrinterNozzleWidth*PartNumberWall/2+0.01;

//output
helper();
output();


//module
module barreau(clearance=0,cut=0){
	translate([0,0,-cut])cylinder(r=barDiameter/2+clearance,h=barSpace/2+2*cut,$fn=50);
	}

module helper(){
	$fn=50;
	hull(){
		translate([-barDiameter/8-barDiameter/2+rPath,-barDiameter/2-rPath-clearance,0])cylinder(r=rPath,h=partHeight);
		translate([+rPath/2,-barDiameter/2-rPath-+clearance,0])cylinder(r=rPath,h=partHeight);
		}
	hull(){
		translate([-barDiameter/8-barDiameter/2+rPath,+barDiameter/2+rPath+clearance,0])cylinder(r=rPath,h=partHeight);
		translate([+rPath/2,+barDiameter/2+rPath+clearance,0])cylinder(r=rPath,h=partHeight);
		}
		
			hull(){
		translate([cylinderPath+barDiameter/8+barDiameter/2-rPath,-barDiameter/2-rPath-+clearance,0])cylinder(r=rPath,h=partHeight);
		translate([-rPath/2+cylinderPath,-barDiameter/2-rPath-+clearance,0])cylinder(r=rPath,h=partHeight);
		}
	hull(){
		translate([cylinderPath+barDiameter/8+barDiameter/2-rPath,+barDiameter/2+rPath+clearance,0])cylinder(r=rPath,h=partHeight);
		translate([-rPath/2+cylinderPath,+barDiameter/2+rPath+clearance,0])cylinder(r=rPath,h=partHeight);
		}
	}

module output(){
	difference(){
		union(){
			//barreau
				translate([0,0,0])barreau(2*rPath+clearance,0);
				translate([cylinderPath,0,0])barreau(2*rPath+clearance,0);
		difference(){

				//cup
			scale([1,1,2*partHeight/barSpace])
			hull(){
				translate([-barDiameter/8,partWidth/2-barDiameter/2,0])barreau(0,0);
				translate([-barDiameter/8,-partWidth/2+barDiameter/2,0])barreau(0,0);
				
				translate([cylinderPath+barDiameter/8,partWidth/2-barDiameter/2,0])barreau(0,0);
				translate([cylinderPath+barDiameter/8,-partWidth/2+barDiameter/2,0])barreau(0,0);
				}	
			
			hull(){
				translate([-barDiameter/8,partWidth/2-barDiameter/2,floorHeight])scale([1,1,2*partHeight/barSpace])barreau(-2*rPath,0);
				translate([-barDiameter/8,-partWidth/2+barDiameter/2,floorHeight])scale([1,1,2*partHeight/barSpace])barreau(-2*rPath,0);
				
				translate([cylinderPath+barDiameter/8,partWidth/2-barDiameter/2,floorHeight])scale([1,1,2*partHeight/barSpace])barreau(-2*rPath,0);
				translate([cylinderPath+barDiameter/8,-partWidth/2+barDiameter/2,floorHeight])scale([1,1,2*partHeight/barSpace])barreau(-2*rPath,0);
				}
			
		}	
		}
		union(){
			//cut barreau
			scale([1,1,2*partHeight/barSpace])
			hull(){
				translate([0,0,0.3])barreau(clearance,0);
				translate([-barDiameter/8-barDiameter/2,0,0.3])barreau(rPath,0);
				}
			scale([1,1,2*partHeight/barSpace])
			hull(){
				translate([cylinderPath+barDiameter/2+barDiameter/8,0,0.3])barreau(rPath,0);
				translate([+cylinderPath,0,0.3])barreau(clearance,0);
				}
		}
	}
		
}





