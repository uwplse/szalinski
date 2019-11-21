// width of the cartridge
cartridgeX = 117;
// depth of the cartidge
cartridgeY = 21;
// how much of the cartridge will sit in the holder
holderDepth = 18;
// thickness of the walls between each game
wallWidth = 3;
// how many cartridges that you want to fit in the holder
numCartridges = 8;


module cartridge() {
	cube([cartridgeX,cartridgeY,holderDepth]);
}
module stadium(levels, width, stairsize) {
	for ( l = [0 : levels]) {
		translate([0,0,l*(stairsize/2)])
		cube([width, (levels*stairsize)-(l*stairsize), stairsize]);
	}

}
module hullcart(levels, width, stairsize) {
	for( l = [0: levels]) {
		translate([
			(width-cartridgeX)/2,
			(l*stairsize)+((stairsize-cartridgeY)/2),
			((levels-l)*stairsize/2)])
		cartridge();
	}
}

module cartridgeHolder(){
	difference() {
		stadium(numCartridges, cartridgeX + wallWidth, cartridgeY + wallWidth);
		hullcart(numCartridges, cartridgeX + wallWidth, cartridgeY + wallWidth);
	}
}

cartridgeHolder();