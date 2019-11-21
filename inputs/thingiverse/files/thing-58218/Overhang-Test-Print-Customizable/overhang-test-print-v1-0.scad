use <write/Write.scad>

// style of test print
_type = "both"; //[bridged, floating, both]

// start angle
_start = 15;

// end angle
_end = 45;

// angle increment between samples
_increment = 5;

// sample width
_width = 7.0; // [1:20]

// height
_height = 6.0; // [1:20]

_fontSizePercent = 65; // [0:100]

_spineWidth = 2; // [0:10]

function getLength(height,angle) = height/tan(angle);

module overhangTest(bridged, start, end, increment, width, height, spine, gap, fontSize, showLabels = true, offsetLabels = true) {
	num = (end-start)/increment + 1;
	length = width * num + gap * (num+1);
	fontFraction = fontSize/100;
	fontDepth = 0.5;
	step = width+gap;
	eps = 0.1;

	difference() {
		union() {
			translate([spine/2, -length/2, height/2]) {
				cube(size=[spine+eps,length,height], center=true);
			}
			
			for (angle = [start:increment:end]) {
				assign(index = (angle-start)/increment + 1) {
					translate([spine,-(step*index - width/2),0])
					rotate([90,0,0])
					linear_extrude(height = bridged ? width+eps : width, center = true, convexity = 2) {
						polygon(points=[[0,0],[getLength(height,angle),height],[0,height]], paths=[[0,1,2]]);
					}
				}
			}

			// beams
			if (bridged) {
				for (index = [0:num]) {
					translate([0,-step*(index) - gap,0]) {
						cube(size=[getLength(height,start + increment * max(0,(index-1))) + spine, gap, height]);
					}
				}
			}
		}

		// labels
		if (showLabels) {
			for (angle = [start:increment:end]) {
				assign(y=step * ((angle-start)/increment +1)) {
					translate([offsetLabels ? width/4 : 0,-(y - width/2 + width * fontFraction/2),height-fontDepth]) {
						write(str(angle), t=fontDepth+eps, h=width*fontFraction, font="write/orbitron.dxf", space=1.2);
					}
				}
			}
		}
	}
}


module make(type, start, end, increment, width, height, fontSize, spineWidth) {
	gap = 1.0;

	if (_type == "floating") {
		overhangTest(false, start, end, increment, width, height, spineWidth, gap, fontSize);
	} else if (_type == "bridged") {
		overhangTest(true, start, end, increment, width, height, spineWidth, gap, fontSize);
	} else {
		overhangTest(true, start, end, increment, width, height, spineWidth, gap, fontSize, true, false);
		mirror([1,0,0]) {
			overhangTest(false, start, end, increment, width, height, spineWidth, gap, fontSize, false);
		}
	}
}


make(_type, _start, _end, _increment, _width, _height, _fontSizePercent, _spineWidth);



