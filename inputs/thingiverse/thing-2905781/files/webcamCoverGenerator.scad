/* Webcam Cover generator v1.0
 * By: Kleinjoni aka. sneezegray
 *
 * - change the values like you want 
 * - render(F6)
 * - look if everything fits, maybe change values again 
 * - change print=true 
 * - export .stl file
 * 
 */
/////////// Settings /////////////
//////////////////////////////////
// print=true putts the parts in printable position 
print=false;
// the outer dimmensions
widht=42;
hight=12;
thickness=1;
// the border width
border=2.4; 
// the width of the webcam cover
camW=13; 
// Design Options
cubic=false;
// stripe widht( 0 if not wanted)
stripes=0.7; 
// how facet rich it should be
$fn=50; 
// spacing Options
// upper gap
gap1=0.15; 
// middel spacing Gap(mostly not necessary)
gap2=0; 
// under gap
gap3=0.15;
// The size difference of the overlapping parts (in Procent) .
under=20; 
//////////////////////////////////
//////////////////////////////////
diff=under/100;

echo("<b>overlapping downpart thickness:", thickness*diff ,"</b>");
echo("<b>overlapping uperpart thickness:", thickness-thickness*diff-gap2 ,"</b>");
echo("<b>webcam hight :", hight-border*2 ,"</b>");

module rcube(w,h,t,cu) {
union(){
if(cu==false){
w=w-h;
translate([w/2,0,0]) {cylinder(t,h/2,h/2);}
translate([-w/2,0,0]) {cylinder(t,h/2,h/2);}
translate([-w/2,-h/2,0]) {cube([w,h,t]);}
}
if(cu==true){
translate([-w/2,-h/2,0]) {cube([w,h,t]);}
}
}
}
if(print==true){
translate([0,hight,thickness])rotate([180,0,0])
oval();
}
if(print==false){
oval();
}
module oval(){
difference(){
rcube(widht,hight,thickness,cubic);
    union(){
rcube((widht-border*2),(hight-border*2),(thickness),cubic);
rcube((widht-border*2),(hight-border),(thickness*diff+gap2),cubic);
    }
}
}

module linear_array( count, distance ) {
    for ( i= [1:1:count])  {
        translate([distance*i,0,0,]) 
        children();
    }
}

translate([widht/2-border-camW/2,0,0]) {
difference(){
union(){
rcube((camW-gap1),(hight-border*2-gap1*1.5),(thickness),cubic);
rcube((camW-gap3),(hight-border-gap3),(thickness*diff),cubic);
}
translate([-camW/2-(hight+border)/2+stripes,-hight/2,thickness*((diff-1)*-1)]) 
linear_array( count=30, distance=2)  cube([stripes,hight+border,1]);

}
}
