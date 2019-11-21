//Once the lens assembly of the C920 is removed, this adapter 
//can be used to mount the image sensor without lens directly 
//over a 25mm microscope trinocular. The 25mm mount fits the 
//camera adapter of the Amscope SM-3T/SM-4T series. 
//Friction fit on microscope side, M2.5

//Best printed using dark, non-translucent filament to reduce 
//stray light. 


wallThickness=1.2;    //Reasonable wall thickness for adapter. 
                      //1.2mm is plenty for this aplication.

heightM12=13;         //The lower, smaller cylindrical part of the adapter is 13mm high
radiusM12=12.5/2;     //The lower, smaler  part of the adapter has a 12.5mm diameter thru hole
radiusM2=2.2/2;       //Thru hole diameter for M2.5 self tapping srews is 2.2mm 
                      //This is to mount the adapter on PCB
screwHeight=13;       //Thru hole height for self tapping screws. 
                      //Mounting screws to mount the adapter on the PCB screws can be up to 14mm long.
screwSpacing=16.5/2;  //Lens mounting holes of Logitech C920 PCB are 16.5mm apart


MicroscopeRadius=(25/2)+0.2; //The microscope adapter should fit over a 25mm flange. 25mm diameter + 0.4mm extra 
MicroscopeHeight=10;         //The larger cylindrical part of the adapter is 10mm tall

$fn=240;                    //renders pretty fine, reduce number to e.g. 64 for faster rendering.

difference()
{
union()
    {
    translate([0,0,heightM12-(wallThickness/2)])cylinder(r1=radiusM12+wallThickness,r2=MicroscopeRadius+wallThickness, h=MicroscopeHeight, center = true);
    translate([0,0,heightM12+MicroscopeHeight-(wallThickness/2)])cylinder(r=MicroscopeRadius+wallThickness, h=MicroscopeHeight, center = true);

    translate([0,screwSpacing,screwHeight/2])cylinder(r=radiusM2+wallThickness-0.25, h=screwHeight, center=true);
    translate([0,-screwSpacing,screwHeight/2])cylinder(r=radiusM2+wallThickness-0.25, h=screwHeight, center=true);
    translate([0,0,heightM12/2])cylinder(r=radiusM12+wallThickness, h=heightM12, center=true);
    }
    
translate([0,0,heightM12+MicroscopeHeight])cylinder( r=MicroscopeRadius, h=MicroscopeHeight, center = true);
    
translate([0,0,heightM12+(wallThickness/2)])cylinder(r1=radiusM12, r2=MicroscopeRadius, h=MicroscopeHeight-wallThickness, center = true);

translate([0,0,heightM12/2])cylinder(r=radiusM12, h=heightM12, center=true);

    translate([0,screwSpacing,screwHeight/2])cylinder(r=radiusM2, h=screwHeight, center=true);
    translate([0,-screwSpacing,screwHeight/2])cylinder(r=radiusM2, h=screwHeight, center=true);

}
