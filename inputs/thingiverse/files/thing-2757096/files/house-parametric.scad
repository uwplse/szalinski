// Vorgaben/settings:
//-------------------
$fn = 300;
breite=914.4;
laenge=1524;
unterbau_balken_breite=50.8;
unterbau_balken_hoehe=101.6;
platform_hoehe=12.7;
support_balken_breite=50.8;
support_balken_hoehe=50.8;
hoehe=939.8;
wand_staerke=12.7;
dachneigung=30;
tuer_hoehe=622.3;
tuer_breite=304.8;
dach_ueberstand=127;
dach_staerke=12.7;

// Variable explanations:
//-----------------------
//breite=914.4; //=36*25.4; //width
//laenge=1524; //=60*25.4; //length
//unterbau_balken_breite=50.8; //=2*25.4; //substruction beam width
//unterbau_balken_hoehe=101.6; //=4*25.4; //substruction beam height
//platform_hoehe=12.7; //=0.5*25.4; //platform height
//support_balken_breite=50.8; //=2*25.4; //support beam width
//support_balken_hoehe=50.8; //=2*25.4; //support beam height
//hoehe=939.8; //=37*25.4; //wall height
//wand_staerke=12.7; //=0.5*25.4; //wall width
//dachneigung=30; //grad //roof pitch in degree
//tuer_hoehe=622.3; //=24.5*25.4; //door height (incl. arch)
//tuer_breite=304.8; //=12*25.4; //door width
//dach_ueberstand=127; //=5*25.4; //roof overhang
//dach_staerke=12.7; //=0.5*25.4; //roof thickness

// Rechnungen/calculations:
//-------------------------
hoehe_giebel3eck = (breite / 2 + wand_staerke) * tan(dachneigung);
tuer_rahmenhoehe = tuer_hoehe - tuer_breite / 2;

rotate([0,0,180]){

translate([0, laenge / 2 - unterbau_balken_breite / 2, 0])
{
	houseBaseWidth(breite, unterbau_balken_breite, unterbau_balken_hoehe);
}

translate([0, -(laenge / 2) + unterbau_balken_breite / 2, 0])
{
	houseBaseWidth(breite, unterbau_balken_breite, unterbau_balken_hoehe);
}

translate([breite / 2 - unterbau_balken_breite / 2, 0, 0])
{
	houseBaseLength(laenge, unterbau_balken_breite, unterbau_balken_hoehe);
}

translate([-(breite / 2) + unterbau_balken_breite / 2, 0, 0])
{
	houseBaseLength(laenge, unterbau_balken_breite, unterbau_balken_hoehe);
}

translate([0, 0, unterbau_balken_hoehe / 2 + platform_hoehe / 2])
{
	houseBasePlatform(breite, laenge, platform_hoehe);
}

translate([breite / 2 - support_balken_breite / 2, 0, unterbau_balken_hoehe / 2 + platform_hoehe + support_balken_hoehe / 2])
{
	houseWallLengthSupport(laenge, support_balken_breite, support_balken_hoehe);
}

translate([-(breite / 2) + support_balken_breite / 2, 0, unterbau_balken_hoehe / 2 + platform_hoehe + support_balken_hoehe / 2])
{
	houseWallLengthSupport(laenge, support_balken_breite, support_balken_hoehe);
}

translate([breite / 2 + wand_staerke / 2, 0, hoehe / 2 + unterbau_balken_hoehe / 2 - platform_hoehe])
{
	houseWallLength(laenge, hoehe, wand_staerke);
}

translate([- breite / 2 - wand_staerke / 2, 0, hoehe / 2 + unterbau_balken_hoehe / 2 - platform_hoehe])
{
	houseWallLength(laenge, hoehe, wand_staerke);
}

translate([0, laenge / 2 - support_balken_breite / 2, unterbau_balken_hoehe / 2 + platform_hoehe + support_balken_hoehe / 2])
{
	houseWallWidthSupport(breite, support_balken_breite, support_balken_hoehe);
}

translate([0, -(laenge / 2) + support_balken_breite / 2, unterbau_balken_hoehe / 2 + platform_hoehe + support_balken_hoehe / 2])
{
	houseWallWidthSupport(breite, support_balken_breite, support_balken_hoehe);
}

translate([0, -laenge / 2 - wand_staerke / 2, hoehe / 2 + unterbau_balken_hoehe / 2 - platform_hoehe])
{
	houseWallBack(laenge, breite, hoehe, wand_staerke, hoehe_giebel3eck);
}

translate([0, laenge / 2 + wand_staerke / 2, hoehe / 2 + unterbau_balken_hoehe / 2 - platform_hoehe])
{
	houseWallFront(laenge, breite, hoehe, wand_staerke, hoehe_giebel3eck, tuer_breite, tuer_rahmenhoehe);
}

translate([0, - laenge / 2 - wand_staerke - dach_ueberstand, hoehe + hoehe_giebel3eck + platform_hoehe + support_balken_hoehe / 2])
{
	roofPanel(laenge, breite, hoehe_giebel3eck, dach_ueberstand, dachneigung, dach_staerke, wand_staerke);
}

translate([0, laenge / 2 + wand_staerke + dach_ueberstand, hoehe + hoehe_giebel3eck + platform_hoehe + support_balken_hoehe / 2])
{
    rotate([0, 0, 180]){
        roofPanel(laenge, breite, hoehe_giebel3eck, dach_ueberstand, dachneigung, dach_staerke, wand_staerke);
    }
}

} //end house rotate

module houseBaseWidth(breite, unterbau_balken_breite, unterbau_balken_hoehe)
{
	rotate([0, 0, 90])
	{
		cube([unterbau_balken_breite, breite - 2 * unterbau_balken_breite, unterbau_balken_hoehe], center = true);
	}
}
module houseBaseLength(laenge, unterbau_balken_breite, unterbau_balken_hoehe)
{
	cube([unterbau_balken_breite, laenge, unterbau_balken_hoehe], center = true);
}
module houseBasePlatform(breite, laenge, platform_hoehe)
{
	cube([breite, laenge, platform_hoehe], center = true);
}
module houseWallLengthSupport(laenge, support_balken_breite, support_balken_hoehe)
{
	cube([support_balken_breite, laenge - 2 * support_balken_breite + support_balken_breite, support_balken_hoehe], center = true);
}
module houseWallWidthSupport(breite, support_balken_breite, support_balken_hoehe)
{
	rotate([0, 0, 90])
	{
		cube([support_balken_breite, breite - 2 * support_balken_breite - support_balken_breite, support_balken_hoehe], center = true);
	}
}
module houseWallLength(laenge, hoehe, wand_staerke)
{
	cube([wand_staerke, laenge, hoehe], center = true);
}
module houseWallBack(laenge, breite, hoehe, wand_staerke, hoehe_giebel3eck)
{
    rotate([0, 0, 90]){
        cube([wand_staerke, breite + 2 * wand_staerke, hoehe], center = true);
    }//end rotate

    translate([breite / 2 + wand_staerke, -wand_staerke / 2, hoehe / 2]){
        rotate([0, 0, 90]){
            prism(wand_staerke, breite / 2 + wand_staerke, hoehe_giebel3eck);
        }
    }
    
    translate([-breite / 2 - wand_staerke, wand_staerke / 2, hoehe / 2]){
        rotate([0, 0, -90]){
            prism(wand_staerke, breite / 2 + wand_staerke, hoehe_giebel3eck);
        }
    }
}
module houseWallFront(laenge, breite, hoehe, wand_staerke, hoehe_giebel3eck, tuer_breite, tuer_rahmenhoehe)
{
    difference(){
        
        union(){
                
            rotate([0, 0, 90]){
                cube([wand_staerke, breite + 2 * wand_staerke, hoehe], center = true);
            }//end rotate
        
            translate([breite / 2 + wand_staerke, -wand_staerke / 2, hoehe / 2]){
                rotate([0, 0, 90]){
                    prism(wand_staerke, breite / 2 + wand_staerke, hoehe_giebel3eck);
                }
            }
            
            translate([-breite / 2 - wand_staerke, wand_staerke / 2, hoehe / 2]){
                rotate([0, 0, -90]){
                    prism(wand_staerke, breite / 2 + wand_staerke, hoehe_giebel3eck);
                }//end rotate
            }//end translate
        }//end wall union
 	
        union()
        {	
            translate([0, 0, -hoehe / 2 + 2 * platform_hoehe + support_balken_hoehe + tuer_rahmenhoehe / 2])
            {
                cube([tuer_breite, 2 * wand_staerke, tuer_rahmenhoehe], center = true);
            }// end translate
        
            translate([0, 0, -hoehe / 2 + 2 * platform_hoehe + support_balken_hoehe + tuer_rahmenhoehe])
            {
                rotate([90, 0, 0])
                {
                    cylinder(d = tuer_breite, h = 2 * wand_staerke, center = true);
                }// end rotate
            }// end translate
        }// end door union
    }// end difference
}//end module
module roofPanel(laenge, breite, hoehe_giebel3eck, dach_ueberstand, dachneigung, dach_staerke, wand_staerke)
{
    rotate([0, dachneigung, 0])
    {
        cube([ sqrt ( pow ( hoehe_giebel3eck, 2) + pow (breite / 2 + wand_staerke, 2) ) + dach_ueberstand, laenge + 2 * dach_ueberstand + 2 * wand_staerke, dach_staerke], center = false);
    }//end rotate
}// end module
module prism(l, w, h){
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}