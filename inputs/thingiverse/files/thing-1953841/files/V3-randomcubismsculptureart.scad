/* Random experimental art

By Julián Caro Linares

jcarolinares@gmail.com

CC-BY-SA


*/

//--Cubes

//--Rules
/*
    - Between 1 and 5 cube per "layer"
    -Layer distance (Z axe) must be lower than the cubes height
    -Relatives positions related to the last generated cube, always inside the area of the cube to ensure the fusion betweeen solids

*/

//Parameters
/* [Cube's sizes] */
//Min Size of a Cube
mincubesize=10;  // [0:1000]
//Max size of a Cube
maxcubesize=50; // [0:1000]
/* [Cubes per layer] */
//Min of cubes per layer
mincubeslayer=2; // [0:100]
//Max of cubes per layer
maxcubeslayer=5; // [0:100]
/* [Layer's parameters] */
//Number of layers
numberoflayers=10; //[0:100]
//Distance between layers (It must be equal or less than mincubesize)
distanceoflayers=10; // [0:100] 
// Mode of rotated cubes
rotated_cubes="false"; // [false,true]




//Layer tree generator
for (layer =[0:1:numberoflayers-1])
{

//Random layer generator
//Get the number of cubes in this layer
cubesperlayer =round(rands(mincubeslayer,maxcubeslayer,1)[0]);
echo("Cubes per layer: ");
echo(cubesperlayer);


//Get the cubes sizes of the layer
cubessizes = rands(mincubesize,maxcubesize,cubesperlayer);
echo("Cubes sizes: ");
echo(cubessizes);



//If random sign is less than 0.5, then the number is negative
randomsign=rands(0,1,1);
echo("Randomsign: ");
echo(randomsign);



//Translation of the layer
translate([0,0,layer*distanceoflayers])
    {
//Layer construction
for (index =[0:1:cubesperlayer-1])
{
//cube(cubessizes[index]);

//Get the relative translation of the cubes based in the last cube generated
    if(index==0)
    {
        relativetranslationXY=rands(1,cubessizes[index],2);
        
        echo("Relative translation XY: ");
        echo(relativetranslationXY);
            
        translate([relativetranslationXY[0],relativetranslationXY[1],0])
        {
            randcolor=rands(0,1,3);
            
            //If we want to generated rotated cubes
            if(rotated_cubes=="true")
            {
                relativerotationZ=rands(0,360,1)[0];
                rotate([0,0,relativerotationZ])
                color(randcolor,a=1.0)
                cube(cubessizes[index]);
            }
            else
            {
                color(randcolor,a=1.0)
                cube(cubessizes[index]);   
            }
            
        }
    }
    else
    {
        relativetranslationXY=rands(1,cubessizes[index-1],2);
        
        echo("Relative translation XY: ");
        echo(relativetranslationXY); 
        
        
        translate([relativetranslationXY[0],relativetranslationXY[1],0])
        {
            randcolor=rands(0,1,3);
            
            //If we want to generated rotated cubes
            if(rotated_cubes==true)
            {
                relativerotationZ=rands(0,360,1)[0];
                rotate([0,0,relativerotationZ])
                color(randcolor,a=1.0)
                cube(cubessizes[index]);
            }
            else
            {
                color(randcolor,a=1.0)
                cube(cubessizes[index]);   
            }
        }
    }
}

}

}