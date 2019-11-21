name = "Your Name Here";
/* [Basic] */
// This determines whether the key has a fixed length or a fixed letter height.
fixedLength = true; // [true,false]
// This scales EVERYTHING proportionately (and may appear to do nothing). NOTE: This will only have an effect if Fixed Length is true.
length = 100; // [1:1000]
// NOTE: This will only have an effect if Fixed Length is false.
letterHeight = 10; // [1:100]
/* [Advanced] */
// This is a multiple of the line width.
minBlankSpace = 10; // [0:100]
// This is the ratio between the diameter and the length of the key. Lower this to allow for a stubbier key with a shorter name.
minWidthRatio = 10; // [2:20]
// This is a multiple of the barrel diameter.
ringSize = 3; // [2:10]
ringScale = 0.75; // [0.5:0.125:1.5]
// Please note that the heart is pretty buggy and may not work if you adjust ring size 
ringType = 0; // [0:circle,1:heart]
// For characters with floating parts
support = true; // [true,false]
supportWidth = 3; // [1:0.5:5]
// this will flip the key for languages written RTL (Hebrew)
textDirection = 0; // [0:left to right,1:right to left]
// The customizer will generate all 3 as seperate files. Use the separate key & name for dual extrusion.
part = 0; // [0:Full Key,1:Key Blank,2:Name]
/* [Character Variants] */
nVariant = 1; // [1:2]
zayinVariant = 1; // [1:2]
ayinVariant = 1; // [1:3]
/* [Hidden] */
// preview[view:south,tilt:top]
lineSize = 0.2;
unit = fixedLength ? min(length / minWidthRatio, length / (pos() + (minBlankSpace * lineSize) + ringSize - lineSize)) : letterHeight; // base unit of measurement - calculated if length is fixed, otherwise fixed
keyLength = fixedLength ? length : max(letterHeight * minWidthRatio, letterHeight * (pos() + (minBlankSpace * lineSize) + ringSize - lineSize));  // calculated if fixed not set to true above
line = unit * lineSize;
$vpt = [keyLength / (textDirection == 0 ? 2 : -2), 0, 0]; // center
$vpd = 100; // zoom
$vpr = [0,0,0]; // show flat
$fn = 50; // resolution
rotate([0, textDirection * 180, 0]){
  if(part < 2){
    keyBlank();
  }
  if(len(name) > 0 && part % 2 == 0){
    word();
  }
}
module word(){
  for(i = [0:len(name) - 1]){
    translate([unit * pos(i),0,unit / -2]){
      if(support){
        supportLetter(name[i]);
      }
      linear_extrude(unit){
        scale([line,line]){
          letter(name[i]);
        }
      }
    }
  }
}
{function pos(n) = ( // position function
  n == undef ? pos(len(name)) : n == 0 || n > len(name) ? 0 : 
    name[n - 1] == "I" ||
    name[n - 1] == "i" ||
    name[n - 1] == "." ? pos(n - 1) + lineSize * 2 : // 1 line-width letters above this line
    name[n - 1] == "[" ||
    name[n - 1] == "]" ||
    name[n - 1] == "י" || // (yud)
    name[n - 1] == "ו" || // (vav)
    name[n - 1] == "ן" || // (nun sofit)
    name[n - 1] == "(" ||
    name[n - 1] == ")" ? pos(n - 1) + lineSize * 3 : // 2 line-width letters above this line
    name[n - 1] == "1" ||
    name[n - 1] == " " ||
    name[n - 1] == "נ" || // (nun)
    name[n - 1] == "ג" || // (gimmel)
    name[n - 1] == "ז" || // (zayin)
    name[n - 1] == "{" ||
    name[n - 1] == "}" ? pos(n - 1) + lineSize * 4 : // 3 line-width letters above this line
    name[n - 1] == "<" ||
    name[n - 1] == ">" ? pos(n - 1) + lineSize * (3.5+sqrt(0.5)) : // 2.5+sqrt(0.5) line-width letters above this line
  pos(n - 1) + lineSize * 6
);}
module letter(char){
    if     (char == "A" || char == "a"){
      polygon([[0,0],[0,5],[5,5],[5,0],[4,0],[4,2],[1,2],[1,0],[1,3],[1,4],[4,4],[4,3]],paths = [[0,1,2,3,4,5,6,7],[8,9,10,11]]);
    }
    else if(char == "B" || char == "b"){
      polygon([[0,0],[0,5],[5,5],[5,0],[1,3],[1,4],[4,4],[4,3],[1,1],[1,2],[4,2],[4,1]],paths = [[0,1,2,3],[4,5,6,7],[8,9,10,11]]);
    }
    else if(char == "C" || char == "c"){
      polygon([[0,0],[0,5],[5,5],[5,4],[1,4],[1,1],[5,1],[5,0]]);
    }
    else if(char == "D" || char == "d"){
      polygon([[0,0],[0,5],[4,5],[5,4],[5,1],[4,0],[1,1],[1,4],[4,4],[4,1]],paths = [[0,1,2,3,4,5],[6,7,8,9]]);
    }
    else if(char == "E" || char == "e"){
      polygon([[0,0],[0,5],[5,5],[5,1 *4],[1,4],[1,3],[3,3],[3,2],[1,2],[1,1],[5,1],[5,0]]);
    }
    else if(char == "F" || char == "f"){
      polygon([[0,0],[0,5],[5,5],[5,1 *4],[1,4],[1,3],[3,3],[3,2],[1,2],[1,0]]);
    }
    else if(char == "G" || char == "g"){
      polygon([[0,0],[0,5],[5,5],[5,1 *4],[1,4],[1,1],[4,1],[4,2],[2,2],[2,3],[5,3],[5,0]]);
    }
    else if(char == "H" || char == "h"){
      polygon([[0,0],[0,5],[1,5],[1,3],[4,3],[4,5],[5,5],[5,0],[4,0],[4,2],[1,2],[1,0]]);
    }
    else if(char == "I" || char == "i"){
      polygon([[0,0],[0,5],[1,5],[1,0]]);
    }
    else if(char == "J" || char == "j"){
      polygon([[0,0],[0,2],[1,2],[1,1],[4,1],[4,5],[5,5],[5,0]]);
    }
    else if(char == "K" || char == "k"){
      polygon([[0,0],[0,5],[1,5],[1,3],[(3 - sqrt(0.5)),3],[(5 - sqrt(0.5)),5],[5,5],[5,(5 - sqrt(0.5))],[(2.5 + sqrt(0.5)),2.5],[5,sqrt(0.5)],[5,0],[(5 - sqrt(0.5)),0],[(3 - sqrt(0.5)),2],[1,2],[1,0]]);
    }
    else if(char == "L" || char == "l"){
      polygon([[0,0],[0,5],[1,5],[1,1],[5,1],[5,0]]);
    }
    else if(char == "M" || char == "m"){
      polygon([[0,0],[0,5],[5,5],[5,0],[4,0],[4,4],[3,4],[3,0],[2,0],[2,4],[1,4],[1,0]]);
    }
    else if(char == "N" || char == "n"){
      if(nVariant == 1) polygon([[0,0],[0,5],[1,5],[1,4+sqrt(0.5)],[4,1+sqrt(0.5)],[4,5],[5,5],[5,0],[4,0],[4,1-sqrt(0.5)],[1,4-sqrt(0.5)],[1,0]]);
      else polygon([[0,0],[0,5],[5,5],[5,0],[4,0],[4,4],[1,4],[1,0]]);
    }
    else if(char == "O" || char == "o"){
      polygon([[0,0],[0,5],[5,5],[5,0],[1,1],[1,4],[4,4],[4,1]],paths = [[0,1,2,3],[4,5,6,7]]);
    }
    else if(char == "P" || char == "p"){
      polygon([[0,0],[0,5],[5,5],[5,2],[1,2],[1,0],[1,3],[1,4],[4,4],[4,3]],paths = [[0,1,2,3,4,5],[6,7,8,9]]);
    }
    else if(char == "Q" || char == "q"){
      polygon([[0,0],[0,5],[5,5],[5,0],[1,1],[1,4],[4,4],[4,(1 + sqrt(0.5))],[(2 + sqrt(0.5)),3],[2,3],[2,(3 - sqrt(0.5))],[(4 - sqrt(0.5)),1]],paths = [[0,1,2,3],[4,5,6,7,8,9,10,11]]);
    }
    else if(char == "R" || char == "r"){
      polygon([[0,0],[0,5],[5,5],[5,2],[(3 + sqrt(0.5)),2],[5,sqrt(0.5)],[5,0],[(5 - sqrt(0.5)),0],[(3 - sqrt(0.5)),2],[1,2],[1,0],[1,3],[1,4],[4,4],[4,3]],paths = [[0,1,2,3,4,5,6,7,8,9,10],[11,12,13,14]]);
    }
    else if(char == "S" || char == "s"){
      polygon([[0,0],[0,1],[4,1],[4,2],[0,2],[0,5],[5,5],[5,4],[1,4],[1,3],[5,3],[5,0]]);
    }
    else if(char == "T" || char == "t"){
      polygon([[0,4],[0,5],[5,5],[5,4],[3,4],[3,0],[2,0],[2,4]]);
    }
    else if(char == "U" || char == "u"){ 
      polygon([[0,0],[0,5],[1,5],[1,1],[4,1],[4,5],[5,5],[5,0]]);
    }
    else if(char == "V" || char == "v"){
      polygon([[0,2],[0,5],[1,5],[1,2.5],[2.5,1],[4,2.5],[4,5],[5,5],[5,2],[3,0],[2,0]]);
    }
    else if(char == "W" || char == "w"){
      polygon([[0,0],[0,5],[1,5],[1,1],[2,1],[2,4],[3,4],[3,1],[4,1],[4,5],[5,5],[5,0]]);
    }
    else if(char == "X" || char == "x"){
      polygon([[0,0],[0,sqrt(0.5)],[(2.5 - sqrt(0.5)),2.5],[0,(5 - sqrt(0.5))],[0,5],[sqrt(0.5),5],[2.5,(2.5 + sqrt(0.5))],[(5 - sqrt(0.5)),5],[5,5],[5,(5 - sqrt(0.5))],[(2.5 + sqrt(0.5)),2.5],[5,sqrt(0.5)],[5,0],[(5 - sqrt(0.5)),0],[2.5,(2.5 - sqrt(0.5))],[sqrt(0.5),0]]);
    }
    else if(char == "Y" || char == "y"){
      polygon([[0,2],[0,5],[1,5],[1,3],[4,3],[4,5],[5,5],[5,2],[3,2],[3,0],[2,0],[2,2]]);
    }
    else if(char == "Z" || char == "z"){
      polygon([[0,0],[0,1],[3.5,4],[0,4],[0,5],[5,5],[5,4],[1.5,1],[5,1],[5,0]]); 
    }
    else if(char == "0"){ 
      polygon([[0,0],[0,5],[5,5],[5,0],[1,1],[1,4],[4,4],[4,1]],paths=[[0,1,2,3],[4,5,6,7]]);
    }
    else if(char == "1"){
      polygon([[0,0],[0,1],[1,1],[1,4],[0,4],[0,5],[2,5],[2,1],[3,1],[3,0]]);
    }
    else if(char == "2"){
      polygon([[0,0],[0,3],[4,3],[4,4],[0,4],[0,5],[5,5],[5,2],[1,2],[1,1],[5,1],[5,0]]);
    }
    else if(char == "3"){
      polygon([[0,0],[0,1],[4,1],[4,2],[1,2],[1,3],[4,3],[4,4],[0,4],[0,5],[5,5],[5,0]]);
    }
    else if(char == "4"){
      polygon([[0,2],[0,5],[1,5],[1,3],[4,3],[4,5],[5,5],[5,0],[4,0],[4,2]]);
    }
    else if(char == "5"){
      polygon([[0,0],[0,1],[4,1],[4,2],[0,2],[0,5],[5,5],[5,4],[1,4],[1,3],[5,3],[5,0]]);
    }
    else if(char == "6"){
      polygon([[0,0],[0,5],[5,5],[5,4],[1,4],[1,3],[5,3],[5,0],[1,1],[1,2],[4,2],[4,1]],paths = [[0,1,2,3,4,5,6,7],[8,9,10,11]]);
    }
    else if(char == "7"){
      polygon([[0,4],[0,5],[5,5],[5,0],[4,0],[4,4]]);
    }
    else if(char == "8"){
      polygon([[0,0],[0,5],[5,5],[5,0],[1,3],[1,4],[4,4],[4,3],[1,1],[1,2],[4,2],[4,1]],paths = [[0,1,2,3],[4,5,6,7],[8,9,10,11]]);
    }
    else if(char == "9"){
      polygon([[0,0],[0,1],[4,1],[4,2],[0,2],[0,5],[5,5],[5,0],[1,3],[1,4],[4,4],[4,3]],paths = [[0,1,2,3,4,5,6,7],[8,9,10,11]]);
    }
    else if(char == "/"){
      polygon([[0,0],[0,sqrt(0.5)],[(5 - sqrt(0.5)),5],[5,5],[5,(5 - sqrt(0.5))],[sqrt(0.5),0]]);
    }
    else if(char == "\\"){ // may need to be escaped in customizer
      polygon([[0,(5 - sqrt(0.5))],[0,5],[sqrt(0.5),5],[5,sqrt(0.5)],[5,0],[(5 - sqrt(0.5)),0]]);
    }
    else if(char == "+"){
      polygon([[0,2],[0,3],[2,3],[2,5],[3,5],[3,3],[5,3],[5,2],[3,2],[3,0],[2,0],[2,2]]);
    }
    else if(char == "-"){
      polygon([[0,2],[0,3],[5,3],[5,2]]);
    }
    else if(char == "="){
      polygon([[0,1],[0,2],[5,2],[5,1]]);
      polygon([[0,3],[0,4],[5,4],[5,3]]);
    }
    else if(char == "#"){ // octothorpe is a fun word
      polygon([[0,1],[0,2],[1,2],[1,3],[0,3],[0,4],[1,4],[1,5],[2,5],[2,4],[3,4],[3,5],[4,5],[4,4],[5,4],[5,3],[4,3],[4,2],[5,2],[5,1],[4,1],[4,0],[3,0],[3,1],[2,1],[2,0],[1,0],[1,1],[2,2],[2,3],[3,3],[3,2]],paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27],[28,29,30,31]]);
    }
    else if(char == "<"){
      polygon([[0,2.5],[2.5,5],[2.5+sqrt(0.5),5],[2.5+sqrt(0.5),5-sqrt(0.5)],[sqrt(2),2.5],[2.5+sqrt(0.5),sqrt(0.5)],[2.5+sqrt(0.5),0],[2.5,0]]);
    }
    else if(char == ">"){
      polygon([[0,0],[0,sqrt(0.5)],[2.5-sqrt(0.5),2.5],[0,5-sqrt(0.5)],[0,5],[sqrt(0.5),5],[2.5+sqrt(0.5),2.5],[sqrt(0.5),0]]);
    }
    else if(char == "["){
      polygon([[0,0],[0,5],[2,5],[2,4],[1,4],[1,1],[2,1],[2,0]]);
    }
    else if(char == "]"){
      polygon([[0,0],[0,1],[1,1],[1,4],[0,4],[0,5],[2,5],[2,0]]);
    }
    else if(char == "{"){
      polygon([[0,2],[0,3],[1,3],[1,5],[3,5],[3,4],[2,4],[2,1],[3,1],[3,0],[1,0],[1,2]]);
    }
    else if(char == "}"){
      polygon([[0,0],[0,1],[1,1],[1,4],[0,4],[0,5],[2,5],[2,3],[3,3],[3,2],[2,2],[2,0]]);
    }
    else if(char == "("){
      polygon([[0,sqrt(0.5)],[0,(5 - sqrt(0.5))],[sqrt(0.5),5],[2,5],[2,4],[1,4],[1,1],[2,1],[2,0],[sqrt(0.5),0]]);
    }
    else if(char == ")"){
      polygon([[0,0],[0,1],[1,1],[1,4],[0,4],[0,5],[(2 - sqrt(0.5)),5],[2,(5 - sqrt(0.5))],[2,sqrt(0.5)],[(2 - sqrt(0.5)),0]]);
    }
    else if(char == "."){ // period
      polygon([[0,0],[0,1],[1,1],[1,0]]);
    }
    else if(char == "$"){
      polygon([[0,0.5],[0,1.5],[4,1.5],[4,2],[0,2],[0,4.5],[2,4.5],[2,5],[3,5],[3,4.5],[5,4.5],[5,3.5],[1,3.5],[1,3],[5,3],[5,0.5],[3,0.5],[3,0],[2,0],[2,0.5]]);
    }
    else if(char == "&"){ // ampersand
      polygon([[0,0],[0,5],[3,5],[3,3],[5,3],[5,2],[(3 + sqrt(0.5)),2],[5,sqrt(0.5)],[5,0],[(5 - sqrt(0.5)),0],[3,(2 - sqrt(0.5))],[3,0],[1,3],[1,4],[2,4],[2,3],[1,1],[1,2],[2,2],[2,1]],paths = [[0,1,2,3,4,5,6,7,8,9,10,11],[12,13,14,15],[16,17,18,19]]);
    }
    else if(char == " "){ // space
      // this space intentionally left blank
    }
    else if(char == "א"   ){ // aleph
      polygon([[0,0],[0,sqrt(0.5)],[1,1+sqrt(0.5)],[0,2+sqrt(0.5)],[0,5],[1,5],[1,1+sqrt(4.5)],[1+sqrt(0.5),1+sqrt(2)],[5-sqrt(0.5),5],[5,5],[5,5-sqrt(0.5)],[4,4-sqrt(0.5)],[5,3-sqrt(0.5)],[5,0],[4,0],[4,4-sqrt(4.5)],[4-sqrt(0.5),4-sqrt(2)],[sqrt(0.5),0]]);
    }
    else if(char == "ב"   ){ // bais
      polygon([[0,0],[0,1],[1,1],[1,5],[5,5],[5,4],[2,4],[2,1],[5,1],[5,0]]);
    }
    else if(char == "ג"   ){ // gimmel
      // this needs a polygon
      polygon([[0,0],[0,5],[3,5],[3,4],[1,4],[1,2+sqrt(0.5)],[3,sqrt(0.5)],[3,0],[3-sqrt(0.5),0],[1,2-sqrt(0.5)],[1,0]]);
   }
    else if(char == "ד"   ){ // daled
      polygon([[0,4],[0,5],[5,5],[5,4],[2,4],[2,0],[1,0],[1,4]]);
    }
    else if(char == "ה"   ){ // hei
      polygon([[0,0],[0,5],[5,5],[5,4],[1,4],[1,0]]);
      polygon([[4,0],[4,3],[5,3],[5,0]]);
    }
    else if(char == "ו"   ){ // vav
      polygon([[0,0],[0,5],[2,5],[2,4],[1,4],[1,0]]);
    }
    else if(char == "ז"   ){ // zayin - needs visual fixing
      if (zayinVariant == 1) polygon([[0,2],[0,2+sqrt(0.5)],[3-sqrt(0.5),5],[3,5],[3,5-sqrt(0.5)],[2,4-sqrt(0.5)],[2,0],[1,0],[1,3-sqrt(0.5)],[sqrt(0.5),2]]);
    }
    else if(char == "ח"   ){ // ches
      polygon([[0,0],[0,5],[5,5],[5,0],[4,0],[4,4],[1,4],[1,0]]);
    }
    else if(char == "ט"   ){ // tes
      polygon([[0,0],[0,5],[2,5],[2,4],[1,4],[1,1],[4,1],[4,5],[5,5],[5,0]]);
    }
    else if(char == "י"   ){ // yud
      polygon([[0,3],[0,5],[2,5],[2,4],[1,4],[1,3]]);
    }
    else if(char == "כ"   ){ // chof
      polygon([[0,0],[0,5],[5,5],[5,4],[1,4],[1,1],[5,1],[5,0]]);
    }
    else if(char == "ך"   ){ // chof sofit
      polygon([[0,-2],[0,5],[5,5],[5,4],[1,4],[1,-2]]);
    }
    else if(char == "ל"   ){ // lamed
      polygon([[0,3],[0,5],[4,5],[4,7],[5,7],[5,4],[1,4],[1,2+sqrt(2)],[3+sqrt(2),0],[3,0]]);
    }
    else if(char == "מ"   ){ // mem
      polygon([[0,0],[0,5],[2+sqrt(0.5),5],[3.5,3.5+sqrt(0.5)],[5-sqrt(0.5),5],[5,5],[5,5-sqrt(0.5)],[3.5+sqrt(0.5),3.5],[5,2+sqrt(0.5)],[5,2],[5-sqrt(0.5),2],[3-sqrt(0.5),4],[1,4],[1,1],[5,1],[5,0]]);
    }
    else if(char == "ם"   ){ // mem sofit
      polygon([[0,0],[0,5],[5,5],[5,0],[1,1],[1,4],[4,4],[4,1]],paths = [[0,1,2,3],[4,5,6,7]]);
    }
    else if(char == "נ"   ){ // nun
      polygon([[0,0],[0,5],[2,5],[2,4],[1,4],[1,1],[3,1],[3,0]]);
    }
    else if(char == "ן"   ){ // nun sofit
      polygon([[0,-2],[0,5],[2,5],[2,4],[1,4],[1,-2]]);
    }
    else if(char == "ס"   ){ // samech
      polygon([[0,0],[0,5],[5,5],[5,4],[4,4],[4,0],[1,1],[1,4],[3,4],[3,1]], paths = [[0,1,2,3,4,5],[6,7,8,9]]);
    }
    else if(char == "ע"   ){ // ayin
      polygon([[0,0],[0,5],[1,5],[1,1],[2,1],[2,5],[3,5],[3,1],[5,1],[5,0]]);
    }
    else if(char == "פ"   ){ // pei
      polygon([[0,0],[0,5],[5,5],[5,2],[2,2],[2,3],[4,3],[4,4],[1,4],[1,1],[5,1],[5,0]]);
    }
    else if(char == "ף"   ){ // pei sofit
      polygon([[0,-2],[0,5],[5,5],[5,2],[2,2],[2,3],[4,3],[4,4],[1,4],[1,-2]]);
    }
    else if(char == "צ"   ){ // tzadi
      polygon([[0,0],[0,sqrt(0.5)],[(2.5 - sqrt(0.5)),2.5],[0,(5 - sqrt(0.5))],[0,5],[sqrt(0.5),5],[2.5,(2.5 + sqrt(0.5))],[(5 - sqrt(0.5)),5],[5,5],[5,(5 - sqrt(0.5))],[1+sqrt(0.5),1],[5,1],[5,0]]);
    }
    else if(char == "ץ"   ){ // tzadi sofit
      polygon([[0,2],[0,5],[1,5],[1,3],[3-sqrt(0.5),3],[5-sqrt(0.5),5],[5,5],[5,5-sqrt(0.5)],[3,3-sqrt(0.5)],[3,-2],[2,-2],[2,2]]);
    }
    else if(char == "ק"   ){ // kuf
      polygon([[0,0],[0,5],[5,5],[5,4],[1,4],[1,0]]);
      polygon([[3,-2],[3,3],[4,3],[4,-2]]);
    }
    else if(char == "ר"   ){ // reish
      polygon([[0,0],[0,5],[5,5],[5,4],[1,4],[1,0]]);
    }
    else if(char == "ש"   ){ // shin
      polygon([[0,0],[0,5],[1,5],[1,1],[2,1],[2,5],[3,5],[3,1],[4,1],[4,5],[5,5],[5,0]]);
    }
    else if(char == "ת"   ){ // taf
      polygon([[0,0],[0,5],[4,5],[4,1],[5,1],[5,0],[3,0],[3,4],[1,4],[1,0]]);
    }
    else echo(str("<b>Invalid character: ", char, "</b>"));
  }
module keyBlank(){
	translate([keyLength - unit * (ringSize / 2),0,0]){ // ring
		if (ringType == 0){
			rotate_extrude(){
				translate([(ringSize - ringScale) / 2 * unit,0,0]){
					scale([ringScale,1]){
						circle(d = unit);
					}
				}
			}
		}
		else if (ringType == 1){
			heart();
		}
	}
	rotate([0,90,0]){ // barrel
		difference(){
			if (ringType == 0){
				cylinder(d = unit,h = keyLength - (ringSize - ringScale / 2) * unit);
			}
			else if (ringType == 1){
				cylinder(d = unit,h = keyLength - (ringSize + 1 - ringScale / 2) * unit);
			}
			translate([unit / -2,0,0]){
				cube([unit,unit,unit * pos() - line]);
			}
    }
  }
}
module heart(){
	difference(){
		translate([0,(ringSize / 2 - ringScale) * unit,0]){
			rotate_extrude(){
				translate([(ringSize - ringScale) / 2 * unit,0,0]){
					scale([ringScale,1]){
						circle(d = unit);
					}
				}
			}
		}
		linear_extrude(unit,center = true){
			polygon([[0,0],[unit * ringSize / 2,0],[unit * ringSize / 2,-unit * ringScale],[unit * ringSize / -2,-unit * ringScale],[unit * ringSize / -2,unit * (ringSize - ringScale)],[0,unit * (ringSize / 2 - ringScale)]]);
		}
	}
	difference(){
		translate([0,(ringSize / 2 - ringScale) * unit,0]){
			rotate([90,0,-45]){
				translate([unit * (ringSize - ringScale) / -2,0,0]){
					linear_extrude(unit * ringSize){
						scale([ringScale,1]){
							circle(d = unit);
						}
					}
				}
			}
		}
		translate([unit * ringSize * -1.2,unit * ringSize * -1,unit / -2]){
			cube([unit * ringSize,unit * ringSize,unit]);
		}
	}
	
	rotate([180,0,0]){
		difference(){
			translate([0,(ringSize / 2 - ringScale) * unit,0]){
				rotate_extrude(){
					translate([(ringSize - ringScale) / 2 * unit,0,0]){
						scale([ringScale,1]){
							circle(d = unit);
						}
					}
				}
			}
			linear_extrude(unit,center = true){
				polygon([[0,0],[unit * ringSize / 2,0],[unit * ringSize / 2,-unit * ringScale],[unit * ringSize / -2,-unit * ringScale],[unit * ringSize / -2,unit * (ringSize - ringScale)],[0,unit * (ringSize / 2 - ringScale)]]);
			}
		}
		difference(){
			translate([0,(ringSize / 2 - ringScale) * unit,0]){
				rotate([90,0,-45]){
					translate([unit * (ringSize - ringScale) / -2,0,0]){
						linear_extrude(unit * ringSize){
							scale([ringScale,1]){
								circle(d = unit);
							}
						}
					}
				}
			}
			translate([unit * ringSize * -1.2,unit * ringSize * -1,unit / -2]){
				cube([unit * ringSize,unit * ringSize,unit]);
			}
		}
	}
}
module supportLetter(letter){
  if     (letter == "י"   ) support(0,3); //yud
  else if(letter == "-") support(2,2);
  else if(letter == "=") support(2,3);
}
module support(position, height){
  scale([line,line,line]){
    translate([position, 0, 2.5-(supportWidth/2)]){
      cube([1, height == undef ? 5 : height, supportWidth]);
    } 
  }
}