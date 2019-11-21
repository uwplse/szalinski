
$fn=200;

fit = 0.5;
wallThickness = 2;

topSectionSize=63;
bottomSectionSize=100;

topSectionHeight = 50;
topOuter = topSectionSize-fit;
topInner = topOuter - wallThickness;

bottomSectionHeight = 50;
bottomOuter = bottomSectionSize - fit;
bottomInner = bottomOuter - wallThickness;

midSectionHeight = 50;


section(bottomSectionHeight,bottomInner,bottomOuter);  // Bottom section

translate([0,0,bottomSectionHeight]) angleSection(midSectionHeight,bottomInner,bottomOuter,topInner,topOuter); // joining piece

translate([0,0,bottomSectionHeight+midSectionHeight]) section(topSectionHeight, topInner, topOuter); // top section


module section(height=50, inner=63, outer=65) {
	
	difference() {
		cylinder(h=height,r1=outer/2,r2=outer/2);
		cylinder(h=height,r1=inner/2,r2=inner/2);
	}
		
}


module angleSection(height=50, startInner=101, startOuter=105,endInner=10,endOuter=20) {
	
	difference() {
		cylinder(h=height,r1=startOuter/2,r2=endOuter/2);
		cylinder(h=height,r1=startInner/2,r2=endInner/2);
	}

}