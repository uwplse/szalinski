//cabinet shelf hole guide/jig

//Diameter of the pin default 5mm
holeDiameter =5;
//Distance between each hole default 32mm
holeOffset=32;
//Number of holes in jig
numberHoles = 7;

//103 allows for 37mm on one side of the hole and 66mm on the other (1-1/2inch, 2-1/2inch)
width=103; 
height=15;

//Short side lip (1 enabled, 0 disabled)
sideOneLip=1;

//Long side lip (1 enabled, 0 disabled)
sideTwoLip=0;

length=(numberHoles+1)*holeOffset;

//Depth of hole in board (stopper height) Take length of drill bit in mm less the desired hole depth, pins push in 8mm so maybe aim for a depth of 10mm
stopperDepth=25;


lipWidth=0.1*width;




module hole(x,y){

	
	translate([x,y,0]){
    difference(){
	cylinder(stopperDepth,d1=3*holeDiameter,d2=1.5*holeDiameter,true);
	translate([0,0,-1]){cylinder(2+stopperDepth,d=holeDiameter,true);}
	}
	}
    
}

module peg(x,y){

	translate([x,y,-1]){
    cylinder(stopperDepth,d=1.5*holeDiameter,true);
	}
	
}

module holes(){
for(a=[1:numberHoles]){
	hole(37,holeOffset*a);
}
}

module pegs(){
	for(a=[1:numberHoles]){
		peg(37,holeOffset*a);
	}
}



//base
difference(){
	
	cube([width, length, height]);
	pegs();	
	}


holes();

if(sideOneLip){
	translate([-lipWidth,0,-height*0.5]){
	cube([lipWidth,length,height*1.5]);
}}

if(sideTwoLip){
	translate([width,0,-height*0.5]){
	cube([lipWidth,length,height*1.5]);
}}
