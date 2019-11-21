nozzleDiameter=0.4;
tolerance=0.1;
totalHeight= 20;
thickRad=10;
thinRad=7;
capTipRad = 2;
screwDiameter = 4;
screwHeadDiameter = 8;
screwHeadDistanceFromWall = 5;

fontFace = "Keep Calm:style=Regular";
shipName = "Hyperion";
shipNameSize = 2.6;
shipSeries = "MK1";
shipSeriesSize = 5.5;

segments=90;

compScrewRadius = (screwDiameter+nozzleDiameter+tolerance)/2;
compScrewHeadRadius = (screwHeadDiameter+nozzleDiameter+tolerance)/2;

//body
module body(){
difference(){
	union(){
		cylinder(r1=thickRad,r2=thinRad,h=totalHeight/2,$fn=segments);
		translate([0,0,totalHeight/2])cylinder(r1=thinRad,r2=thickRad,h=totalHeight/2,$fn=segments);
	}
	cylinder(h=totalHeight, r=compScrewRadius, center=false, $fn=segments);
	translate([0,0,screwHeadDistanceFromWall])cylinder(h=totalHeight, r=compScrewHeadRadius, center=false, $fn=segments);
	translate([0,0,totalHeight-3+tolerance])cylinder(r=compScrewHeadRadius+0.5+nozzleDiameter,h=1,$fn=segments);
}
}

//cap
module cap(){
difference(){
	union(){
		translate([0,0,3])cylinder(h=5, r1=thickRad,r2=capTipRad, center=false, $fn=segments);
		translate([0,0,0])cylinder(h=3, r=(screwHeadDiameter-nozzleDiameter-tolerance)/2, center=false, $fn=segments);
		translate([0,0,0])cylinder(h=1, r1=(screwHeadDiameter-nozzleDiameter-tolerance)/2, r2=(screwHeadDiameter-nozzleDiameter-tolerance+0.5)/2, center=false, $fn=segments);
	}
	cylinder(h=4,r=compScrewHeadRadius/3*2,$fn=segments);
	cube([thickRad*2,2,6],center=true);
	cube([2,thickRad*2,6],center=true);
}
}

//textCap
module textCap(label = "none",labelSize = 10){
difference(){
	union(){
		translate([0,0,3])cylinder(h=3, r1=thickRad,r2=thickRad-1, center=false, $fn=segments);
		translate([0,0,0])cylinder(h=3, r=(screwHeadDiameter-nozzleDiameter-tolerance)/2, center=false, $fn=segments);
		translate([0,0,0])cylinder(h=1, r1=(screwHeadDiameter-nozzleDiameter-tolerance)/2, r2=(screwHeadDiameter-nozzleDiameter-tolerance+0.5)/2, center=false, $fn=segments);
		
		
	}
	cylinder(h=4,r=compScrewHeadRadius/3*2,$fn=segments);
	cube([thickRad*2,2,6],center=true);
	cube([2,thickRad*2,6],center=true);
	translate([0,0,5])linear_extrude(h=0.1,center=false,convexity = 10)text(label,labelSize,fontFace,center=true,halign="center",valign="center");
}
}

translate([-thickRad-1,-thickRad-1,0])body();
translate([thickRad+1,-thickRad-1,0])textCap(shipSeries,shipSeriesSize);
translate([-thickRad-1,thickRad+1,0])body();
translate([thickRad+1,thickRad+1,0])textCap(shipName,shipNameSize);