/* [Cap] */
Wall_Thickness=0.4;//[0.2:0.1:2]
Cap_Ceiling_Thickness=0.6;//[0.4:0.1:2]
Cap_Inner_Diameter=80;//[30:150]
Cap_Wall_Height=15;//[5:30]
/* [Center Trap] */
Will_There_Be_Center_Trap="Yes";//[Yes,No]
Center_Trap_Upper_Hole_Diameter=40;//[15:55]
Center_Trap_Lower_Hole_Diameter=5;//[1:0.1:15]
Center_Trap_Lower_Hole_Angle=45;//[0:45]
Center_Trap_Height=50;//[5:150]
/* [Surrounding Traps] */
Number_Of_Surrounding_Traps=7;//[0:34]
Surrounding_Traps_Upper_Holes_Diameter=27;//[5:35]
Surrounding_Traps_Lower_Holes_Diameter=2;//[1:0.1:5]
Surrounding_Traps_Lower_Holes_Angle=0;//[0:45]
Surrounding_Traps_Lower_Holes_Orientation=0;//[0:359]
Surrounding_Traps_Height=30;//[5:150]
/* [Hidden] */
Keskjoon=(Will_There_Be_Center_Trap=="Yes")?(Cap_Inner_Diameter/2-Center_Trap_Upper_Hole_Diameter/2)/2+Center_Trap_Upper_Hole_Diameter/2:Cap_Inner_Diameter/4;
YmbritsevAuk=((Cap_Inner_Diameter/2-Keskjoon)<Surrounding_Traps_Upper_Holes_Diameter)?Cap_Inner_Diameter/2-Keskjoon:Surrounding_Traps_Upper_Holes_Diameter;
Maksimaalselt=floor(Keskjoon*2*3.14/YmbritsevAuk);
Ymbritsevaid=(Maksimaalselt<Number_Of_Surrounding_Traps)?Maksimaalselt:Number_Of_Surrounding_Traps;
difference(){
union(){
difference(){
kaas(Cap_Wall_Height,Cap_Inner_Diameter,Cap_Ceiling_Thickness);
if(Will_There_Be_Center_Trap=="Yes"){
cylinder(h=Cap_Ceiling_Thickness, d=Center_Trap_Upper_Hole_Diameter, $fn=100);}}
if(Will_There_Be_Center_Trap=="Yes"){
koonus(Center_Trap_Height,Center_Trap_Upper_Hole_Diameter,Center_Trap_Lower_Hole_Diameter,Center_Trap_Lower_Hole_Angle);}}
if(Number_Of_Surrounding_Traps!=0){
for ( i = [0 : Ymbritsevaid-1] ){
rotate( (i * 360 / Ymbritsevaid), [0, 0, 1])
translate([0, Keskjoon, 0])
cylinder(h=Cap_Ceiling_Thickness, d=YmbritsevAuk, $fn=100);}}}
if(Number_Of_Surrounding_Traps!=0){
for ( i = [0 : Ymbritsevaid-1] ){
rotate( (i * 360 / Ymbritsevaid), [0, 0, 1])
translate([0, Keskjoon, 0])
rotate(Surrounding_Traps_Lower_Holes_Orientation)
koonus(Surrounding_Traps_Height,YmbritsevAuk,Surrounding_Traps_Lower_Holes_Diameter,Surrounding_Traps_Lower_Holes_Angle);}}
module kaas(Korgus,Laius,Paksus){
difference(){
cylinder(h=Korgus, d=Laius+Wall_Thickness*2, $fn=100);
translate([0,0,Paksus])cylinder(h=Korgus, d=Laius, $fn=100);}}
module koonus(Korgus,Ylemine,Alumine,Nurk){
difference(){
difference(){
cylinder(h=Korgus, d1=Ylemine+Wall_Thickness*2, d2=Alumine+Wall_Thickness*2, $fn=100);
cylinder(h=Korgus, d1=Ylemine, d2=Alumine, $fn=100);}
translate([-Alumine*2,-Alumine/2-Cap_Ceiling_Thickness,Korgus])rotate([-Nurk,0,0])
cube([Alumine*4,Alumine*4,Alumine*2],center=false);}}