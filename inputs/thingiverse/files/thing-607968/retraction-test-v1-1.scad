
/* [Parameters] */
// width of test print
_width = 25;

// length of test print
_length = 25;

// max height of test print
_height = 25;

// number of test spires
_spireCount = 100;

// minimum spire diameter, also the diameter at the top of the spire
_minSpireDiameter = 1;

// maximum spire diameter at the base.
_maxSpireDiameter = 4;

/* [Advanced] */
// height distribution, use values between 0 and 1 to create more small spires, greater than 1 creates more tall spires, 1.0 for a equal distribution.
_heightDistribution = .25;

// base size distribution, use values between 0 and 1 to create more thin spires, greater than 1 for more wider spires, 1.0 for a equal distribution.
_sizeDistribution = 2;

// thickness of the test print base
_baseHeight = 0.5;


// ignore
_eps = 0.1*1;

module rrect(h, w, l, r) {
	r = min(r, min(w/2, l/2));
	w = max(w, _eps);
	l = max(l, _eps);
	h = max(h, _eps);
	if (r <= 0) {
		translate([-w/2, -l/2,0]) {
			cube([w,l,h]);
		}
	} else {
		hull() {
			for (y = [-l/2+r, l/2-r]) {
				for (x = [-w/2+r, w/2-r]) {
					translate([x,y,0]) {
						cylinder(h=h, r=r, center=false);
					}
				}
			}
		}
	}
}

function scaleHeight(hFrac) = pow(hFrac, max(_eps,1.0/_heightDistribution)) * _height;
function scaleThickness(tFrac) = _minSpireDiameter + pow(tFrac, max(_eps,1.0/_sizeDistribution)) * (_maxSpireDiameter-_minSpireDiameter);


module make() {
	xArray = rands(1,_width - 1,_spireCount);
	yArray = rands(1,_length - 1,_spireCount);
	heightArray = rands(_eps,1,_spireCount);
	thicknessArray = rands(_eps,1,_spireCount);
	union() {		
		for (i=[0:_spireCount-1]) {
			assign(diameter = scaleThickness(thicknessArray[i]),
					height = scaleHeight(heightArray[i])) {
				translate([xArray[i], yArray[i], height/2])
				cylinder(r1=diameter/2, r2 = _minSpireDiameter/2, h=height, center=true, $fn=16);
			}
		}

		// add platform
		translate([_width/2, _length/2, -_baseHeight+_eps])
		rrect(_baseHeight, _width + _maxSpireDiameter, _length + _maxSpireDiameter, _maxSpireDiameter, $fn=64);
	}
}

make();	