//
// IKEA Ivar Hook
// This is hook for hanging electronics or other stuff on vertical planks
// Originally designed to hang my Fritz!Box Router on the side of a IKEA
// Ivar shelf.
//
// 2018 by David Riedl
// It's my first build with OpenSCAD. Enjoy remixing it!


// Thickness of the IVAR wooden support (a.k.a. inner height)
innercavityZ = 11;

// Material thickness
hookthickness = 5;

// Length of the two hook ends
hookX = 45;
// Width of the whole hook
hookY = 15;

// Width of the hole for the screw head
mushroomhead = 7.5;
// Width of the narrow part of the hole
mushroomstem = 4;

// These two values should be the total depth of the hole of the device
mushroomstemheight = 4;
mushroomheadheight = 2;

$fn = 50; 

union () {
 //rotating for optimal printing (optional)
 //rotate (a = [0,-90,0]){
    
    //bottom horizontal beam
    translate ([hookthickness,0,0]) {
        cube ([hookX,hookY,hookthickness], center = false);
        }
    //vertical beam
    cube ([hookthickness,hookY,hookthickness * 2 + innercavityZ], center = false);
    //top horizontal beam
    translate ([hookthickness,0,hookthickness + innercavityZ]) {
        cube ([hookX,hookY,hookthickness], center = false);
        }
    
    //hook for device   
    //stem
    translate ([mushroomhead / 2 ,hookY / 2,hookthickness * 2 + innercavityZ]) { 
        cylinder (mushroomstemheight, mushroomstem / 2,mushroomstem / 2 , center = false);
        }
        
    //detail1
    translate ([mushroomhead / 2 ,hookY / 2,hookthickness * 2 + innercavityZ]) { 
        cylinder (mushroomstemheight /3, mushroomhead /2,mushroomstem /2 , center = false);
        }

    //head
    translate ([mushroomhead / 2 ,hookY / 2,hookthickness * 2 + innercavityZ + mushroomstemheight]) {
        cylinder (mushroomheadheight,mushroomhead / 2,mushroomhead / 2, center = false);
        }
}

//}