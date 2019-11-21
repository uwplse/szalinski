/******************** INTRO ********************/{
/*This SCAD file is for quick and easy creation of custom "Outer_Rings" for the cryptex design "Combination Safe 00" http://www.thingiverse.com/thing:586169

 I've made this file as easy as possible to use, so you don’t need to be familiar with OpenSCAD to use it. Just follow the directions in the "SET TEXT","FONT SETTINGS" and "ALIGN TEXT" sections (below) and ignore the rest of the code.
 
 To preview any changes you make press F5.
 When you've finished your design press F6 to render it, once the render is complete, save your custom Outer_Ring as an STL file by pressing the "Export as STL" button, on the tool bar (above). 
    
  Additional features by Xepherys, January 2018.
    https://www.thingiverse.com/xepherys/about
    */

}
/******************** SET TEXT ********************/{

// To create your own custom Outer_Ring, simply replace each of the ten letters within the quotation marks with numbers or letters of your choice.
      
    Text =       [  "A",   "B",   "C",   "D",   "E",   "F",   "G",   "H",   "I",   "J"];
}
/******************** FONT SETTINGS ********************/{

Default_Font = "Arial: style=Bold Italic";// To change font, replace "Arial" with the font of your choice. To remove bold or italics, simply delete the word "Bold" and/or "Italic".  By default, this font will be used for all sections.

Font = [Default_Font, Default_Font, Default_Font, Default_Font, Default_Font, Default_Font, Default_Font, Default_Font, Default_Font, Default_Font]; //To override the font on a single face, replace the variable Default_Font with a string value, such as "AnironC: style=Bold Italic" or "Arial: style=Bold" for that character.

Default_Size = 8.5; // The default size of the font in each position.

Font_Size       = [Default_Size, Default_Size, Default_Size, Default_Size, Default_Size, Default_Size, Default_Size, Default_Size, Default_Size, Default_Size]; // To override the size of a font on a single face, replace the variable Default_Size with a numeric value for that character.

Rotate_Text     = 90;// Rotates each character relative to its respective face of the ring.

Depth           = .4;// The difference in depth between the the suface of the ring and the text.

EmbossText      = "no"; // Replace the "no" with a "yes" to make the text embossed (stick out) rather than engraved (cut in).

}
/******************** ALIGN TEXT ********************/{

//The text can't be made to auto center so you have to tweak it manually
    
H = -3.9; // Set average horizontal center point (relative to text not the work space)
V = -3.5; // Set average vertical center point (relative to text not the work space)

// You might find it helpful to fill in the reference text on line 38 to match your own "Text". 
  
//           [  "A",   "B",   "C",   "D",   "E",   "F",   "G",   "H",   "I",   "J"]; // Reference

// Change these values to fine tune the horizontal (H) and vertical (V) placement of each individual character.
TextMove_H = [H+0.0, H+0.1, H+0.1, H+0.4, H+0.4, H+0.6, H+0.0, H+0.1, H+2.6, H+1.1];
TextMove_V = [V+0.0, V+0.0, V+0.0, V+0.0, V+0.0, V+0.0, V+0.0, V+0.0, V+0.0, V+0.0];
}
/******************** THE CODE!*********************/{

//It should't be neccesary to change any of the settings in this section

module Ring_Section(){// 1/10 of the ring section
for (NumCop=[0:9]) {//* number of copies  
rotate([0,0,NumCop *36]) //generater othe 9 sections
//********** make shape 3D and duplicate to make one section**********
for(mx=[0:1],my=[0:1]) mirror([0,0,mx])mirror([my,0,0])//mirror X & Y
difference() {//subtract cube from 3d shape to create camfer edge
translate(v = [0, 0, -1]){// Basic 3d Shape
linear_extrude(height = 6){// extrude Basic 2d Shape +1 as overlap

//********** 2D Shape start **********
union(){  
difference() {//subtract large circle from 2d shape
union() {//combine basic shape to small circle
polygon(points=[[-1,20.92],[-1,23.50],[6,23.5],[6,23.15],[7.55,23.15],[7.1,20.92]]);//create Basic 2d Shape
translate(v = [6, 23, 0]) {// position fillit circle
circle(d=1,$fn=40);//add circle to make small fillited edge
}
}
translate(v = [7.64, 23.5, 0]) {// position large circle
circle(d=2.43,$fn=60);//large circle to be cut
}
}//********** 2D Shape end **********
}
}
}
translate(v = [-2, 20.5, 4]) {// move camfer tool
rotate(a= [45,0,0]){// rotate camfer tool
cube(size = [10,2,2]);//create cube as camfer tool
}
}
}
}
}





module Text_Characters() {// 
    

    
for (NumCop2=[0:9]) {//* number of copies  
rotate([0,0,NumCop2 *36]) //generate the other nine sections

rotate([0,Rotate_Text,0]){//rotation of text relative to ring segment
translate([-TextMove_H [NumCop2],23.5-Depth,TextMove_V [NumCop2]]){//align text on ring segment + depth of text
rotate([90,0,180]){//make text parallel with face of ring segment   
linear_extrude(Depth*2){// make text solid 3d geometry


text(Text[NumCop2], Font_Size[NumCop2], Font[NumCop2], spacing=1, direction="ltr");//Generate text
}
}
}
}
}
}

if(EmbossText == "yes"){//make the text embossed (stick out) or than engraved (cut in)   
    difference(){//Crop text
union(){//Combine text and ring into one object
    Ring_Section();//module of ring segment
    Text_Characters();//module containg 3D text.
}
    union(){// combine cropping tools into single object
    translate(v=[0,0,10.005]){//move cropping tool into position
    cube([60,60,10], center=true);//Create text cropping tool top.
    }
        translate(v=[0,0,-10.005]){//move cropping tool into position
    cube([60,60,10], center=true);//Create text cropping tool bottom.
    }
}
}
}
else
    {
difference(){// make the text engraved (cut in)
    Ring_Section();
    Text_Characters();    
}
 } 
 
 }
 
  