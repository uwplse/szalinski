// Customizable Letter Tiles
// Will Schleter (wschleter@gmail.com)
//  Dec 14, 2016 - original version
//  Oct 17, 2018 - added option to cut out the design

/* [Extrusion Settings] */
// this is how the image is added to the tile
cut_or_add = "add"; // [cut,add]
// extrusion height (mm)
e = 0.6;

/* [Text Settings] */
// Tile text
txt = "Z";
// Text size as percentage of tile height
ts = 0.75;
// Text aspect ratio - w/h
ar = 0.8;
// Text font
fn = "Serif"; // [Sans, Mono, Sans Narrow, Serif]
// Text style
tst = "bold italic"; //[:Regular,bold:Bold,italic:Italic,bold italic:Bold/Italic]

/* [Tile Settings] */
// Tile height (mm)
th = 15;
// Tile width (mm, use 0 to autosize)
tw = 15;
// Tile thickness (mm)
tt = 4;
// Tile separator - character in text used to split, leave empty to split on every character
sep = "";
// Tile width multiplier (use to adjust width of autosized tiles)
twm = 1;

/* [Hole Settings] */
// Hole diameter (mm)
d = 1;
// Number of side holes
ns = 2; // [0,1,2,3]
// Number of top holes
nt = 3; // [0,1,2,3]

/* [Chamfer Settings] */
// Top chamfer size (mm)
cht = 1;
// Side chamfer size (mm)
chs = 1;
// Corner chamfer size (mm)
chc = 1;
// Chamfers on bottom
chb = 1; // [0:No, 1:Yes]

/* [Layout Settings] */
// Number of tiles per row
tpr = 4;
// Tile spacing (mm)
sp = 2;

/* [Image Tile] */
// Use image (if set to yes the text settings will be ignored and a single tile generated)
useimg = 0; // [0:No, 1:Yes]
// Image height as percentage of tile height
ih = 0.75;
// Image width as percentage of tile width
iw = 0.75;
// Upload an 100x100 image that will be used
image_file = "dog.png"; // [image_surface:100x100]


// split text into tiles
txt2 = useimg==1 ? " " : txt;
list = len(sep)==0 ? str2vec(txt2) : split(txt2,sep);

// loop through each tile
h=th;
w=tw;
t=tt;
tilesperrow = (tw==0) ? 1 : tpr; // force tpr to be 1 if autowidth
for (j=[0:len(list)-1]) {
  // make and position each tile
  w = (tw>0) ? tw : (len(list[j]) + 0.5)*th*ts*ar*twm; 
  row = floor(j/tilesperrow);
  yy = -row*(h+sp);
  xx = (j-row*tilesperrow)*(w+sp);
  translate([xx,yy,0]) makeTile(list[j],w);
}

module makeBlankTile(w) {
    difference() {
      makeBlock(w);
      if (nt>0) { makeTopHoles(w); }
      if (ns>0) { makeSideHoles(w); }
      }
}
  
module makeTile(letter,w) {
    if (cut_or_add=="add") {
        union() {
        makeBlankTile(w);
        if (useimg) makeImage(w);
        else makeText(letter,w);
        }
    } else {
        difference() {
        makeBlankTile(w);
        if (useimg) makeImage(w);
        else makeText(letter,w);
        }
    }
}

module makeBlock(w) {
// three intersecting polygon extrusions are used to support chamfers on all edges
  intersection() {

// this is the y (height) polygon
  rotate([-90,0,0])
  linear_extrude(h)
  polygon([[chs,0],[w-chs,0],[w,chs],[w,t-chs*chb],[w-chs*chb,t],[chs*chb,t],[0,t-chs*chb],[0,chs]]);

 // this is the x (width) polygon
  translate([w,0,0])
  rotate([-90,0,90])
  linear_extrude(w)
  polygon([[cht,0],[h-cht,0],[h,cht],[h,t-cht*chb],[h-cht*chb,t],[cht*chb,t],[0,t-cht*chb],[0,cht]]);

 // this is the z (thickness) polygon
  translate([0,0,-t])
  rotate([0,0,0])
  linear_extrude(t)
  polygon([[chc,0],[w-chc,0],[w,chc],[w,h-chc],[w-chc,h],[chc,h],[0,h-chc],[0,chc]]);

}
}

module makeTopHoles(w) {
  s=w/(nt+1);
  for (i=[0:nt-1]) {
    translate([i*s+s,h/2,-t/2])
    rotate([-90,0,0])
    cylinder(h=h*2, d=d, center=true,$fn=36);
  }
}

module makeSideHoles(w) {
  s=h/(ns+1);
  for (i=[0:ns-1]) {
    translate([w/2,i*s+s,-t/2])
    rotate([0,90,0])
    cylinder(h=w*2, d=d, center=true,$fn=36);
  }
}
 
module makeText(letter,w) {
//text on top
  translate([w/2,h/2,-e])
  linear_extrude(height = e*2) 
  scale([ar,1,1])
  text(text = letter,
            font = str("Liberation ",fn,":style=",tst),
            size = h*ts,
            valign = "center",
            halign = "center");
  
}

module makeImage(w) {
translate([w*(1-iw)/2,h*(1-iw)/2,e])
scale([w*iw/(imgW-1),h*ih/(imgH-1),2*e])
surfaceNoBase(file=image_file,invert=true);
}

module surfaceNoBase(convexity=10,invert=false) {
    // when an XxY resolution image is loaded via the surface command,
    // it becomes an (X-1)x(Y-1)x101 solid image, with a rectangular base.
    // to further complicate things, if the invert option is used,
    // the resulting solid is shifted
    // this module removes the base and corrects for the shifting
    // note: centering isn't supported because I could not find a way of obtaining the image resolution
    
    translate([0,0,-1])  // shift back down to z=0
    intersection() {
        translate([0,0,invert ? 100:0]) // correct for shifting if inverted
        surface(file = file, invert=invert, convexity=convexity); // make the surface
        translate([0,0,1]) cube([1000,1000,100]); // this cube cuts of the bottom 2 units
    }
}
///////////////////////////////////////////////////////////////////
// functions below from http://www.thingiverse.com/thing:1237203 //
///////////////////////////////////////////////////////////////////

/**** split ****

[vect] split(`str`, `[sep]`)
Returns a vector of substrings by cutting the string `str` each time where `sep` appears.
See also: strcat(), str2vec()

Arguments:
- [str] `str`: The original string.
- [char] `sep`: The separator who cuts the string (" " by default).

Usage:
str = "OpenScad is a free CAD software.";
echo(split(str)); // ["OpenScad", "is", "a", "free", "CAD", "software."]
echo(split(str)[3]); // "free"
echo(split("foo;bar;baz", ";")); // ["foo", "bar", "baz"]
*/
function split(str, sep=" ", i=0, word="", v=[]) =
	i == len(str) ? concat(v, word) :
	str[i] == sep ? split(str, sep, i+1, "", concat(v, word)) :
	split(str, sep, i+1, str(word, str[i]), v);

/**** str2vec ****

[vect] str2vec(`str`)
Returns a vector of chars, corresponding to the string `str`.
See also: split()

Arguments:
- [str] `str`: The original string.

Usage:
echo(str2vec("foo")); // ["f", "o", "o"] 
*/
function str2vec(str, v=[], i=0) =
	i == len(str) ? v :
	str2vec(str, concat(v, str[i]), i+1);

/**** substr ****

[str] substr(`str`, `[pos]`, `[len]`)
Returns a substring of a string.

Arguments:
- [str] `str`: The original string.
- [int] `pos` (optional): The substring position (0 by default).
- [int] `len` (optional): The substring length (string length by default).

Usage:
str = "OpenScad is a free CAD software.";
echo(substr(str, 12)); // "a free CAD software."
echo(substr(str, 12, 10)); // "a free CAD"
echo(substr(str, len=8)); // or substr(str, 0, 8); // "OpenScad"
*/
function substr(str, pos=0, len=-1, substr="") =
	len == 0 ? substr :
	len == -1 ? substr(str, pos, len(str)-pos, substr) :
	substr(str, pos+1, len-1, str(substr, str[pos]));