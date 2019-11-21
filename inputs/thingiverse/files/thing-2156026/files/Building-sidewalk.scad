//CUSTOMIZER VARIABLES
// Building sizes are 71mmx109mm, 109mmx109mm or 109mmx180mm
// The width of the building.
width=109; //[71:71 mm / 2 3/4", 109:109mm / 4 1/4", 180:180mm / 7"]
// The length of the building.
length=109; //[71:71 mm / 2 3/4", 109:109mm / 4 1/4", 180:180mm / 7"]
// How high above the sidewalk to make the slot for the building to fit in, in mm. 3 is recommended.
slot_height=3.5; //[1:5]
// How thick is the material of the building in mm. Note that the building is double-thik in places. 2 mm recommended.
paper=2;
// How much should the sidewalk stick out from the building, in mm. 5 is standard.
sidewalk_width=5;
// How high is the sidewalk, in mm. 1.5 is standard.
sidewalkHeight=1.5;
// How deep to make the grooves for the sidewalk texture. Should be less than sidewalk height. 0.5 is standard.
groove_depth=0.5;
// Number of sidewalk squares along the length. 18 is standard for 7". 10 is standard for 4". The number is scaled for the width.
sidewalk_squares= length==180 ? 18 : length==109 ? 10 : 7;
//CUSTOMIZER VARIABLES END

// number of sidewalk squares along the width
sidewalk_squares_width = round(sidewalk_squares*width/length);

// How wide is the sidewalk - include room for the slot.
base_width=sidewalk_width+3*paper;

// Outer perimeter of the whole thing.
outer_width=width+3*paper+2*base_width;
outer_length=length+3*paper+2*base_width;

// Outer perimeter of the building slot
outerSlotWidth=width+3*paper;
outerSlotLength=length+3*paper;

// Outer perimeter of the bit to remove in the middle.
innerWidth=width-3*paper;
innerLength=length-3*paper;

include <RubbleDabble.scad>
cubes = (innerWidth * innerLength) / 200;
spheres = cubes * 0.5;
cylinders = cubes * 0.5;

module sidewalk() {
    //Sidewalk
    difference() {
        // base
        cube([outer_length, outer_width, sidewalkHeight]);
        //remove from base
        translate([base_width+3*paper, base_width+3*paper,-1]) cube([innerLength,innerWidth,slot_height+2]);
        
        // x-axis groove nearest street
        translate([groove_depth,groove_depth,sidewalkHeight-groove_depth]) {
            cube([outer_length-1, 0.5, groove_depth+1]);
        }
        translate([groove_depth,outer_width-1,sidewalkHeight-groove_depth]) {
            cube([outer_length-1, 0.5, groove_depth+1]);
        }
        // y-axis groove
        translate([groove_depth,groove_depth,sidewalkHeight-groove_depth]) { 
            cube([0.5, outer_width-1, groove_depth+1]);
        }
        translate([outer_length-1,groove_depth,sidewalkHeight-groove_depth]) { 
            cube([0.5, outer_width-1, groove_depth+1]);
        }
    
        // sidewalk squares Length
        for(x=[0:1:sidewalk_squares]) {
            translate([base_width+x*outerSlotLength/sidewalk_squares, groove_depth+0.5, sidewalkHeight-groove_depth]) 
                cube([groove_depth,base_width-groove_depth-0.5,groove_depth+1]);
            translate([base_width+x*outerSlotLength/sidewalk_squares, outer_width-base_width-groove_depth-0.5, sidewalkHeight-groove_depth]) 
                cube([groove_depth,base_width-groove_depth-0.5,groove_depth+1]);
        }
        // sidewalk squares Width
        for(x=[0:1:sidewalk_squares_width]) {
            translate([groove_depth, base_width+x*outerSlotWidth/sidewalk_squares_width, sidewalkHeight-groove_depth]) 
                cube([base_width-groove_depth-0.5,groove_depth,groove_depth+2]);
            translate([outer_length-base_width-groove_depth, base_width+x*outerSlotWidth/sidewalk_squares_width, sidewalkHeight-groove_depth]) 
                cube([base_width-groove_depth-0.5,groove_depth,groove_depth+2]);
        }
    }
}
module buildingSlot() {
    translate([base_width, base_width, sidewalkHeight]) {
        difference() {
            // outer building Slot
            cube([outerSlotLength, outerSlotWidth,slot_height]);
            // inner building Slot
            translate([3*paper,3*paper,-1]) cube([innerLength,innerWidth,slot_height+2]);
            // Lengthwise building slot
            translate([paper,paper,0]) cube([length+paper,paper,slot_height+1]);
            translate([paper,width+paper,0]) cube([length+paper,paper,slot_height+1]);
            // width-wise building slot
            translate([paper,paper,0]) cube([paper, width+paper,slot_height+1]);
            translate([length+paper,paper,0]) cube([paper, width+paper,slot_height+1]);
        }
    }
}

sidewalk();
buildingSlot();
translate([base_width+3*paper,base_width+3*paper,0]) rubble([innerLength, innerWidth,slot_height+sidewalkHeight] );
