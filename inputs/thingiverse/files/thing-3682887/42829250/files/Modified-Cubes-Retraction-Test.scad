/*---------------------------------------------------------
licenced under Creative Commons :
Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
http://creativecommons.org/licenses/by-nc-sa/4.0/

Based on the models found here: https://www.matterhackers.com/articles/retraction-just-say-no-to-oozing
and here: https://www.thingiverse.com/thing:1240361/files

Use this link to calibrate retraction using this model: https://www.matterhackers.com/articles/retraction-just-say-no-to-oozing

Basic Instructions - OpenSCAD:
1. The parameters below can be adjusted, though not all need to be.
2. make any required changes then hit F5 to view the model.
3. Press F6 to render and then export to STL.
4. Slice in your favourite software and print.

Note: There is no error checking so you need to use commnon-sense when changing parameters. 

v1.0 - First upload 16-Jun-2019
---------------------------------------------------------*/
//CUSTOMIZER VARIABLES
//these most likely should be changed

//The X dimension of the "cubes", this will affect overall length of the test piece.
cubeX=2.5; //[3:25]

//The Y dimension of the "cubes".
cubeY=10; //[5:25]

//The Z dimension or height of the "cubes".
cubeZ=10; //[10:25]

//The height of the baseplate used to keep pieces together, enter 0 to remove completely. 1mm default.
baseZ=1; //[0:5]

//The distance in mm between the first two "cubes", 10mm is default.
a=10; //[1:75]

//The distance in mm between the second two "cubes", 20mm is default.
b=20; //[1:75]

//The distance in mm between the third two "cubes", 40mm is default.
c=40; //[1:75]
//CUSTOMIZER VARIABLES END
//---------------------------------------------------------------------------------------
//You should not need to make any changes below this line.

translate([0,0,baseZ])
makeCube();

translate([cubeX+a,0,baseZ])
makeCube();

translate([cubeX*2+a+b,0,baseZ])
makeCube();

translate([cubeX*3+a+b+c,0,baseZ])
makeCube();

//make the base
cube([cubeX*4+a+b+c,cubeY,baseZ]);


module makeCube(){
    cube([cubeX,cubeY,cubeZ]);
}