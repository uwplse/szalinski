/***
  Multi-Column Card Box generator
  Based on https://www.thingiverse.com/thing:2120898
  
  Version 1.0
    Initial Release
  Version 1.1
    Auto-compute divider thickness, center partial fills
*/

outputs = "caddy"; // [cover:Cover Only,caddy:Caddy Only,both:Caddy and Cover]

// A value of 0 will use the widest compartment width as the overall width of the box
minimum_box_width=0;
// A value of 0 will use the combined thickness of all the compartments and appropriate dividers.
minimum_box_length=0;
// Thickness of the dividers separating the individual pockets
divider_thickness=1.5;
// This will determine how high the body walls will go. This value must be lower than the compartment height.
divider_height=60;
// Use compartment_width in the pocket array if compartments are all the same size
compartment_width=66;
// Use compartment_height in the pocket array if compartments are all the same size
compartment_height=91;
// The thickness of each wall (Not counting the lip thickness)
wall_thickness_minimum=1.5;

// Amount of height to add to the top cover
cover_top_clearance=1;
// Amount of material to add to the sides of the cover's sides and lip thickness
cover_side_clearance=.3;

// Serves as the stopper for the cover, preventing the cover from squishing the top of the compartments
caddy_lip = "yes"; // [no:no, yes:yes]

// Height of the lip. A higher value means less material needed for the cover
lip_height=10;

// Thickness of the caddy lip. Also determines the thickness of the cover walls.
lip_thickness = 2;

el_alamein = [
  [
    [ compartment_width, 4, compartment_height],
    [ compartment_width, 3, compartment_height],
    [ compartment_width, 3, compartment_height],
    [ compartment_width, 3, compartment_height],
    [ compartment_width, 3, compartment_height],
    [ compartment_width, 3, compartment_height],
    [ compartment_width, 4, compartment_height],
    [ compartment_width, 3, compartment_height],
    [ compartment_width, 4, compartment_height],
    [ compartment_width, 5, compartment_height],
    [ compartment_width, 7, compartment_height],
    
    [ compartment_width, 3, compartment_height],
    [ compartment_width, 3, compartment_height],
    [ compartment_width, 4, compartment_height],
    [ compartment_width, 4, compartment_height],
    [ compartment_width, 5, compartment_height],
    [ compartment_width, 4, compartment_height],

    [ compartment_width, 22, compartment_height],
    [ compartment_width, 3, compartment_height],
    [ compartment_width, 4, compartment_height],
    [ compartment_width, 4, compartment_height],
    [ compartment_width, 4, compartment_height],
    [ compartment_width, 4, compartment_height],

    [ compartment_width, 6, compartment_height],
    [ compartment_width, 4, compartment_height],
    [ compartment_width, 4, compartment_height],
    [ compartment_width, 4, compartment_height],
    [ compartment_width, 16, compartment_height],
  ]
];

star_realms_frontiers=[
  // divider_height = 60
  // compartment_width = 66
  // compartment_height = 91
  // lip_height = 10
  // caddy_lip = "yes"
  // cover_side_clearance= 0.3
  [
    // event
    [compartment_width,  8, compartment_height],
    //explorers
    [compartment_width, 10, compartment_height, -1],
    //main
    [compartment_width, 75, compartment_height],
    //expansion
    [compartment_width, 30, compartment_height],
    //rules/misc
    [compartment_width, 8, compartment_height],
    [compartment_width, 9, compartment_height],
  ],[
    [10,  140, compartment_height]
  ],[
    //players X 6
    [compartment_width, 6, compartment_height, -1],
    [compartment_width, 6, compartment_height,  1],
    [compartment_width, 6, compartment_height, -1],
    [compartment_width, 6, compartment_height,  1],
    [compartment_width, 6, compartment_height, -1],
    [compartment_width, 6, compartment_height,  1],

    //Command Decks x 11
    [compartment_width,  8, compartment_height],
    [compartment_width,  8, compartment_height],
    [compartment_width,  8, compartment_height],
    [compartment_width,  8, compartment_height],
    [compartment_width,  8, compartment_height],
    [compartment_width,  8, compartment_height],
    [compartment_width,  8, compartment_height],
    [compartment_width,  8, compartment_height],
    [compartment_width,  8, compartment_height],
    [compartment_width,  8, compartment_height],
    [compartment_width,  8, compartment_height],
  ]
];

// A vector of pockets defined by [width,thickness,height, alignment(<0:left , 0:center, >0:right)]
n_pockets=[  [    [compartment_width,  8, compartment_height],    [compartment_width, 10, compartment_height, -1],    [compartment_width, 75, compartment_height], [ compartment_width, 30, compartment_height],   [compartment_width, 8, compartment_height],    [compartment_width, 9, compartment_height],  ],[    [10,  140, compartment_height]  ],[    [compartment_width, 6, compartment_height, -1],    [compartment_width, 6, compartment_height,  1],    [compartment_width, 6, compartment_height, -1],    [compartment_width, 6, compartment_height,  1],    [compartment_width, 6, compartment_height, -1],    [compartment_width, 6, compartment_height,  1],    [compartment_width,  8, compartment_height],    [compartment_width,  8, compartment_height],    [compartment_width,  8, compartment_height],    [compartment_width,  8, compartment_height],    [compartment_width,  8, compartment_height],    [compartment_width,  8, compartment_height],    [compartment_width,  8, compartment_height],    [compartment_width,  8, compartment_height],    [compartment_width,  8, compartment_height],    [compartment_width,  8, compartment_height],    [compartment_width,  8, compartment_height],  ]];

// A vector of finger grooves radii for each column.  0 for no groove
fingers = [ 18, 0, 18 ];

compartments = n_pockets ? n_pockets : star_realms_frontiers;
rows = len(compartments);

function getAxisValuesFromVectorArray(v, a) = 
    [ for (i = [0: len(v) - 1]) v[i][a] ];

function addToVector(v, s) =
    [ for (i = [0: len(v) - 1]) v[i] + s ];

function sumPrevious(v, i, s=0) = 
    (i==s ? v[i] : v[i] + sumPrevious(v, i-1, s));
    
function getOffsets(v,s=0)=
    [ for (i = [0 : len(v)]) i==0 ? 0 : sumPrevious(v, i-1)+s ];

echo (compartments);
yValues = [for (i = [0:1 : rows-1]) getAxisValuesFromVectorArray(compartments[i], 1) ];
yValuesWithDividerThickness = [for (i = [0 : rows-1]) addToVector(yValues[i], divider_thickness) ];
offsets = [for (i = [0:1 : rows-1]) getOffsets(yValuesWithDividerThickness[i]) ];
    
echo ("Row ");
echo (yValues);
echo (yValuesWithDividerThickness);
echo ("Offsets:");
echo (offsets);

boxWidth_side = [for (i = [0:1: rows-1]) max(getAxisValuesFromVectorArray(compartments[i], 0)) ];
boxLength_side = [for (i = [0:1 : rows-1]) max(offsets[i][len(offsets[i])-2] + yValues[i][len(yValues[i])-1]) ];

boxWidth = max(sumPrevious(boxWidth_side, rows-1, 0), minimum_box_width);
boxLength = rows > 1 ? max(boxLength_side) : max(boxLength_side[0], minimum_box_length);

function computeDivider(r) =
    max(divider_thickness, (boxLength - boxLength_side[r] + divider_thickness * len(compartments[r]) ) / len(n_pockets[r]));

function initial_offset(r) =
    (computeDivider(r)/2 - divider_thickness) < 0 ? 0 : computeDivider(r)/2 - divider_thickness;

function rc_getOffsets(v, r, s=0) =
    [ for (i = [0 : len(v)]) i==0 ? initial_offset(r): sumPrevious(v, i-1)+initial_offset(r) ];

rc_yValuesWithDividerThickness = [for (i = [0 : rows-1]) addToVector(yValues[i], computeDivider(i)) ];
echo (rc_yValuesWithDividerThickness);
rc_offsets = [for (i = [0:1 : rows-1]) rc_getOffsets( rc_yValuesWithDividerThickness[i], i) ];
echo ("Recalculated Offsets:");
echo (rc_offsets);

echo(boxWidth);
echo(boxLength);

boxBody = [
    boxWidth + wall_thickness_minimum*(rows+2) + wall_thickness_minimum * (rows+2), 
    boxLength + wall_thickness_minimum*2,
    divider_height
];

echo("Box Size: ", boxBody);

boxBody_side = [ for (i = [0:1 : rows-1]) [boxWidth_side[i] + wall_thickness_minimum, boxLength_side[i], divider_height] ];
compartmentBlockWidth = [ for (i = [0:1 : rows-1]) max(getAxisValuesFromVectorArray(compartments[i], 0)) ];
compartmentBlockDepth = [ for (i = [0:1 : rows-1]) boxLength ];
compartmentBlockHeight = [ for (i = [0:1 : rows-1]) max(getAxisValuesFromVectorArray(compartments[i], 2)) ];

bodyXoffset = [ for (r = [0:1:rows-1]) sumPrevious(boxBody_side, r, 0) - boxBody_side[r]];
echo("BodyXoffset: ",bodyXoffset);

// ** lip **
lip = [
    boxBody[0] + lip_thickness*2 + cover_side_clearance*2,
    boxBody[1] + lip_thickness*2 + cover_side_clearance*2,
    lip_height,
];
lip_offset = lip_thickness + cover_side_clearance;

// ** cover **
cover = [
    boxBody[0] + lip_thickness*2 + cover_side_clearance*2,
    boxBody[1] + lip_thickness*2 + cover_side_clearance*2,
    compartmentBlockHeight[0] + lip_thickness + wall_thickness_minimum-lip_height +cover_top_clearance
];

// ** cover cavity **
coverCavity = [
    cover[0] - lip_thickness*2,
    cover[1] - lip_thickness*2,
    cover[2] - cover_top_clearance
];

module body(){
    union(){
      difference(){
        union(){ //mainbox
          translate([lip_offset,lip_offset,0])
           cube(size=boxBody);
          if(caddy_lip=="yes"){
            translate ([0,0,0])
             //color([0,0,1])
              cube(size=lip);
          };
        };
        for (r = [0:1: rows-1])
          union(){
            translate([ bodyXoffset[r][0] + boxBody_side[r][0]/2 + (wall_thickness_minimum*(r+1)) + lip_offset*2, lip_offset*2, 0 ])
            for (i=[0:1:len(compartments[r])-1]) 
                translate([
                    -compartments[r][i][0]/2 +
                    // ** stagger **
                    (
                        compartments[r][i][3]<0?
                         (compartments[r][i][0] - boxBody_side[r][0])/2 +wall_thickness_minimum:
                        compartments[r][i][3]>0?
                        -(compartments[r][i][0] - boxBody_side[r][0])/2 -wall_thickness_minimum
                        :0
                    ),
                    rc_offsets[r][i],
                    wall_thickness_minimum
                ])
                //color([1,0,1])
                cube( size=[
                    compartments[r][i][0],
                    compartments[r][i][1],
                    compartmentBlockHeight[r]
                ]);
          }
        for (r = [0:1: rows-1])
        // ** Finger Groove
          if (fingers[r] > 0) {
            translate( [bodyXoffset[r][0] + boxBody_side[r][0]/2 + wall_thickness_minimum*r + lip_offset*2, lip_thickness, divider_height] )
            rotate([270,0,0])
                cylinder(h = coverCavity[1], r=fingers[r], center = false, $fn=50);
        };
      }
    }
}

module cover(){
    translate ([0,0,cover[2]+lip_height])
    rotate([0,180,0])
    difference(){
        // Cover Body
        translate([
            -(cover[0] )/2, 
            -cover[1]/2, 
            lip_height
        ])
            cube(cover);
        // Inner Cavity
        translate([
            -coverCavity[0]/2,
            -coverCavity[1]/2, 
            lip_height-1
        ])
            cube(coverCavity);
    }
    echo(cover);
}

print_part();
module print_part() {
	if (outputs == "cover") {
        cover();
	} else if (outputs == "caddy") {
        translate([-boxBody[0]/2, -boxBody[1]/2, 0])
        body();
	} else if (outputs == "both") {     
        translate ([-boxBody[0] - 10 -lip_thickness, -boxBody[1]/2, 0]) 
            body();
        translate ([cover[0]/2+10,0,0])
            cover();
	} else {
		both();
	}
}
