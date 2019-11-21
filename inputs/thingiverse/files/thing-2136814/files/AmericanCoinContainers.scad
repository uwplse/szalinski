/*  
**  Name:  Customizable American Coin Container_3d_model
**  Author:  Chris Benson  @TheExtruder
**  Created:  2/24/2017
*/
coin = "Dollar" ; // [Pennies,Nickels,Dimes,Quarters,Dollar,Silver Eagles]

numberOfCoins = 25;

/* [Hidden] */
$fn = 100;
capHeight = 5;
wallThickness = 1;

print_part();

module print_part() {
	if (coin == "Pennies") {
        CreateContainerAndCap(
            numberOfCoins = numberOfCoins,
            coinHeight = 1.54,
            coinDiameter = 19.07,
            wallThickness = wallThickness,
            capHeight = capHeight
        );
	} else if (coin == "Nickels") {
        CreateContainerAndCap(
            numberOfCoins = numberOfCoins,
            coinHeight = 1.97,
            coinDiameter = 21.23,
            wallThickness = wallThickness,
            capHeight = capHeight
        );
	} else if (coin == "Dimes") {
		CreateContainerAndCap(
            numberOfCoins = numberOfCoins,
            coinHeight = 1.37,
            coinDiameter = 17.93,
            wallThickness = wallThickness,
            capHeight = capHeight
        );
    } else if (coin == "Quarters") {
		CreateContainerAndCap(
            numberOfCoins = numberOfCoins,
            coinHeight = 1.77,
            coinDiameter = 24.28,
            wallThickness = wallThickness,
            capHeight = capHeight
        );
    } else if (coin == "Dollar") {
		CreateContainerAndCap(
            numberOfCoins = numberOfCoins,
            coinHeight = 2.02,
            coinDiameter = 25.7,
            wallThickness = wallThickness,
            capHeight = capHeight
        );
    } else if (coin == "Silver Eagles") {
		CreateContainerAndCap(
            numberOfCoins = numberOfCoins,
            coinHeight = 3,
            coinDiameter = 41,
            wallThickness = wallThickness,
            capHeight = capHeight
        );
	}
}

module CreateContainerAndCap(numberOfCoins, coinHeight, coinDiameter, wallThickness, capHeight){
    CreateCylinder(numberOfCoins * coinHeight, coinDiameter, wallThickness);
    translate([coinDiameter + wallThickness + 5,0,0])
        CreateCylinder(capHeight, coinDiameter + wallThickness * 2, wallThickness);
}

module CreateCylinder(height,innerDiameter,wallThinkness){
    union(){
        //bottom
        cylinder(wallThickness, d=innerDiameter + (wallThickness * 2), true);
        
        translate([0,0,wallThickness]){
            difference(){
                //outer wall
                cylinder(height, d=innerDiameter + (wallThickness * 2), true);
                //inner wall
                cylinder(height, d=innerDiameter, true);
            }
        }
    }
}