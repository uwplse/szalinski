textLeft1="TO";
textLeft2="AN";
textMain="AMAZING TEACHER";

/* [hidden] */



font_width_arial_black = [
["A",0.778],["B",0.778],["C",0.778],["D",0.778],["E",0.722],
["F",0.667],["G",0.833],["H",0.833],["I",0.389],["J",0.667],
["K",0.833],["L",0.667],["M",0.944],["N",0.833],["O",0.833],
["P",0.722],["Q",0.833],["R",0.778],["S",0.722],["T",0.722],
["U",0.833],["V",0.778],["W",1],["X",0.778],["Y",0.778],
["Z",0.722],["a",0.667],["b",0.667],["c",0.667],["d",0.667],
["e",0.667],["f",0.389],["g",0.667],["h",0.667],["i",0.333],
["j",0.333],["k",0.667],["l",0.333],["m",1],["n",0.667],
["o",0.667],["p",0.667],["q",0.667],["r",0.444],["s",0.611],
["t",0.444],["u",0.667],["v",0.611],["w",0.944],["x",0.667],
["y",0.611],["z",0.556],["1",0.667],["2",0.667],["3",0.667],
["4",0.667],["5",0.667],["6",0.667],["7",0.667],["8",0.667],
["9",0.667],["0",0.667],["!",0.333],["@",0.74],["#",0.66],
["$",0.667],["%",1],["^",0.66],["&",0.889],["*",0.556],
["(",0.389],[")",0.389],["_",0.5],[":",0.333],[",",0.333],
[".",0.333],["\"",0.5],["'",0.278],["-",0.333],[" ",0.334],["?",0.611],
["~",0]
];
font_width_scale_arial_black = 1;
//font_width_scale_arial_black = 94.8/70.9466;

font_width_arial = [
["A",0.667],["B",0.667],["C",0.722],["D",0.722],["E",0.667],
["F",0.611],["G",0.778],["H",0.722],["I",0.278],["J",0.5],
["K",0.667],["L",0.556],["M",0.833],["N",0.722],["O",0.778],
["P",0.667],["Q",0.778],["R",0.722],["S",0.667],["T",0.611],
["U",0.722],["V",0.667],["W",0.944],["X",0.667],["Y",0.667],
["Z",0.611],["a",0.556],["b",0.556],["c",0.5],["d",0.556],
["e",0.556],["f",0.278],["g",0.556],["h",0.556],["i",0.222],
["j",0.222],["k",0.5],["l",0.222],["m",0.833],["n",0.556],
["o",0.556],["p",0.556],["q",0.556],["r",0.333],["s",0.5],
["t",0.278],["u",0.556],["v",0.5],["w",0.722],["x",0.5],
["y",0.5],["z",0.5],["1",0.556],["2",0.556],["3",0.556],
["4",0.556],["5",0.556],["6",0.556],["7",0.556],["8",0.556],
["9",0.556],["0",0.556],["!",0.278],["@",1.015],["#",0.556],
["$",0.556],["%",0.889],["^",0.469],["&",0.667],["*",0.389],
["(",0.333],[")",0.333],["_",0.556],[":",0.278],[",",0.278],
[".",0.278],["?",0.556],["-",0.333],[" ",0.278],["~",0]
];
font_width_scale_arial = 83.5/63.3826;

font_width_arial_bold = [
["A",0.722],["B",0.667],["C",0.667],["D",0.722],["E",0.611],
["F",0.556],["G",0.722],["H",0.722],["I",0.333],["J",0.389],
["K",0.722],["L",0.611],["M",0.889],["N",0.722],["O",0.722],
["P",0.556],["Q",0.722],["R",0.667],["S",0.556],["T",0.611],
["U",0.722],["V",0.722],["W",0.944],["X",0.722],["Y",0.722],
["Z",0.611],["a",0.444],["b",0.5],["c",0.444],["d",0.5],
["e",0.444],["f",0.333],["g",0.5],["h",0.5],["i",0.278],
["j",0.278],["k",0.5],["l",0.278],["m",0.778],["n",0.5],
["o",0.5],["p",0.5],["q",0.5],["r",0.333],["s",0.389],
["t",0.278],["u",0.5],["v",0.5],["w",0.722],["x",0.5],
["y",0.5],["z",0.444],["1",0.5],["2",0.5],["3",0.5],
["4",0.5],["5",0.5],["6",0.5],["7",0.5],["8",0.5],
["9",0.5],["0",0.5],["!",0.333],["@",0.921],["#",0.5],
["$",0.5],["%",0.833],["^",0.469],["&",0.778],["*",0.5],
["(",0.333],[")",0.333],["_",0.5],[":",0.278],[",",0.25],
[".",0.25],["?",0.444],["-",0.333],[" ",0.25],["~",0],
];
font_width_scale_arial_bold = 85.0/63.023;


font="Arial Sans:style=Bold";
t = font_width_arial_bold;
s = font_width_scale_arial_bold;

// add text:
/*
font="Arial Black";
t = font_width_arial_black;
s = font_width_scale_arial_black;
*/
/*
font="Arial";
t = font_width_arial;
s = font_width_scale_arial;
*/
/*
font="Arial Sans:style=Bold";
t = font_width_arial_bold;
s = font_width_scale_arial_bold;
*/


function getCharWidth(ch="X") =
    t[search(ch, t, num_returns_per_match=0)[0][0]][1];

function _getStringWidth(str,i=0) =
    len(str) > i ? getCharWidth(str[i]) + _getStringWidth(str,i+1) : 0;

function getStringWidth(str,size) = 
    (_getStringWidth(str,0)+(len(str)-1)*getCharWidth("~")) * s * size;

/*
module getCharWidthMod(ch="X") = 
    
    echo("char - ", ch);
    idx = search(ch, t, num_returns_per_match=0);
    if (len(idx[0])) {
        echo(ch, idx, idx[0][0], t[idx[0][0]][1]);
        
    } else {
        echo ("not found");
    };
}
*/

mainFontSize=6.2;
smallFontSize=mainFontSize/2.2;

    
textLeftSize = max( getStringWidth(textLeft1,smallFontSize), 
                    getStringWidth(textLeft2,smallFontSize));
textMainSize = getStringWidth(textMain,mainFontSize);

gapSize = textLeftSize > 0 ? textMainSize > 0 ? 3 : 0 : 0;

textMainOffset=(textLeftSize+gapSize)/2;
textLeftOffset=textMainOffset-textMainSize/2-gapSize-textLeftSize/2;

echo(textMainOffset);
echo(textLeftOffset);

textHotPoint=[-2.8,22,6.5];

/*
translate(textHotPoint)  translate([textMainOffset,0,0]){
    
    color("blue") sphere(2);
    color("blue") translate([textMainSize/2,0,0]) sphere(1);
    color("blue") translate([-textMainSize/2,0,0]) sphere(1);
    color("blue") translate([-textMainSize/2-gapSize,0,0]) sphere(1);
    color("blue") translate([-textMainSize/2-gapSize-textLeftSize,0,0]) sphere(1);
}
*/

translate(textHotPoint)
color("red")
linear_extrude(1) {
    
    translate([textMainOffset,0,0])
    text(textMain, size= mainFontSize, font=font, halign="center", valign="center");


    // draw small text:
    translate([textLeftOffset,smallFontSize*0.7,0]) 
        text(textLeft1, size = smallFontSize, font=font, halign="center", valign="center");
    translate([textLeftOffset,-smallFontSize*0.7,0]) 
        text(textLeft2, size = smallFontSize, font=font, halign="center", valign="center");
    
}
//object_stl(1);
// Here is right object !!!

translate([0,0,2]){
  translate([-3,22,0])
    difference(){
      rounded_brick([102,15,5.5],[4,0,4,0]);
      translate([0,0,4.5])rounded_brick([102-3,15-3,5.5],[4,0,4,0]);
      translate([-49.5,-1.5,-.1])cube([3,3,3.1]);
    }
    translate([0,-1.4,0])
      difference(){
        translate([0,-5,0])rounded_brick([96,50,3],[0,0,0,0]);
        translate([-1,0,1.5])rounded_brick([96,51,3],[0,0,0,0]);
        translate([-16,-26,-.1])rounded_brick([20,15,4],[5,0,5,0]);
      }
    translate([-38,-29.5,2.5])cylinder(h=2,d=3.5,$fn=32);
    translate([-38,15,3]){
      hull(){
        translate([0,0,.5])cube([3.5,1,1],center=true);
        translate([0,-.5,1+.25])cube([3.5,1,.5],center=true);
        translate([0,-1,1+.25])cube([1.25,1,.5],center=true);
        }
    }
}
module rounded_brick(d=[10,10,10],sides=[1,1,1,1]){
  hull()
    for (i=[0:3])
        mirror([floor(i/2),0,0])mirror([0,i%2,0])
          if (sides[i])
            translate([d[0]/2-sides[i],d[1]/2-sides[i],0])
              cylinder(h=d[2],r=sides[i],$fn=36);
          else
            translate([d[0]/2-1,d[1]/2-1,0])
              cube([1,1,d[2]]);
}
