//Outer Radius of Bearing to be Used
BearingOuterRad=100;
//Thickness of Bearing to be Used
BearingThickness=100;
//Radius of Bolt Head For Fastening
BoltHeadRadius=15;


//Driven Variables
    //Main Body Dimensions
MainBodyCylThickness=BearingThickness+10;
MainBodyCylRad=BearingOuterRad+10;

    //Bearing Support Block Dimensions
BearingSupportBlockHeightX=MainBodyCylRad;
BearingSupportBlockLengthY=2*MainBodyCylRad;
BearingSupportBlockThickZ=MainBodyCylThickness;
BearingSupportBlockYshift=-1*MainBodyCylRad;

    //Bolt Flange Block Dimensions
FlangeHeightX=.5*MainBodyCylRad;
FlangeLengthY=2*MainBodyCylRad+8*BoltHeadRadius;
FlangeThickZ=MainBodyCylThickness;
FlangeBlockXshift=MainBodyCylRad;
FlangeBlockYshift=-.5*FlangeLengthY;

    //Bearing Seat Dimensions
BearingSeatRad=BearingOuterRad;
BearingSeatThickness=MainBodyCylThickness-4;
    
    //Main Cut Out Dimensions
MainCutOutRadius=BearingOuterRad-5;
MainCutOutThickness=MainBodyCylThickness+1;
    
    

//This Difference Subtracts the Main Cutout From the Pillow Block
difference(){

//This Difference Subtracts the BearingSeat From the Pillow Block
difference(){

//This Union Unites Main Body Cylinder and Bearing Support Block to Flange Block
union(){
    
//This Union Unites Main Body Cylinder with Bearing Support Block
union(){

//Main Body Cylinder
translate([0,0,0])rotate([0,0,0])cylinder(MainBodyCylThickness,MainBodyCylRad,MainBodyCylRad);

//Bearing Support Block
translate([0,BearingSupportBlockYshift,0])rotate([0,0,0])cube([BearingSupportBlockHeightX,BearingSupportBlockLengthY,BearingSupportBlockThickZ]);
    
};


//Flange Block
translate([FlangeBlockXshift,FlangeBlockYshift,0])rotate([0,0,0])cube([FlangeHeightX,FlangeLengthY,FlangeThickZ]);

};

//Bearing Seat
translate([0,0,-1])rotate([0,0,0])cylinder(BearingSeatThickness,BearingSeatRad,BearingSeatRad);

};

//Main Cut Out
translate([0,0,0])rotate([0,0,0])cylinder(MainCutOutThickness,MainCutOutRadius,MainCutOutRadius);
};