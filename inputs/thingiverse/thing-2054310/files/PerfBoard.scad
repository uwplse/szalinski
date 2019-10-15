/* 
Parametric Perfboard for electronics
with or without screw holes
*/


boardLength = 27; //Length in MM
boardWidth = 16; //Width in MM
boardThickness =1.5; //Thickness in MM
//Add screw holes (true or false)
screwHoles = 1; //[1:true,0:false]
screwHoleDiameter =  2.5; //Screw Hole Diameter

holesModuloX = (boardLength%2.54);
holesModuloY = (boardWidth%2.54);
holesLength = (boardLength-holesModuloX)/2.54;
holesWidth = (boardWidth-holesModuloY)/2.54;


boardLayout();
//throughHole();
//throughHoleLayout();

module boardLayout(){
    difference(){
        boardFlat();
        if (screwHoles==1)
            screwHolesLayout();
        throughHoleLayout();
    }
    dimensions();
}
module dimensions(){
    echo("Dimensions ",boardLength,"x",boardWidth,"x",boardThickness);
    echo("Hole Pattern ",holesLength,"x",holesWidth);
    if (screwHoles==1)
    echo("Screw Locations on center ", boardLength-screwHoleDiameter*6/4,"x",boardWidth-screwHoleDiameter*6/4);
}

module screwHolesLayout(){
    translate([0+screwHoleDiameter/4,0+screwHoleDiameter/4,0]) screwHole();
    translate([0+screwHoleDiameter/4,boardWidth-screwHoleDiameter*5/4,0]) screwHole();
    translate([boardLength-screwHoleDiameter*5/4,0+screwHoleDiameter/4,0]) screwHole();
    translate([boardLength-screwHoleDiameter*5/4,boardWidth-screwHoleDiameter*5/4,0]) screwHole();
    
}
module throughHoleLayout(){
    translate([holesModuloX/2,holesModuloY/2,0]){
        for (x = [1:holesLength]){
            for(y=[1:holesWidth]){
                translate([x*2.54-2.54/2,y*2.54-2.54/2,0]) throughHole();
            }
        }
    }
}


module boardFlat(){
    translate([]) cube([boardLength,boardWidth,boardThickness]);
}
module throughHole(){
    translate([0,0,boardThickness/2]) rotate([0,0,45]) cylinder (d=1.5,h=boardThickness,center=true,$fn=4);
}
module screwHole(){
    translate([screwHoleDiameter/2,screwHoleDiameter/2,boardThickness/2]) cylinder(d=screwHoleDiameter,h=boardThickness,center=true,$fn=36);
}