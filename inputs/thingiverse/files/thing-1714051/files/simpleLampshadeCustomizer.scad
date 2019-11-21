//Changes the appearance
Crumpled = "yes"; // [yes,no]
//Adjust number of sides to the lampshade
numberOfSides=3;// [3,4,5,6,7,8,9,10]
//Setting this to 1 will only display the internal socket holder
numberOfLayers=3; //[1,2,3,4,5,6]
distanceBetweenLayers=75; //[60:100]
//base Diameter Parameter
baseD=120; // [100:150]
//how many mm larger the next layer diameter will be
diameterIncreaseByLayer=20; //[5:45]
//in mm
Wall_Thickness=5; 
//I recommend leaving this to yes to help prevent heat buildup
Include_Heat_Escape_Holes = "yes"; // [yes,no]


// ignore variable values
socketOD=40+1;
socketStraightH=40+1;
socketSphereD=40+1;
holeForCordW=19+1;
holeForCordH=26+1;


poly=50;

if(Crumpled=="yes"){
difference(){
    ODCrumpled();
    IDCrumpled();
}
}

else{
    difference(){
    ODNotCrumpled();
    IDNotCrumpled();
}
}
  

    base();
    socketHolder();



module base(){
    difference(){
        layer(baseD,20,0,0);
        cylinder(d=socketOD+Wall_Thickness*4,h=Wall_Thickness,$fn=poly);
        if(Include_Heat_Escape_Holes == "yes"){
        heatHoles();
        }
    }
}

module ODNotCrumpled(){
for(i=[0:1:numberOfLayers-2]){
        hull(){
    hull(){
        layer(baseD+i*diameterIncreaseByLayer,20,distanceBetweenLayers*i,i);
        layer(baseD+(i+1)*diameterIncreaseByLayer,20,distanceBetweenLayers*(i+1),i+1);
    }
    if(i+2<numberOfLayers){
        layer(baseD+(i+2)*diameterIncreaseByLayer,20,distanceBetweenLayers*(i+2),i+2);
    }
    }
}
}

module IDNotCrumpled(){
for(i=[0:1:numberOfLayers-2]){
            hull(){
    hull(){
        layer(baseD+i*diameterIncreaseByLayer,20-Wall_Thickness,distanceBetweenLayers*i,i);
        layer(baseD+(i+1)*diameterIncreaseByLayer,20-Wall_Thickness,distanceBetweenLayers*(i+1),i+1);
    }
    if(i+2<numberOfLayers){
        layer(baseD+(i+2)*diameterIncreaseByLayer,20-Wall_Thickness,distanceBetweenLayers*(i+2),i+2);
    }
            
    }
}
}

module ODCrumpled(){
for(i=[0:1:numberOfLayers-2]){
    hull(){
        layer(baseD+i*diameterIncreaseByLayer,20,distanceBetweenLayers*i,i);
        layer(baseD+(i+1)*diameterIncreaseByLayer,20,distanceBetweenLayers*(i+1),i+1);
    }
}
}

module IDCrumpled(){
for(i=[0:1:numberOfLayers-2]){
    hull(){
        layer(baseD+i*diameterIncreaseByLayer,20-Wall_Thickness,distanceBetweenLayers*i,i);
        layer(baseD+(i+1)*diameterIncreaseByLayer,20-Wall_Thickness,distanceBetweenLayers*(i+1),i+1);
    }
}
}

module layer(x,r,z,i){
    translate([0,0,z])linear_extrude(height=5)rotate([0,0,i*(360/(numberOfSides*2))])minkowski(){
    circle(d=x,$fn=numberOfSides);
       circle(d=r,$fn=poly);
}
}

module socketHolder(){
    difference(){
        hull(){
         cylinder(d=socketOD+Wall_Thickness*4,h=Wall_Thickness,$fn=poly);
         translate([0,0,socketStraightH+socketSphereD/2])cylinder(d=socketOD+Wall_Thickness,h=Wall_Thickness,$fn=poly);
        }
        socket();
}
}

module socket(){
        translate([0,0,socketSphereD/2+Wall_Thickness])cylinder(d=socketOD,h=socketStraightH,$fn=poly);
        translate([0,0,socketSphereD/2+Wall_Thickness])sphere(d=socketSphereD,$fn=poly);
        translate([0,0,Wall_Thickness*2])cube([holeForCordW,holeForCordH,Wall_Thickness*4],center=true);
}

module heatHoles(){
    translate([0,0,-5])for(i=[0:360/numberOfSides:360]){
     translate([(socketOD/2+Wall_Thickness*4)*cos(i),(socketOD/2+Wall_Thickness*4)*sin(i),0])cylinder(d=10,h=80,$fn=poly);   
    }
}