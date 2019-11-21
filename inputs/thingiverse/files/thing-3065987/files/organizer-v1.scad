echo(version=version());


//Number of wrench slots
NumSlots = 9;
//Width of front slot
Slot1 = 4.5;
//Width of last (back) slot
SlotLast = 5.7;
//Depth of cut of the deepest (back) slot
SlotDepth = 22;
//Angle to rotate slots back
SlotAngle = 30;
//Spacing between each of the slots
SlotSpacing = 15;
//Slope of the bottom of each slot, in degrees
SlotBottomSlope = 4.4;
//Slope of the top of each slot, in degrees
SlotTopSlope = 8.6;
//Set width of front of model
FrontWidth = 40;
//Set width of back of model
BackWidth = 136;
//Sets additional thickness to front of model, offsetting from first slot
FrontOffset = 5;
//Sets additional thickness to bottom of model, offsetting underneath the slots
BottomOffset = 10; 

/* [Hidden] */

//used to calculate linear gradation of slot widths from front to back
SlotSizeStep = (SlotLast-Slot1)/NumSlots;

//widths of front and back parts of model
w1 = FrontWidth/2;
w2 = BackWidth/2;
//total length, front to back
l = (NumSlots+1)*(SlotSpacing);
//total height, bottom to top (height of back of model)
h = BottomOffset+ l * tan(SlotBottomSlope) + SlotDepth*cos(SlotAngle);

//Poly1 is extruded into the basic shape of the model
Poly1 = [[-w1,0],[w1,0],[w2,l],[-w2,l]];

//z1,y1 finds the top, back corner of the first slot
z1 = BottomOffset+SlotDepth*cos(SlotAngle); 
y1 = FrontOffset+Slot1+(SlotDepth*sin(SlotAngle));
//z2,y2 finds the top, back corner of the last slot
y2 = ((NumSlots-1)*SlotSpacing)+y1;
z2 = (y2-y1)*tan(SlotBottomSlope)+z1;
//z3 finds the intersection of the top slope with the front of the model. 
z3 = z2-(y2*tan(SlotTopSlope));
//Poly2 draws the polygon that will be extruded to remove and shape the top slope of the model (this polygon is the "side view" of what needs to be removed (differenced)
Poly2 = [[z2,y2],[z2,l],[h+1,l],[h+1,0],[z3,0]];


// 


difference(){
    linear_extrude(height=h)
        offset(r=5)
        offset(r=-5)
        polygon(Poly1);

    linear_extrude(height=h)
        offset(r=5)
        offset(r=-10)
        polygon(Poly1);

    translate([w2,0,0])
    rotate([0,-90,0])
    linear_extrude(height=BackWidth)
        polygon(Poly2);
    
    for (a =[0:NumSlots-1])
     translate([0, FrontOffset+Slot1+(a*SlotSpacing)+(0*SlotSizeStep), BottomOffset +((a)*tan(SlotBottomSlope)*SlotSpacing)])
        rotate([-SlotAngle,0,0])
            translate([-(BackWidth/2),-(Slot1+a*SlotSizeStep),0])
            cube([BackWidth,Slot1+(a*SlotSizeStep),SlotDepth], center=false); 
}

/*
difference(){


    translate([0, 0, 0])
        linear_extrude(height = 156, scale = [0.5,0.5])
            translate([0,20,0])
            square([136, 40], center=true);
    
    translate([0, 5, 5])
        linear_extrude(height = 156-10, scale = [0.5,0.5*(156-5)/156])
            translate([0,20,0])
            square([136-10, 40-10], center=true);
}
*/