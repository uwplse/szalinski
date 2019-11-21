/* [Template] */

// Choose the template
template = "Tower ground" ; //[Tower ground, Tower floor]

/* [Base] */

// Base size of the template (8, 12 or 16)
base_plate_size = 8 ; //[8:4:16]

/* [Gates/Windows] */

// Choose the style of the 'Gate(s)' [Ground] or the 'high part of Window(s)' [Floor]
gate_style = "Ogee Arch" ; //[Roman Arch, Ogee Arch, Pointed Arch, Angular Arch]

// Choose the height (12 to 24)
gate_height = 12 ; //[12:1:24]

// Choose the width (Max half of gate height, Min 3.5 [Ground] or 0.5 [Floor])
gate_width = 4 ; //[0.5:0.5:8]

// Choose the position (f:front, b:back, l:left, r:right)
gate_position = "fblr" ; //[fb,rl,fbrl,f,b,r,l,fl,fr,bl,br,fbr,fbl,frl,brl]

// Choose the height over the Gate or Window
height_over_gate = 0.5 ; //[0.5:0.5:6]


/* [Battlements/Windows] */

// Choose the height of the 'Battlements' or the 'low part of Window(s)'
windows_height = 3 ; //[3:1:9]

// Choose the width (Max quater of base size)
windows_width = 2 ; //[0.5:0.5:4]


/* [Hidden] */
if (template == "Tower ground") 
tower_round_ground (base_plate_size, gate_style, gate_height, gate_width, gate_position, height_over_gate, windows_height, windows_width, "fbrl");
else if (template == "Tower floor")
tower_round_floor (base_plate_size, gate_style, gate_height, gate_width, gate_position, height_over_gate, windows_height, windows_width, "fbrl");
else {
  tower_round_ground (base_plate_size, "Ogee Arch", gate_height, gate_width, "fb", height_over_gate, windows_height, 0.5, "fbrl");
  /*
  translate([0,0,(1+gate_height+height_over_gate+15)*3.2])
  tower_round_floor (base_plate_size, "Angular Arch", gate_height, 0.5, gate_position, height_over_gate, windows_height, 2, "fbrl");
  translate([0,0,(1+gate_height+height_over_gate+36.5)*3.2])
  tower_round_floor (base_plate_size, "Roman Arch", gate_height, 2, gate_position, height_over_gate, windows_height, 2, "fbrl");
  */
}



// ******* Settings *******

SCALE =0.5;
LEGO_DIV = true;
LEGO_SCALE = 2 * SCALE;
PART_WIDTH   = 16.0  * SCALE;
PART_HEIGHT  = ((SCALE < 0.6) && LEGO_DIV) ? ( 3.2 * LEGO_SCALE ) : ( 4.8 * SCALE );
NO = PART_WIDTH / 2.0;
NBO = PART_WIDTH ;
NH = (SCALE < 0.6) ? 1.75 * LEGO_SCALE : 4.55 * SCALE;
NB_RADIUS       = (SCALE < 0.6) ? (4.9 / 2 * LEGO_SCALE) : (9.2 / 2.0 * SCALE);
NB_RADIUS_INSIDE = 6.8/2  * SCALE;
LATTICE_WIDTH   = 1.50 * SCALE;
LATTICE_TYPE    = 1;



// ******* Customizable Legolike Round Tower *******

//***********************************************
//* tower_round_ground (...)                  *
//* size of base_plate                          *
//*     b_plate = [8,8] (min 8 & multiple of 4) *
//* number of gate                              *
//*     gate = 0 (aucune porte) à 4             *
//* h_Gate <=> height of gate(s)                *
//*        default = 12 (multiple of 3)         *
//* p_Gate <=> position(s) of gate(s)           *
//*         = f,b,l,r                           *
//*         = fb,fl,fr,bl,br,lr                 *
//*         = fbl,fbr,flr,blr                   *
//*         = fblr                              *
//* number of window                            *
//*      window= 0 (aucune porte) à 4           *
//* h_Window <=> height of window(s)            *
//* w_Window <=> width of window(s)             *
//* p_window <=> position(s) of window(s)       *
//*         = "f","b","r","l"                   *
//*         = "fb","fr","fl","br","bl","rl"     *
//*         = "fbr","fbl","frl","brl"           *
//*         = "fbrl"                            *
//***********************************************
// Ogee Arch


function getHeightWindow(h_Win) 
    = h_Win < 3 ? 3 : h_Win > 9 ? 9 : h_Win;
	
function getWidthWindow(w_Win, b_plate) 
    = w_Win < 0.5 ? 0.5 : w_Win > b_plate/4 ? b_plate/4 : w_Win;
	
function getHeightGate(h_Gate) 
    = h_Gate < 12 ? 12 : h_Gate > 24 ? 24 : h_Gate;
	
function getWidthGateFloor(w_Gate, b_plate) 
    = w_Gate < 0.5 ? 0.5 : w_Gate > b_plate/4 ? b_plate/4 : w_Gate;
	
function getWidthGateGround(w_Gate, b_plate) 
    = w_Gate < 3.5 ? 3.5 : w_Gate > b_plate/2 ? b_plate/2 : w_Gate;

function getOverGate(h_OverGate, w_Gate)
    = h_OverGate < 0 ? 0 : h_OverGate > 6 ? 6 : h_OverGate;

function getPosiGate(p_Gate)
    = len(p_Gate) < 4 ? "fblr" : p_Gate;

function getWidthBase(b_plate) 
    = b_plate[0] < 8 ? 8 : b_plate[0] > 16 ? 16 : b_plate[0]%8 > 0 ? b_plate[0]-b_plate[0]%8+4 : b_plate[0];
	
function getLengthBase(b_plate) 
    = b_plate[1] < 8 ? 8 : b_plate[1] > 16 ? 16 : b_plate[1]%8 > 0 ? b_plate[1]-b_plate[1]%8+4 : b_plate[1];
	
function getstudsSize(w_Gate) 
    = w_Gate == 8 || w_Gate > 8 ? 8 : w_Gate == 6 || w_Gate > 6 ? 6 : w_Gate == 4 || w_Gate > 4 ? 4 : 2;


// ******* templates *******

module tower_round_floor (
            b_plate, s_Gate, 
            h_Gate, w_Gate, p_Gate, 
            h_OverGate,
            h_Window, w_Window, p_window )
{
    echo( str("Template FLOOR") );
    $fs = 0.1;
    $fa = 4;
    
    heightBase = 0;
    xBase = b_plate;//getWidthBase(b_plate);//
    yBase = b_plate;//getLengthBase(b_plate);//
    echo( str("Size Base = ", xBase,"x", yBase) );
    styleGate = s_Gate;
    heightGate = getHeightGate(h_Gate)/2;
    widthGate = getWidthGateFloor(w_Gate, b_plate);
	posiGate = getPosiGate(p_Gate);
    echo( str("Largeur = ", widthGate,", ", w_Gate) );
    overGate = getOverGate(h_OverGate,widthGate);//widthGate*(3/3,5);
    echo( str("Nombre porte = ", len(p_Gate),", heightGate = ", heightGate,", widthGate = ",widthGate,", heightBase = ",heightBase,", overGate = ",overGate) );
    posiFloor = heightBase+heightGate+overGate;
    echo( str("posiFloor = ", posiFloor) );
    heightFloor = 6;
    overFloor = 3;
    heightBattlement = getHeightWindow(h_Window);//6;
    heightTow = heightGate+overGate+heightFloor
    +overFloor+heightBattlement;
    echo( str("heightTow = ", heightTow) );
    posiBattlement = heightBase+heightTow
    -heightBattlement;
    
    // (col, row, up, width,length,height,studs_on_off) 
    
    // Base plate
    widthB = xBase;
    lengthB = yBase;
    
    // Tower settings
    weTow = widthB;//8
    leTow = lengthB;//8
    ceTow = weTow/2;//4
    reTow = leTow/2;//4
    wiTow = weTow-2;//6
    liTow = leTow-2;//6
    ciTow = wiTow/2;//3
    riTow = liTow/2;//3
    wBat = weTow+2;//10
    lBat = getWidthWindow(w_Window, b_plate);//2;
    //heightWindow = heightGate;
    widthWindow = lBat;
    
    echo( str("heightBase = ", heightBase) );
    echo( str("weTow = ",weTow,", leTow = ",leTow,
              ", ceTow = ",ceTow,", reTow = ",reTow,
              ", wBat = ",wBat,", lBat = ",lBat) );
    
    // All tower structures
    difference () {
	// Tower & Roof platform
    union () {
      // Tower corpse structure
      difference () {
        cyl_block (-ceTow, -reTow, heightBase, weTow, leTow, heightTow, false) ;
        cyl_block (-ciTow, -riTow, heightBase-1, wiTow, liTow, heightTow+2, false) ;
        // holes in the wall on top
        // <=> battlement or window base
        block (-wBat/2, -lBat/2, posiBattlement, wBat, lBat, heightBattlement+1, false) ;
        block (-lBat/2, -wBat/2, posiBattlement, lBat, wBat, heightBattlement+1, false) ;
        
      } 
      // End difference() Tower corpse structure
      
      // Roof platform 
      union() {
        difference () {
          cyl_block (-ciTow,   -riTow,   posiFloor,  wiTow, liTow, heightFloor, false) ;
          cyl_block (-ciTow, -riTow, posiFloor-0.01, wiTow, 1, heightFloor-1, false) ;
        } 
        // End difference() Roof platform
        // studs on roof platform
        pFloor = posiFloor+heightFloor;
        studs_in_round_wall ( widthB, lengthB, pFloor,
                                  ceTow, reTow );
      } 
      // End union() Roof platform
    } 
    // End union() Tower & Roof platform
	// Gate(s)
        echo( str("Largeur = ", widthGate) );
		gate_with_arch (styleGate, widthGate, wBat, heightGate, posiGate);
    // Negative studs on base of Template
        height = -0.25;
        #studs_on_battlement(height, widthB, lengthB);
        #studs_on_battlement(height+0.5, widthB, lengthB);
    } 
    // End difference() All tower structures
    // studs on battlement
    height = heightTow+heightBase;
    studs_on_battlement(height, widthB, lengthB);

}


module tower_round_ground (
            b_plate, s_Gate,
            h_Gate, w_Gate, p_Gate, 
            h_OverGate,
            h_Window, w_Window, p_window )
{
    echo( str("Template GROUND") );
    $fs = 0.1;
    $fa = 4;
    
    heightBase = 1;
    xBase = b_plate;//getWidthBase(b_plate);//
    yBase = b_plate;//getLengthBase(b_plate);//
    echo( str("Size Base = ", xBase,"x", yBase) );
	styleGate = s_Gate;
    heightGate = getHeightGate(h_Gate);
    widthGate = getWidthGateGround(w_Gate, b_plate);
    overGate = getOverGate(h_OverGate,widthGate);//widthGate*(3/3,5);
    echo( str("Nombre porte = ", len(p_Gate),", heightGate = ", heightGate,", widthGate = ",widthGate,", heightBase = ",heightBase,", overGate = ",overGate) );
    posiFloor = heightBase+heightGate+overGate;
    echo( str("posiFloor = ", posiFloor) );
    heightFloor = 6;
    overFloor = 3;
    heightBattlement = getHeightWindow(h_Window);//6;
    heightTow = heightGate+overGate+heightFloor
    +overFloor+heightBattlement;
    echo( str("heightTow = ", heightTow) );
    posiBattlement = heightBase+heightTow
    -heightBattlement;
    
    // (col, row, up, width,length,height,studs_on_off) 
    
    // Base plate
    widthB = xBase;
    lengthB = yBase;
    heightB = heightBase;
    colB = xBase/2;
    rowB = yBase/2;
    upB = 0;

    base_plate (-colB, -rowB, upB, widthB, lengthB, heightB, false);
    
    // studs of base plate
    studs_on_base_round_tower(widthB, lengthB, heightB,
                                colB, rowB, p_Gate, widthGate);

    // Tower settings
    weTow = widthB;//8
    leTow = lengthB;//8
    ceTow = weTow/2;//4
    reTow = leTow/2;//4
    wiTow = weTow-2;//6
    liTow = leTow-2;//6
    ciTow = wiTow/2;//3
    riTow = liTow/2;//3
    wBat = weTow+2;//10
    lBat = getWidthWindow(w_Window, b_plate);//2;
    echo( str("heightBase = ", heightBase) );
    echo( str("weTow = ",weTow,", leTow = ",leTow,
              ", ceTow = ",ceTow,", reTow = ",reTow,
              ", wBat = ",wBat,", lBat = ",lBat) );
    
    // All tower structures
    difference () {
	// Tower & Roof platform
    union () {
      // Tower corpse structure
      difference () {
        cyl_block (-ceTow, -reTow, heightBase, weTow, leTow, heightTow, false) ;
        cyl_block (-ciTow, -riTow, heightBase-1, wiTow, liTow, heightTow+2, false) ;
        // holes in the wall on top
        // <=> battlement or window base
        block (-wBat/2, -lBat/2, posiBattlement, wBat, lBat, heightBattlement+1, false) ;
        block (-lBat/2, -wBat/2, posiBattlement, lBat, wBat, heightBattlement+1, false) ;
      } 
      // End difference() Tower corpse structure
      
      // Roof platform 
      union() {
        difference () {
          cyl_block (-ciTow,   -riTow,   posiFloor,  wiTow, liTow, heightFloor, false) ;
          cyl_block (-ciTow, -riTow, posiFloor-0.01, wiTow, 1, heightFloor-1, false) ;
        } 
        // End difference() Roof platform
        // studs on roof platform
        pFloor = posiFloor+heightFloor;
        studs_in_round_wall ( widthB, lengthB, pFloor,
                                  ceTow, reTow );
      } 
      // End union() Roof platform
    } 
    // End union() Tower & Roof platform
	// Gate(s)
		gate_with_arch (styleGate, widthGate, wBat, heightGate+heightBase, p_Gate);
	} 
    // End difference() All tower structures
    
    // studs on battlement
    height = heightTow+heightBase;
    studs_on_battlement(height, widthB, lengthB);

}



// ******* Archs *******

module gate_with_arch (styleGate, widthGate, lengthGate, heightGate, p_Gate)
{
	union() {
        if( search("f",p_Gate) && search("b",p_Gate) )  {  
            if (styleGate == "Angular Arch")      angulararch_fb (-widthGate/2, -lengthGate/2, -1, widthGate, lengthGate, heightGate) ;
			else if (styleGate == "Pointed Arch") pointedarch_fb (-widthGate/2, -lengthGate/2, -1, widthGate, lengthGate, heightGate) ;
			else if (styleGate == "Roman Arch")     romanarch_fb (-widthGate/2, -lengthGate/2, -1, widthGate, lengthGate, heightGate) ;
			else if (styleGate == "Ogee Arch")       ogeearch_fb (-widthGate/2, -lengthGate/2, -1, widthGate, lengthGate, heightGate) ;
		}
        else if( search("f",p_Gate) )    {
            if (styleGate == "Angular Arch")      angulararch_fb (-widthGate/2, 0, -1, widthGate, lengthGate, heightGate) ;
			else if (styleGate == "Pointed Arch") pointedarch_fb (-widthGate/2, 0, -1, widthGate, lengthGate, heightGate) ;
			else if (styleGate == "Roman Arch")     romanarch_fb (-widthGate/2, 0, -1, widthGate, lengthGate, heightGate) ;
			else if (styleGate == "Ogee Arch")       ogeearch_fb (-widthGate/2, 0, -1, widthGate, lengthGate, heightGate) ;
		}
		else if( search("b",p_Gate) ) {   
            if (styleGate == "Angular Arch")      angulararch_fb (-widthGate/2, -lengthGate, -1, widthGate, lengthGate, heightGate) ;
			else if (styleGate == "Pointed Arch") pointedarch_fb (-widthGate/2, -lengthGate, -1, widthGate, lengthGate, heightGate) ;
			else if (styleGate == "Roman Arch")     romanarch_fb (-widthGate/2, -lengthGate, -1, widthGate, lengthGate, heightGate) ;
			else if (styleGate == "Ogee Arch")       ogeearch_fb (-widthGate/2, -lengthGate, -1, widthGate, lengthGate, heightGate) ;
		}
		
        if( search("l",p_Gate) && search("r",p_Gate) ) {   
            if (styleGate == "Angular Arch")      angulararch_lr (-widthGate/2, -lengthGate/2, -1, widthGate, lengthGate, heightGate) ;
			else if (styleGate == "Pointed Arch") pointedarch_lr (-widthGate/2, -lengthGate/2, -1, widthGate, lengthGate, heightGate) ;
			else if (styleGate == "Roman Arch")     romanarch_lr (-widthGate/2, -lengthGate/2, -1, widthGate, lengthGate, heightGate) ;
			else if (styleGate == "Ogee Arch")       ogeearch_lr (-widthGate/2, -lengthGate/2, -1, widthGate, lengthGate, heightGate) ;
        }
		else if( search("l",p_Gate) ) {  
            if (styleGate == "Angular Arch")      angulararch_lr (-widthGate/2, -lengthGate, -1, widthGate, lengthGate, heightGate) ;
			else if (styleGate == "Pointed Arch") pointedarch_lr (-widthGate/2, -lengthGate, -1, widthGate, lengthGate, heightGate) ;
			else if (styleGate == "Roman Arch")     romanarch_lr (-widthGate/2, -lengthGate, -1, widthGate, lengthGate, heightGate) ;
			else if (styleGate == "Ogee Arch")       ogeearch_lr (-widthGate/2, -lengthGate, -1, widthGate, lengthGate, heightGate) ;
			
        }
        else if( search("r",p_Gate) )  {
			if (styleGate == "Angular Arch")      angulararch_lr (-widthGate/2, 0, -1, widthGate, lengthGate, heightGate) ;
			else if (styleGate == "Pointed Arch") pointedarch_lr (-widthGate/2, 0, -1, widthGate, lengthGate, heightGate) ;
			else if (styleGate == "Roman Arch")     romanarch_lr (-widthGate/2, 0, -1, widthGate, lengthGate, heightGate) ;
			else if (styleGate == "Ogee Arch")       ogeearch_lr (-widthGate/2, 0, -1, widthGate, lengthGate, heightGate) ;
		}
		
	}
}

module ogeearch_fb (col, row, up, width, length, height)
{
	halfWidth = width/2 ;
	thickness_point = halfWidth/20 ;
	correctedHeight = (height*PART_HEIGHT-width*PART_WIDTH/2)/PART_HEIGHT ;
	echo( str("* Hauteur = ",height) );
	echo( str("* Hauteur corrigée = ",correctedHeight) );
	// build the cube from its center
    x_0 = col*PART_WIDTH + width*PART_WIDTH / 2.0 ;
    y_0 = - (row*PART_WIDTH + length*PART_WIDTH / 2.0) ;
    z_0 = up*PART_HEIGHT + (correctedHeight+1)*PART_HEIGHT / 2.0 ;
    
	// the cube is drawn at absolute x,y,z = 0 then moved
    translate ([x_0, y_0, z_0]) {
	//the cube
	cube([width*PART_WIDTH, length*PART_WIDTH, (correctedHeight+1)*PART_HEIGHT], true);
	difference() {
        union() {
            translate([0,0,(correctedHeight+1)*PART_HEIGHT/2+halfWidth*PART_WIDTH/2])
            cube([halfWidth*PART_WIDTH, length*PART_WIDTH, halfWidth*PART_WIDTH], true);
            
            translate([-halfWidth*PART_WIDTH/2,0,(correctedHeight+1)*PART_HEIGHT/2])
            rotate([90,0,0])
            cylinder($fn = 64, h=length*PART_WIDTH, d=halfWidth*PART_WIDTH, center=true);
            ;
            translate([halfWidth*PART_WIDTH/2,0,(correctedHeight+1)*PART_HEIGHT/2])
            rotate([90,0,0])
            cylinder($fn = 64, h=length*PART_WIDTH, d=halfWidth*PART_WIDTH, center=true);
			
			
        }
        translate([-halfWidth*PART_WIDTH/2-thickness_point,0,(correctedHeight+1)*PART_HEIGHT/2+halfWidth*PART_WIDTH])
        rotate([90,0,0])
        cylinder($fn = 64, h=length*PART_WIDTH+2, d=halfWidth*PART_WIDTH, center=true);
           
        translate([halfWidth*PART_WIDTH/2+thickness_point,0,(correctedHeight+1)*PART_HEIGHT/2+halfWidth*PART_WIDTH])
        rotate([90,0,0])
        cylinder($fn = 64, h=length*PART_WIDTH+2, d=halfWidth*PART_WIDTH, center=true);
    }
	}
}

module romanarch_fb (col, row, up, width, length, height) 
/* Use cases:
- create doors with openscad difference operator
- a hack, only work along y axis and with a min. height and length ... try ;)
*/
{
    correctedHeight = (height*PART_HEIGHT-width*PART_WIDTH/2)/PART_HEIGHT ;
	// build the cube from its center
    x_0 = col    * PART_WIDTH  + width  * PART_WIDTH / 2.0;
    y_0 = - (row * PART_WIDTH + length * PART_WIDTH / 2.0) ;
    z_0 = up      * PART_HEIGHT  + (correctedHeight+1) * PART_HEIGHT / 2.0;
    
	// the cube is drawn at absolute x,y,z = 0 then moved
    translate ([x_0, y_0, z_0]) {
	//the cube
	cube([width*PART_WIDTH, length*PART_WIDTH, (correctedHeight+1)*PART_HEIGHT], true);
	translate ([0,0,(correctedHeight+1)*PART_HEIGHT/2]) {
	    rotate ([90,0,0]) {
		cylinder($fn = 64, h=length*PART_WIDTH, d=width * PART_WIDTH, center = true);
	    }
	}
    }		
}

module pointedarch_fb (col, row, up, width, length, height) 
/* Use cases:
- create doors with openscad difference operator
- a hack, only work along y axis and with a min. height and length ... try ;)
*/
{
    correctedHeight = (height*PART_HEIGHT-sqrt(3)/2*width*PART_WIDTH)/PART_HEIGHT ;
	// build the cube from its center
    x_0 = col    * PART_WIDTH  + width  * PART_WIDTH / 2.0;
    y_0 = - (row * PART_WIDTH + length * PART_WIDTH / 2.0) ;
    z_0 = up      * PART_HEIGHT  + (correctedHeight+1) * PART_HEIGHT / 2.0;
    
    // the cube is drawn at absolute x,y,z = 0 then moved
    translate ([x_0, y_0, z_0]) {
	//the cube
	cube([width*PART_WIDTH, length*PART_WIDTH, (correctedHeight+1)*PART_HEIGHT], true);
	translate ([0,0,(correctedHeight+1)*PART_HEIGHT/2]) {
	    rotate ([90,0,0]) {
		intersection() {
		translate ([width * PART_WIDTH/2,0,0])
		cylinder($fn = 64, h=length*PART_WIDTH, d=width*PART_WIDTH*2, center = true);
		translate ([-width * PART_WIDTH/2,0,0])
		cylinder($fn = 64, h=length*PART_WIDTH, d=width*PART_WIDTH*2, center = true);
		}
	    }
	}
    }		
}

module angulararch_fb (col, row, up, width,length,height) 
/* Use cases:
- create doors with openscad difference operator
- a hack, only work along y axis and with a min. height and length ... try ;)
*/
{
    correctedHeight = (height*PART_HEIGHT-width*PART_WIDTH/2)/PART_HEIGHT ;
	// build the cube from its center
    x_0 = col    * PART_WIDTH  + width  * PART_WIDTH / 2.0;
    y_0 = - (row * PART_WIDTH + length * PART_WIDTH / 2.0) ;
    z_0 = up      * PART_HEIGHT  + (correctedHeight+1) * PART_HEIGHT / 2.0;
    // That was 40 years ago
    roof_l = width*PART_WIDTH/sqrt(2);;

    // the cube is drawn at absolute x,y,z = 0 then moved
    translate ([x_0, y_0, z_0]) {
	//the cube
	cube([width*PART_WIDTH, length*PART_WIDTH, (correctedHeight+1)*PART_HEIGHT], true);
	translate ([0,0,(correctedHeight+1)*PART_HEIGHT/2]) {
	    rotate ([0,45,0]) {
		cube([roof_l, length*PART_WIDTH, roof_l], true);
	    }
	}
    }		
}

module ogeearch_lr (col, row, up, width, length, height)
/* Use cases:
- create doors with openscad difference operator
- a hack, only work along x axis and with a min. height and width
*/
{
	rotate([0,0,90])
	ogeearch_fb (col, row, up, width, length, height);
}

module romanarch_lr (col, row, up, width, length, height) 
/* Use cases:
- create doors with openscad difference operator
- a hack, only work along x axis and with a min. height and width
*/
{
    rotate([0,0,90])
	romanarch_fb (col, row, up, width, length, height);
}

module pointedarch_lr (col, row, up, width, length, height) 
/* Use cases:
- create doors with openscad difference operator
- a hack, only work along x axis and with a min. height and width
*/
{
    rotate([0,0,90])
	pointedarch_fb (col, row, up, width,length,height);
}

module angulararch_lr (col, row, up, width, length, height) 
/* Use cases:
- create doors with openscad difference operator
- a hack, only work along x axis and with a min. height and width
*/
{
    rotate([0,0,90])
	angulararch_fb (col, row, up, width,length,height);
}



// ******* Base plate *******

module base_plate (col, row, up, width,length,height,studs_on_off) 
/* Use cases:
- Creating an easy to print base plate for showing off your prints. I believe that buying one in a shop is more efficient ....
- to do: an other version that has round holes allowing to stack it.
*/
{
    // construction of the grid underneath
    // spacing = (SCALE < 0.6) ? NBO/LATTICE_TYPE*2 : NBO/LATTICE_TYPE;
    spacing = (SCALE > 0.6) ? NBO : NBO*2;
    offset  = NBO;
    x_start = - width/2  * PART_WIDTH + NBO;
    y_start = - length/2 * PART_WIDTH + NBO;
    z_pos   = (LEGO_DIV) ? height * PART_HEIGHT/2 - LATTICE_WIDTH * 2 : height * PART_HEIGHT/2 - LATTICE_WIDTH - LATTICE_WIDTH/2 ;
    n_rows  = (SCALE > 0.6) ? length-2 : (length-2)/2 ;  // Need less for legos
    n_cols  = (SCALE > 0.6) ? width-2 :  (width-2)/2;

    // positioning of the grid with respect to the cube
    x_0 = col    * PART_WIDTH  + width  * PART_WIDTH / 2.0;
    y_0 = - (row * PART_WIDTH + length * PART_WIDTH / 2.0) ;
    z_0 = up      * PART_HEIGHT ;

    difference () {
	block (col, row, up, width,length,height,studs_on_off) ;

	union () {
	    translate ([x_0, y_0, z_0])
		{
		    translate ([0, y_start, z_pos]) {
			// grid along y-axis
			for (i = [0:n_rows]) {
			   translate([0, i* spacing, 0])
				{ cube([width*PART_WIDTH-offset*2, LATTICE_WIDTH, LATTICE_WIDTH],true); }
			}
		    }
		    // grid along x-axis
		    translate ([x_start, 0, z_pos]) {
			// holes along x-axis
			for (j = [0:n_cols]) {
			    translate([j * spacing, 0, 0]) 
				{ cube([LATTICE_WIDTH,length*PART_WIDTH-offset*2,LATTICE_WIDTH],true); }
			}
		    }
		}
	}
    }
}



// ******* Studs *******

module studs_on_base_round_tower(widthB, lengthB, heightB,
                        colB, rowB, p_Gate, w_Gate) {
                            
    // Central studs
    studs_in_round_wall (widthB, lengthB, heightB,
                        colB, rowB);
    
    // F, B, L, R studs add to Central Niddles
    // on gate localisation(s)
    studs_through_gate(widthB, lengthB, heightB,
                        colB, rowB, p_Gate, w_Gate);
    // Corner studs
    corner_studs_over_round_wall(widthB, lengthB, heightB,
                        colB, rowB);

}

module studs_through_gate(widthB, lengthB, heightB,
                        colB, rowB, p_Gate, widthGate)
{
    // Under Gate studs
    w_Gate = widthGate;
    pNib = heightB;
    cNib = colB/2;
    rNib = rowB/2;
    wNib = getstudsSize(w_Gate); 
    lNib = getstudsSize(w_Gate);
    
    echo( str("In studs_through_gate : widthGate = ", w_Gate,", wNib = ", wNib,", lNib = ", lNib) );
                            
    if(widthB == 8 && lengthB == 8) {
      if( search("f",p_Gate) ) 
          studs (-wNib/2,    rNib,   pNib, wNib, 2);
      if( search("b",p_Gate) )  
          studs (-wNib/2,   -rNib-2, pNib, wNib, 2);
      if( search("l",p_Gate) ) 
          studs (-cNib-2, -lNib/2, pNib, 2, lNib);
      if( search("r",p_Gate) ) 
          studs ( cNib,   -lNib/2, pNib, 2, lNib);
      
    }
    if(widthB == 12 && lengthB == 12) {
      if( search("f",p_Gate) ) 
          studs (-wNib/2, rNib+1, pNib, wNib, 2);
      if( search("b",p_Gate) )  
          studs (-wNib/2, -rNib-3, pNib, wNib, 2);
      if( search("l",p_Gate) ) 
          studs (-cNib-3, -lNib/2, pNib, 2, lNib);
      if( search("r",p_Gate) ) 
          studs ( cNib+1, -lNib/2, pNib, 2, lNib);
      
    }
    if(widthB == 16 && lengthB == 16) {
      if( search("f",p_Gate) ) 
          studs (-wNib/2,  rNib+2, pNib, wNib, 2);
      if( search("b",p_Gate) ) 
          studs (-wNib/2, -rNib-4, pNib, wNib, 2);
      if( search("l",p_Gate) ) 
          studs (-cNib*2,  -lNib/2, pNib, 2, lNib);
      if( search("r",p_Gate) ) 
          studs ( cNib+2, -lNib/2, pNib, 2, lNib);
      
    }       
}

module studs_in_round_wall (widthB, lengthB, pFloor,
                        ceTow, reTow)
{
    pNib = pFloor;
    wNib = widthB/2;
    lNib = lengthB/2;
    cNib = ceTow/2;
    rNib = reTow/2;
    
    studs (-cNib,   -rNib,   pNib, wNib, lNib);
    if(widthB > 8) {
        studs (-cNib-1, -rNib,   pNib, 1,    lNib);
        studs ( cNib,   -rNib,   pNib, 1,    lNib);
    }
    if(lengthB > 8) {
        studs (-cNib,   -rNib-1, pNib, wNib, 1);
        studs (-cNib,    rNib,   pNib, wNib, 1);
    }
    if(widthB > 12) {
        studs (-cNib-2, -rNib+1, pNib, 1,    lNib-2);
        studs ( cNib+1, -rNib+1, pNib, 1,    lNib-2);
    }
    if(lengthB > 12) {
        studs (-cNib+1, -rNib-2, pNib, wNib-2, 1);
        studs (-cNib+1,  rNib+1, pNib, wNib-2, 1);
    }
}

module corner_studs_over_round_wall(widthB, lengthB, heightB,
                        colB, rowB)
{
                            
    // Corner studs
    pNib = heightB;
    wNib = widthB/2;
    lNib = lengthB/2;
    cNib = colB/2;
    rNib = rowB/2;
    
    // bl
    studs (-wNib, -lNib, pNib, 1, 1);
    //br
    studs (wNib-1, -lNib, pNib, 1, 1);
    //fr
    studs (wNib-1, lNib-1, pNib, 1, 1);
    //fl
    studs (-wNib, lNib-1, pNib, 1, 1);
    if(widthB > 8 && lengthB > 8) {
        // bl
        studs (-wNib, -lNib+1, pNib, 1, 2);
        studs (-wNib+1, -lNib, pNib, 2, 1);
        // br
        studs (wNib-1, -lNib+1, pNib, 1, 2);
        studs (wNib-3, -lNib, pNib, 2, 1);
        // fr
        studs (wNib-1, lNib-3, pNib, 1, 2);
        studs (wNib-3, lNib-1, pNib, 2, 1);
        // fl
        studs (-wNib, lNib-3, pNib, 1, 2);
        studs (-wNib+1, lNib-1, pNib, 2, 1);
    }
    if(widthB > 12 && lengthB > 12) {
        // bl
        studs (-wNib, -lNib+3, pNib, 1, 1);
        studs (-wNib+3, -lNib, pNib, 1, 1);
        studs (-wNib+1, -lNib+1, pNib, 1, 1);
        // br
        studs (wNib-1, -lNib+3, pNib, 1, 1);
        studs (wNib-4, -lNib, pNib, 1, 1);
        studs (wNib-2, -lNib+1, pNib, 1, 1);
        // fr
        studs (wNib-1, lNib-4, pNib, 1, 1);
        studs (wNib-4, lNib-1, pNib, 1, 1);
        studs (wNib-2, lNib-2, pNib, 1, 1);
        // fl
        studs (-wNib, lNib-4, pNib, 1, 1);
        studs (-wNib+3, lNib-1, pNib, 1, 1);
        studs (-wNib+1, lNib-2, pNib, 1, 1);
    }
                           
}

module studs_on_battlement(height, widthB, lengthB)
{
    hNB = height;
    if(widthB > 12 && lengthB > 12) {
        cLNB = -5.75;//-ceTow/2-2;//-5;//
        cRNB = 4.80;//ceTow/2+0;//2;//
        rFNB = 4.80;//reTow/2+0;//2;//
        rBNB = -5.75;//-reTow/2-2;//-3;//
        
        
        four_square_studs(cLNB,cRNB,rFNB,rBNB,hNB);
    }
    else if(widthB > 8 && lengthB > 8) {
        cLNB = -4.35;
        cRNB = 3.4;
        rFNB = 3.4;
        rBNB = -4.35;
        
        four_square_studs(cLNB,cRNB,rFNB,rBNB,hNB);
    }
    else {
        cLNB = -2.95;
        cRNB = 1.95;
        rFNB = 1.95;
        rBNB = -2.95;
        
        four_square_studs(cLNB,cRNB,rFNB,rBNB,hNB);
    }
}

module four_square_studs (cLNB,cRNB,rFNB,rBNB,hNB)
{
        studs (cLNB, rFNB, hNB, 1, 1);
        studs (cLNB, rBNB, hNB, 1, 1);
        studs (cRNB, rFNB, hNB, 1, 1);
        studs (cRNB, rBNB, hNB, 1, 1);
}

module studs (col, row, up, width, length)
/* Use cases:
- needed by the doblo and the block modules
- can also be stuck on top on parts of a nibble-less doblo or block
*/
{
    // Uses a local coordinate system left/back = 0,0
    // E.g. studs (-2,    -2,      0,    4,       4      );
    // echo ("PART_WIDTH", PART_WIDTH, "NO", NO);
    x_start =           col    * PART_WIDTH +  NO ;
    // echo ("x_start", x_start, "col", col);
    y_start =  - (  row * PART_WIDTH + NO);
    // echo ("y_start", y_start, "row", row);
    z_local = up * PART_HEIGHT + NH / 2;
    translate ([x_start , y_start, z_local]) {
	// 0,0 is left/back corner. Draw to the right (x) and forward (-y)
	for(j=[1:length])
	    {
		for (i = [1:width])
		    {
			translate([(i-1) * PART_WIDTH, -(1) * (j-1) * PART_WIDTH, 0]) doblonibble();
		    }
	    }
    }
}



// ******* Cylinder block & Block *******

module cyl_block (col, row, up, bottom_r, top_r, height, studs_on_off) 
{
    bottom_r_mm = bottom_r * NO;
    top_r_mm    = top_r * NO;
    x_0         = col    * PART_WIDTH   + bottom_r_mm;
    y_0         = - (row * PART_WIDTH   + bottom_r_mm);
    z_0         = up     * PART_HEIGHT;
	
    // the cylinder is drawn at absolute x,y,z = 0 then moved
    translate ([x_0, y_0, z_0]) {
	cylinder(h= height*PART_HEIGHT, r1 = bottom_r_mm, r2 = top_r_mm, center = false, $fs = 0.2);
	if  (studs_on_off)
	    {
		//      (col, row,  up,  width, length)
		// circle is a bit different from cube
		studs (-top_r/2+0.5, -top_r/2+0.5, height, top_r-1, top_r-1);
	    }
    }
}

module block (col, row, up, width,length,height,studs_on_off) 
/* Use cases:
- building blocks for 3D structures (saves times and plastic, use a light fill in skeinforge)
- movable blocks for games (printed apart)
*/
{
    // build the cube from its center
    x_0 = col    * PART_WIDTH  + width  * PART_WIDTH / 2.0;
    y_0 = - (row * PART_WIDTH + length * PART_WIDTH / 2.0) ;
    z_0 = up      * PART_HEIGHT  + height * PART_HEIGHT / 2.0;
    
    // the cube is drawn at absolute x,y,z = 0 then moved
    translate ([x_0, y_0, z_0]) {
	//the cube
	cube([width*PART_WIDTH, length*PART_WIDTH, height*PART_HEIGHT], true);
	// studs on top
	if  (studs_on_off)
	    {
		//      (col, row, up, width, length)
		studs (-width/2, -length/2, height/2, width, length);
	    }
    }
}



//  ******* Auxiliary modules *******

module doblonibble() {
    // Lego size does not have holes in the studs
    if (SCALE < 0.6) {
	cylinder(r=NB_RADIUS,           h=NH,  center=true,  $fs = 0.2);
    } else {
	difference() {
	    cylinder(r=NB_RADIUS,       h=NH,  center=true,  $fs = 0.2);
	    cylinder(r=NB_RADIUS_INSIDE,h=NH+1,center=true,  $fs = 0.2);
	}
    }
}

