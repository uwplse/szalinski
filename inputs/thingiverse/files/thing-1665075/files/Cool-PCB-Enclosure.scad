//---------------------------------------------------------------
//-- Openscad Cool PCB enclosure (http://www.thingiverse.com/thing:1665075)
//-- This is a simple fan cooled box, reusing ideas and code from the following excellent projects:
//--   + "The Ultimate box maker" (http://www.thingiverse.com/thing:12Resolution391)
//--   + "Customizable Fan Grille" (http://www.thingiverse.com/thing:52305).
//--   + "Radiator difussers" (http://www.thingiverse.com/thing:Resolution07)
//-- IMPORTANT NOTES:
//--   + The coordinate system is mostly center based in order to simplify the integration between different projects involved.
//--   + Fan grille's logos cannot be used through the Customizer App. In order to use Fan grille's logos, you must download both source code files and use Openscad instead.
//-- Please, refer to original projects for additional documentation and samples.
//-- Version: 1.0
//-- Aug-2016
//---------------------------------------------------------------
//-- Released under the GPL3 license
//---------------------------------------------------------------



//---------------------------------------------------------------
//-- CUSTOMIZER PARAMETERS
//---------------------------------------------------------------

/* [ACTIVE_PARTS] */
// - Coque
Shield_Active = 1;// [0:No, 1:Yes]
// - Coque type
Shield_Type = 0;//[0:Bottom, 1:Top]
// - Coque split
Shield_Split = 0;// [0:No, 1:Yes]
// - Coque part
Shield_Split_Part = 0;// [0:Rear, 1:Front]
// - Panel
Panel_Active = 0;// [0:No, 1:Yes]
// - Panel Type 
Panel_Type = 1;// [0:Rear, 1:Front]
// - Lateral screws
Lateral_Screws_Active = 1;// [0:No, 1:Yes]
// - Decorations to ventilation holes
Ventilation_Active = 0;// [0:No, 1:Yes]
// - Reinforcements of corners
Corner_reinforcements_Active = 1;// [0:No, 1:Yes]
// - Honeycomb mesh
Honeycomb_Active = 1;// [0:No, 1:Yes]



/* [VISIBILITY] */
// - InternalBox Visibility
InternalBox_Visible = 1;// [0:No, 1:Yes]
// - CounterShield Visibility
CounterShield_Visible = 0;// [0:No, 1:Yes]
// - Panel Visibility
Panel_Visible = 0;// [0:No, 1:Yes]


/* [EXTERNAL_BOX_DIMENSIONS] */
// - Longueur - Length  
Box_Length = 135;       
// - Largeur - Width
Box_Width = 85;                     
// - Hauteur - Height  
Box_Height = 26;  


/* [INTERNAL_BOX_PARAMETERS] */
// - Epaisseur - Shield thickness  
Shield_thickness = 2;  
// - Epaisseur anche - Reed thickness  
reed_thickness = 2; // It should be equal to honeycomb_height
// - 
honeycomb_height = 2; // It should be equal to reed_thickness
// - Epaisseur rail - Rail thickness  
rail_thickness = 4; 
// - Hauteur rail - Rail height 
rail_height = 3;
// - 
reed_hexagon_diameter = 10;
// - 
honeycomb_hexagon_thickness = 2;
// - Number of lateral screws
n_screws = 4;
// -
lateral_screw_diameter = 1.3;
// - Displacement of hexagonal mesh in vertical walls in case antireed leaves the area too unmeshed. (rhd+hht)/2 = (reed_hexagon_diameter + honeycomb_hexagon_thickness)/2
// - Hexagonal mesh displacement range: [ -(rhd+hht)/2, (rhd+hht)/2] 
deltaH = 6; 

  
/* [EXTERNAL_BOX_PARAMETERS) ] */
// - Diamètre flocon - Flake diameter
flake_dia = 10;
// - Epaisseur flocon - Flake thickness
flake_thick = 1;
// - Flake height
flake_height = Shield_thickness + honeycomb_height;
// - M3 nut's diameter (accross corners)
M3_dia = 6.1; // M3 standard = 6.01
// - M3 nut's diameter (accross corners)
M3_washer_dia = 9.1; // DIN-9021 = 9.01
// - Decoration-Holes width (in mm)
Vent_width = 1;//Obsolete

// - Diamètre coin arrondi - Fillet diameter  
Fillet = 6;//[0.1:16] 
// - lissage de l'arrondi - Fillet smoothness  
Resolution = 128;//[1:256] 


/* [BOTTOM_SHIELD_ITEMS] */
// - Bottom Fan Grill
BFan_Grill_item = 0;// [0:No, 1:Yes]
// - Bottom PCB1
BPCB1_item = 0;// [0:No, 1:Yes]
// - Bottom PCB2
BPCB2_item = 0;// [0:No, 1:Yes]
// - Bottom PCB3
BPCB3_item = 0;// [0:No, 1:Yes]
// - Bottom PCB4
BPCB4_item = 0;// [0:No, 1:Yes]
// - Power Supply
PS_item = 0;// [0:No, 1:Yes]
// - Pillar #1
Pillar1_item = 0;// [0:No, 1:Yes]
// - Pillar #2
Pillar2_item = 0;// [0:No, 1:Yes]
// - Pillar #3
Pillar3_item = 0;// [0:No, 1:Yes]
// - Pillar #4
Pillar4_item = 0;// [0:No, 1:Yes]
// - Pillar #5
Pillar5_item = 0;// [0:No, 1:Yes]
// - Pillar #6
Pillar6_item = 0;// [0:No, 1:Yes]

  
/* [TOP_SHIELD_ITEMS] */
// - Top Fan Grill
TFan_Grill_item = 0;// [0:No, 1:Yes]
// - Top PCB1
TPCB1_item = 0;// [0:No, 1:Yes]
// - Top PCB2
TPCB2_item = 0;// [0:No, 1:Yes]
// - Top PCB3
TPCB3_item = 0;// [0:No, 1:Yes]
// - Top PCB4
TPCB4_item = 0;// [0:No, 1:Yes]



/* [REAR_PANEL_ITEMS] */
// - Rear Fan Grill
RFan_Grill_item = 0;// [0:No, 1:Yes]
// - Rear Hexagonal_grid_item
RHexagonal_grid_item = 0;// [0:No, 1:Yes]
// - 
rear_hexagon_diameter = 5;
// -
rear_hexagon_thickness = 2;
// - Tolérance - Tolerance (Panel/rails gap)
fitting_factor = 0.99;
// -
panel_thickness = 4.5;
// - Rear Fuse item
RFuse_item = 0;// [0:No, 1:Yes]
// - Rear Plug_item
RPlug_item = 0;// [0:No, 1:Yes]
// - Rear Switch_item
RSwitch_item = 0;// [0:No, 1:Yes]
// - Rear USB_item
RUSB_item = 0;// [0:No, 1:Yes]


/* [FRONT_PANEL_ITEMS] */
// - Panneau avant - Front panel
// - Text you want
txt = "Cool Box";           
// - Font size  
TxtSize = 3;                 
// - Font  
Police ="Arial Black"; 
// - Texte façade - Front text
Main_Text_Panel = 0;// [0:No, 1:Yes]



/* [COMMON_FEET_PARAMETERS) ] */
//All dimensions are from the center foot axis

// - Heuteur pied - Feet height
PCBFootHeight = 15;
// - Diamètre pied - Foot diameter
PCBFootDia = 10;
// - Diamètre trou - Hole diameter
PCBFootHole = 3.5;  

// - Power Supply Heuteur pied - Power Supply Feet height
PSF_Height = 25;
// - Power Supply Feet external diameter
PSF_ext_dia = 15;
// - Power Supply Feet internal diameter
PSF_int_dia = 3.5; // 6-32 UNC
// - Power Supply Feet base hole diameter
PSF_bh_dia = 7.5;
// - Power Supply Feet Fillet
PSF_Fillet = 12;
// - Power Supply Feet base hole height
PSF_bh_height = PSF_Height - 4;


// - Pillar height
Pillar_Height = Box_Height/2 - Shield_thickness;
// - Pillar external diameter
Pillar_ext_dia = 20;
// - Pillar internal diameter
Pillar_int_dia = 3.05; // M3
// - Pillar base hole diameter
Pillar_bh_dia = M3_washer_dia; // M3 standard = 6.01
// - Pillar top thickness
Pillar_top_thick = 7;
// - Pillar Fillet
Pillar_Fillet = 12;
// - Pillar base hole height
Pillar_bh_height = Pillar_Height - Pillar_top_thick;


/* [POWER_SUPPLY_FEET_PARAMETERS) ] */
// - PS Center X position
PS_PosX = 0;
// - PS Center Y Position
PS_PosY = 0;
// - Longueur PS - PS Length
PS_Length = 0;
// - Largeur PS - PS Width
PS_Width = 0;
// - Longueur PS Boite - PS Box Length
PS_box_length = 0;
// - Largeur PS Boite - PS Box Width
PS_box_width = 0;
// - Heuteur PS Boite - PS Box height
PS_box_height = 0;


/* [PCB1_FEET_PARAMETERS) ] */
// - PCB Center X Position
PCB1_PosX = 0;
// - PCB Center Y Position
PCB1_PosY = 0;
// - Longueur PCB - PCB Length
PCB1_Length = 0;
// - Largeur PCB - PCB Width
PCB1_Width = 0;
// - Heuteur PCB - PCB height
PCB1_Height = 0;


/* [PCB2_FEET_PARAMETERS) ] */
// - PCB Center X Position
PCB2_PosX = 0;
// - PCB Center Y Position
PCB2_PosY = 0;
// - Longueur PCB - PCB Length
PCB2_Length = 0;
// - Largeur PCB - PCB Width
PCB2_Width = 0;
// - Heuteur PCB - PCB height
PCB2_Height = 0;


/* [PCB3_FEET_PARAMETERS) ] */
// - PCB Center X Position
PCB3_PosX = 0;
// - PCB Center Y Position
PCB3_PosY = 0;
// - Longueur PCB - PCB Length
PCB3_Length = 0;
// - Largeur PCB - PCB Width
PCB3_Width = 0;
// - Heuteur PCB - PCB height
PCB3_Height = 0;


/* [PCB4_FEET_PARAMETERS) ] */
// - PCB Center X Position
PCB4_PosX = 0;
// - PCB Center Y Position
PCB4_PosY = 0;
// - Longueur PCB - PCB Length
PCB4_Length = 0;
// - Largeur PCB - PCB Width
PCB4_Width = 0;
// - Heuteur PCB - PCB height
PCB4_Height = 0;


/* [PILLAR_PARAMETERS) ] */
// - Center X Position
BPillar1_PosX = 0;
// - Center Y Position
BPillar1_PosY = 0;
// - Center X Position
BPillar2_PosX = 0;
// - Center Y Position
BPillar2_PosY = 0;
// - Center X Position
BPillar3_PosX = 0;
// - Center Y Position
BPillar3_PosY = 0;
// - Center X Position
BPillar4_PosX = 0;
// - Center Y Position
BPillar4_PosY = 0;
// - Center X Position
BPillar5_PosX = 0;
// - Center Y Position
BPillar5_PosY = 0;
// - Center X Position
BPillar6_PosX = 0;
// - Center Y Position
BPillar6_PosY = 0;

// - Center X Position
TPillar1_PosX = - BPillar1_PosX;
// - Center Y Position
TPillar1_PosY = BPillar1_PosY;
// - Center X Position
TPillar2_PosX = - BPillar2_PosX;
// - Center Y Position
TPillar2_PosY = BPillar2_PosY;
// - Center X Position
TPillar3_PosX = - BPillar3_PosX;
// - Center Y Position
TPillar3_PosY = BPillar3_PosY;
// - Center X Position
TPillar4_PosX = - BPillar4_PosX;
// - Center Y Position
TPillar4_PosY = BPillar4_PosY;
// - Center X Position
TPillar5_PosX = - BPillar5_PosX;
// - Center Y Position
TPillar5_PosY = BPillar5_PosY;
// - Center X Position
TPillar6_PosX = - BPillar6_PosX;
// - Center Y Position
TPillar6_PosY = BPillar6_PosY;


//FAN GRILLE PARAMETERS

/* [FAN_GRILL_PARAMETERS) ] */
//All dimensions are from the center foot axis
// - Center X position
FanPosX = -45;
// - Center Y position
FanPosY = 0;
// - Longueur Fan - Fan Length
FanLength = 71.5;
// - Largeur Fan - Fan Width
FanWidth = 71.5;
// - Heuteur Fan - Fan height
FanHeight = 26;
// - Heuteur pied - Feet height
FanFootHeight = 15;
// - Diamètre pied - Foot diameter
FanFootDia = 8;
// - Diamètre trou - Hole diameter
FanFootHole = 3;  
// - Diamètre Fan - Fan diameter
FanDia = 80;  


// - Size of the inner icon or text
innerIconDiameter = 45;	// [0:50]
// - Diameter of the circle
inner_circle_diameter =30;
// - Thickness of the Inner Vanes which should be less than outside frame thickness
innerThickness = (FanFootHeight+Shield_thickness)*3/4;	
// - How much thicker or thinner would you like the inner Logo to Be than the Innver Vane Thickness?
logoThickness = 1;
// - 	
innerLogoThickness = logoThickness + innerThickness;

// - Number of Vanes
vaneCount = 12; // [1:45]	
// - Width of Vanes
vaneWidth = 1; // [1:45]
// - Number of Rings
numberOfRings = 6; // [0:45]
// - Ring Width
ringWidth = 1; // [1:45]

// - some calculated values
vane_angle = 360 / vaneCount;
// - ring_spacing defines the CENTER of each ring (radius)
ring_spacing = (FanDia - inner_circle_diameter + ringWidth) / (numberOfRings + 1)/2;
// - ring_spacing = FanDia;


//HEXAGONAL GRID PARAMETERS

/*[HEXAGONAL GRID]*/
// - 
area_width = 80;
// - 
area_length = 80;
// - 
hexagon_radius = 5;  
// - 
hexagon_thickness = Shield_thickness;  
// - 
hexagon_extra_distance = 0;


/* [HIDDEN] */

    
cos60 = cos(60);
sin60 = sin(60);

echo("** panel_thickness = ", panel_thickness);


if (Shield_Active == 1) {
  if  (Shield_Type == 0) {
    echo("Bottom_Shield_Active");
  }
}
if (Shield_Active == 1) {
  if  (Shield_Type == 1) {
    echo("Top_Shield_Active");
  }
}

if (Panel_Active == 1) {
  if  (Panel_Type == 0) {
    echo("Rear_Panel_Active");
  }
  if  (Panel_Type == 1) {
    echo("Front_Panel_Active");
  }
}



// - Couleur coque - Shell color  
Couleur1 = "Orange";       
// - Couleur panneaux - Panels color    
Couleur2 = "Red";    
// Thick X 2 - making decorations thicker if it is a vent to make sure they go through shell
Dec_Thick = Ventilation_Active ? Shield_thickness*4 : Shield_thickness;//Obsolete
// - Depth decoration
Dec_size = Ventilation_Active ? Shield_thickness*2 : 0.8;//Obsolete


include <fan_grille_logos.scad>;
innerIconLogo = 40;


//It may be necessary to rotate the logo to make sure the vines go through any unconnected pieces of Logo
rotateLogo = 0; // [ -180:179]

// If Text for Logo Put Here
logoText = "Fused3D";
//						Size Ratio Slider
fontScaleRatio = 100; // [1:100]
    fontScale = fontScaleRatio/1.90;

//	Distance between Characters, Value of 25 or Less needed to make Without Line Through Text
characterSpacing = 25; // [1:50]


// Position the text on the X and Y 
textXPosition = 0; // [ -50:50]
textYPosition = 0; // [ -50:50]
everyOtherCharacterIsThicker = 1; // [0:10]

FanL = FanLength;
FanW = FanWidth;
FanH = FanHeight;



//---------------------------------------------------------------
//-- RENDERS
//---------------------------------------------------------------

// PANELS VISIBILITY
  if  (Panel_Type == 1) 
    front_panel();
  else
    rear_panel();

// SHIELDS VISIBILITY
if (Shield_Active == 1) {
  if  (Shield_Type == 0) {
    if (InternalBox_Visible == 1) 
      bottom_shield(active = 1, visible = 1);
    else
      bottom_shield(active = 1, visible = 0);
    
    if (CounterShield_Visible == 1) 
      %top_shield(active = 1, visible = 0);
  }
  else {
    if (InternalBox_Visible == 1) 
      top_shield(active = 1, visible = 1);
    else
      //rotate([180, 0, 0])
      top_shield(active = 1, visible = 0);       
    
    if (CounterShield_Visible == 1) 
      %bottom_shield(active = 1, visible = 0);
  }
  
      
//  bottom_shield(active = 1, visible = 1);
//  top_shield(active = 1, visible = 1);  // Comment out to fit both shields
}

//---------------------------------------------------------------
//-- MODULES
//---------------------------------------------------------------

module panel_rails() {
echo("START RAILS ..."); 
  difference() {
    union() {
      //external rail
      difference() {
        external_box1 = [Box_Length, Box_Width, Box_Height];
        internal_box1 = [Box_Length - 2*rail_thickness, Box_Width + 0.001, Box_Height + 0.001];

        rounded_polig4(external_box1, radius = Fillet);
        rounded_polig4(internal_box1, radius = Fillet);
      } //di (external rail)

      //internal rail
      difference() {        
        external_box2 = [Box_Length - 2*rail_thickness - 2*panel_thickness/fitting_factor, Box_Width - 2*Shield_thickness, Box_Height - 2*Shield_thickness];
        internal_box2 = [Box_Length - 4*rail_thickness - 2*panel_thickness/fitting_factor, Box_Width - 2*Shield_thickness + 0.001, Box_Height - 2*Shield_thickness + 0.001];

        rounded_polig4(external_box2, radius = Fillet);
        rounded_polig4(internal_box2, radius = Fillet);
      } //di (internal rail)     
      
    } //un
    internal_box3 = [Box_Length + 1, Box_Width - 2*Shield_thickness - 2*rail_height, Box_Height - 2*Shield_thickness - 2*rail_height];
    rounded_polig4(internal_box3, radius = Fillet/2);
  } //di        
echo("--> END RAILS");
} //mo


module shield() {
  union() {
    external_box1 = [Box_Length, Box_Width, Box_Height];
    internal_box1 = [Box_Length + 1, Box_Width - 2*Shield_thickness, Box_Height - 2*Shield_thickness];
    difference() {
      rounded_polig4(external_box1, radius = Fillet);
      rounded_polig4(internal_box1, radius = Fillet);
      screw_holes();
      antipegs();
      if (Ventilation_Active) flake_holes();
    } //di
    if (Ventilation_Active) flakes();  
    panel_rails();
  } //un  
  if (Corner_reinforcements_Active) {
    af = cos(360/16); //apotheme factor
    external_XPos = Box_Width - 2*Fillet;
    external_YPos = Box_Height - 2*Fillet;
    external_Pos = square_vertices(external_XPos, external_YPos);

    internal_XPos = Box_Width - 2*Fillet * af - 2*honeycomb_height - 2*Shield_thickness;
    internal_YPos = Box_Height - 2*Fillet * af - 2*honeycomb_height - 2*Shield_thickness;
    internal_Pos = square_vertices(internal_XPos, internal_YPos);
  
    difference() {  
      for (i = [0 : 3] ) {
        translate([external_Pos[i][0], 0, external_Pos[i][1]]) 
          rotate([90, 360/16, 0])
            cylinder(r = Fillet, h = Box_Length  - 4*rail_thickness - 2*panel_thickness/fitting_factor, center = true, $fn = 8);
      } //fo
      for (i = [0 : 3] ) {
        translate([internal_Pos[i][0], 0, internal_Pos[i][1]]) 
          rotate([90, 360/16, 0])
            cylinder(r = Fillet, h = Box_Length + 1, center = true, $fn = 8);
      } //fo
    } //di
  }
} //mo


module hex_mesh() {
echo("START HEX MESH ...");
  rhd = reed_hexagon_diameter;
  hht = honeycomb_hexagon_thickness;
  hh = honeycomb_height;
  rt = rail_thickness;
  pt = panel_thickness;
  ff = fitting_factor;
  secant = (Fillet - Shield_thickness > 0) ? (Fillet - Shield_thickness) * cos(45) : 0 ;

  internal_XPos = Box_Width - 2*Fillet - 2*honeycomb_height - 2*Shield_thickness;
//    h_area = [Box_Width - 2*Shield_thickness, Box_Length - 4*rt - 2*pt, hh];
    h_area = [Box_Width - 2*secant - 2*honeycomb_height - 2*Shield_thickness, Box_Length - 4*rt - 2*pt/ff, hh];
    echo(h_area);
  translate([0, 0, - Box_Height/2 + Shield_thickness + hh/2]) 
    hexagonal_grid(box = h_area, hexagon_diameter = (rhd - hht)/sin60, hexagon_thickness = hht);  

    v_area1 = [2*deltaH + Box_Height - 2*secant - 2*honeycomb_height - 2*Shield_thickness, Box_Length - 4*rt - 2*pt/ff, hh];
//    echo(v_area1);
  translate([ - Box_Width/2 + Shield_thickness + hh/2, 0, deltaH]) rotate([0, 90, 0]) 
    hexagonal_grid(box = v_area1, hexagon_diameter = 2/sqrt(3)*rhd - hht, hexagon_thickness = hht);

    v_area2 = [2*deltaH + Box_Height - 2*0*Fillet - 2*honeycomb_height - 2*Shield_thickness, Box_Length - 4*rt - 2*pt/ff, hh];
  translate([Box_Width/2 - Shield_thickness - hh/2, 0,  deltaH]) rotate([0, 90, 0]) 
    hexagonal_grid(box = v_area2, hexagon_diameter = 2/sqrt(3)*rhd - hht, hexagon_thickness = hht);
  echo("--> END HEX MESH");
} //mo            


module reeds() {
echo("START REEDS ..."); 
  // Reeds
  reed_length = Box_Length - 2*panel_thickness/fitting_factor - 4*rail_thickness;
  modulo = reed_length % reed_hexagon_diameter;
  total_num = floor(reed_length/reed_hexagon_diameter);
  half_num = floor(total_num/2);
  half_screws = floor(n_screws/2);
  step = floor(half_num/half_screws);
  difference() {        // Fixation box legs
    union() {
      for (i = [1 : total_num]) {
        //color("red") 
        translate([(- Box_Width)/2 + Shield_thickness + reed_thickness/2, (reed_length - modulo - reed_hexagon_diameter)/2 - (i - 1) * reed_hexagon_diameter , 0])
          rotate([90, 0, 90])
              cylinder(d = reed_hexagon_diameter + 0.001, h = reed_thickness, center = true, $fn=6);
      } //fo
    } //un
    // Lateral screws
    if (Lateral_Screws_Active) {
    starting_point = (total_num % 2 == 0) ? (n_screws % 2 == 0 ? -reed_hexagon_diameter/2 : -reed_hexagon_diameter/2) : 0; 
    nl_screws = (total_num % 2 == 0) ? (n_screws % 2 == 0 ? n_screws : n_screws - 1) : n_screws;
    color("red") 
      union() {
        for (j = [step : step : half_num - step]) {
              translate([ - Box_Width/2 + Shield_thickness + reed_thickness/2, j * reed_hexagon_diameter + starting_point, reed_hexagon_diameter * sin60/4])
               rotate([90, 0, 90])
                 cylinder(d = lateral_screw_diameter, h = 2*Shield_thickness, center = true, $fn=Resolution); 
              translate([ - Box_Width/2 + Shield_thickness + reed_thickness/2, - j * reed_hexagon_diameter - starting_point, reed_hexagon_diameter * sin60/4])
               rotate([90, 0, 90])
                 cylinder(d = lateral_screw_diameter, h = 2*Shield_thickness, center = true, $fn=Resolution); 
        } //fo
      // center one
      if (nl_screws % 2 != 0)  {
        translate([ - Box_Width/2 + Shield_thickness + reed_thickness/2, 0, reed_hexagon_diameter*sin60/4])
               rotate([90, 0, 90])
                 cylinder(d = lateral_screw_diameter, h = 2*Shield_thickness, center = true, $fn=Resolution); 
        echo("IMPAR", step);
  }
      // first one
      translate([ - Box_Width/2 + Shield_thickness + reed_thickness/2, (reed_length - modulo - reed_hexagon_diameter)/2, reed_hexagon_diameter*sin60/4])
               rotate([90, 0, 90])
                 cylinder(d = lateral_screw_diameter, h = 2*Shield_thickness, center = true, $fn=Resolution);         
      // last one
      translate([ - Box_Width/2 + Shield_thickness + reed_thickness/2, (reed_length - modulo - reed_hexagon_diameter)/2 - (total_num - 1) * reed_hexagon_diameter, reed_hexagon_diameter*sin60/4])
               rotate([90, 0, 90])
                 cylinder(d = lateral_screw_diameter, h = 2*Shield_thickness, center = true, $fn=Resolution);         
      } //un
   }
      // bevel
    angle = atan(2*reed_thickness / reed_hexagon_diameter);
    translate([ - Box_Width/2 + Shield_thickness + reed_thickness/2, 0, - reed_hexagon_diameter/2])
      //color("blue")
      rotate([0, angle, 0]) 
        cube([reed_thickness, (reed_length - modulo), reed_hexagon_diameter], center = true);
  } //di (Fixation box legs)
echo("--> END REEDS"); 
} //mo


module antireeds() {
echo("START ANTI-REEDS ..."); 
  // Reeds
  reed_length = Box_Length - 2*panel_thickness/fitting_factor - 4*rail_thickness;
  modulo = reed_length % reed_hexagon_diameter;
  total_num = floor(reed_length/reed_hexagon_diameter);
  half_num = floor(total_num/2);
  half_screws = floor(n_screws/2);
  step = floor(half_num/half_screws);
  difference() {        // Fixation box legs
    union() {
      for (i = [1 : total_num]) {
        //color("red") 
        translate([(Box_Width)/2 - Shield_thickness - reed_thickness/2 - rail_height/2, (reed_length - modulo - reed_hexagon_diameter)/2 - (i - 1) * reed_hexagon_diameter , 0])
          rotate([90, 0, 90])
              cylinder(d = reed_hexagon_diameter + 0.001, h = reed_thickness + rail_height, center = true, $fn=6);
      } //fo
    } //un
  } //di (Fixation box legs)
echo("--> END ANTI-REEDS"); 
} //mo


module pegs() {
  reed_length = Box_Length - 2*panel_thickness/fitting_factor - 4*rail_thickness;
  modulo = reed_length % reed_hexagon_diameter;
  total_num = floor(reed_length/reed_hexagon_diameter);
  half_num = floor(total_num/2);
  half_screws = floor(n_screws/2);
  step = floor(half_num/half_screws);
echo("START PEGS ..."); 
// Edge's pegs
  starting_point = (total_num % 2 == 0) ? (n_screws % 2 == 0 ? -reed_hexagon_diameter/2 : -reed_hexagon_diameter/2) : 0; 
  nl_screws = (total_num % 2 == 0) ? (n_screws % 2 == 0 ? n_screws : n_screws - 1) : n_screws;
    color("blue") 
      union() {
        for (j = [step : step : half_num - step]) {
        translate([(Box_Width/2 - Shield_thickness/2), j * reed_hexagon_diameter + starting_point, 0])
          sphere (r = Shield_thickness/4, center = true, $fn=Resolution); 
        translate([(Box_Width/2 - Shield_thickness/2), - j * reed_hexagon_diameter - starting_point, 0])
          sphere (r = Shield_thickness/4, center = true, $fn=Resolution); 
        } //fo
      // center one
      if (nl_screws % 2 != 0)  
        translate([(Box_Width/2 - Shield_thickness/2), 0, 0])
        sphere (r = Shield_thickness/4, center = true, $fn=Resolution); 
      // first one
        translate([(Box_Width/2 - Shield_thickness/2), (reed_length - modulo - reed_hexagon_diameter)/2, 0])
        sphere (r = Shield_thickness/4, center = true, $fn=Resolution); 
      // last one
        translate([(Box_Width/2 - Shield_thickness/2), (reed_length - modulo - reed_hexagon_diameter)/2 - (total_num - 1) * reed_hexagon_diameter, 0])
        sphere (r = Shield_thickness/4, center = true, $fn=Resolution); 
    } //un
echo("--> END PEGS"); 
} //mo


//module antipegs(total_num, reed_hexagon_diameter, modulo) {
module antipegs() {
  reed_length = Box_Length - 2*panel_thickness/fitting_factor - 4*rail_thickness;
  modulo = reed_length % reed_hexagon_diameter;
  total_num = floor(reed_length/reed_hexagon_diameter);
  half_num = floor(total_num/2);
  half_screws = floor(n_screws/2);
  step = floor(half_num/half_screws);
echo("START ANTI-PEGS ..."); 
// Edge's anti-pegs
  starting_point = (total_num % 2 == 0) ? (n_screws % 2 == 0 ? -reed_hexagon_diameter/2 : -reed_hexagon_diameter/2) : 0; 
  nl_screws = (total_num % 2 == 0) ? (n_screws % 2 == 0 ? n_screws : n_screws - 1) : n_screws;
    color("blue") 
      union() {
        for (j = [step : step : half_num - step]) {
        translate([ -(Box_Width/2 - Shield_thickness/2), j * reed_hexagon_diameter + starting_point, 0])
          cylinder(d = Shield_thickness/2, h = 2 * Shield_thickness, center = true, $fn=Resolution); 
        translate([ -(Box_Width/2 - Shield_thickness/2), - j * reed_hexagon_diameter - starting_point, 0])
          cylinder(d = Shield_thickness/2, h = 2 * Shield_thickness, center = true, $fn=Resolution); 
        } //fo
      // center one
      if (nl_screws % 2 != 0)  
        translate([ -(Box_Width/2 - Shield_thickness/2), 0, 0])
          cylinder(d = Shield_thickness/2, h = 2 * Shield_thickness, center = true, $fn=Resolution); 
      // first one
        translate([ -(Box_Width/2 - Shield_thickness/2), (reed_length - modulo - reed_hexagon_diameter)/2, 0])
          cylinder(d = Shield_thickness/2, h = 2 * Shield_thickness, center = true, $fn=Resolution); 
      // last one
        translate([ -(Box_Width/2 - Shield_thickness/2), (reed_length - modulo - reed_hexagon_diameter)/2 - (total_num - 1) * reed_hexagon_diameter, 0])
          cylinder(d = Shield_thickness/2, h = 2 * Shield_thickness, center = true, $fn=Resolution); 
    } //un
echo("--> END ANTI-PEGS"); 
} //mo


module screw_holes() {
  // Lateral screws
  reed_length = Box_Length - 2*panel_thickness/fitting_factor - 4*rail_thickness;
  modulo = reed_length % reed_hexagon_diameter;
  total_num = floor(reed_length/reed_hexagon_diameter);
  half_num = floor(total_num/2);
  half_screws = floor(n_screws/2);
  step = floor(half_num/half_screws);
  if (Lateral_Screws_Active) {
    starting_point = (total_num % 2 == 0) ? (n_screws % 2 == 0 ? -reed_hexagon_diameter/2 : -reed_hexagon_diameter/2) : 0; 
    nl_screws = (total_num % 2 == 0) ? (n_screws % 2 == 0 ? n_screws : n_screws - 1) : n_screws;
    color("red") 
      union() {
        for (j = [step : step : half_num - step]) {
              translate([Box_Width/2 - Shield_thickness/2, j * reed_hexagon_diameter + starting_point, - reed_hexagon_diameter * sin60/4])
               rotate([90, 0, 90])
                 cylinder(d = lateral_screw_diameter, h = 2*Shield_thickness, center = true, $fn=Resolution); 
              translate([Box_Width/2 - Shield_thickness/2, - j * reed_hexagon_diameter - starting_point, - reed_hexagon_diameter * sin60/4])
               rotate([90, 0, 90])
                 cylinder(d = lateral_screw_diameter, h = 2*Shield_thickness, center = true, $fn=Resolution); 
        } //fo
      // center one
      if (nl_screws % 2 != 0)  
        translate([Box_Width/2 - Shield_thickness/2, 0, -reed_hexagon_diameter*sin60/4])
               rotate([90, 0, 90])
                 cylinder(d = lateral_screw_diameter, h = 2*Shield_thickness, center = true, $fn=Resolution); 
      // first one
      translate([Box_Width/2 - Shield_thickness/2, (reed_length - modulo - reed_hexagon_diameter)/2, -reed_hexagon_diameter*sin60/4])
               rotate([90, 0, 90])
                 cylinder(d = lateral_screw_diameter, h = 2*Shield_thickness, center = true, $fn=Resolution);         
      // last one
      translate([Box_Width/2 - Shield_thickness/2, (reed_length - modulo - reed_hexagon_diameter)/2 - (total_num - 1) * reed_hexagon_diameter, -reed_hexagon_diameter*sin60/4])
               rotate([90, 0, 90])
                 cylinder(d = lateral_screw_diameter, h = 2*Shield_thickness, center = true, $fn=Resolution);         
      } //un
   }
} //mo


module flakes() {
  posX = (Box_Width - flake_height)/2;
  posY = Box_Length/4;
  posZ = Box_Height/4;

  //posY = 150;
  //posZ = 23.923 + deltaH - honeycomb_hexagon_thickness/2;

  union() {  
  translate([ - posX, - posY, - posZ])
    rotate([0, 90, 0]) ventilation_flake(diameter = flake_dia, thickness = flake_thick, height = flake_height);
  translate([ - posX, posY, - posZ])
    rotate([0, 90, 0]) ventilation_flake(diameter = flake_dia, thickness = flake_thick, height = flake_height);
  translate([ posX, - posY, - posZ])
    rotate([0, 90, 0]) ventilation_flake(diameter = flake_dia, thickness = flake_thick, height = flake_height);
  translate([ posX, posY, - posZ])
    rotate([0, 90, 0]) ventilation_flake(diameter = flake_dia, thickness = flake_thick, height = flake_height);
  }
} //mo


module flake_holes() {
  posX = (Box_Width - flake_height)/2;
  posY = Box_Length/4;
  posZ = Box_Height/4;

  //posY = 150;
  //posZ = 23.923 + deltaH - honeycomb_hexagon_thickness/2; // numerical value must be selected from the output of the console ECHO; [posZ, posY].
   
  translate([ - posX, - posY, - posZ])
    rotate([0, 90, 0]) flake_hole(diameter = flake_dia, thickness = flake_thick, height = flake_height + 0.001);
  translate([ - posX, posY, - posZ])
    rotate([0, 90, 0]) flake_hole(diameter = flake_dia, thickness = flake_thick, height = flake_height + 0.001);
  translate([ posX, - posY, - posZ])
    rotate([0, 90, 0]) flake_hole(diameter = flake_dia, thickness = flake_thick, height = flake_height + 0.001);
  translate([ posX, posY, - posZ])
    rotate([0, 90, 0]) flake_hole(diameter = flake_dia, thickness = flake_thick, height = flake_height + 0.001);
} //mo

module ventilation_holes() {      
echo("START VENTILATION HOLES ..."); 
  reed_length = Box_Length - 2*panel_thickness/fitting_factor - 4*rail_thickness;
  modulo = reed_length % reed_hexagon_diameter;
  total_num = floor(reed_length/reed_hexagon_diameter);
  half_num = floor(total_num/2);
  half_screws = floor(n_screws/2);
  step = floor(half_num/half_screws);
  vent_hole_thick = Shield_thickness*2;
      // Ventilation Holes
      rotate ([0, 0, 90]) 
        union() {
          for (i = [Shield_thickness*5 : Shield_thickness*2 : Box_Length/4]) {
            // Ventilation holes part code submitted by Ettie - Thanks ;) 
            translate([ - Box_Length/2 + 10 + i, - Box_Width/2 - Dec_Thick + Dec_size, - Box_Height/2 + Shield_thickness])
              cube([Vent_width, Dec_Thick, Box_Height/4]);
            translate([Box_Length/2 - 10 - i, - Box_Width/2 - Dec_Thick + Dec_size, - Box_Height/2 + Shield_thickness])
              cube([Vent_width, Dec_Thick, Box_Height/4]);
            translate([Box_Length/2 - 10 - i, Box_Width/2 - Dec_size, - Box_Height/2 + Shield_thickness])
              cube([Vent_width, Dec_Thick, Box_Height/4]);
            translate([ - Box_Length/2 + 10 + i, Box_Width/2 - Dec_size, - Box_Height/2 + Shield_thickness])
              cube([Vent_width, Dec_Thick, Box_Height/4]);
          } //fo
        } //un
    // Lateral screws
    if (Lateral_Screws_Active) {
    starting_point = (total_num % 2 == 0) ? (n_screws % 2 == 0 ? -reed_hexagon_diameter/2 : -reed_hexagon_diameter/2) : 0; 
    nl_screws = (total_num % 2 == 0) ? (n_screws % 2 == 0 ? n_screws : n_screws - 1) : n_screws;
    color("red") 
      union() {
        for (j = [step : step : half_num - step]) {
              translate([Box_Width/2 - Shield_thickness, j * reed_hexagon_diameter + starting_point, - reed_hexagon_diameter * sin60/4])
               rotate([90, 0, 90])
                 cylinder(d = lateral_screw_diameter, h = 2*Shield_thickness, center = true, $fn=Resolution); 
              translate([Box_Width/2 - Shield_thickness, - j * reed_hexagon_diameter - starting_point, - reed_hexagon_diameter * sin60/4])
               rotate([90, 0, 90])
                 cylinder(d = lateral_screw_diameter, h = 2*Shield_thickness, center = true, $fn=Resolution); 
        } //fo
      // center one
      if (nl_screws % 2 != 0)  
        translate([Box_Width/2 - Shield_thickness, 0, -reed_hexagon_diameter*sin60/4])
               rotate([90, 0, 90])
                 cylinder(d = lateral_screw_diameter, h = 2*Shield_thickness, center = true, $fn=Resolution); 
      // first one
      translate([Box_Width/2 - Shield_thickness, (reed_length - modulo - reed_hexagon_diameter)/2, -reed_hexagon_diameter*sin60/4])
               rotate([90, 0, 90])
                 cylinder(d = lateral_screw_diameter, h = 2*Shield_thickness, center = true, $fn=Resolution);         
      // last one
      translate([Box_Width/2 - Shield_thickness, (reed_length - modulo - reed_hexagon_diameter)/2 - (total_num - 1) * reed_hexagon_diameter, -reed_hexagon_diameter*sin60/4])
               rotate([90, 0, 90])
                 cylinder(d = lateral_screw_diameter, h = 2*Shield_thickness, center = true, $fn=Resolution);         
      } //un
   }
      echo("--> END VENTILATION HOLES"); 
} //mo


module pillar_holes(Shield_Type) {    
    echo("START PILLARS HOLES ..."); 
    //Holes for pillars
  if (Shield_Type == 0) { 
    //Bottom shield   
    if (Pillar1_item) translate([BPillar1_PosX, BPillar1_PosY, - Box_Height/2])
    cylinder(d = Pillar_ext_dia - 0.001, h = Box_Height + Shield_thickness, $fn=Resolution);
    if (Pillar2_item) translate([BPillar2_PosX, BPillar2_PosY, - Box_Height/2])
    cylinder(d = Pillar_ext_dia - 0.001, h = Box_Height + Shield_thickness, $fn=Resolution);
    if (Pillar3_item) translate([BPillar3_PosX, BPillar3_PosY, - Box_Height/2])
    cylinder(d = Pillar_ext_dia - 0.001, h = Box_Height + Shield_thickness, $fn=Resolution);
    if (Pillar4_item) translate([BPillar4_PosX, BPillar4_PosY, - Box_Height/2])
    cylinder(d = Pillar_ext_dia - 0.001, h = Box_Height + Shield_thickness, $fn=Resolution);
    if (Pillar5_item) translate([BPillar5_PosX, BPillar5_PosY, - Box_Height/2])
    cylinder(d = Pillar_ext_dia - 0.001, h = Box_Height + Shield_thickness, $fn=Resolution);
    if (Pillar6_item) translate([BPillar6_PosX, BPillar6_PosY, - Box_Height/2])
    cylinder(d = Pillar_ext_dia - 0.001, h = Box_Height + Shield_thickness, $fn=Resolution);
  }
  else {
    //Top shield
    if (Pillar1_item) translate([TPillar1_PosX, TPillar1_PosY, - Box_Height/2])
    cylinder(d = Pillar_ext_dia - 0.001, h = Box_Height + Shield_thickness, $fn=Resolution);
    if (Pillar2_item) translate([TPillar2_PosX, TPillar2_PosY, - Box_Height/2])
    cylinder(d = Pillar_ext_dia - 0.001, h = Box_Height + Shield_thickness, $fn=Resolution);
    if (Pillar3_item) translate([TPillar3_PosX, TPillar3_PosY, - Box_Height/2])
    cylinder(d = Pillar_ext_dia - 0.001, h = Box_Height + Shield_thickness, $fn=Resolution);
    if (Pillar4_item) translate([TPillar4_PosX, TPillar4_PosY, - Box_Height/2])
    cylinder(d = Pillar_ext_dia - 0.001, h = Box_Height + Shield_thickness, $fn=Resolution);
    if (Pillar5_item) translate([TPillar5_PosX, TPillar5_PosY, - Box_Height/2])
    cylinder(d = Pillar_ext_dia - 0.001, h = Box_Height + Shield_thickness, $fn=Resolution);
    if (Pillar6_item) translate([TPillar6_PosX, TPillar6_PosY, - Box_Height/2])
    cylinder(d = Pillar_ext_dia - 0.001, h = Box_Height + Shield_thickness, $fn=Resolution);      
  }
echo("--> END PILLARS HOLES"); 
} //mo


module psf_holes(Shield_Type) {    
    echo("START PS FEET HOLES ..."); 
    //Holes for PS feet
  if (Shield_Type == 0) {

  PSFoot1_PosX = PS_PosX + PS_Length/2;
  PSFoot1_PosY = PS_PosY + PS_Width/2;

  PSFoot2_PosX = PS_PosX + PS_Length/2;
  PSFoot2_PosY = PS_PosY - PS_Width/2;

  PSFoot3_PosX = PS_PosX - PS_Length/2;
  PSFoot3_PosY = PS_PosY + PS_Width/2;

  PSFoot4_PosX = PS_PosX - PS_Length/2;
  PSFoot4_PosY = PS_PosY - PS_Width/2;

    //Bottom    
    if (PS_item) translate([PSFoot1_PosX, PSFoot1_PosY, - Box_Height/2])
    cylinder(d = PSF_ext_dia - 0.001, h = Box_Height + Shield_thickness, $fn = Resolution);
    if (PS_item) translate([PSFoot2_PosX, PSFoot2_PosY, - Box_Height/2])
    cylinder(d = PSF_ext_dia - 0.001, h = Box_Height + Shield_thickness, $fn = Resolution);
    if (PS_item) translate([PSFoot3_PosX, PSFoot3_PosY, - Box_Height/2])
    cylinder(d = PSF_ext_dia - 0.001, h = Box_Height + Shield_thickness, $fn = Resolution);
    if (PS_item) translate([PSFoot4_PosX, PSFoot4_PosY, - Box_Height/2])
    cylinder(d = PSF_ext_dia - 0.001, h = Box_Height + Shield_thickness, $fn = Resolution);
  }
  else {
    //Top
  }
echo("--> END PS FEET HOLES"); 
} //mo


module pillars(Shield_Type) {    
echo("START PILLARS ..."); 
  //PILLARS
  if (Shield_Type == 0) {
    // * Bottom    
  if (Pillar1_item) translate([BPillar1_PosX, BPillar1_PosY, - Box_Height/2])
  Bpillar(pillar_height = Pillar_Height, ext_diameter = Pillar_ext_dia, int_diameter = Pillar_int_dia, base_hole_diameter = Pillar_bh_dia, base_hole_height = Pillar_bh_height, pillar_Fillet = Pillar_Fillet);    
  if (Pillar2_item) translate([BPillar2_PosX, BPillar2_PosY, - Box_Height/2])
  Bpillar(pillar_height = Pillar_Height, ext_diameter = Pillar_ext_dia, int_diameter = Pillar_int_dia, base_hole_diameter = Pillar_bh_dia, base_hole_height = Pillar_bh_height, pillar_Fillet = Pillar_Fillet);    
  if (Pillar3_item) translate([BPillar3_PosX, BPillar3_PosY, - Box_Height/2])
  Bpillar(pillar_height = Pillar_Height, ext_diameter = Pillar_ext_dia, int_diameter = Pillar_int_dia, base_hole_diameter = Pillar_bh_dia, base_hole_height = Pillar_bh_height, pillar_Fillet = Pillar_Fillet);    
  if (Pillar4_item) translate([BPillar4_PosX, BPillar4_PosY, - Box_Height/2])
  Bpillar(pillar_height = Pillar_Height, ext_diameter = Pillar_ext_dia, int_diameter = Pillar_int_dia, base_hole_diameter = Pillar_bh_dia, base_hole_height = Pillar_bh_height, pillar_Fillet = Pillar_Fillet);    
  if (Pillar5_item) translate([BPillar5_PosX, BPillar5_PosY, - Box_Height/2])
  Bpillar(pillar_height = Pillar_Height, ext_diameter = Pillar_ext_dia, int_diameter = Pillar_int_dia, base_hole_diameter = Pillar_bh_dia, base_hole_height = Pillar_bh_height, pillar_Fillet = Pillar_Fillet);    
  if (Pillar6_item) translate([BPillar6_PosX, BPillar6_PosY, - Box_Height/2])
  Bpillar(pillar_height = Pillar_Height, ext_diameter = Pillar_ext_dia, int_diameter = Pillar_int_dia, base_hole_diameter = Pillar_bh_dia, base_hole_height = Pillar_bh_height, pillar_Fillet = Pillar_Fillet);    
  }
  else {
    // * Top
    if (Pillar1_item) translate([TPillar1_PosX, TPillar1_PosY, - Box_Height/2])
  Tpillar(pillar_height = Pillar_Height, ext_diameter = Pillar_ext_dia, int_diameter = Pillar_int_dia, base_hole_diameter = Pillar_bh_dia, base_hole_height = Pillar_bh_height, pillar_Fillet = Pillar_Fillet);    
    if (Pillar2_item) translate([TPillar2_PosX, TPillar2_PosY, - Box_Height/2])
  Tpillar(pillar_height = Pillar_Height, ext_diameter = Pillar_ext_dia, int_diameter = Pillar_int_dia, base_hole_diameter = Pillar_bh_dia, base_hole_height = Pillar_bh_height, pillar_Fillet = Pillar_Fillet);    
    if (Pillar3_item) translate([TPillar3_PosX, TPillar3_PosY, - Box_Height/2])
  Tpillar(pillar_height = Pillar_Height, ext_diameter = Pillar_ext_dia, int_diameter = Pillar_int_dia, base_hole_diameter = Pillar_bh_dia, base_hole_height = Pillar_bh_height, pillar_Fillet = Pillar_Fillet);    
    if (Pillar4_item) translate([TPillar4_PosX, TPillar4_PosY, - Box_Height/2])
  Tpillar(pillar_height = Pillar_Height, ext_diameter = Pillar_ext_dia, int_diameter = Pillar_int_dia, base_hole_diameter = Pillar_bh_dia, base_hole_height = Pillar_bh_height, pillar_Fillet = Pillar_Fillet);    
    if (Pillar5_item) translate([TPillar5_PosX, TPillar5_PosY, - Box_Height/2])
  Tpillar(pillar_height = Pillar_Height, ext_diameter = Pillar_ext_dia, int_diameter = Pillar_int_dia, base_hole_diameter = Pillar_bh_dia, base_hole_height = Pillar_bh_height, pillar_Fillet = Pillar_Fillet);    
    if (Pillar6_item) translate([TPillar6_PosX, TPillar6_PosY, - Box_Height/2])
  Tpillar(pillar_height = Pillar_Height, ext_diameter = Pillar_ext_dia, int_diameter = Pillar_int_dia, base_hole_diameter = Pillar_bh_dia, base_hole_height = Pillar_bh_height, pillar_Fillet = Pillar_Fillet);    
  }
  echo("--> END PILLARS"); 
} //mo


module ps_feet(Shield_Type) {    
echo("START PS FEET ..."); 
  // PS FEET
  if (Shield_Type == 0) {
    // * Bottom    
  if ((InternalBox_Visible == 1) && (PS_item ==1)) {
  translate([PS_PosX, PS_PosY, - Box_Height/2 + PSF_Height + Shield_thickness + PS_box_height/2])   
    %cube ([PS_box_length, PS_box_width, PS_box_height], center = true);
  translate([PS_PosX, PS_PosY, - Box_Height/2 + PSF_Height + Shield_thickness + PS_box_height])   
    color("Olive")
      %text("PS", halign="center", valign="center", font="Arial black");
  }
  PSFoot1_PosX = PS_PosX + PS_Length/2;
  PSFoot1_PosY = PS_PosY + PS_Width/2;

  PSFoot2_PosX = PS_PosX + PS_Length/2;
  PSFoot2_PosY = PS_PosY - PS_Width/2;

  PSFoot3_PosX = PS_PosX - PS_Length/2;
  PSFoot3_PosY = PS_PosY + PS_Width/2;

  PSFoot4_PosX = PS_PosX - PS_Length/2;
  PSFoot4_PosY = PS_PosY - PS_Width/2;
 

  if (PS_item) translate([PSFoot1_PosX, PSFoot1_PosY, - Box_Height/2])
  PSFoot(pillar_height = PSF_Height, ext_diameter = PSF_ext_dia, int_diameter = PSF_int_dia, base_hole_diameter = PSF_bh_dia, base_hole_height = PSF_bh_height, pillar_Fillet = PSF_Fillet);    
  if (PS_item) translate([PSFoot2_PosX, PSFoot2_PosY, - Box_Height/2])
  PSFoot(pillar_height = PSF_Height, ext_diameter = PSF_ext_dia, int_diameter = PSF_int_dia, base_hole_diameter = PSF_bh_dia, base_hole_height = PSF_bh_height, pillar_Fillet = PSF_Fillet);    
  if (PS_item) translate([PSFoot3_PosX, PSFoot3_PosY, - Box_Height/2])
  PSFoot(pillar_height = PSF_Height, ext_diameter = PSF_ext_dia, int_diameter = PSF_int_dia, base_hole_diameter = PSF_bh_dia, base_hole_height = PSF_bh_height, pillar_Fillet = PSF_Fillet);    
  if (PS_item) translate([PSFoot4_PosX, PSFoot4_PosY, - Box_Height/2])
  PSFoot(pillar_height = PSF_Height, ext_diameter = PSF_ext_dia, int_diameter = PSF_int_dia, base_hole_diameter = PSF_bh_dia, base_hole_height = PSF_bh_height, pillar_Fillet = PSF_Fillet);    

  }
  else {
    // * Top
  }
  echo("--> END PS FEET"); 
} //mo


module pcb_feet(Shield_Type, bottom_active, top_active) {    
  echo("START PCB FEET ..."); 
  //PCB FEET
  if (Shield_Type == 0) {
    //Bottom        
  if (BPCB1_item == 1) {
    translate([PCB1_PosX, PCB1_PosY, - Box_Height/2]) 
      PCB(PCB1_Length, PCB1_Width, PCB1_Height, num = 1, active = bottom_active); }
    
  if (BPCB2_item == 1) {
    translate([PCB2_PosX, PCB2_PosY, - Box_Height/2]) 
      PCB(PCB2_Length, PCB2_Width, PCB2_Height, num = 2, active = bottom_active); }

  if (BPCB3_item == 1) {
    translate([PCB3_PosX, PCB3_PosY, - Box_Height/2]) 
      PCB(PCB3_Length, PCB3_Width, PCB3_Height, num = 3, active = bottom_active); }

  if (BPCB4_item == 1) {
    translate([PCB4_PosX, PCB4_PosY, - Box_Height/2]) 
      PCB(PCB4_Length, PCB4_Width, PCB4_Height, num = 4, active = bottom_active); }

  if (BFan_Grill_item == 1) {
    rotate([0,0,0])
    translate([FanPosX, FanPosY, - Box_Height/2])
      Fan_grille(fan_active = bottom_active, plate_thickness = Shield_thickness); 
//    if ((BFan_Grill_item == 1) && (visible == 1))
//      %Fan_grille(!bottom_active); 
  }
  }
  else {
    //Top
    if (TPCB1_item == 1) {
      translate([PCB1_PosX, PCB1_PosY, - Box_Height/2]) 
        PCB(PCB1_Length, PCB1_Width, PCB1_Height, num = 1, active = top_active); }
    
    if (TPCB2_item == 1) {
      translate([PCB2_PosX, PCB2_PosY, - Box_Height/2]) 
        PCB(PCB2_Length, PCB2_Width, PCB2_Height, num = 2, active = top_active); }

    if (TPCB3_item == 1) {
      translate([PCB3_PosX, PCB3_PosY, - Box_Height/2]) 
        PCB(PCB3_Length, PCB3_Width, PCB3_Height, num = 3, active = top_active); }

    if (TFan_Grill_item == 1) {
      rotate([0,0,0])
      translate([FanPosX, FanPosY, - (Box_Height - Shield_thickness)/2])
        Fan_grille(fan_active = top_active, plate_thickness = Shield_thickness); 
     // if ((TFan_Grill_item == 1) && (top_visible == 1))
       // Fan_grille(!top_active); 
  }
        echo("--> END PCB FEET"); 
  }
} //mo


//ANTI-PCB FEET
module antipcb_feet(Shield_Type, bottom_active, top_active) {    
  echo("START PCB FEET ..."); 
  //APCB FEET
  if (Shield_Type == 0) {
    //Bottom        
  if (PS_item == 1) {
    translate([PS_PosX, PS_PosY, - Box_Height/2]) 
      APCB(PS_Length, PS_Width, num = 0, active = bottom_active); }
    
  if (BPCB1_item == 1) {
    translate([PCB1_PosX, PCB1_PosY, - Box_Height/2]) 
      APCB(PCB1_Length, PCB1_Width, num = 1, active = bottom_active); }
    
  if (BPCB2_item == 1) {
    translate([PCB2_PosX, PCB2_PosY, - Box_Height/2]) 
      APCB(PCB2_Length, PCB2_Width, num = 2, active = bottom_active); }

  if (BPCB3_item == 1) {
    translate([PCB3_PosX, PCB3_PosY, - Box_Height/2]) 
      APCB(PCB3_Length, PCB3_Width, num = 3, active = bottom_active); }

  if (BPCB4_item == 1) {
    translate([PCB4_PosX, PCB4_PosY, - Box_Height/2]) 
      APCB(PCB4_Length, PCB4_Width, num = 4, active = bottom_active); }
/*
  if (BFan_Grill_item == 1) {
    rotate([0,0,0])
    translate([FanPosX, FanPosY, - Box_Height/2])
      Fan_grille(fan_active = bottom_active, plate_thickness = Shield_thickness); 
//    if ((BFan_Grill_item == 1) && (visible == 1))
//      %Fan_grille(!bottom_active); 
    }
*/
  }
  else {
    //Top
    if (TPCB1_item == 1) {
      translate([PCB1_PosX, PCB1_PosY, - Box_Height/2]) 
        APCB(PCB1_Length, PCB1_Width, num = 1, active = top_active); }
    
    if (TPCB2_item == 1) {
      translate([PCB2_PosX, PCB2_PosY, - Box_Height/2]) 
        APCB(PCB2_Length, PCB2_Width, num = 2, active = top_active); }

    if (TPCB3_item == 1) {
      translate([PCB3_PosX, PCB3_PosY, - Box_Height/2]) 
        APCB(PCB3_Length, PCB3_Width, num = 3, active = top_active); }

 /*   if (TFan_Grill_item == 1) {
      rotate([0,0,0])
      translate([FanPosX, FanPosY, - Box_Height/2])
        Fan_grille(fan_active = top_active, plate_thickness = Shield_thickness); 
     // if ((TFan_Grill_item == 1) && (top_visible == 1))
       // Fan_grille(!top_active); 
  }
*/
        echo("--> END APCB FEET"); 
  }
} //mo


//                          <- Circle hole -> 
// Cx=Cylinder X position | Cy=Cylinder Y position | Cdia= Cylinder dia | Cheight=Cyl height
module CylinderHole(OnOff, Cx, Cy, Cdia) {
    if(OnOff == 1)
    translate([Cx, Cy, 0])
      rotate ([0, 0, 0])
       cylinder(d = Cdia, h = Shield_thickness + 1, center = true, $fn=Resolution);
}
//                          <- Square hole ->  
// Sx=Square X position | Sy=Square Y position | Sl= Square Length | Sw=Square Width | Fillet = Round corner
module SquareHole(OnOff, Sx, Sy, Sl, Sw, Fillet) {
    if(OnOff== 1)
        translate([Sx, Sy, 0])
        rotate([90, 0, 0])
        rounded_polig4([Shield_thickness + 1, Sl, Sw], Fillet);
 /*    minkowski() {
        translate([Sx + Fillet/2, -1, Sz + Fillet/2])
            cube([Sl - Fillet, Sw - Fillet, 10], center = true);
            cylinder(d=Fillet, h=10, $fn=100);
       }
    */
}

 
//                      <- Linear text panel -> 
module LText(OnOff, Tx, Ty, Font,Size, Content) {
    if(OnOff== 1)
    translate([Tx, Ty, (Shield_thickness - 0.5)/2])
    linear_extrude(height = 0.5) {
    text(Content, size = Size, font = Font);
    }
}
//                     <- Circular text panel->  
module CText(OnOff, Tx, Ty, Font, Size, TxtRadius, Angl, Turn, Content) { 
      if(OnOff == 1) {
      Angle = -Angl / len(Content);
      translate([Tx, Ty, (Shield_thickness - 0.5)/2])
          for (i = [0 : len(Content) - 1] ) {   
              rotate([0, 0, i * Angle + 90 + Turn])
              translate([0, TxtRadius, 0])
              {
                linear_extrude(height = 0.5) {
                text(Content[i], font = Font, size = Size,  valign ="baseline", halign ="center");
                    }
                }
             }
      }
}
////////////////////// <- New module Panel -> //////////////////////

module bottom_shield(active, visible) { 
  if (active == 1) {
    difference() {
      union() {
        difference() {
          bshield(bottom_active = 1, bottom_visible = 0);
          if ((Shield_Split == 1) && (Shield_Split_Part == 0)) { // REAR PART
            translate([0, - Box_Length/2, 0])
              cube ([Box_Length, Box_Length, Box_Length], center = true);
            color("blue") union() { 
              translate([- Box_Width/4, 0, -(Box_Height/2 - Shield_thickness/2)]) rotate([90, 0, 0]) 
                cylinder(d = Shield_thickness/2, h = Shield_thickness/2, center = true, $fn=Resolution); 
              translate([0, 0, -(Box_Height/2 - Shield_thickness/2)]) rotate([90, 0, 0])
                cylinder(d = Shield_thickness/2, h = Shield_thickness/2, center = true, $fn=Resolution); 
              translate([Box_Width/4, 0, -(Box_Height/2 - Shield_thickness/2)]) rotate([90, 0, 0])
                cylinder(d = Shield_thickness/2, h = Shield_thickness/2, center = true, $fn=Resolution);
              translate([-(Box_Width/2 - Shield_thickness/2), 0, -(Box_Height/4)]) rotate([90, 0, 0]) 
                cylinder(d = Shield_thickness/2, h = Shield_thickness/2, center = true, $fn=Resolution); 
              translate([(Box_Width/2 - Shield_thickness/2), 0, -(Box_Height/4)]) rotate([90, 0, 0]) 
                cylinder(d = Shield_thickness/2, h = Shield_thickness/2, center = true, $fn=Resolution); 
            } //un
          }
          else  // FRONT PART
            if (Shield_Split == 1) translate([0, Box_Length/2, 0])
              cube ([Box_Length, Box_Length, Box_Length], center = true);
        } //di
        if ((Shield_Split == 1) && (Shield_Split_Part == 1))  // FRONT PART
        color("blue") union() { 
          translate([- Box_Width/4, 0, -(Box_Height/2 - Shield_thickness/2)])
            sphere (r = Shield_thickness/4, center = true, $fn=Resolution); 
          translate([0, 0, -(Box_Height/2 - Shield_thickness/2)])
            sphere (r = Shield_thickness/4, center = true, $fn=Resolution); 
          translate([Box_Width/4, 0, -(Box_Height/2 - Shield_thickness/2)])
            sphere (r = Shield_thickness/4, center = true, $fn=Resolution); 
          translate([-(Box_Width/2 - Shield_thickness/2), 0, -(Box_Height/4)])
            sphere (r = Shield_thickness/4, center = true, $fn=Resolution); 
          translate([(Box_Width/2 - Shield_thickness/2), 0, -(Box_Height/4)])
            sphere (r = Shield_thickness/4, center = true, $fn=Resolution); 
        } //un
      } //un
    } //di
     //   rotate([0,180,0]) tshield(top_active = 1, top_visible=0); //Uncomment this line in order to visualize both shields matched.
  }
  else
    if (visible == 1) %bshield(bottom_active = 0, bottom_visible = 1);
} //mo   

module top_shield(active, visible) { 
  rotate([0,180,0])
  union() {
  if (active == 1) {
    difference() {
      union() {
        difference() {
          tshield(top_active = 1, top_visible=0);
          if ((Shield_Split == 1) && (Shield_Split_Part == 0)) { // REAR PART
            translate([0, - Box_Length/2, 0])
              cube ([Box_Length, Box_Length, Box_Length], center = true);
            color("blue") union() { 
              translate([- Box_Width/4, 0, -(Box_Height/2 - Shield_thickness/2)]) rotate([90, 0, 0]) 
                cylinder(d = Shield_thickness/2, h = Shield_thickness/2, center = true, $fn=Resolution); 
              translate([0, 0, -(Box_Height/2 - Shield_thickness/2)]) rotate([90, 0, 0])
                cylinder(d = Shield_thickness/2, h = Shield_thickness/2, center = true, $fn=Resolution); 
              translate([Box_Width/4, 0, -(Box_Height/2 - Shield_thickness/2)]) rotate([90, 0, 0])
                cylinder(d = Shield_thickness/2, h = Shield_thickness/2, center = true, $fn=Resolution);
              translate([-(Box_Width/2 - Shield_thickness/2), 0, -(Box_Height/4)]) rotate([90, 0, 0]) 
                cylinder(d = Shield_thickness/2, h = Shield_thickness/2, center = true, $fn=Resolution); 
              translate([(Box_Width/2 - Shield_thickness/2), 0, -(Box_Height/4)]) rotate([90, 0, 0]) 
                cylinder(d = Shield_thickness/2, h = Shield_thickness/2, center = true, $fn=Resolution); 
            } //un
          }
          else  // FRONT PART
            if (Shield_Split == 1) translate([0, Box_Length/2, 0])
              cube ([Box_Length, Box_Length, Box_Length], center = true);
        } //di
        if ((Shield_Split == 1) && (Shield_Split_Part == 1))  // FRONT PART
        color("blue") union() { 
          translate([- Box_Width/4, 0, -(Box_Height/2 - Shield_thickness/2)])
            sphere (r = Shield_thickness/4, center = true, $fn=Resolution); 
          translate([0, 0, -(Box_Height/2 - Shield_thickness/2)])
            sphere (r = Shield_thickness/4, center = true, $fn=Resolution); 
          translate([Box_Width/4, 0, -(Box_Height/2 - Shield_thickness/2)])
            sphere (r = Shield_thickness/4, center = true, $fn=Resolution); 
          translate([-(Box_Width/2 - Shield_thickness/2), 0, -(Box_Height/4)])
            sphere (r = Shield_thickness/4, center = true, $fn=Resolution); 
          translate([(Box_Width/2 - Shield_thickness/2), 0, -(Box_Height/4)])
            sphere (r = Shield_thickness/4, center = true, $fn=Resolution); 
        } //un
      } //un
    } //di
     //   rotate([0,180,0]) bshield(top_active = 1, top_visible=0); //Uncomment this line in order to visualize both shields matched.
  }
  else
    if (visible == 1) %tshield(top_active = 1, top_visible = 1);   
  } //un
} //mo   


module tshield(top_active, top_visible) { 
  echo("START TOP SHIELD ...");
  bottom_active = 0;
  difference() { //shield holes  
      union() {    
        // Outer Shield
        difference() {
          union() {
            //main shield   
            shield();
            if (Honeycomb_Active == 1) 
            hex_mesh();
          } //un
          echo("START HALF ..."); 
          //Half enclosure
          translate([0, 0, Box_Height])
            cube ([Box_Width, Box_Length, 2*Box_Height], center = true);
          echo("--> END HALF"); 
          antireeds();
          antipcb_feet(Shield_Type = 0, bottom_active = 1, top_active = 0);
          //Fan Hole
          if (TFan_Grill_item == 1) {
            translate([FanPosX,  FanPosY, - Box_Height/2])
            cylinder(r = FanDia/2, h = 2*(Shield_thickness + honeycomb_height));
          }
        } //di
        reeds();
        pegs();
      } //un 
    pillar_holes(Shield_Type = 1);
    } //di (shield holes)
    pillars(Shield_Type = 1);
    pcb_feet(Shield_Type = 1, bottom_active = 0, top_active = 1);
  echo("--> END TOP SHIELD");
} //mo


module bshield(bottom_active, bottom_visible) { 
  echo("START BOTTOM SHIELD ...");
  top_active = 0;
  difference() { //shield holes  
      union() {    
        // Outer Shield
        difference() {
          union() {
            //main shield   
            shield();
            if (Honeycomb_Active == 1) 
            hex_mesh();
          } //un
          echo("START HALF ..."); 
          //Half enclosure
          translate([0, 0, Box_Height])
            cube ([Box_Width, Box_Length, 2*Box_Height], center = true);
          echo("--> END HALF"); 
          antireeds();
          antipcb_feet(Shield_Type = 0, bottom_active = 1, top_active = 0);
        //Fan Hole
          if (BFan_Grill_item == 1) {
            translate([FanPosX,  FanPosY, - Box_Height/2])
            cylinder(r = FanDia/2, h = 2*(Shield_thickness + honeycomb_height));
          }
        } //di
        reeds();
        pegs();
      } //un 
    pillar_holes(Shield_Type = 0);
    psf_holes(Shield_Type = 0);
    } //di (shield holes)
    pillars(Shield_Type = 0);
    ps_feet(Shield_Type = 0);
    pcb_feet(Shield_Type = 0, bottom_active = 1, top_active = 0);
  echo("--> END BOTTOM SHIELD");
} //mo


// * FAN GRILLE
// - FAN FOOT  
module fanfoot(FanFootDia, FanFootHole, FanFootHeight) {
  Fillet = Shield_thickness;
  color("Orange")   
//    translate([0 ,0 , Shield_thickness])
      difference() {
        difference() {
          cylinder(d = FanFootDia + Fillet, h = FanFootHeight,  $fn=Resolution);
          rotate_extrude($fn = Resolution) {
            translate([(FanFootDia + Fillet * 2)/2, Fillet, 0]) {
              minkowski() {
                square(10);
                circle(Fillet, $fn=Resolution);
              } //mi
            } //tr
          } //ro
        } //di
        cylinder(d = FanFootHole, h = FanFootHeight + 1, $fn=Resolution);
      } //di
} //mo


// - FAN GRILLE
module Fan_grille(fan_active, plate_thickness) {
    echo(plate_thickness);
    
echo("START FAN GRILLE ...");
// - How Thick do you require the outer frame to be?
outsideFrameThickness = FanFootHeight; // + plate_thickness;	

  // Fan only visible in the preview mode
  if (InternalBox_Visible == 1) {
  translate([0, 0, FanFootHeight + Shield_thickness+ FanH/2])   
    %cube ([FanL + 3/2*FanFootDia, FanW + 3/2*FanFootDia, FanH], center = true);
  translate([0, 0, FanFootHeight + Shield_thickness+ FanH])   
    color("Olive")
      %text("FAN", halign="center", valign="center", font="Arial black");
  }
  
  // Fan Grille + 4 Fan Feet
  translate([0, 0, plate_thickness/2])
  union() {
    // outer mounting ring is a cube minus the cutouts
    translate([0, 0, outsideFrameThickness/2 ])
 	  difference() {
        intersection() {
          difference() {
              union() {
            cube([(FanL + sqrt(2)*FanFootDia), (FanW + sqrt(2)*FanFootDia), outsideFrameThickness], center = true);
/*
                  // cut the screw holes
            translate ([ - FanL/2, - FanW/2, 0]) cylinder(d = FanFootHole, FanFootHeight);
            translate ([ - FanL/2, FanW/2, 0]) cylinder(d = FanFootHole, FanFootHeight);
            translate ([ FanL/2, - FanW/2, 0]) cylinder(d = FanFootHole, FanFootHeight);
            translate ([ FanL/2, FanW/2, 0]) cylinder(d = FanFootHole, FanFootHeight);
*/              }
              } //di
		  cylinder( d = sqrt(2)*FanL -FanFootDia, h = outsideFrameThickness, center = true, $fn = 12);
		} //in
		// cut the main center hole
		cylinder(r = FanDia/2, h = outsideFrameThickness + 0.001, center = true);
      } //di

    // Fan Feet
    if (fan_active == 1) 
      translate([0, 0, -0* plate_thickness/2]) {
        echo("----------FAN FEET-----------");
    translate ([ - FanL/2, - FanW/2, 0]) fanfoot(FanFootDia, FanFootHole, FanFootHeight);
    translate ([ - FanL/2, FanW/2, 0]) fanfoot(FanFootDia, FanFootHole, FanFootHeight);
    translate ([ FanL/2, - FanW/2, 0]) fanfoot(FanFootDia, FanFootHole, FanFootHeight);
    translate ([ FanL/2, FanW/2, 0]) fanfoot(FanFootDia, FanFootHole, FanFootHeight);
    }
    
  // Make Icon
  translate([0, 0, - plate_thickness/2 + 0*outsideFrameThickness - 0* innerThickness]) {
  rotate([0,0,-90 + rotateLogo])
    scale([inner_circle_diameter/20, inner_circle_diameter/20, 1])
      pickLogo(innerIconLogo, innerLogoThickness, 1, inner_circle_diameter);

    // rotate for aesthetics
    rotate([0, 0, vane_angle/2])
      for (angle = [0 : vane_angle : 360]) {
        rotate([0,0,angle])
         translate(v = [0, -vaneWidth/2, 0])
            cube(size = [FanDia/2, vaneWidth, innerThickness]);
      } //fo
      // circles
      for (x = [1 : numberOfRings ]) {
        difference() {
          cylinder(h = innerThickness, r = inner_circle_diameter/2 + (ring_spacing * x) + (ringWidth/2), $fn = Resolution);
          cylinder(h = innerThickness + 0.001, r = inner_circle_diameter/2 + (ring_spacing * x) - (ringWidth/2), $fn = Resolution);
        } //di
      } //fo
    } //tr
  } //un
  echo("--> END FAN GRILLE");
}

// * END OF FAN GRILLE


//PCB FOOT  
module PCBfoot(PCBFootDia, PCBFootHole, PCBFootHeight, active) {
  Fillet = Shield_thickness;
  if (active == 1) {  
    color("Orange")   
    translate([0 ,0 , Shield_thickness])
      difference() {
        difference() {
          cylinder(d = PCBFootDia + Fillet, h = PCBFootHeight,  $fn=Resolution);
          rotate_extrude($fn = Resolution) {
            translate([(PCBFootDia + Fillet * 2)/2, Fillet, 0]) {
              minkowski() {
                square(PCBFootHeight);
                circle(Fillet, $fn=Resolution);
              } //mi
            } //tr
          } //ro
        } //di
        cylinder(d = PCBFootHole, h = PCBFootHeight + 0.001, $fn=Resolution);
      } //di
    }
} //mo

//PCB ANTI-PCBFOOT  
module APCBfoot(PCBFootDia, PCBFootHole, PCBFootHeight, active) {
  if (active == 1) {  
    color("Orange")   
    translate([0 ,0 , Shield_thickness])
        cylinder(d = PCBFootHole, h = PCBFootHeight + 0.001, $fn=Resolution);
                
  }
} //mo


//PCB 
module PCB(PCBL, PCBW, PCBH, num, active) {     
  //PCB only visible in the preview mode
  if (InternalBox_Visible == 1) {
  translate([0, 0, PCBFootHeight + Shield_thickness+ PCBH/2])   
    %cube ([PCBL + 3/2*PCBFootDia, PCBW + 3/2*PCBFootDia, PCBH], center = true);
  translate([0, 0, PCBFootHeight + Shield_thickness+ PCBH])   
    color("Olive")
    if (num == 0) {
      %text("PS", halign="center", valign="center", font="Arial black");}
    else
    if (num == 1) {
      %text("PCB1", halign="center", valign="center", font="Arial black");}
    else
    if (num == 2) {
      %text("PCB2", halign="center", valign="center", font="Arial black");}
    else
    if (num == 3) {
      %text("PCB3", halign="center", valign="center", font="Arial black");}
    else
    if (num == 4) {
      %text("PCB4", halign="center", valign="center", font="Arial black");}
    }
    
    // 4 PCB Feet
    translate ([ - PCBL/2, - PCBW/2, 0]) PCBfoot(PCBFootDia, PCBFootHole, PCBFootHeight, active);
    translate ([ - PCBL/2, PCBW/2, 0]) PCBfoot(PCBFootDia, PCBFootHole, PCBFootHeight, active);
    translate ([ PCBL/2, - PCBW/2, 0]) PCBfoot(PCBFootDia, PCBFootHole, PCBFootHeight, active);
    translate ([ PCBL/2, PCBW/2, 0]) PCBfoot(PCBFootDia, PCBFootHole, PCBFootHeight, active);
}
 

// ANTI-PCB 
module APCB(PCBL, PCBW, num, active) {     
    // 4 PCB Feet
    translate ([ - PCBL/2, - PCBW/2, 0]) APCBfoot(PCBFootDia, PCBFootHole, PCBFootHeight, active);
    translate ([ - PCBL/2, PCBW/2, 0]) APCBfoot(PCBFootDia, PCBFootHole, PCBFootHeight, active);
    translate ([ PCBL/2, - PCBW/2, 0]) APCBfoot(PCBFootDia, PCBFootHole, PCBFootHeight, active);
    translate ([ PCBL/2, PCBW/2, 0]) APCBfoot(PCBFootDia, PCBFootHole, PCBFootHeight, active);
}

// * ROUNDED POLIGON

module rounded_polig4(box, radius)
{
  rotate([ -0, 0, 0]) {
    length = box[0];
    width = box[1];
    height = box[2];
	vertices = square_vertices(height, width);
    
    A = vertices[0];
	B = vertices[1];
	C = vertices[2];
	D = vertices[3];

	rotate([0, 90, 90]) translate([0, 0, -length/2]) linear_extrude(height = length, $fn = Resolution)
//      offset(r = Fillet)
//        square(size = [height - 2*Fillet, width - 2*Fillet], center = true);

    hull() {
		// place 4 circles in the corners, with the given radius
		translate(roundvertex(A, B, C, radius)) circle(r = radius, center = true);
		translate(roundvertex(B, C, D, radius)) circle(r = radius, center = true);
		translate(roundvertex(C, D, A, radius)) circle(r = radius, center = true);
		translate(roundvertex(D, A, B, radius)) circle(r = radius, center = true);
	} //hu

  } //ro
}


// polig6 - [x,y,z]
// radius - radius of corners
module rounded_polig6(polig6, height, radius)
{
	A = polig6[0];
	B = polig6[1];
	C = polig6[2];
	D = polig6[3];
	E = polig6[4];
	F = polig6[5];

	linear_extrude(height = height, center= true, $fn = Resolution)
	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate(roundvertex(A, B, C, radius)) circle(r = radius, center = true);
		translate(roundvertex(B, C, D, radius)) circle(r = radius, center = true);
		translate(roundvertex(C, D, E, radius)) circle(r = radius, center = true);
		translate(roundvertex(D, E, F, radius)) circle(r = radius, center = true);
		translate(roundvertex(E, F, A, radius)) circle(r = radius, center = true);
		translate(roundvertex(F, A, B, radius)) circle(r = radius, center = true);
	}
}


function square_vertices(x, y) = [[ -x/2, -y/2, 0], [ -x/2, y/2, 0], [x/2, y/2, 0], [x/2, -y/2, 0]];

function trapezoid_vertex(long_base, height, short_base, base_height) = [[ -long_base/2, -height/2, 0], [ -long_base/2, - height/2 + base_height, 0], [ -short_base/2, height/2, 0], [short_base/2, height/2, 0], [long_base/2, - height/2 + base_height, 0], [long_base/2, -height/2, 0]];

function hexagon_vertices(r) = [[r * cos(2 * 180 * 0 / 6), r * sin(2 * 180 * 0/6), 0], [r * cos(2 * 180 * 1/6), r * sin(2 * 180 * 1/6), 0], [r * cos(2 * 180 * 2/6), r * sin(2 * 180 * 2/6), 0], [r * cos(2 * 180 * 3/6), r * sin(2 * 180 * 3/6), 0], [r * cos(2 * 180 * 4/6), r * sin(2 * 180 * 4/6), 0], [r * cos(2 * 180 * 5/6), r * sin(2 * 180 * 5/6), 0]];

//translate([ -30, -30, 0]) rotate([90, 0, 90]) rounded_polig6(trapezoid_vertex(27.5, 19.4, 14, 12.4), 10, 2);
//translate([ -30, -30, 0]) rotate([90, 0, 90]) rounded_polig6(hexagon_vertices(20), 10, 5);


//----------------------------------------
//-- FUNCTIONS FOR WORKING WITH VECTORS
//----------------------------------------

//-- Calculate the module of a vector
function mod(v) = (sqrt(v[0]*v[0]+v[1]*v[1]+v[2]*v[2]));

//-- Calculate the cros product of two vectors
function cross(u,v) = [
  u[1]*v[2] - v[1]*u[2],
  -(u[0]*v[2] - v[0]*u[2]) ,
  u[0]*v[1] - v[0]*u[1]];

//-- Calculate the dot product of two vectors
function dot(u,v) = u[0]*v[0]+u[1]*v[1]+u[2]*v[2];

//-- Return the unit vector of a vector
function unitv(v) = v/mod(v);

//-- Return the angle between two vectores
function anglev(u, v) = acos( dot(u,v) / (mod(u)*mod(v)) );

function distance(u, v) = mod(v - u);

function incenter(A, B, C) = (A * distance(B, C) + B * distance(C, A) + C * distance(A, B)) / (distance(B, C) + distance(C, A) + distance(A, B));

function roundvertex(A, B, C, r) = B + (unitv(incenter(A, B, C) - B) * r / sin(anglev(B - A, B - C)/2)); 

// * END OF ROUNDED POLIGON


// * HONEYCOMB

module hexagonal_grid(box, hexagon_diameter, hexagon_thickness) {
// first arg is vector that defines the bounding box, length, width, height
// second arg in the 'diameter' of the holes. In OpenScad, this refers to the corner-to-corner diameter, not flat-to-flat
// this diameter is 2/sqrt(3) times larger than flat to flat
// third arg is wall thickness.  This also is measured that the corners, not the flats. 

// example 
//    hexagonal_grid([25, 25, 5], 5, 1);

    difference() {
        cube(box, center = true);
        hexgrid(box, hexagon_diameter, hexagon_thickness);
    }
}


module hex_hole(hexdiameter, height) {
  cylinder(d = hexdiameter, h = height, center = true, $fn = 6);
}




module hexgrid(box, hexagon_diameter, hexagon_thickness) {
  cos60 = cos(60);
  sin60 = sin(60);
  d = hexagon_diameter + hexagon_thickness;
  a = d*sin60;

  moduloX = (box[0] % (2*a*sin60));
//    numX = (box[0] - moduloX) / a;
  numX =  floor(box[0] / (2*a*sin60));
  oddX = numX % 2;
  numberX = numX;

  moduloY = (box[1] % a);
//    numY = (box[1] - moduloY) / a;
  numY =  floor(box[1]/a);
  oddY = numY % 2;
  numberY = numY;
    
// Center the central hexagon on the origin of coordinates
  deltaY = oddY == 1 ? a/2 : 0;

  x0 = (numberX + 2) * 2*a*sin60;
  y0 = (numberY + 2) * a/2 + deltaY;

  for(x = [ -x0: 2*a*sin60 : x0]) {
    for(y = [ -y0 : a : y0]) {
      translate([x, y, 0]) hex_hole(hexdiameter = hexagon_diameter, height = box[2] + 0.001);
      translate([x + a*sin60, y + a*cos60 , 0]) hex_hole(hexdiameter = hexagon_diameter, height = box[2] + 0.001);
      echo ("[z, y] = ", [x, y]); // print coordinates for manual matching of ventilation flakes
      echo ("[z, y] = ", [x + a*sin60, y + a*cos60]); // print coordinates for manual matching of ventilation flakes
    } //fo
  } //fo
} //mo

// * END OF HONEYCOMB

// * PANELS
// - FRONT PANEL
module front_panel() {
  union() {
    if (Panel_Active == 1)
      translate([0, - Box_Length/2 + rail_thickness + panel_thickness/2, 0]) 
        rotate([90, 0, 0])
        FPanel();
    else
      if (Panel_Visible == 1)
      translate([0, - Box_Length/2 + rail_thickness + panel_thickness/2, 0]) 
        rotate([90, 0, 0])
          %FPanel();
  }
  echo("*** END FRONT PANEL ***"); 
}

// - REAR PANEL
module rear_panel() {
  union() {
    if (Panel_Active == 1)
      translate([0, Box_Length/2 - rail_thickness - panel_thickness/2, 0]) 
        rotate([ -90, 180, 0])
        RPanel();
    else
      if (Panel_Visible == 1)
        translate([0, Box_Length/2 - rail_thickness - panel_thickness/2, 0]) 
        rotate([ -90, 180, 0])
          %RPanel();
 
  }
  echo("*** END REAR PANEL ***"); 
}


// - FPANEL
module FPanel() {
  echo("START FRONT PANEL ..."); 
  panel_height = (Box_Height - 2*Shield_thickness) * fitting_factor;
  panel_width = (Box_Width - 2*Shield_thickness) * fitting_factor;
  panel_thick = panel_thickness;
  difference() {
    rotate([90, 0, 0])
      rounded_polig4([panel_thick, panel_width, panel_height], Fillet);
    rotate([0,0,0]) {
      SquareHole  (1, -68, -20, 15, 10, 1); //(On/Off, Xpos, Ypos, Length, Width, Fillet)
      SquareHole  (1, -48, -20, 15, 10, 1);
      SquareHole  (1, -28, -20, 15, 10, 1); 
      CylinderHole(1, -68, -5, 8);       //(On/Off, Xpos, Ypos, Diameter)
      CylinderHole(1, -48, -5, 8);
      CylinderHole(1, -28, -5, 8);
      SquareHole  (1, -panel_width/5, 14, 80, 20, 2);
      CylinderHole(1, 0, -15, 10);
      SquareHole  (1, 50, 0, 30, 40, 3);
    } //ro
  } //di
  echo("---> END FRONT PANEL"); 

  color(Couleur1) {
    rotate([0, 0, 0]) {
      LText(1, -60, 30, "Arial Black", 4, "Digital Screen");//(On/Off, Xpos, Ypos, "Font", Size, "Text")
      LText(1, 40, 30, "Arial Black", 4, "Level");
      LText(1, -68 - 1, -33, "Arial Black", 6, "1");
      LText(1, -48 - 1, -33, "Arial Black", 6, "2");
      LText(1, -28 - 1, -33, "Arial Black", 6, "3");
      CText(1, 0, -15, "Arial Black", 4, 10, 180, 0, "1 . 2 . 3 . 4 . 5 . 6");//(On/Off, Xpos, Ypos, "Font", Size, Diameter, Arc(Deg), Starting Angle(Deg),"Text")
    } //ro
  } //co
} //mo


// - RPANEL
module RPanel() {
echo("START REAR PANEL ..."); 
  panel_height = (Box_Height - 2*Shield_thickness) * fitting_factor;
  panel_width = (Box_Width - 2*Shield_thickness) * fitting_factor;
  panel_thick = panel_thickness;
 
  echo("** panel_height = ", panel_height);
  echo("** panel_width = ", panel_width);
  echo("** panel_thick = ", panel_thick);
   
    // Items' positions must be referenced from the outside of the enclosure.

  rotate([0, 180 , 0]) {
    difference() {
      union() {
        rotate([90, 0, 0])
          rounded_polig4([panel_thick, panel_width, panel_height], Fillet);

    // Plug block
        if (RPlug_item) {
        f = 1.5;
          translate([ - 45, -30, 5]) 
            rounded_polig6(trapezoid_vertex(27.5*2, 19.5*f, 14*f, 12.5*f), 10, 2*f);
        }
    // Switch block
        if (RSwitch_item == 1) {
          f = 1.65;
          translate([ - 45, 30, 5])
            cube([30.2*f, 22*f, 10], center = true);
        }
    // Fuse block
        if (RFuse_item == 1) {
          f = 1.5;
          translate([ - 45, 0, 5])
            intersection() {
              cylinder(d = 16.13*f, h = 10, center = true);
              cube([16.13*f, 13.97*f, 10], center = true);
            } //in
        }
      } //un
      
    // Fan hole
  if (RFan_Grill_item == 1) {
      translate([FanPosX + 15, FanPosY, 0])
        cylinder(d = FanDia, h = Shield_thickness + 0.001, center = true);
  }    
    // Plug hole
    if (RPlug_item == 1) {
      translate([ - 45, -30, 0]) {     
        rounded_polig6(trapezoid_vertex(27.5, 19.5, 14, 12.5), 20, 2);
      translate([ - 20, 0, 0])     
        cylinder(d = 3.5, h = 5*panel_thick + 0.001, center = true, $fn = Resolution);
      translate([20, 0, 0])     
        cylinder(d = 3.5, h = 5*panel_thick + 0.001, center = true, $fn = Resolution);
      // screws holes
      translate([20, 0, 10 - 3])
        rotate([0, 0, 30])     
          cylinder(d = M3_dia, h = 4, $fn = 6);
      translate([ - 20, 0, 10 - 3])
        rotate([0, 0, 30])     
          cylinder(d = M3_dia, h = 4, $fn = 6);
     } //tr
   }

    // Switch hole
    if (RSwitch_item == 1) {
    translate([ - 45, 30, 0])
      cube([30.2, 22, 5*panel_thick + 0.001], center = true);
    translate([ - 45, 30, 4])
      cube([30.2 + 4, 22 + 4, 6 + 0.001], center = true);
    }
  // Fuse hole
  if (RFuse_item == 1) {
 translate([ - 45, 0, 0])
    intersection() {
      cylinder(d = 16.13, h = 5*panel_thick + 0.001, center = true);
      cube([16.13, 13.97, 5*panel_thick + 0.001], center = true);
    } //in
  translate([ - 45, 0, 3])
    intersection() {
      cylinder(d = 16.13 + 6, h = 6, center = true);
      cube([16.13+6, 13.97, 5*panel_thick + 0.001], center = true);
    } //in
  }
  } //di

  if (RFan_Grill_item == 1) {
    translate([FanPosX + 15, FanPosY, -panel_thick/2])
      rotate([0, 0, 0])    
        Fan_grille(fan_active = 1, plate_thickness = panel_thick); 
  }
  else 
  if (RHexagonal_grid_item == 1) {
    translate([FanPosX + 15, FanPosY, 0])
      rotate([0, 0, 30])    
        intersection() {
//    rounded_polig6(hexagon_vertices(r = 40), Shield_thickness + 0.001, 5);
          cylinder(d = FanDia, h = Shield_thickness + 0.001, center = true);
          hexagonal_grid([FanDia, FanDia, Shield_thickness], rear_hexagon_diameter, rear_hexagon_thickness);
        } //in
    }
  } //ro
echo("---> END REAR PANEL"); 
} //mo



// * PILLARS
// - BPILLAR
module Bpillar(pillar_height, ext_diameter, int_diameter, base_hole_diameter, base_hole_height, pillar_Fillet) {
    translate([0, 0, 0])
     difference() {
        cylinder(d = ext_diameter + pillar_Fillet, h = pillar_height + Shield_thickness, $fn=Resolution);
        rotate_extrude($fn = Resolution) {
          translate([(ext_diameter + pillar_Fillet * 2)/2, pillar_Fillet + Shield_thickness, 0]) {
            minkowski() {
              square(Box_Height/2);
              circle(pillar_Fillet, $fn=Resolution);
            }
          }
        }
    cylinder(d = int_diameter, h = pillar_height + Shield_thickness, $fn = Resolution);
    color("red") 
      translate([0, 0, 0])
        cylinder(d = base_hole_diameter, h = base_hole_height, $fn = Resolution);
    }
}

// - TPILLAR
module Tpillar(pillar_height, ext_diameter, int_diameter, base_hole_diameter, base_hole_height, Fillet) {
  rotate([0, 0, 0])
     difference() {
        cylinder(d = ext_diameter + pillar_Fillet, h = pillar_height + Shield_thickness, $fn = Resolution);
        rotate_extrude($fn = Resolution) {
          translate([(ext_diameter + pillar_Fillet * 2)/2, pillar_Fillet + Shield_thickness, 0]) {
            minkowski() {
              square(Box_Height/2);
              circle(pillar_Fillet, $fn = Resolution);
            }
          }
        }
    cylinder(d = int_diameter, h = pillar_height + Shield_thickness, $fn = Resolution);
    color("red") 
      translate([0, 0, 0])
        cylinder(d = base_hole_diameter, h = base_hole_height, $fn=Resolution);
    }
}

// - PSFoot 
module PSFoot(pillar_height, ext_diameter, int_diameter, base_hole_diameter, base_hole_height, pillar_Fillet) {
    translate([0, 0, 0])
     difference() {
        cylinder(d = ext_diameter + pillar_Fillet, h = pillar_height + Shield_thickness, $fn = Resolution);
        rotate_extrude($fn = Resolution) {
          translate([(ext_diameter + pillar_Fillet * 2)/2, pillar_Fillet + Shield_thickness, 0]) {
            minkowski() {
              square(Box_Height/2);
              circle(pillar_Fillet, $fn = Resolution);
            }
          }
        }
    cylinder(d = int_diameter, h = pillar_height + Shield_thickness, $fn = Resolution);
    color("red") 
      translate([0, 0, 0])
        cylinder(d = base_hole_diameter, h = base_hole_height + Shield_thickness, $fn = Resolution);
    }
}

// * VENTILATION FLAKE

module hex_cell(d, t, h) { //diameter, thick, height
  difference() {
    cylinder(d = d + t, h = h, center = true, $fn = 6);
    cylinder(d = d, h = h + 0.001, center = true, $fn = 6);
  } //di
  difference() {
  rounded_polig6(hexagon_vertices(r = (d + t)/2), height = h, radius = d/12);
  rounded_polig6(hexagon_vertices(r = d/2), height = h, radius = d/12);
  } //di
} //mo


module out_tricell(diameter, thickness, height) {
  translate([-(diameter + thickness) * cos(60), -(diameter + thickness)*sin(60), 0])
    hex_cell(d = diameter, t = thickness, h = height);
  translate([-(diameter + thickness) * cos(60), (diameter + thickness)*sin(60), 0])
    hex_cell(d = diameter, t = thickness, h = height);
  translate([(diameter + thickness) * 2*cos(60), 0, 0])
    hex_cell(d = diameter, t = thickness, h = height);
} //mo


module tricell(diameter, thickness, height) {
  translate([-(diameter + thickness)/2 * cos(60), -(diameter + thickness)/2*sin(60), 0])
    hex_cell(d = diameter + 0.001, t = thickness, h = height);
  translate([-(diameter + thickness)/2 * cos(60), (diameter + thickness)/2*sin(60), 0])
    hex_cell(d = diameter + 0.001, t = thickness, h = height);
  translate([(diameter + thickness) * cos(60), 0, 0])
    hex_cell(d = diameter + 0.001, t = thickness, h = height);
} //mo


module ventilation_flake(diameter, thickness, height) {
echo("START VENTILATION FLAKES ..."); 
  intersection() {
    cylinder(d = 2*(diameter + thickness)+ thickness, h = height, center = true, $fn = 6);
    union() {
      tricell(diameter, thickness, height);
      rotate ([0, 0, 60]) 
        tricell(diameter, thickness, height);
      out_tricell(diameter, thickness, height);
      rotate ([0, 0, 60]) 
        out_tricell(diameter, thickness, height);
      hex_cell(d = 2*(diameter + thickness), t = thickness, h = height);
    } //un
    rounded_polig6(hexagon_vertices(r = (diameter + thickness)+ thickness/2), height = height, radius = ((diameter + thickness)+ thickness/2)/6);
  } //di
echo("---> END VENTILATION FLAKES"); 
} //mo


module flake_hole(diameter, thickness, height) {
    rounded_polig6(hexagon_vertices(r = (diameter + thickness)+ thickness/2), height = height, radius = ((diameter + thickness)+ thickness/2)/6);
} //mo

// * END OF VENTILATION FLAKE


//---------------------------------------------------------------
//-- SANDBOX
//---------------------------------------------------------------


//    panel_height = Box_Height -2*Shield_thickness - m;
//    panel_length = Box_Width - 2*Shield_thickness - m;
//    panel_thickness = Shield_thickness - m;

//translate([00,00, 0]) FPanel();
//        SquareHole  (1, -68, -20, 15, 10, 1); //(On/Off, Xpos, Ypos, Length, Width, Fillet)
//union() { 
    //rotate([90, 0, 0])
//color("red")        rounded_polig4(panel_thickness, panel_length, panel_height, Fillet);
    
//    translate([0, 0, 0 ])
//                     <- Cutting shapes from here ->  
 //  color("white")  SquareHole  (1, 0, 0, 15, 15, 1);
 //  cube(20,20); //(On/Off, Xpos, Ypos, Length, Width, Fillet)

//}
/*
translate([00,00, 0]) FPanel();
  color("white")      SquareHole  (1, -68, -20, 15, 10, 1); //(On/Off, Xpos, Ypos, Length, Width, Fillet)
*/
// - Tolérance - Tolerance (Panel/rails gap)
//flake_dia = 10;
//flake_thick = 1;
//flake_height = 5;

  //color ("red") translate([ - Box_Width/2, Box_Length/4, 0])
    //rotate([0, 90, 0]) ventilation_flake(diameter = flake_dia, thickness = flake_thick, height = flake_height);

