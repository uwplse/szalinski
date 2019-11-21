
depth = 60;
width = 105;
height = 20;

slotHeight = 7;
numSlots = 3;
numCylinders = 7;
edgeThickness = 4;


$fn=16;// make this number smaller to speed up generation when playing with measurements
letter_height = 3;
letter_size = 11;

font = "Liberation Sans";
frontText = "front text";
backText = "back text";
rightText = "right";
leftText = "left";

union()
{
    // front angled text
    color("gray")  translate([width/2, 5, height/2]) rotate([60,0,0]) linear_extrude(height = letter_height) {text(frontText, size = letter_size, font = font, halign = "center", valign = "center", $fn = 16);}
    // back flat text
    color("gray")  translate([width/2, depth-1, height/2]) rotate([90,0,180]) linear_extrude(height = letter_height) {text(backText, size = letter_size, font = font, halign = "center", valign = "center", $fn = 16);}
    // Right flat text
    color("gray")  translate([width-1, depth/2, height/2]) rotate([90,0,90]) linear_extrude(height = letter_height) {text(rightText, size = letter_size, font = font, halign = "center", valign = "center", $fn = 16);}
    // Right flat text
    color("gray")  translate([1, depth/2, height/2]) rotate([90,0,270]) linear_extrude(height = letter_height) {text(leftText, size = letter_size, font = font, halign = "center", valign = "center", $fn = 16);}


    difference()
    {
        cube([width, depth, height]);
        
        // front area
        translate([-1,0,height/5]) rotate([60,0,0]) cube([width+2, depth+2, height+1]);
        
        
        actualNumSlots = numSlots + 1;
        for(i = [0:actualNumSlots-1])
        {
            translate([edgeThickness,depth/actualNumSlots * (i),height/5]) rotate([60,0,0]) cube([width-edgeThickness*2, depth-4, slotHeight]);
            
        }
        
        color("gray")  translate([width/2, depth/4, 1]) rotate([180,0,0]) linear_extrude(height = letter_height) {text("Design by :", size = letter_size, font = font, halign = "center", valign = "center", $fn = 16);}
        color("gray")  translate([width/2, depth*2/4, 1]) rotate([180,0,0]) linear_extrude(height = letter_height) {text("TroyF", size = letter_size, font = font, halign = "center", valign = "center", $fn = 16);}
        color("gray")  translate([width/2, depth*3/4, 1]) rotate([180,0,0]) linear_extrude(height = letter_height) {text("On Thingiverse", size = letter_size, font = font, halign = "center", valign = "center", $fn = 16);}
    }
    
    // cylinders running from back to front to break up the slots so round coins dont slide around too much
    actualNumCylinders = numCylinders + 1;
    for(i = [1:actualNumCylinders-1])
    {
        translate([width/actualNumCylinders * i,10,height/4]) rotate([-90,0,0]) cylinder(h = depth-10, d = height/3);
        
    }
}