//TopBar
latchWidth=5;
latchLength=114;
latchHeight=10;

//MiddleHook
hookLength=67;
hookWidth=6;

//Hoop
openingMul=3;

//Tabs
tabsLength=15;
tabsThickness=5;

opening=hookWidth*openingMul;
hookHeight=latchHeight;

union(){
    cube([latchWidth,latchLength,latchHeight],center=true);
    translate([latchWidth+((tabsLength-latchWidth)/2),0,0]){
    difference(){
        cube([tabsLength,latchLength,latchHeight],center=true);
        cube([tabsLength,latchLength-tabsThickness,latchHeight],center=true);
    }}
    translate([(hookLength/2)+(latchWidth/2),0,0]){
        cube([hookLength,hookWidth,hookHeight],center=true);
    }
}
translate([(hookLength+(latchWidth/2)),hookWidth*(openingMul-1)+(hookWidth/2),-(hookHeight/2)]){
    linear_extrude(height=latchHeight){
    union(){
    difference(){
        circle(opening);
        translate([-(opening/2),0,0]){
        square([opening,opening*2],center=true);}
        circle(opening-hookWidth);
    }
    translate([-(hookWidth),hookWidth*(openingMul-1)+(hookWidth/2)]){
        union(){
    square([hookWidth*2,hookWidth],center=true);
            translate([-(hookWidth),0,0]){ 
            circle(hookWidth/2);
            } }
    }
 }}
}