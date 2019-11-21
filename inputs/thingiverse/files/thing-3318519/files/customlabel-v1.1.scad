// custom_label.scad
// library for parametric Labels
// Author: Graham Read (UK) 
// v1.1
// last update: December 2018

//////////////////////////
// Configurable parameters
//////////////////////////

// Text
Text_line_1 = "Text 1";
Font_Size_1 = 16;
Text_alignment_1 = "bottom"; //options=top, center, bottom (relative to rule)

Text_line_2 = "text 2";
Font_Size_2 = 30;
Text_alignment_2 = "center"; //options=top, center, bottom (relative to rule)

Text_line_3 = "text 3";
Font_Size_3 = 8;
Text_alignment_3 = "top"; //options=top, center, bottom (relative to rule)

// (in mm)
Text_extrude_height = 1.0  ;

// Character spacing, default is 1
Text_Spacing = 01;

// Platform specific font name and style
// To change font use the Font List popup found under the scad help menu, and drag the
// selected font into this window to replace the string in quotes below
Font_Name="Calibri:style=Regular";

// Width (in mm) - doesn't include the curve
//Label_Width = 117;
//Label_Width = 75;
Label_Height = 70;

// Height (in mm) - doesn't include the hole curve
//Label_Height = 15;
//Label_Height = 95;
Label_Width = 80;

// Depth/thickness (in mm)
// 3 mm will create a semi-flexible label
Label_Depth = 3;

// Number of fixing holes, 0 = none, 1 = one hole, 2 = two holes
Holes = 1;

// Position for fixing holes. 0 = Left/Right and 1 = Top/Bottom
HoleLoc = 1;

// Hole size (mm)
HoleSize = 4;

// render just text1=1, just text2 = 2, just text3 = 3, 
// just baseplate=4, just alltext=5, or assembled=6
// Usefull if using a multi-colour printer where seperate STL's are needed
// Use the mode below to render each item and export as a seperate STL
mode = 6;

// granularity (number of fragments)
$fn=30;

// main function
Export_STL();

///////////////////////////////
// Modules, best not to alter
///////////////////////////////

module Export_STL()
{ 
    if (mode == 1) {
        label_text(Text_line_1, 0, Font_Size_1);
    } else if (mode == 2) {
        label_text(Text_line_2, 1, Font_Size_2);
    } else if (mode == 3) {
        label_text(Text_line_3, 2, Font_Size_3);
    } else if (mode == 4) {
        base_plate();
    } else if (mode == 5) {
        label_text(Text_line_1, 0, Font_Size_1);
        label_text(Text_line_2, 1, Font_Size_2);
        label_text(Text_line_3, 2, Font_Size_3);
    } else if (mode == 6) {
        base_plate();
        label_text(Text_line_1, 0, Font_Size_1);
        label_text(Text_line_2, 1, Font_Size_2);
        label_text(Text_line_3, 2, Font_Size_3);
    }             
}

module label_text(text_string, position, Font_Size)
{
   textvalign = [
    [ ((Label_Height/4)-1)*3, Text_alignment_1, "line 1"],
    [ (Label_Height/2), Text_alignment_2, "line 2"],
    [ ((Label_Height/4)+1), Text_alignment_3, "line 3"]
   ];
        translate([0,textvalign[position][0],Label_Depth])
            generate_labeltext(text_string,textvalign[position][1], Font_Size);           
}

module generate_labeltext(textstring, valigntxt, Font_Size)
{
  linear_extrude(Text_extrude_height) {
            text(textstring,size=Font_Size,font=Font_Name,spacing = Text_Spacing,
      halign="center",valign = valigntxt, direction="ltr"); 
  }
}

module base_plate()
{
   curvepos = [
    [ (Label_Width/2)+2.5,Label_Height/2,-(Label_Width/2)-2.5,Label_Height/2, Label_Height/(Label_Height*0.1), "left-right curves"],
    [ 0,Label_Height+3, 0,-3, Label_Width/(Label_Width*0.1), "top-bottom curves"]   
   ];   
    
   holepos = [
    [ (Label_Width/2)+Label_Height/(Label_Height*0.13)-HoleSize/2,Label_Height/2, -(Label_Width/2)-Label_Height/(Label_Height*0.13)+HoleSize/2,Label_Height/2,"left-right holes"],
    [ 0,(Label_Height)+Label_Width/(Label_Width*0.13)-HoleSize/2,0,-Label_Width/(Label_Width*0.13)+HoleSize/2,  "top-bottom holes"]   
   ];
    
 difference() 
    {   
    union() {
        // The basic box, with curved corners
        points = [ 
        [-Label_Width/2,0,0], [-Label_Width/2,Label_Height,0], 
        [Label_Width/2,0,0], [Label_Width/2,Label_Height,0] 
        ];
        rounded_box(points,6, Label_Depth);
  
        // Curve for hole at left/right or top/bottom      
        if (Holes==1) {
            translate([curvepos[HoleLoc][0],curvepos[HoleLoc][1],0])
                cylinder(h=Label_Depth, r=curvepos[HoleLoc][4]);
            }
        else if (Holes==2) {
            translate([curvepos[HoleLoc][0],curvepos[HoleLoc][1],0])
                cylinder(h=Label_Depth, r=curvepos[HoleLoc][4]);
            translate([curvepos[HoleLoc][2],curvepos[HoleLoc][3],0])
                cylinder(h=Label_Depth, r=curvepos[HoleLoc][4]); 
            }
        } 
      
      // Add Screw Holes at left/right or top/bottom
      if (Holes==1) { 
        translate([holepos[HoleLoc][0],holepos[HoleLoc][1],-1])
            cylinder(h=Label_Depth+2, r=HoleSize);
      }
      else if (Holes==2) {
        translate([holepos[HoleLoc][0],holepos[HoleLoc][1],-1])
            cylinder(h=Label_Depth+2, r=HoleSize);
        translate([holepos[HoleLoc][2],holepos[HoleLoc][3], -1])
            cylinder(h=Label_Depth+2, r=HoleSize);        
      }       
   }
}
 
module rounded_box(points, radius, height){
    // Create four cylinders at each courner and then 
    // wrap them with hull cmd
    hull(){
        for (p = points){
            translate(p) cylinder(r=radius, h=height);
        }
    }
}






 