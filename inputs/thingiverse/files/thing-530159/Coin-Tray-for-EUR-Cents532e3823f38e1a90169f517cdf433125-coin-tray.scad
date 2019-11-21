oneCent = 16.25;
oneCentCount = 5;

twoCent = 18.75;
twoCentCount = 4;

fiveCent = 21.25;
fiveCentCount = 4;

borderThickness = 2;

maxLength = max(fiveCent*fiveCentCount+(fiveCentCount+1)*borderThickness, twoCent*twoCentCount+(twoCentCount+1)*borderThickness,oneCent*oneCentCount+(oneCentCount+1)*borderThickness);

difference () {
translate([-borderThickness,-borderThickness,0])
cube(size = [maxLength,oneCent+twoCent+fiveCent+4*borderThickness,1.67]);

translate([oneCent/2,oneCent/2,0])
	coin(oneCent,oneCentCount);

translate([twoCent/2,oneCent+twoCent/2+borderThickness,0]) 
	coin(twoCent,twoCentCount);

translate([fiveCent/2,oneCent+twoCent+fiveCent/2+2*borderThickness,0]) 
	coin(fiveCent,fiveCentCount);
}

module coin(d,c) {
	for (i = [0:c-1]) {
		translate([(d+borderThickness)*i,0,0])
		cylinder(h = 1.67, r=d/2);
	}
}