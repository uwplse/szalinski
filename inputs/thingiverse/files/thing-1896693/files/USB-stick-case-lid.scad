notchWidth = 1.2; //Width of slots on the side of the PCB
portLength = 23.4; //Distance between the front of the slot to the end of the USB port
boardLength = 23.4; //Dsitance from the rear of the slot to the back of the board
boardWidth = 14.7; // Width from one side of the board to the other
capacity = "4GB"; //The capacity of the drive to be written on the bottom
textSize = 10; // If you have a very large or small drive you can change the text size (default = 6)

USBLength = 12.2; // The required length of protruding port (should remain constant)
USBWidth = 12.7; // The width of a USB port (should remain constant)

unitLength = boardLength+notchWidth+(portLength-USBLength)+2;
difference(){
    translate([0, 0, -0.5])
        cube([boardWidth+2, unitLength,1], center=true);
    translate([0,0,-0.6])
        rotate([180,0,90])
            linear_extrude(height = 0.5)
                text(text = capacity, font = "Liberation Sans:style=Bold", size = textSize, valign = "center", halign = "center");
}
difference(){
    translate([0, -0.5, 0.5])
        cube([boardWidth-0.4, unitLength-3.2,1], center = true);
    translate([0, 1, 0.5])
        cube([boardWidth-2.4, unitLength-2,1.1], center = true);
}