/*
----------------------------
-------Customization---------
----------------------------
*/

//Beam Outer Dimension
Size = 20; 
//Deeper plugs are more rigid
PlugDepth = 5;
//Center Post Diameter
CenterDiameter = 4.15;
//Center Post Depth
CenterDepth = 8;
//Width of interior slot edge
SlotWidth = 5;
//Depth of slot from outside edge
SlotDepth = 5.9;
//Thickness of slot lip
LipThickness = 2;
//Angle of slot lip
LipAngle = 45;

/*
----------------------------
-------Plug----------------
----------------------------
*/

module plug(width=20, depth=5, centerDepth=8, centerDiameter=4.15, lipThickness=2, lipAngle=45, slotWidth=5, slotDepth=5.9) {
    
    halfSlot = 0 - (slotWidth / 2);
    trueCenterDepth = centerDepth + 2;
    halfWidth = 0 - (width / 2);
    
    //Lip Polyhedron Derivation
    lipTransX = (lipThickness * tan(lipAngle));
    lipTransY = 0 - lipThickness;
    lipPolyPoints = [
        [0,0,0],                                    //0
        [slotWidth,0,0],                            //1
        [slotWidth + lipTransX,lipTransY,0],        //2
        [0 - lipTransX,lipTransY,0],                //3
        [0,0,depth],                            //4
        [slotWidth,0,depth],                    //5
        [slotWidth + lipTransX,lipTransY,depth],//6
        [0 - lipTransX,lipTransY,depth]         //7
    ];
    lipPolyFaces = [
        [0,3,2,1], //Bottom
        [0,1,5,4], //Front
        [0,4,7,3], //Right
        [6,5,1,2], //Left
        [6,2,3,7], //Back
        [6,7,4,5]  //Top
    ];
    
    //Plug Connector Polyhedron Derivation
    plugConnTrans = width / 5;
    plugConnHeight = width * 0.75;
    plugConnPolyPoints = [
        [0,0,0],                                    //0
        [0,3,0],                                    //1
        [0.4,3,0],                                  //2
        [0.4,3.2,0],                                //3
        [plugConnTrans - 0.4,3.9,0],                //4
        [plugConnTrans,3.9,0],                      //5
        [plugConnTrans,0,0],                        //6
        [0,0,plugConnHeight],                       //7
        [0,3,plugConnHeight],                       //8
        [0.4,3,plugConnHeight],                     //9
        [0.4,3.2,plugConnHeight],                   //10
        [plugConnTrans - 0.4,3.9,plugConnHeight],   //11
        [plugConnTrans,3.9,plugConnHeight],         //12
        [plugConnTrans,0,plugConnHeight],           //13
    ];
    plugConnPolyFaces = [
        [0,7,13,6],         //Front
        [6,13,12,5],        //Right
        [0,1,8,7],          //Left
        [0,6,5,4,3,2,1],    //Bottom
        [7,8,9,10,11,12,13],//Top
        [1,2,9,8],          //BackLeftA
        [2,3,10,9],         //BackLeftB
        [3,4,11,10],        //BackCenter
        [4,5,12,11],        //BackRight
    ];

    union() {
        cube([width,width,2], center=true); //Base Structure
        translate([0,0,1]) for(i = [0:3]) {    //Lip Generation
            angle = 90 * i;
            rotate(angle, [0,0,1]) {
                translate([halfWidth,halfWidth,0]) 
                    cube([width,lipThickness,2]);
                difference() {
                    translate([halfSlot,halfWidth + lipThickness,0])
                        union() {
                            cube([slotWidth,slotDepth - lipThickness,depth + 2]);
                            translate([0,0,2])
                                polyhedron(lipPolyPoints, lipPolyFaces);
                        }
                    translate([0 - ((slotWidth / 10) / 2), halfWidth - 1,2])
                        cube([slotWidth / 10,slotDepth + 2,depth + 1]);
                }
            }
        }
        translate([0,0,1]) { //Center Post
            difference() {
                difference() {
                    cylinder(h=trueCenterDepth,d=centerDiameter);
                    cylinder(h=trueCenterDepth + 1,d=centerDiameter - 1);
                }
            translate([-0.5,-1 - (centerDiameter / 2),4])
                cube([1,centerDiameter + 2,centerDepth]);
            }
        }
        translate([halfWidth,halfWidth,-9]) //Base of connector
            cube([width,width / 4, 8]);
        translate([0 - (width / 10),halfWidth,-9]) //Post of connector
            cube([width / 5,width,8]);
        translate([0,0 - halfWidth,-9]) //Flanges of connector
            rotate(90, [1,0,0]) {
                mirror([1,0,0])
                    translate([width / 10,0,0])
                        polyhedron(plugConnPolyPoints, plugConnPolyFaces);
                translate([width / 10,0,0])
                        polyhedron(plugConnPolyPoints, plugConnPolyFaces);
            }
    }
}
translate([-12,0,1]) plug(width=Size, depth=PlugDepth, centerDepth=CenterDepth, centerDiameter=CenterDiameter, lipThickness=LipThickness, slotWidth=SlotWidth, slotDepth=SlotDepth, lipAngle=LipAngle);

/*
----------------------------
-------ConnectorBase--------
----------------------------
*/
module connector(width=20) {
    
    halfWidth = 0 - (width / 2);
    //Connector Polyhedron Derivation
    connTrans = width / 5;
    connHeight = width * 0.75;
    connPolyPoints = [
        [0,0,0],                    //0
        [0,0,3.4],                  //1
        [connTrans,0,3.4],          //2
        [connTrans,0,-1],           //3
        [0,connHeight,0],           //4
        [0,connHeight,3.4],         //5
        [connTrans,connHeight,3.4], //6
        [connTrans,connHeight,-1]   //7
    ];

    connPolyFaces = [
        [0,3,2,1], //Bottom
        [4,5,6,7], //Top
        [6,5,1,2], //Front
        [7,6,2,3], //Left
        [5,4,0,1], //Right
        [4,7,3,0]  //Back
    ];
    
    union() {
        cube([width,width,2], center=true); //Base Structure
        mirror([1,0,0]) {
            translate([halfWidth,0 - (width / 4), 1]) {
                cube([(width / 5) - 0.4,width * 0.75,8]);
                translate([(width / 5) - 0.4,0,4.6])
                    polyhedron(connPolyPoints, connPolyFaces);
            }
        }
        translate([halfWidth,0 - (width / 4), 1]) {
                cube([(width / 5) - 0.4,width * 0.75,8]);
                translate([(width / 5) - 0.4,0,4.6])
                    polyhedron(connPolyPoints, connPolyFaces);
        }
    }
}
translate([Size + 4,0,2])
    rotate(90, [0,0,1])
        rotate(90, [-1,0,0])
            connector(width=Size);