//the length of the Mounting-Part
mountLength = 100; //[70:10:300]
//Width of the Extrusion, mostly 20mm
mountWidth = 20; //[10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
//overall Thickness
thickness = 5; //[1:0.5:15]
//Mounting Hole diameter, M5 will be 5.2mm
mountScrew = 5.2; //[[2.2:M2, 3.2:M3, 4.2:M4, 5.2:M5, 6.2:M6]
// Width of the Filament-Role = Length of the arm between the cones. You can reduce this by some Millimeters so that the role lays with its edge on the End-cones and not on the full arm-length. This may reduce friction, but maybe not.
roleWidth = 90;
//Radius of the end-cone
endConeRadius = 20; //[10:2:50]
//Overhang of endcone in degree. Use a value that fits your printer.0° will be no overhang (blocked because nonsense), 90° will be a horizontal endplate with the overall thickness (use support material!)
gradientEndcone = 40; //[10:5:90]
//Radius of the filamentrole holder (arm strength)
roleholderRadius = 6;//[2:2:50]

/*[hidden]*/
$fn = 80;
overlaping=0.01;

difference(){
    union(){
        //Mounting-Block
        cube([mountLength, mountWidth, thickness]);
        //Role-Holder
        color("red",1){
        translate([mountLength*2/3, mountWidth/2, thickness-overlaping]){
            cylinder(h=roleWidth+2*overlaping+(roleholderRadius-overlaping), r=roleholderRadius);
        }}
        //cone-style transition from mounting block to arm
        color("green",1){
        translate([mountLength*2/3, mountWidth/2, thickness-overlaping]){
            cylinder(h=roleholderRadius,r1=mountWidth/2, r2=roleholderRadius);
        }}
        //End-Block
        color("blue",1){
        translate([mountLength*2/3, mountWidth/2, roleWidth+thickness+(roleholderRadius-overlaping)]){
            difference(){
                height = tan(90-gradientEndcone)*(endConeRadius-roleholderRadius);
                union(){
                    cylinder(h=height,r1=roleholderRadius, r2=endConeRadius);
                    translate([0, 0, height-overlaping]){
                        cylinder(h=thickness,r=endConeRadius);
                    }
                }
                //hole in the Endblock for reducing material. With correction-faktor for very low gradientEndcone-values
                union(){
                    wallthickness = sqrt(pow((thickness*tan(90-gradientEndcone)),2)+pow(thickness,2));
                    translate([0,0,wallthickness]){
                        cylinder(h=height+3,r1=thickness/2, r2=endConeRadius);
                    }
                }
            }
        }}
    }
    //upper Screw-Hole
    translate([thickness+mountScrew, mountWidth/2, -1]){
        cylinder(h=thickness+2 , r=mountScrew/2);
    }
    //lower Screw-Hole
    translate([mountLength-(thickness+mountScrew), mountWidth/2, -1]){
        cylinder(h=thickness+2 , r=mountScrew/2);
    }
}