notchDepth = 1.2; //Depth of slots on the side of the PCB
notchWidth = 1.2; //Width of slots on the side of the PCB
portLength = 23.4; //Distance between the front of the slot to the end of the USB port
boardLength = 23.4; //Dsitance from the rear of the slot to the back of the board
boardWidth = 14.7; // Width from one side of the board to the other, you may want to add some tolerance
capacity = "4GB"; //The capacity of the drive to be written on the bottom
textSize = 10; // If you have a very large or small drive you can change the text size (default = 6)

USBLength = 12.2; // The required length of protruding port (should remain constant)
USBHeight = 4.6; // The height of a USB port (should remain constant)
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
translate([0, (unitLength-1)/-2, ((USBHeight+2)/2)-1])
    cube([boardWidth+2, 1, USBHeight+2], center=true);
difference(){
    translate([0, (unitLength-1)/2, ((USBHeight+2)/2)-1])
        cube([boardWidth+2, 1, USBHeight+2], center=true);
    translate([0, (unitLength-1)/2, ((USBHeight+2)/2)+0.1])
        cube([USBWidth, 1.1, USBHeight+0.1], center=true);
}
translate([(boardWidth/2)+0.5, 0, ((USBHeight+2)/2)-1])
    cube([1, unitLength, USBHeight+2],center = true);
translate([-(boardWidth/2)-0.5, 0, ((USBHeight+2)/2)-1])
    cube([1, unitLength, USBHeight+2],center = true);
translate([(boardWidth/2)-0.5, ((unitLength-1)/2)-(portLength-USBLength), ((USBHeight)/2)])
    cube([notchDepth-(notchDepth*0.3), notchWidth-(notchWidth*0.3), USBHeight], center = true);
translate([(boardWidth/-2)+0.5, ((unitLength-1)/2)-(portLength-USBLength), ((USBHeight)/2)])
    cube([notchDepth-(notchDepth*0.3), notchWidth-(notchWidth*0.3), USBHeight], center = true);