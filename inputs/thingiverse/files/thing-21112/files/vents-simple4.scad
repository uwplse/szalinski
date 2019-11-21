/*
    INTRODUCTION

Fan adaptor in scad.

Versions:
1.11    Played around with a module for the flange. Works fine, but some more understanding is needed.
1.1.    Aiming for a more complex version now. I will try and use IF statements to choose between having a lower flange with holes going through the inside or not. Essentially emulating the thruholes and no holes versions of the SWorks files. Geometry still very simple and unrefined. There is a lot of repetition, I should get the hang of using modules and functions I guess.
1.      Very simple, two flanges, cowling, and no special treatment of lower flange holes.

Initial values are 120 to 80.

Very basic appearance at the moment, just testing out the software and getting a feel for it. I may tidy up in later versions and as I learn more about the software.
*/

/*  BASIC SETUP  */
//Select type option. Cowling: Small fan screws accessed through the cowling. External: Small fan screws accessed from outside of the adaptor. Customiser makes the "Cowling" option look messy, but they are fine once created. Flange: A simple flat plate with mounting holes for large and small size but no cowling. Very inefficient flow but a very low profile.
holeaccess="Cowling"; //[Cowling,External,Flange]

//Smoothing of cylindrical faces (Can be ignored under most circumstances)
$fn = 80;

/*  VARIABLES  */
//Nominal fan sizes
//Nominal size of the smaller fan
smallsize=80;
//Nominal size of the larger fan. It is possible to choose the same size for both. This can lead to funky results sometimes.
largesize=120;

//Flange thicknesses
//Small side flange thickness
smallflange=3; //[1:0.2:6]
//Large side flange thickness (flange thickness used for the "Flange" option above)
largeflange=4; //[1:0.2:6]

//Cowling size
//Total height is cowling height plus the flange thicknesses.
//Thickness of the cowling wall
wallthickness=2; //[1:0.2:5]
//Height of the cowling, taller generally leads to better airflow. Total height will be this plus flange thicknesses.
cowlingheight=30;

/*
Mounting hole spacing and size
Size is usually pretty uniform (4.5 mm) due to using standard screws however for smaller sizes the screw holes are likely smaller
*/
//Spacing
//Small fan side mounting hole spacing
smallholes=71.5;
//Large fan side mounting hole spacing
largeholes=105;
//Size
//Diameter of the mounting holes on the small fan side
smallholesize=4.5; //[2:0.25:6]
//Diameter of the mounting holes on the large fan side
largeholesize=4.5; //[2:0.25:6]


/*  MODULES  */
module flange (size_fan,thick_wall,thick_flange,space_mount,size_mount) {
/*
    Creates a flange with or without mounting holes cut.
    
    VARIABLES
size_fan:       The given nominal size of the fan
thick_wall:     The cowling wall thickness
thick_flange:   The thickness of the flange
space_mount:    The spacing between mounting holes. If 0 then no holes will be cut.
size_mount:     The diameter of the mounting holes
*/
    
//OPERATION
    //difference() to perform subtractive operations on the base flange piece
    difference(){
        //translate() half flange thickness from initial centre position.
        //This ensures the base small flange is sitting at z=0 on the XY plane.
        translate([0,0,thick_flange/2])
        //Uncut flange shape.
        cube(size=[size_fan+thick_wall*2, size_fan+thick_wall*2, thick_flange], center=true);
        
        //Cut fan hole
        translate([0,0,thick_flange/2])
        //Hole shape removed by the difference() operation
        cylinder(h=thick_flange, d=size_fan, center=true);
        
        //Check for mounting hole requirement
        if (space_mount>0) {
            //Cut each hole individually.
            //I haven't yet found a pattern command and mirror doesn't copy as far as I can see.
            //This way will suffice for now.
            translate([space_mount/2, space_mount/2, thick_flange/2])
            cylinder(h=thick_flange, d=size_mount, center=true);
            
            translate([-space_mount/2, space_mount/2, thick_flange/2])
            cylinder(h=thick_flange, d=size_mount, center=true);
            
            translate([space_mount/2, -space_mount/2, thick_flange/2])
            cylinder(h=thick_flange, d=size_mount, center=true);
            
            translate([-space_mount/2, -space_mount/2, thick_flange/2])
            cylinder(h=thick_flange, d=size_mount, center=true);
        } // if (space_mount>0)
        
        else { /*do nothing*/ } // else
        
    } // difference
} // module flange


/*
    MODEL CODE
    Starts with an if statement to distinguish between type choices.
    holeaccess variable is user choice.
        Choices are:
        1. Cowling:     Small side hole access from inside the cowling
        2. External:    Small side access from outside the adaptor
        3. Angled:      With an angle between flanges. Hole access is as external.
*/
if (holeaccess=="Cowling") {
/*
    MATHS
*/
//Calculate boss and countersink sizes
smallholeboss=smallholesize*3;
smallholecountersink=smallholesize*1.75;

//difference() to subtract the inner parts and mounting holes from a solid geometry.
difference(){
/*
union() command to join cowling and flanges together and add small side hole bosses.
    Lower flange built centred on the xy plane at z=0 
    Cowling built centrally on top of the lower flange
    Upper flange built centrally on top of the cowling

Create geometry:
1. lower flange
2. cowling
3. lower mounting hole bosses
4. upper flange
*/
    union(){
    //1. Lower flange
        translate([0,0,smallflange/2])
        //Uncut flange shape. Centred for ease. The position uses basic maths.
        cube(size=[smallsize+wallthickness*2, smallsize+wallthickness*2, smallflange], center=true);

    //2. Cowling
        translate([0,0,smallflange+cowlingheight/2])
        //tapered cylinder for cowling
        //difference to other tapered cylinder
        cylinder(h=cowlingheight, r1=smallsize/2+wallthickness, r2=largesize/2+wallthickness, center=true);

    //3. Lower mounting hole bosses
        /*
        Extruding the mounting hole bosses.
        I don't know of a way to extrude to a surface, so for now will do it this way.
        Mirror seems to not have a copy option, so I have to recreate each boss for each corner. Again, there is probably a better way to do it, but I will have to learn it.
        */
        translate([smallholes/2,smallholes/2, (cowlingheight+smallflange)/2])
        cylinder(h=cowlingheight+smallflange, d=smallholeboss, center=true);
        
        translate([-smallholes/2,smallholes/2, (cowlingheight+smallflange)/2])
        cylinder(h=cowlingheight+smallflange, d=smallholeboss, center=true);
        
        translate([smallholes/2,-smallholes/2, (cowlingheight+smallflange)/2])
        cylinder(h=cowlingheight+smallflange, d=smallholeboss, center=true);
        
        translate([-smallholes/2,-smallholes/2, (cowlingheight+smallflange)/2])
        cylinder(h=cowlingheight+smallflange, d=smallholeboss, center=true);
            
    //4. Upper flange
        translate([0,0,smallflange+cowlingheight])
        flange(largesize,wallthickness,largeflange,largeholes,largeholesize);        
    } //union

/*
Remove inner geometry:
1. lower flange fan hole
2. cowling
3. lower mounting holes
4. lower mounting hole countersink
*/
    //1. Lower flange fan hole
        translate([0,0,smallflange/2])
        //Uncut flange shape. Centred for ease. The position uses basic maths.
        cylinder(h=smallflange, d=smallsize, center=true);

    //2. Cowling
        translate([0,0,smallflange+cowlingheight/2])
        //tapered cylinder for cowling
        //difference to other tapered cylinder
        cylinder(h=cowlingheight, d1=smallsize, d2=largesize, center=true);
        
    //3. lower mounting holes
        /*
        Cutting the mounting holes.
        Mirror seems to not have a copy option, so I have to recreate each hole for each corner. Again, there is probably a better way to do it, but I will have to learn it.
        */
        translate([smallholes/2,smallholes/2,(smallflange+cowlingheight+largeflange)/2])
        cylinder(h=smallflange+cowlingheight+largeflange, d=smallholesize, center=true);
        
        translate([-smallholes/2,smallholes/2,(smallflange+cowlingheight+largeflange)/2])
        cylinder(h=smallflange+cowlingheight+largeflange, d=smallholesize, center=true);
        
        translate([smallholes/2,-smallholes/2,(smallflange+cowlingheight+largeflange)/2])
        cylinder(h=smallflange+cowlingheight+largeflange, d=smallholesize, center=true);
        
        translate([-smallholes/2,-smallholes/2,(smallflange+cowlingheight+largeflange)/2])
        cylinder(h=smallflange+cowlingheight+largeflange, d=smallholesize, center=true);
            
    //4. lower mounting hole countersink
        /*
        Cutting the mounting hole counter sinks.
        Mirror seems to not have a copy option, so I have to recreate each countersink for each corner. Again, there is probably a better way to do it, but I will have to learn it.
        */
        translate([smallholes/2,smallholes/2, (cowlingheight+largeflange)/2+smallflange])
        cylinder(h=cowlingheight+largeflange, d=smallholecountersink, center=true);
        
        translate([-smallholes/2,smallholes/2, (cowlingheight+largeflange)/2+smallflange])
        cylinder(h=cowlingheight+largeflange, d=smallholecountersink, center=true);
        
        translate([smallholes/2,-smallholes/2, (cowlingheight+largeflange)/2+smallflange])
        cylinder(h=cowlingheight+largeflange, d=smallholecountersink, center=true);
        
        translate([-smallholes/2,-smallholes/2, (cowlingheight+largeflange)/2+smallflange])
        cylinder(h=cowlingheight+largeflange, d=smallholecountersink, center=true);

} //difference
} //if

else if (holeaccess=="External") {
/*
1. Begin by revolving the shape of the cowling.
2: Add the lower and upper flanges using the flange() module

1. Revolve the cowling
Draw revolved polygon shape
This requires a polygon following points inside a rotate_extrude
*/
    
    rotate_extrude(angle=360, convexity=10)
        polygon(points=[[smallsize/2,smallflange],
        [(smallsize/2)+wallthickness,smallflange],
        [(largesize/2)+wallthickness,cowlingheight+smallflange],
        [largesize/2,cowlingheight+smallflange]]);
        
    //2. Use modules to create the flanges
    //Lower (smaller) flange
    flange(smallsize,wallthickness,smallflange,smallholes,smallholesize);

    //Upper (larger) flange
    translate([0,0,smallflange+cowlingheight])
    flange(largesize,wallthickness,largeflange,largeholes,largeholesize);
} //else if (holeaccess=="External")

else if (holeaccess=="Flange") {
/*
1. Create blank flange according to "largesize"
2. Cut "smallsize" hole into flange blank
3. Drill large size holes (largeholes, largeholesize)
4. Drill small size holes (smallholes, smallholesize)
*/
//1. Create blank flange according to "largesize"
//difference() to perform subtractive operations on the base flange piece
    difference(){
        //translate() half flange thickness from initial centre position.
        //This ensures the base small flange is sitting at z=0 on the XY plane.
        translate([0,0,largeflange/2])
        //Uncut flange shape.
        cube(size=[largesize+largeflange*2, largesize+largeflange*2, largeflange], center=true);
        //2. Cut "smallsize" hole into flange blank
        //Cut fan hole
        translate([0,0,largeflange/2])
        //Hole shape removed by the difference() operation
        cylinder(h=largeflange, d=smallsize, center=true);

//3. Drill large size holes (largeholes, largeholesize)
//4. Drill small size holes (smallholes, smallholesize)
    //Cut each largesize hole individually.
        translate([largeholes/2, largeholes/2, largeflange/2])
        cylinder(h=largeflange, d=largeholesize, center=true);
        
        translate([-largeholes/2, largeholes/2, largeflange/2])
        cylinder(h=largeflange, d=largeholesize, center=true);
        
        translate([largeholes/2, -largeholes/2, largeflange/2])
        cylinder(h=largeflange, d=largeholesize, center=true);
        
        translate([-largeholes/2, -largeholes/2, largeflange/2])
        cylinder(h=largeflange, d=largeholesize, center=true);
        
        //Cut each smallsize hole individually.
        translate([smallholes/2, smallholes/2, largeflange/2])
        cylinder(h=largeflange, d=smallholesize, center=true);
        
        translate([-smallholes/2, smallholes/2, largeflange/2])
        cylinder(h=largeflange, d=smallholesize, center=true);
        
        translate([smallholes/2, -smallholes/2, largeflange/2])
        cylinder(h=largeflange, d=smallholesize, center=true);
        
        translate([-smallholes/2, -smallholes/2, largeflange/2])
        cylinder(h=largeflange, d=smallholesize, center=true);
                } //difference()
} //else if (holeaccess=="Flange")