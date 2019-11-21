// Max inner diameter of the tube [mm]
InnerDiameter = 30; 

// Outer diameter of the tube [mm]. This will determine the max. diameter of the cap.
OuterDiameter = 34;  

// Height of outer part of the cap [mm]
CapHeight=12; 

// How deep inside the tube the cap penetrates [mm]
InnerHeight=10;

// minimum diameter of the cap will be this ratio the vaule of InnerDiameter. Set 1 for cylinder shape and <1 for conical shape
Ratio=0.98; // [0.90:0.01:1]

//Thickness of the walls [mm]
WallThickness=2;  // [1:0.01:3]

Fillet=10; // Fillet radius for the CAP, should be less or equal than CapHeight. Zero for no fillet. Should be also less or equal than OuterDiameter/2.

// 1:Add rings, 0:Do not add rings
Ringsornot=1; //[0,1]

// This determines the distance of rings. 
RingsDistance=4;



// this part goes in the tube:

difference(){
translate([0,0,CapHeight-0.3])
cylinder(h=InnerHeight+0.3, r1=InnerDiameter/2, r2=Ratio*InnerDiameter/2, center=false);
translate([0,0,CapHeight-0.3])
cylinder(h=InnerHeight+0.3, r1=InnerDiameter/2-WallThickness, r2=Ratio*(InnerDiameter/2-WallThickness), center=false);}

$fn = 100;
// cap part


rotate_extrude(convexity = 10, $fn = 100)
intersection(){    
translate([OuterDiameter/2 - Fillet, Fillet, 0])
circle(r = Fillet, $fn = 100);
translate([OuterDiameter/2 - Fillet,0,0])
square(Fillet);}
    


difference(){
cylinder(h=CapHeight*0.9, r=OuterDiameter/2-Fillet, center=false);
translate([0,0,Fillet])
cylinder(h=CapHeight*0.9, r=InnerDiameter/2-WallThickness, center=false);
}   
    

difference(){
translate([0,0,Fillet])
cylinder(h=CapHeight-Fillet, r=OuterDiameter/2, center=false);
translate([0,0,Fillet])
cylinder(h=CapHeight-Fillet, r=(InnerDiameter/2-WallThickness), center=false);
}

//rings

end=floor(InnerHeight/RingsDistance);

if (Ringsornot==1)

for(i = [1 : end])
rotate_extrude(convexity = 10, $fn = 100)
translate([(1-((1-Ratio)*(i*RingsDistance/InnerHeight)))*InnerDiameter/2, CapHeight+i*RingsDistance-0.3, 0])
circle(r = 0.3, $fn = 100);