//!OpenSCAD

// The useable length of the Clip
Clip_Length = 100;
// The height of the clip
Clip_Height = 15;
// The thickness of one of the two arms
Arm_Thickness = 6;

// Your extrusion width (Width of the molten plastic trace of your nozzle - Usally your nozzle diameter)
Extrusion_Width = 0.4;
// Your layer height
Layer_Height = 0.2;

// The amount of noses and slots to create
Amount_Noses = 2;
// The length how far a nose is standing out
Noses_Size = 1;

// The angle how far the clip is opened
Opening_Angle = 30;

// How much the clip has to be bowed to snap (I recommend 2mm for PLA and 3mm for ABS)
Clip_Overstand = 2;

//Circle Resolution
$fn = 64;

translate([0,0,Clip_Height/2])
union() {
    // Upper part
    translate([Clip_Length/2 + Arm_Thickness + 1.75*Extrusion_Width, 0, 0])
        rotate([0, 0, -Opening_Angle])
            translate([-Clip_Length/2 - Arm_Thickness - 1.75*Extrusion_Width, 0, 0])
                union() {
                    translate([0,Arm_Thickness/2 + Extrusion_Width/4, 0])
                        cube([Clip_Length, Arm_Thickness, Clip_Height], center=true);
    
                    for(i = [1 : 1 : Amount_Noses]) 
                        translate([0, Extrusion_Width/4, -Clip_Height/2 + i*Clip_Height/(Amount_Noses + 1)])
                            rotate([45,0,0])
                                cube([Clip_Length, sqrt(2)*Noses_Size, sqrt(2)*Noses_Size], center=true);
    
                    translate([(Clip_Length + Arm_Thickness + 1.75*Extrusion_Width)/2, Arm_Thickness/2 + Extrusion_Width/4, 0])
                        cube([Arm_Thickness + 1.75*Extrusion_Width, Arm_Thickness, Clip_Height/2-Layer_Height], center=true);
    
                    translate([Clip_Length/2 + Arm_Thickness + 1.75*Extrusion_Width, 0, 0])
                        cylinder(r = Arm_Thickness/2, h = Clip_Height, center=true);
                }
    
    // Lower part
    difference() {
        union() {
            translate([(Arm_Thickness + 1.75*Extrusion_Width)/2, -Arm_Thickness/2 - Extrusion_Width/4, 0])
                cube([Clip_Length + Arm_Thickness + 1.75*Extrusion_Width, Arm_Thickness, Clip_Height], center=true);
            
            translate([Clip_Length/2 + Arm_Thickness + 1.75*Extrusion_Width, 0, 0])
                cylinder(r = Arm_Thickness + Extrusion_Width/4, h = Clip_Height, center=true);
            
            translate([-(Clip_Length + 5.5*Extrusion_Width)/2, -Arm_Thickness + 1.75*Extrusion_Width, 0])
                cube([5.5*Extrusion_Width, 4*Extrusion_Width, Clip_Height], center=true);
            
            translate([-Clip_Length/2 - 3.5*Extrusion_Width, 0.75*Extrusion_Width, 0])
                cube([4*Extrusion_Width, 2*Arm_Thickness + 2*Extrusion_Width, Clip_Height], center=true);
            
            translate([-Clip_Length/2 - 5.5*Extrusion_Width, Arm_Thickness + 1.75*Extrusion_Width , 0])
                polyhedron( points = [[0, 0, -Clip_Height/2], [Clip_Overstand + 5.5*Extrusion_Width, 0, -Clip_Height/2], [5.5*Extrusion_Width, Clip_Overstand, -Clip_Height/2], [0, Clip_Overstand, -Clip_Height/2], [0, 0, Clip_Height/2], [Clip_Overstand + 5.5*Extrusion_Width, 0, Clip_Height/2], [5.5*Extrusion_Width, Clip_Overstand, Clip_Height/2], [0, Clip_Overstand, Clip_Height/2]], faces = [[0,1,2,3], [4,7,6,5], [0,4,5,1], [1,5,6,2], [2,6,7,3], [3,7,4,0]], convexity = 10);
        }
        
        for(i = [1 : 1 : Amount_Noses]) 
            translate([Extrusion_Width/4, -Extrusion_Width/4, -Clip_Height/2 + i*Clip_Height/(Amount_Noses + 1)])
                rotate([45,0,0])
                    cube([Clip_Length + Extrusion_Width/2, sqrt(2)*Noses_Size, sqrt(2)*Noses_Size], center=true);
        
        translate([Clip_Length/2 + Arm_Thickness + 1.75*Extrusion_Width, 0, 0])
            cylinder(r = Arm_Thickness/2 + 1.25*Extrusion_Width, h = Clip_Height, center=true);
        
        translate([Clip_Length/2 + Arm_Thickness + 1.75*Extrusion_Width, Arm_Thickness/2, 0])
            cube([2*Arm_Thickness + Extrusion_Width/2, Arm_Thickness + Extrusion_Width/2, Clip_Height/2 + Layer_Height], center=true);
        
        translate([-Clip_Length/2 + Clip_Height/4, -Arm_Thickness + 4.5*Extrusion_Width, 0])
            cube([Clip_Height/2, 1.5*Extrusion_Width, Clip_Height], center=true);
    }
}