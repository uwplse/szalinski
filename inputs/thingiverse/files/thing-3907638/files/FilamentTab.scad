/* [Tabs] */
//Tab
type = 0;//[0:Left,1:Center,2:Righ]

//Tab heading text
text = "PETG";

/* [Hidden] */
Hight = 0.8;
TextSize = 7;
$fn=100; //smoother text

cube([101.6,57.2,Hight]); //tab

translate([3.1+type*32,57.2,0]) {
    cube([32,12.7,Hight]); //heading
    translate([16,6.35,0.8]) linear_extrude(height=Hight)
    text(text=text, valign = "center", halign="center" , size=TextSize, font="Helvetica");
}
    


