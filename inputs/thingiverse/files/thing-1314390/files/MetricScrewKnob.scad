// <Sopak's Metric Screw Knob> (c) by <Kamil Sopko>
// 
// <Sopak's Metric Screw Knob> is licensed under a
// Creative Commons Attribution-ShareAlike 4.0 Unported License.
// 
// You should have received a copy of the license along with this
// work.  If not, see <http://creativecommons.org/licenses/by-sa/4.0/>.

// it incorporate some methods from http://www.thingiverse.com/thing:269863

/* [ScrewDimensions] */

// type odf screw head 6 sides iso nut  M1...M8..M10
headIso=8;// [1:21]

//height of screw head, use bigger size, as it is  printed  from bottom and   can collapse littlebit
headHeight=7.5;  // [0:0.1:50]

/* [KnobDimensions] */

//maximum radius  of knob
maxRadius=25; // [10:100]

//minimum radius  of knob
minRadius=12; // [5:100]

//maximum radius chamfer
maxRadiusChamfer=1.3; // [0.1:0.1:10]

//max height of whole knob
maxHeight=40;  // [5:100]

//height of  holder include chamfers
holderHeight=10;    // [5:100]

// number of  side cuts   in knob
numberOfCuts=5; // [0:30]

//radius  of cut
cutRadius=12; // [10:50]

//maxRadius+cutOffset is center of cutting  cylinder should be  smaller then cutRadius
cutOffset=8;  // [1:50]

//big chamfer height
holderChamfer=10;  // [0:50]

//this is height of  conus  between  6side head and  screw hole, this is here for printability as its  from botom to top
screwHeadSafetyHeight=6;  // [0:10]

/* [OtherValues] */

//just  for cleaner boolean  operations
tolerance=0.3;

//quality
$fn=100;

module knob(numberOfCuts=7,maxRadius=25,minRadius=10,maxRadiusChamfer=1.5,
    maxHeight=20,holderHeight=10,cutRadius=12,cutOffset=8,holderChamfer=5,headIso=8, headHeight=7,screwHeadSafetyHeight=5,tolerance=0.3){

    rotate([0,0,0])difference(){
        //main body
        union(){
            translate([0,0,0]){
                cylinder(r2=maxRadius,r1=maxRadius-maxRadiusChamfer,h=maxRadiusChamfer*2);
                translate([0,0,maxRadiusChamfer*2]){
                    cylinder(r1=maxRadius,r2=maxRadius,h=holderHeight-4*maxRadiusChamfer);
                    translate([0,0,holderHeight-4*maxRadiusChamfer]){
                        hull(){
                            cylinder(r2=maxRadius-maxRadiusChamfer,r1=maxRadius,h=maxRadiusChamfer*2);
                            translate([0,0,maxRadiusChamfer+holderChamfer-tolerance])cylinder(r=minRadius,h=tolerance);
                        }
                    }
                }
            }
            cylinder(r=minRadius,h=maxHeight);            
        }
        
        //cut for screw rod
        translate([0,0,-tolerance])cylinder(d=headIso+2*tolerance,h=maxHeight+2*tolerance);
        
        //remove for screw head
        hull(){
            translate([0,0,-tolerance-headHeight])hex_head(2*headHeight+2*tolerance, get_iso_waf(headIso) + tolerance);
            translate([0,0,headHeight-tolerance+screwHeadSafetyHeight])cylinder(d=headIso+2*tolerance,h=tolerance);
        }

        //remove cuts in holder
        if(numberOfCuts>0){
            for(a=[0:360/numberOfCuts:359]){
                rotate([0,0,a]){
                      //cut  section hole
                    hull(){
                        translate([0,maxRadius+cutOffset,-tolerance])cylinder(r=cutRadius,h=maxHeight+tolerance*2);
                    }
                }
            }
        }
    }
}

/*
 * creates a hexagon head for a screw or a nut
 * original method  from http://www.thingiverse.com/thing:269863
 * 
 * @param hg   height of the head
 * @param df   width across flat (take 0.1 less!)
 * @param $fn  should be 30 minimum (do not use $fs or $fa)
 */
module hex_head(hg, df)
{
	rd0 = df/2/sin(60);
	
	x0 = 0; x1 = df/2; x2 = x1+hg/2;
	y0 = 0; y1 = hg/2; y2 = hg;
	
	intersection()
	{
		cylinder(
				h = hg,
				r = rd0,
				$fn = 6,
				center = false
			);
		
		rotate_extrude(convexity = 10)
		polygon([ [x0, y0], [x1, y0], [x2, y1], [x1, y2], [x0, y2] ]);
	}
}

/*
 * returns the width across flat (tool size) for an ISO M-Number (take 0.1 less!)
 * original method  from http://www.thingiverse.com/thing:269863
 * 
 * @param d    the iso diameter
 */
function get_iso_waf(d) = lookup(d, 
	[
		[ 1  ,  2  ],
		[ 1.2,  2.5],
		[ 1.6,  3.2],
		[ 2  ,  4  ],
		[ 2.5,  5  ],
		[ 3  ,  5.5],
		[ 4  ,  7  ],
		[ 5  ,  8  ],
		[ 6  , 10  ],
		[ 8  , 13  ],
		[10  , 17  ],
		[12  , 19  ],
		[16  , 24  ],
		[20  , 30  ],
		[24  , 36  ],
		[30  , 46  ],
		[36  , 55  ],
		[42  , 65  ],
		[48  , 75  ],
		[56  , 85  ],
		[64  , 96  ]
	]
);


knob(numberOfCuts=numberOfCuts,minRadius=minRadius,maxRadiusChamfer=maxRadiusChamfer,maxHeight=maxHeight,holderHeight=holderHeight,
    cutRadius=cutRadius,cutOffset=cutOffset,holderChamfer=holderChamfer,headIso=headIso,headHeight=headHeight,screwHeadSafetyHeight=screwHeadSafetyHeight,tolerance=tolerance);