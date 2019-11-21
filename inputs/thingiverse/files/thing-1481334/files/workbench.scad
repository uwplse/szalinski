
// inches or mm?
units=1;			// [1:inches,0:mm]

benchWidth=60;

benchHeight=30;

benchDepth=32;

braceHeight=8;
// 0 = no top
topThickness=0.75;


// this is an openScad parametric version of Thingiverse item 1456181 by JenniferG

// stud orientation
hx=1*1;	// horizontal x
hy=2*1;	// horizontal y
v=3*1;	// vertical

module stud(length=72,orient=v) {
	echo(length = length);
	if (orient==hy) {
		cube([1.5,length,3.5]);
	} else if (orient==hx) {
		cube([length,1.5,3.5]);
	} else {
		cube([1.5,3.5,length]);
	}		
}

module bench(length=72,width=24,height=32,braceHeight=8,topThickness=0.75) {
	// legs
	translate([3,3,0]) stud(height-topThickness);
	translate([3+length-6-1.5,3,0]) stud(height-topThickness);
	translate([3,3+width-3.5-3,0]) stud(height-topThickness);
	translate([3+length-6-1.5,3+width-3.5-3,0]) stud(height-topThickness);
	// leg doublers - left
	translate([1.5,3,braceHeight]) stud(height-braceHeight-3.5);	
	translate([1.5,3,0]) stud(braceHeight-3.5);
	translate([1.5,3+width-3.5-3,braceHeight]) stud(height-braceHeight-3.5);
	translate([1.5,3+width-3.5-3,0]) stud(braceHeight-3.5);
	// leg doublers - right
	translate([3+length-6,3,braceHeight]) stud(height-braceHeight-3.5);
	translate([3+length-6,3,0]) stud(braceHeight-3.5);
	translate([3+length-6,3+width-3.5-3,braceHeight]) stud(height-braceHeight-3.5);
	translate([3+length-6,3+width-3.5-3,0]) stud(braceHeight-3.5);
	// leg braces
	translate([1.5,3,braceHeight-3.5]) stud(width-3, orient=hy);
	translate([3+length-6,3,braceHeight-3.5]) stud(width-3, orient=hy);

	// lower brace
	translate([1.5,width-5,braceHeight-3.5]) stud(length-3, orient=hx);
	translate([1.5,3+(width-3)/2-0.75,braceHeight-3.5]) stud(length-3, orient=hx);
	// lower brace fillers
	translate([(length-3)/3-0.75,3+(width-3)/2+0.75,braceHeight-3.5]) stud(width-5-3-(width-3)/2-0.75, orient=hy);
	translate([(length-3)*2/3-0.75,3+(width-3)/2+0.75,braceHeight-3.5]) stud(width-5-3-(width-3)/2-0.75, orient=hy);

	// horizontals
	translate([1.5,1.5,height-topThickness-3.5]) stud(length-3, orient=hx);
	translate([0,0,height-topThickness-3.5]) stud(length, orient=hx);
	translate([3,1.5+3.5+1.5,height-topThickness-3.5]) stud(length-6, orient=hx);
	translate([3,3+width-3.5-3-1.5,height-topThickness-3.5]) stud(length-6, orient=hx);
	translate([4.5,3+width-3.5-3-1.5+3.5,height-topThickness-3.5]) stud(length-9, orient=hx);
	
	// front-to-backs
	translate([0,1.5,height-topThickness-3.5]) stud(width-1.5, orient=hy);
	translate([1.5,3,height-topThickness-3.5]) stud(width-3, orient=hy);
	translate([length-1.5,1.5,height-topThickness-3.5]) stud(width-1.5, orient=hy);
	translate([length-3,3,height-topThickness-3.5]) stud(width-3, orient=hy);
	
	// fillers
	translate([(length-6)/3-0.75+3,8,height-topThickness-3.5]) stud(width-13, orient=hy);
	translate([(length-6)*2/3-0.75+3,8,height-topThickness-3.5]) stud(width-13, orient=hy);
	translate([(length-9)*2/4-0.75+3,width-3.5,height-topThickness-3.5]) stud(2, orient=hy);
	translate([(length-9)*2/4-0.75+3,3,height-topThickness-3.5]) stud(3.5, orient=hy);

	// these fillers are probably overkill - leaving them in since original design by JenniferG had them
	translate([(length-9)*1/4-0.75+3,width-3.5,height-topThickness-3.5]) stud(2, orient=hy);
	translate([(length-9)*3/4-0.75+3,width-3.5,height-topThickness-3.5]) stud(2, orient=hy);		
	translate([(length-9)*1/4-0.75+3,3,height-topThickness-3.5]) stud(3.5, orient=hy);
	translate([(length-9)*3/4-0.75+3,3,height-topThickness-3.5]) stud(3.5, orient=hy);	
	
	// and finally...the top sheet
	if (topThickness > 0) {
		translate([0,0,height-topThickness]) cube([length,width,topThickness]);
		// and even a lower shelf while we're at it
		translate([1.5,3+(width-3)/2-0.75,braceHeight]) cube([length-3,(width-3)/2+0.75-3.5,topThickness]);
		// if I were making this in real life, I'd have fit the lower shelf around the back legs...but I'm too lazy right now	
	}
}

//scaleFactor = (units == "inches")?25.4:1;
scaleFactor = units*24.4+1;

scale(scaleFactor) {
	bench(benchWidth,benchDepth,benchHeight,braceHeight,topThickness);
}
