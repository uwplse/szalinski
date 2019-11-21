//CUSTOMIZER VARIABLES

//Facet number
Definition = 100;


//The radus of the model (at mid height; top and bottom radius is calculated based on Hole Pitch)
Model_Radius = 40;

//The radius of the center hole (at midpoint; set to 0 to disable; should be considerably smaller than the Model Radius)
Internal_Radius = 30;

//The height of the entire model
Height = 15;

//The amount of material cut off of the top edge of the model (should be greater than 0; 0 to disable)
Bevel = 5;

//The angle of the applied bevel
Bevel_Angle = 40; // [0:90]

//The number of pen/pencil holes
Hole_Number = 20;

//Radius of the pen/pencil holes
Hole_Radius = 4;

//The sideways tilt of the pen/pencil holes
Hole_Angle = 20; // [-90:90]

//The inwards tilt of the pen/pencil holes
Hole_Pitch = 15; // [-45:45]

//The distance of the holes from the center of the model (shold be slightly less than the Model Radius)
Hole_Distance = 37;

//Test function (should be set to export when model is saved)
Test = "export"; // [test,export]


module penholder(intrad,thickness,height,bevel,bevelangle,holenum,holerad,dist,angle,severity,test){

difference(){

cylinder(height,thickness+(tan(severity)*height/2),thickness-(tan(severity)*height/2),center = true);
cylinder(height+2,intrad+(tan(severity)*(height+2)/2),intrad-(tan(severity)*(height+2)/2),center = true);

for(n = [0:holenum-1]){

rotate([0,0,n*(360/holenum)])translate([dist,0,0])rotate([angle,-severity,0])cylinder(height*2,holerad,holerad,center = true);

};

translate([0,0,height/2-bevel+thickness/2])rotate_extrude($fn = 100)translate([thickness,0,0])rotate([0,0,-bevelangle-45])circle(thickness/2,$fn = 4);

};

if(test == "test"){

#for(n = [0:holenum-1]){

rotate([0,0,n*(360/holenum)])translate([dist,0,0])rotate([angle,-severity,0])translate([0,0,-height/2])cylinder(150,holerad-0.5,holerad-0.5);

};

};

};

penholder(Internal_Radius,Model_Radius,Height,Bevel,Bevel_Angle,Hole_Number,Hole_Radius,Hole_Distance,Hole_Angle,Hole_Pitch,Test,$fn = Definition);