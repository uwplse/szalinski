/*
Bananagrams replacement/custom tile maker
There should be 144 tiles in the game; they are: A=13, B=3, C=3, D=6, E=18, F=3, G=4, H=3, I=12, J=2, K=2, L=5, M=3, N=8, O=11, P=3, Q=2, R=9, S=6, T=9, U=6, V=3, W=3, X=2, Y=3, Z=2.
*/
letter="◊";
lettersize=11;
/* [Hidden] */
TileThickness=4.65;
TileWidth=18.7;
TileHeight=18.7;
EdgeRadius=.75;
LetterDepth=.75;

$fn=50;

difference()
{
    hull()
    {
        translate([TileWidth/2-EdgeRadius,TileHeight/2-EdgeRadius,TileThickness/2-EdgeRadius]) sphere(r = EdgeRadius);
        translate([-(TileWidth/2-EdgeRadius),TileHeight/2-EdgeRadius,TileThickness/2-EdgeRadius]) sphere(r = EdgeRadius);
        translate([TileWidth/2-EdgeRadius,-(TileHeight/2-EdgeRadius),TileThickness/2-EdgeRadius]) sphere(r = EdgeRadius);
        translate([-(TileWidth/2-EdgeRadius),-(TileHeight/2-EdgeRadius),TileThickness/2-EdgeRadius]) sphere(r = EdgeRadius);

        translate([TileWidth/2-EdgeRadius,TileHeight/2-EdgeRadius,-(TileThickness/2-EdgeRadius)]) sphere(r = EdgeRadius);
        translate([-(TileWidth/2-EdgeRadius),TileHeight/2-EdgeRadius,-(TileThickness/2-EdgeRadius)]) sphere(r = EdgeRadius);
        translate([TileWidth/2-EdgeRadius,-(TileHeight/2-EdgeRadius),-(TileThickness/2-EdgeRadius)]) sphere(r = EdgeRadius);
        translate([-(TileWidth/2-EdgeRadius),-(TileHeight/2-EdgeRadius),-(TileThickness/2-EdgeRadius)]) sphere(r = EdgeRadius);
    }
    translate([0,0,TileThickness/2-LetterDepth]) linear_extrude(LetterDepth){text(letter, size = lettersize, font = "Arial:style=Regular", halign = "center", valign = "center");};
/*
    translate([0,0,0]) cube([55,20,1]);
    translate([5,11,0.5]) linear_extrude(0.5){text("Press Button", size = 5, font = "Arial:style=Regular");};
    translate([5,4,0.5]) linear_extrude(0.5){text("To Open", size = 5, font = "Arial:style=Regular");};
    translate([50,7,0.5]) cube([1,10,0.5]);
*/
}