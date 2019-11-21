/* +----------------------------------+
   |    ULTIMATE CONFIGURABLE DICE    |
   +----------------------------------+
   | First release: 01 DEC 2016       |
   | Author: Henrik Sozzi             |
   | Country: Italy                   |
   | E-Mail: henrik_sozzi@hotmail.com |
   +----------------------------------+-----------------------+
   | Twitter: https://twitter.com/henriksozzi                 |
   | Thingiverse: http://www.thingiverse.com/energywave/about |
   | 3DHUB: https://www.3dhubs.com/milan/hubs/3d-lab          |
   | Shapeways: http://3dlabshop.com                          |
   +----------------------------------------------------------+
   | LICENSE: Creative Commons - Attribution - Non-Commercial |
   | All uses not included in the license like, but not       |
   | limited to, commercial use should be authorized by the   |
   | author in a written form. If not authorized all other    |
   | uses are forbidden and persecuted by law.                |
   +----------------------------------------------------------+
*/
// Dice size in (mm)
DiceSide = 20; // [5:1:50]
// How much to "spherize" the dice. 0=cube, 10=normal, 20=max roundness
Roundness = 10; // [0:1:20]
// How depth to engrave faces with given images (mm)
EngravingDepth = 1; // [0.1:0.1:5]
// Face 1 engraving image (heightmap)
Side1Engraving = "1.png"; // [image_surface:100x100]
// Face 2 engraving image (heightmap)
Side2Engraving = "2.png"; // [image_surface:100x100]
// Face 3 engraving image (heightmap)
Side3Engraving = "3.png"; // [image_surface:100x100]
// Face 4 engraving image (heightmap)
Side4Engraving = "4.png"; // [image_surface:100x100]
// Face 5 engraving image (heightmap)
Side5Engraving = "5.png"; // [image_surface:100x100]
// Face 6 engraving image (heightmap)
Side6Engraving = "6.png"; // [image_surface:100x100]


/* [Hidden] */
// This is a shortcut if you want to change texture-set using same files in subfolders.
// Set the following to the subfolder name where the 6 engraving textures are stored
// Must terminate with "\\" like "Textures - Names\\"
TextureFolder = "";

// Don't touch the following constants :)
SphereRadius = DiceSide * ((1-Roundness/10)*(0.87-0.70)+0.70);
EngravingCorrection = -0.014;
SizeCorrection = 1.01;
Mult = (15-(Roundness-10))/15;
SurfaceSide = (Roundness>10 ? DiceSide*Mult : DiceSide) * SizeCorrection;

difference(){
    intersection(){
        cube(DiceSide, true);
        sphere(SphereRadius, true, $fn=100);
    }
    SideSub(1);
    SideSub(2);
    SideSub(3);
    SideSub(4);
    SideSub(5);
    SideSub(6);
}

module SideSub(Number){

    if (Number == 1)
    {
        mirror([1,0,0])
        translate([0,0,DiceSide/2-EngravingCorrection])
        rotate([0,180,0])
        resize([SurfaceSide, SurfaceSide, EngravingDepth])
        surface(file = str(TextureFolder, Side1Engraving), center = true, invert = false);
    }
    else if (Number == 2)
    {
        rotate([-90,0,0])
        mirror([0,1,0])
        translate([DiceSide/2-EngravingCorrection,0,0])
        rotate([0,270,00])
        resize([SurfaceSide, SurfaceSide, EngravingDepth])
        surface(file = str(TextureFolder, Side2Engraving), center = true, invert = false);
    }
    else if (Number == 3)
    {
        mirror([1,0,0])
        translate([0,DiceSide/2-EngravingCorrection,0])
        rotate([90,0,0])
        resize([SurfaceSide, SurfaceSide, EngravingDepth])
        surface(file = str(TextureFolder, Side3Engraving), center = true, invert = false);
    }
    else if (Number == 4)
    {
        mirror([0,0,1])
        translate([0,-(DiceSide/2-EngravingCorrection),0])
        rotate([270,0,0])
        resize([SurfaceSide, SurfaceSide, EngravingDepth])
        surface(file = str(TextureFolder, Side4Engraving), center = true, invert = false);
    }
    else if (Number == 5)
    {
        rotate([-90,0,0])
        mirror([0,1,0])
        translate([-(DiceSide/2-EngravingCorrection),0,0])
        rotate([0,90,0])
        resize([SurfaceSide, SurfaceSide, EngravingDepth])
        surface(file = str(TextureFolder, Side5Engraving), center = true, invert = false);
    }
    else
    {
        mirror([0,1,0])
        translate([0,0,-(DiceSide/2-EngravingCorrection)])
        resize([SurfaceSide, SurfaceSide, EngravingDepth])
        surface(file = str(TextureFolder, Side6Engraving), center = true, invert = false);
    }
}
