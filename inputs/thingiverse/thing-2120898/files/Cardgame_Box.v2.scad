outputs = "both"; // [cover:Cover Only,caddy:Caddy Only,both:Caddy and Cover]

// A value of 0 will use the widest compartment width as the overall width of the box
minimum_box_width=0;
// A value of 0 will use the combined thickness of all the compartments and appropriate dividers.
minimum_box_length=0;
// Thickness of the dividers separating the individual pockets
divider_thickness=1.5;
// This will determine how high the body walls will go. This value must be lower than the compartment height.
divider_height=60;
// Use compartment_width in the pocket array if compartments are all the same size
compartment_width=91;
// Use compartment_height in the pocket array if compartments are all the same size
compartment_height=64;
// The thickness of each wall (Not counting the lip thickness)
wall_thickness_minimum=1.5;

// For easy content removal
finger_groove_radius=30;

// A single groove that cuts through all pockets, or a hole under each pocket
finger_groove_type="horizontal";//[none:none, horizontal:horizontal, vertical:vertical]

// Amount of height to add to the top cover
cover_top_clearance=1;
// Amount of material to add to the sides of the cover's sides and lip thickness
cover_side_clearance=.1;

// Serves as the stopper for the cover, preventing the cover from squishing the top of the compartments
caddy_lip = "yes"; // [no:no, yes:yes]

// Height of the lip. A higher value means less material needed for the cover
lip_height=42;

// Thickness of the caddy lip. Also determines the thickness of the cover walls.
lip_thickness = 2;



// A vector of pockets defined by [width,thickness,height, alignment(<0:left , 0:center, >0:right)]
pockets=[[compartment_width,  10, compartment_height],[compartment_width, 88, compartment_height], [compartment_width, 7.5, compartment_height, -1],[compartment_width, 7.5, compartment_height,  1],[compartment_width, 7.5, compartment_height, -1],[compartment_width, 7.5, compartment_height,  1],[compartment_width,  7, compartment_height],[99,  25, compartment_height]];

starRealms = 
    [
        //explorers
        [compartment_width,  10, compartment_height], //10
        
        //main
        [compartment_width, 88, compartment_height], //88
        
        //player decks x4
        [compartment_width, 7.5, compartment_height,    -1], 
        [compartment_width, 7.5, compartment_height,     1],
        [compartment_width, 7.5, compartment_height,    -1],
        [compartment_width, 7.5, compartment_height+15,  1],
        
        //missions and gambits
        [compartment_width,   7, compartment_height], 
        
        //accessories
        [               99,  25, compartment_height]  
    ];

epicSpellWars = 
    [
        [60, 30, 20],
        [60, 30, 20]
    ];
compartments=pockets?pockets:starRealms;

function getAxisValuesFromVectorArray(v, a) = 
    [ for (i = [0: len(v) - 1]) v[i][a] ];

function addToVector(v, s) =
    [ for (i = [0: len(v) - 1]) v[i] + s ];

function sumPrevious(v, i, s=0) = 
    (i==s ? v[i] : v[i] + sumPrevious(v, i-1, s));
    
function getOffsets(v,s=0)=
    [ for (i = [0 : len(v)]) i==0 ? 0 : sumPrevious(v, i-1)+s ];


// ** compartments **
echo (compartments);
yValues = getAxisValuesFromVectorArray(compartments, 1);    
echo (yValues);
yValuesWithDividerThickness = addToVector(yValues, divider_thickness);    
echo (yValuesWithDividerThickness);
offsets = getOffsets(yValuesWithDividerThickness,0);    
echo ("Offsets:");
echo (offsets);


// ** body **
boxWidth=max(max(getAxisValuesFromVectorArray(compartments, 0)),minimum_box_width);
boxLength=max(minimum_box_length,offsets[len(offsets)-2] + yValues[len(yValues)-1]);
boxBody = [
    boxWidth + wall_thickness_minimum*2,
    boxLength + wall_thickness_minimum*2,
    divider_height
];
compartmentBlockWidth  = max(getAxisValuesFromVectorArray(compartments, 0));
compartmentBlockDepth  = boxLength;
compartmentBlockHeight = max(getAxisValuesFromVectorArray(compartments, 2));


// ** lip **
lip = [
    boxBody[0] + lip_thickness*2 + cover_side_clearance*2,
    boxBody[1] + lip_thickness*2 + cover_side_clearance*2,
    lip_height,
];

// ** cover **
cover = [
    boxBody[0] + lip_thickness*2 + cover_side_clearance*2,
    boxBody[1] + lip_thickness*2 + cover_side_clearance*2,
    compartmentBlockHeight + lip_thickness + wall_thickness_minimum-lip_height +cover_top_clearance
];

// ** cover cavity **
coverCavity = [
    cover[0] - lip_thickness*2,
    cover[1] - lip_thickness*2,
    cover[2] - cover_top_clearance
];

module body(){    
    difference(){
        union(){
            translate (-[boxBody[0]/2,boxBody[1]/2,0])
                cube(size=boxBody);
            if(caddy_lip=="yes"){
                translate ([-(lip[0]/2),-lip[1]/2,0])
                    //color([0,0,1])
                    cube(size=lip);
            }
        }
        translate ([0,-compartmentBlockDepth/2,0])
        union(){
            for (i=[0:1:len(compartments)-1]) 
                translate([
                    -compartments[i][0]/2 +
                    // ** stagger **
                    (
                        compartments[i][3]<0?
                         (compartments[i][0] - boxBody[0])/2+wall_thickness_minimum:
                        compartments[i][3]>0?
                        -(compartments[i][0] - boxBody[0])/2-wall_thickness_minimum
                        :0
                    ),
                    offsets[i],
                    wall_thickness_minimum
                ])
                cube( size=[
                    compartments[i][0],
                    compartments[i][1],
                    compartmentBlockHeight
                ]);
            ;
                
            // ** Finger Groove
            if (finger_groove_type=="vertical") {
                for (i=[0:1:len(compartments)-1]) 
                    translate([
                        0,
                        offsets[i]+compartments[i][1]/2,
                        -1
                    ])
                    color([0,1,0])
                    cylinder(h = compartmentBlockHeight, r=finger_groove_radius, center = false, $fn=50);
                ;
            }
            // ** debugger **
            //color([0,0,1])
            //translate([-compartmentBlockWidth/2,0,wall_thickness_minimum])
            //cube([compartmentBlockWidth,compartmentBlockDepth,compartmentBlockHeight]);
            
        }
        
        // ** Finger Groove
        if (finger_groove_type=="horizontal") {
            translate( [0,-coverCavity[1]/2,divider_height] )
            rotate([270,0,0])
                cylinder(h = coverCavity[1], r=finger_groove_radius, center = false, $fn=50);
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
        body();
	} else if (outputs == "both") {     
        translate ([-boxBody[0]/2 - 10 -lip_thickness, 0, 0]) 
            body();
        translate ([cover[0]/2+10,0,0])
            cover();
	} else {
		both();
	}
}




