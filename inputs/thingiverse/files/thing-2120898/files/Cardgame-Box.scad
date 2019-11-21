outputs = "both"; // [cover:Cover Only,caddy:Caddy Only,both:Caddy and Cover]
caddy_lip = "yes"; // [no:no, yes:yes]

// A value of 0 will use the widest compartment width as the overall width of the box
minimum_box_width=0;
// A value of 0 will use the combined thickness of all the compartments and appropriate dividers.
minimum_box_length=0;
divider_thickness=1.5;
divider_height=40;
// Use compartment_width in the pocket array if compartments are all the same size
compartment_width=91;
// Use compartment_height in the pocket array if compartments are all the same size
compartment_height=64;
// Walls generated offset to the widest pocket 
wall_thickness_minimum=1.5;

finger_groove_radius=20;

// A vector of pockets defined by [width,thickness,height, alignment(<0:left , 0:center, >0:right)]
pockets=[[compartment_width,  10, compartment_height],[compartment_width, 88, compartment_height], [compartment_width, 7.5, compartment_height, -1],[compartment_width, 7.5, compartment_height,  1],[compartment_width, 7.5, compartment_height, -1],[compartment_width, 7.5, compartment_height,  1],[compartment_width,  7, compartment_height],[99,  25, compartment_height]];

starRealms = [
    //explorers
    [compartment_width,  10, compartment_height], 
    
    //main
    [compartment_width, 88, compartment_height], 
    
    //player decks x4
    [compartment_width, 7.5, compartment_height, -1], 
    [compartment_width, 7.5, compartment_height,  1],
    [compartment_width, 7.5, compartment_height, -1],
    [compartment_width, 7.5, compartment_height,  1],
    
    //missions and gambits
    [compartment_width,  7, compartment_height], 
    
    //accessories
    [               99,  25, compartment_height]  
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
echo (offsets);


// ** body **
boxWidth=max(max(getAxisValuesFromVectorArray(compartments, 0)),minimum_box_width);
boxLength=max(minimum_box_length,offsets[len(offsets)-2] + yValues[len(yValues)-1]);
boxBody = [
    boxWidth + wall_thickness_minimum*2,
    boxLength + wall_thickness_minimum*2,
    divider_height
];
echo(boxBody);
    
// ** lip **
lip = [
    boxBody[0] + wall_thickness_minimum*2,
    boxBody[1] + wall_thickness_minimum*2,
    wall_thickness_minimum*2,
];
module caddy(){
    
    difference(){
        // ** body **
        union(){
            translate ([-(boxBody[0]/2),-wall_thickness_minimum,0])
                color([0,1,0])
                cube(size=boxBody);
            echo (lip[2]);
            if(caddy_lip=="yes"){
                translate ([-(lip[0]/2),-wall_thickness_minimum*2,0])
                    color([0,0,1])
                    cube(size=lip);
            }
        }
        
        // ** compartments **
        union(){
            translate ([0,(boxBody[1]-offsets[len(offsets)-1]-wall_thickness_minimum)/2,0]){

                for (i=[0:1:len(compartments)]) 
                    translate([
                        -compartments[i][0]/2 +
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
                    color([1,0,0])
                    cube( size=[
                        compartments[i][0],
                        compartments[i][1],
                        compartments[i][2]
                    ]);
            }
            
            // ** Finger Groove
            if (finger_groove_radius>0) {
                translate( [0,-wall_thickness_minimum-1,divider_height] )
                rotate([270,0,0])
                    cylinder(h = offsets[len(offsets)-1] + (boxBody[1]-offsets[len(offsets)-1]-wall_thickness_minimum)/2, r=finger_groove_radius, center = false, $fn=300);
            }
        }
   }        
}


module cover(){    
    cover = [
        boxBody[0] + wall_thickness_minimum*2,
        boxBody[1] + wall_thickness_minimum*2,
        max(getAxisValuesFromVectorArray(compartments, 2)) + wall_thickness_minimum*3
    ];
    translate ([-boxWidth/2,0,0]) 
    difference(){
        color([0,1,0])
        cube(cover);
        translate ([wall_thickness_minimum,wall_thickness_minimum,wall_thickness_minimum])
        color([1,0,0])
            cube([
                cover[0] - wall_thickness_minimum*2,
                cover[1] - wall_thickness_minimum*2,
                cover[2]
            ]);
    }
    echo(cover);
}


// ** Render Parts **
//translate (-[boxBody[0]/2+wall_thickness_minimum + 10, -wall_thickness_minimum*2, 0]) 
//caddy();
//translate ([boxWidth/2+10,0,0]) 
//cover();


print_part();
module print_part() {
	if (outputs == "cover") {
        cover();
	} else if (outputs == "caddy") {
        caddy();
	} else if (outputs == "both") {     
        translate (-[boxBody[0]/2+wall_thickness_minimum + 10, -wall_thickness_minimum*2, 0]) 
        caddy();
        translate ([boxWidth/2+10,0,0]) 
        cover();
	} else {
		both();
	}
}




