// HO scale water tower, based on stucture on E. 94th st, NYC

///*
full_tank();   // leave this uncommented to render a full tank
               // note that to print sucessfully you will need to use the 
               //    current color variable to separate out the various sub-assemblies
               //    or if you wish you can comment out 'full_tank()' 
               //    and uncomment other pieces below.

// Top level parts
//translate([0,0,0]) tank();        // just the tank object with body and bands
//translate([0,0,scale]) top();     // the tank top
//translate([0,0,0]) tank_base(1);  // 0=no deck, 1=partial deck, 2=half deck, 3=full deck
//rotate([180,0,0]) combined_supports(base,xb); // produces the full support assembly
    // 1st param: 0=no base, 1=add full sub_base, 2=flat base plate   
    // 2nd param: # of middle crossbars, 0, 1, 2, or 3
lprint = false;
//lprint = true;   // set to true to allow easy printing of ladders
//ladder_print();  // prints two of each kind of ladder with support pads

//piping();
//sub_base();
//*/

// scale in use by # of mm to a foot
scale = 3.5; 
//Diameter in feet, reasonable numbers are 6-25
tank_diameter = 14; 
td = tank_diameter * scale;  // shorten variable for prog. use
// % to scale tank/base height-adjust for desired proportions, > = taller
scale_factor = .250;
sf = scale_factor; // shorten for prog. use
          // tank height will be echoed when you render
// number of bays with angled crosspieces- 0,1,2, or 3
cross_bars = 2; //[0,1,2,3]
xb = cross_bars;
// deck type- 0-none,1-partial,2-half,3-full
deck = 1; // [0,1,2,3]
// base type - 0-none,1-full girder, 2- simple plate
bottom_base = 1; // [0,1,2]
// layer height setting in printer, in mm
layer_height = .15;
lh = layer_height; 
// number of layers in wire band (2 or 3), if 3 can be rounded
nlb = 3; 
wh = lh*nlb; // height of wire bands, should be multiple of layer height
//wire offset- how far out the wire band sticks
wo = .50; 
//the number of vertical boards in the tank
number_of_boards_in_tank = 64;
ntb = number_of_boards_in_tank;
// check if you want to deliniate between boards, takes a long time to render
tank_boards_groove = true;
nb = 13*1; // number of wire bands around tank max 15 (currently doesn't automaticall adjust, see comments)
start = scale/2; // starting (smallest) band, scale/2 = 6 inches
t1 = start*sf;              // gradually increasing distance between bands
t2 = (start*2*sf)+0;       // 
t3 = (start*3*sf)+t2;       //
t4 = (start*4*sf)+t3;
t5 = (start*5*sf)+t4;
t6 = (start*6*sf)+t5;
t7 = (start*7*sf)+t6;
t8 = (start*8*sf)+t7;
t9 = (start*9*sf)+t8;
t10 = (start*10*sf)+t9;
t11 = (start*11*sf)+t10;
t12 = (start*12*sf)+t11;
t13 = (start*13*sf)+t12;
t14 = (start*14*sf)+t13;
t15 = (start*15*sf)+t14;
t16 = (start*16*sf)+t15;
th = t13;           // assign to the number of bands desired


//adj = th;
// Find angles for crosspieces
opp1 = ((.89-.5)/2)*td;
sup_angle1 = atan(opp1/th);  // angle for main vertical crosspieces
bh = cos(sup_angle1)*(th+(t13-t12)+scale);
ro = sin(sup_angle1)*(td*.25);
//bb = th/th;
echo("Tank diameter =",td," Tank height= ",th+t13-t12+scale,"Supports height",bh," in mm");
echo("Tank diameter =",tank_diameter," Tank height= ",(th+t13-t12+scale)/3.5,"Supports height",bh/3.5," in scale feet");

$fn = 56*1;  // default curvature for cylinders

/* Make an array of colors so they can be assigned as variables, adjust as needed
0-all colors, 1-white,    2-gray,     3-red,      4-orange,
5-yellow,     6-green,    7-blue,     8-purple,   9-brown,   
10-black,    11-silver,  12-beige,   13-lgtBlue, 14-darkBrown "#654321",
15-drkGray   16=maroon   17-saddleBrn18-Tan,     19-Olive  
20-lgtGray   21-dimGray  22-gainsboro*/

colors = concat(["ALL",               "White",      "Gray",       "Red",          "Orange",   
          "Yellow",         "Green",      "Blue",       "Purple",       "Brown",
          "Black",          "Silver",     "Beige",      "LightBlue",    "#654321",
          "DarkSlateGray",  "Maroon",     "SaddleBrown","Tan",          "Olive",],
          "LightGray",      "DimGray",    "Gainsboro"  ,[]); 
// don't show in customize

//Set colors for each part of wall
tbody_clr = colors[22];    // tank bocy color Gainsboro - 22
band_clr = colors[14];    // tank band color Dark brown - 14
top_clr = colors[18];      // tank top color Tan - 18
base_clr = colors[21];    // tank base color DimGray - 21
deck_clr = colors[12];    // tank deck color Beige- 12
rail_clr = colors[17];    // tank rail color SaddleBrown-17
support_clr = colors[15]; // tank support color DarlS;ateGray - 15
pipe_clr = colors[11];    // piping color Silver - 16
ladder_clr = colors[10];  // ladder color Black - 10;

// For modules that have multhple colors, use the method below to generate 
//  a separate stl for each color, requires color assignment for each desired part
// Pick a color below for STL export, or "ALL" to show all colors.
//all_clr = colors[0]; // don't show in customize

//select colors for different parts of the model as separate stl files, combine in slicer for multicolor  
current_color = "ALL"; //["ALL","Gainsboro","#654321","Tan","DimGray","Beige","SaddleBrown","DarkSlateGray","Silver","Black"]
//current_color = tbody_clr;
//current_color = band_clr;
//current_color = top_clr;
//current_color = base_clr;
//current_color = deck_clr;
//current_color = rail_clr;
//current_color = support_clr;

//current_color = "white";
//current_color = "gray";
//current_color = "red";
//current_color = "orange";
//current_color = "yellow";
//current_color = "green";
//current_color = "blue";
//current_color = "purple";
//current_color = "brown";
//current_color = "black";
//current_color = "Silver";
//current_color = "beige";

// untranslated/rotated individual modules for testing purposes
//tank(); 
//top();
//tank_base();
//rotate([0,0,0]) tank_base();
//gussett(scale*2, scale*.33, -sup_angle1);
//translate([10,0,0]) gussettf(scale*2, scale*.33, -sup_angle1);
//deck_trapezoid();
//mathng_plate();
//base_plate();
//sub_base();
//rotate([180,0,0]) supports(1,0,2);  // full individual support-arg1-type-0 no corner pieces, 1-full
                  // arg2- combined or individual, arg3=number of interior bays
//translate([0,0,td]) supports(1,0);
//translate([td*.8,0,td*2]) rotate([0,180,0]) supports(0,0);
//translate([td*.8,0,td]) rotate([0,180,0]) supports(0,0);

module tank() {   //tank segments- verthcal wood slats and contrasthng color wire bands
    translate([0,0,-t1]) {      // lower by first t value -puts bottom center on the origin
        //tank_band(0,t1);      // comment out these lines for fewer bands
        tank_band(t2,t2-t1);
        tank_band(t2,t3-t2);
        tank_band(t3,t4-t3);
        tank_band(t4,t5-t4);
        tank_band(t5,t6-t5);
        tank_band(t6,t7-t6);
        tank_band(t7,t8-t7);
        tank_band(t8,t9-t8);
        tank_band(t9,t10-t9);
        tank_band(t10,t11-t10);
        tank_band(t11,t12-t11);
        tank_band(t12,t13-t12);
        tank_band(t13,t14-t13);
        //tank_band(t13,t15-t14);  //uncomment for more bands
        //tank_band(t13,t16-t15);
        multicolor(tbody_clr) translate([0,0,t14-5]) color(tbody_clr) 
            cylinder(h = 9.5, d = 4.5);  //peg to fit roof
        }
}

module tank_base(deck) {
    multicolor(base_clr) color(base_clr) {
        // long support beams
        if (deck == 0) {
            longbeaml =  td*.94;
            longbeamc = td*.94;
            translate([-td/2+scale*.25,td*.25-.33*scale,0]) 
                ibeaml(longbeaml,.67*scale,scale);  //main long beam
            translate([-td/2+scale*.25,-td*.25-.33*scale,0]) 
                ibeaml(longbeaml,.67*scale,scale);  //main long beam
            translate([td*.23,-td*.47,0])
                ibeamc(.67*scale,longbeamc,scale);  //long cross beam
            translate([td*-.27,-td*.47,0]) 
                ibeamc(.67*scale,td*.94,scale);  // short cross beam  
            translate([0,0,scale*.67]) 
                cylinder(h=4+scale*.33,d=4.5, $fn=24);            }
        else if (deck == 1) {
            longbeaml =  td+scale*2.0;
            longbeamc = td+scale*5;
            translate([-td/2+scale*.25,td*.25-.33*scale,0]) 
                ibeaml(longbeaml,.67*scale,scale);  //main long beam
            translate([-td/2+scale*.25,-td*.25-.33*scale,0]) 
                ibeaml(longbeaml,.67*scale,scale);  //main long beam
            translate([td*.23,-td/2-scale*2.5,0])
                ibeamc(.67*scale,longbeamc,scale);  //long cross beam
            translate([td*-.27,-td*.47,0]) 
                ibeamc(.67*scale,td*.94,scale);  // short cross beam
            }
        else if (deck == 2) {
            longbeaml =  td+scale*2.0;
            longbeamc = td+scale*5;
            translate([-td/2+scale*.25,td*.25-.33*scale,0]) 
                ibeaml(longbeaml,.67*scale,scale);  //main long beam
            translate([-td/2+scale*.25,-td*.25-.33*scale,0]) 
                ibeaml(longbeaml,.67*scale,scale);  //main long beam
            translate([td*.23,-td/2-scale*2.5,0])
                ibeamc(.67*scale,longbeamc,scale);  //long cross beam
            translate([td*-.27,-td/2-scale*2.5,0]) 
                ibeamc(.67*scale,longbeamc,scale);  // short cross beam
            }
        else if (deck == 3) {
            longbeaml =  td+scale*5.0;
            longbeamc = td+scale*5;
            translate([-td*.5-scale*2.5,td*.25-.33*scale,0]) 
                ibeaml(longbeaml,.67*scale,scale);  //main long beam
            translate([-td*.5-scale*2.5,-td*.25-.33*scale,0]) 
                ibeaml(longbeaml,.67*scale,scale);  //main long beam
            translate([td*.23,-td/2-scale*2.5,0])
                ibeamc(.67*scale,longbeamc,scale);  //long cross beam
            translate([td*-.27,-td/2-scale*2.5,0]) 
                ibeamc(.67*scale,longbeamc,scale);  // short cross beam
            }
        // inner beams, same for all types
        translate([-td*.25,td*.05-.33*scale,0]) 
            ibeaml(td*.50,.67*scale,scale);  //inner beam 1
        translate([-td/4,-td*.05-.33*scale,0]) 
            ibeaml(td*.50,.67*scale,scale); //inner beam 2
        translate([td*.05-.33*scale,-td/4,0]) 
            ibeamc(.67*scale,td*.5,scale);   //inner cross beam 1
        translate([td*-.05-.33*scale,-td/4,0]) 
            ibeamc(.67*scale,td*.5,scale);  //inner cross beam 2
        translate([td*-.030,td*-.030,scale*.67]) 
            cube([td*.10,td*.10,scale*.3]); //tank index block
        }
    if (deck > 0){
        // deck support beams
         multicolor(base_clr) color(base_clr) {    
            translate([td*.5+scale*2,-td/4,0]) 
                ibeamo(.25*scale,td*.5,scale);  //deck support beam 1
            translate([td*.5,-td/4,0]) 
                ibeamo(.25*scale,td*.5,scale);  //deck support beam 2
            translate([td*.5+scale*2.09,td*.255,0]) rotate([0,0,46.7])
                ibeamo(.25*scale,(td*.25+scale*1.92)*1.414,scale);  //right side deck support beam 1
            translate([td*.5,td*.25,0])  rotate([0,0,46.7 ])
                ibeamo(.25*scale,td*.36,scale);  //right side deck support beam 2
            mirror([0,1,0]) translate([td*.5+scale*2.09,td*.255,0]) rotate([0,0,46.7])
                ibeamo(.25*scale,(td*.25+scale*1.92)*1.414,scale);  //left side deck support beam 1
            translate([td*.25,-td*.505,0])  rotate([0,0,-46.5])
                ibeamo(.25*scale,td*.36,scale);  //left side deck support beam 2
            translate([td*.5,scale,0]) cube([scale*2,scale/4,scale]);
            translate([td*.5,-scale-scale/4,0]) cube([scale*2,scale/4,scale]);
            }
        // deck      
        multicolor(deck_clr) color(deck_clr) {
            translate([td*.5,-td*.257,scale]) 
                cube([scale*2.18,td*.25-scale*.9,scale*.2]);  //deck part 1
            mirror([0,1,0]) translate([td*.5,-td*.257,scale]) 
                cube([scale*2.18,td*.25-scale*.9,scale*.2]);  //deck part 1
   
            translate([0,0,scale]) linear_extrude(height = scale*.2) 
                deck_trapezoid();
                //polygon([[td*.658,td*.2585],[td*.658-scale*2.568,td*.2585],[td*.263,td*.495],[td*.263,td*.63]]);
            translate([0,0,scale]) linear_extrude(height = scale*.2) 
                mirror([0,1,0]) deck_trapezoid();
                //polygon([[td*.658,-td*.2585],[td*.658-scale*2.568,-td*.2585],[td*.263,-td*.495],[td*.263,-td*.63]]);
            //deck_trapezoid();
            } // end deck     
        //railings
        multicolor(rail_clr) color(rail_clr) {
            translate([td*.5+scale*2.09,td*.255,scale]) rotate([0,0,46.7])
                ibeamr(.25*scale,(td*.25+scale*1.92)*1.414,scale*1.5);  //right side deck railing beam bot    
            translate([td*.5+scale*2.09,td*.255,scale*2.5]) rotate([0,0,46.7])
                ibeamr(.25*scale,(td*.25+scale*1.92)*1.414,scale*1.5);  //right side deck railing beam top  

            translate([td*.5+scale*2,-td*.265,scale]) 
                ibeamr(.25*scale,td*.525,scale*1.5);  //deck railing beam bot
            translate([td*.5+scale*2,-td*.265,scale*2.5]) 
                ibeamr(.25*scale,td*.525,scale*1.5);  //deck railing beam top

            mirror([0,1,0]) translate([td*.5+scale*2.09,td*.255,scale]) rotate([0,0,46.7]) 
                ibeamr(.25*scale,(td*.25+scale*1.92)*1.414,scale*1.5);  //left side deck railing beam bot
            mirror([0,1,0]) translate([td*.5+scale*2.09,td*.255,scale*2.5]) rotate([0,0,46.7])
                ibeamr(.25*scale,(td*.25+scale*1.92)*1.414,scale*1.5);  //left side deck railing beam top
            translate([0,0,scale*0.90]) 
                cylinder(h=3.5+scale*.25,d=4.5, $fn=24);            
            }
        }
        if (deck > 1) {
            multicolor(deck_clr) translate([-td*.25,-td*.5-scale*2.0,scale]) 
                color(deck_clr) cube([td*.5,scale*1.95,scale*.2]);  //deck part 1
            multicolor(deck_clr) mirror([0,1,0]) translate([-td*.25,-td*.5-scale*2,scale]) 
                color(deck_clr) cube([td*.5,scale*1.95,scale*.2]);  //deck part 1
            
            multicolor(rail_clr) translate([-td*.265,td*.5+scale*2,scale]) rotate([0,0,270]) 
                color(rail_clr) ibeamr(.25*scale,td*.525,scale*1.5);  //deck railing beam bot
            multicolor(rail_clr) translate([-td*.265,td*.5+scale*2,scale*2.5]) rotate([0,0,270]) 
                color(rail_clr) ibeamr(.25*scale,td*.525,scale*1.5);  //deck railing beam top
            multicolor(base_clr) translate([-td/4,td*.5+scale*2,0]) rotate([0,0,270])
                color(base_clr) ibeamo(.25*scale,td*.5,scale);  //deck support beam 1    
            multicolor(base_clr) translate([-td/4,td*.5,0]) rotate([0,0,270])
                color(base_clr) ibeamo(.25*scale,td*.5,scale);  //deck support beam 1      
            mirror([0,1,0]) {
                multicolor(rail_clr) translate([-td*.265,td*.5+scale*2,scale]) rotate([0,0,270]) 
                    color(rail_clr) ibeamr(.25*scale,td*.525,scale*1.5);  //deck railing beam bot             
                multicolor(rail_clr) translate([-td*.265,td*.5+scale*2,scale*2.5]) rotate([0,0,270]) 
                    color(rail_clr) ibeamr(.25*scale,td*.525,scale*1.5);  //deck railing beam top
                multicolor(base_clr) translate([-td/4,td*.5+scale*2,0]) rotate([0,0,270])
                    color(base_clr) ibeamo(.25*scale,td*.5,scale);  //deck support beam 1    
                multicolor(base_clr) translate([-td/4,td*.5,0]) rotate([0,0,270])
                    color(base_clr) ibeamo(.25*scale,td*.5,scale);  //deck support beam 1   
                }
            }
        if (deck > 2) {
        mirror([1,0,0]) {
            multicolor(base_clr) color(base_clr) {
                translate([td*.5+scale*2,-td/4,0]) 
                ibeamo(.25*scale,td*.5,scale);  //deck support beam 1
            translate([td*.5,-td/4,0]) 
                ibeamo(.25*scale,td*.5,scale);  //deck support beam 2
            translate([td*.5+scale*2.09,td*.255,0]) rotate([0,0,46.7])
                ibeamo(.25*scale,(td*.25+scale*1.92)*1.414,scale);  //right side deck support beam 1
            translate([td*.5,td*.25,0])  rotate([0,0,46.7 ])
                ibeamo(.25*scale,td*.36,scale);  //right side deck support beam 2
            mirror([0,1,0]) translate([td*.5+scale*2.09,td*.255,0]) rotate([0,0,46.7])
                ibeamo(.25*scale,(td*.25+scale*1.92)*1.414,scale);  //left side deck support beam 1
            translate([td*.25,-td*.505,0])  rotate([0,0,-46.5])
                ibeamo(.25*scale,td*.36,scale);  //left side deck support beam 2
            }
        
            multicolor(deck_clr) color(deck_clr) {
                translate([td*.5,-td*.257,scale]) 
                    cube([scale*2.18,td*.51,scale*.2]);  //deck
                translate([0,0,scale]) linear_extrude(height = scale*.2) 
                    deck_trapezoid();
                //polygon([[td*.658,td*.2585],[td*.658-scale*2.568,td*.2585],[td*.263,td*.495],[td*.263,td*.63]]);
                translate([0,0,scale]) linear_extrude(height = scale*.2) 
                mirror([0,1,0]) deck_trapezoid();
                //polygon([[td*.658,-td*.2585],[td*.658-scale*2.568,-td*.2585],[td*.263,-td*.495],[td*.263,-td*.63]]);
                //deck_trapezoid();
                }
        
            //railings
            multicolor(rail_clr) color(rail_clr) {
                translate([td*.5+scale*2.09,td*.255,scale]) rotate([0,0,46.7])
                    ibeamr(.25*scale,(td*.25+scale*1.92)*1.414,scale*1.5);  //right side deck railing beam bot    
                translate([td*.5+scale*2.09,td*.255,scale*2.5]) rotate([0,0,46.7])
                    ibeamr(.25*scale,(td*.25+scale*1.92)*1.414,scale*1.5);  //right side deck railing beam top  

                translate([td*.5+scale*2,-td*.265,scale]) 
                    ibeamr(.25*scale,td*.525,scale*1.5);  //deck railing beam bot
                translate([td*.5+scale*2,-td*.265,scale*2.5]) 
                    ibeamr(.25*scale,td*.525,scale*1.5);  //deck railing beam top

                mirror([0,1,0]) translate([td*.5+scale*2.09,td*.255,scale]) rotate([0,0,46.7]) 
                    ibeamr(.25*scale,(td*.25+scale*1.92)*1.414,scale*1.5);  //left side deck railing beam bot
                mirror([0,1,0]) translate([td*.5+scale*2.09,td*.255,scale*2.5]) rotate([0,0,46.7])
                    ibeamr(.25*scale,(td*.25+scale*1.92)*1.414,scale*1.5);  //left side deck railing beam top
                }
            }
        }
}
    
module top() {
    ttd = td+(8*wo); ttth = td/20; tth = t15/4;
    tangle = atan((tth*2.0)/ttd);               // do some trig to get angles
    sdiv = 7;
    hw = td/sdiv;
    //echo(tangle);
    multicolor(top_clr) translate([0,0,th])  
        color(top_clr) difference() {
            cylinder(d1 = ttd, d2 = ttth, h = tth, $fn = 24);  // top piece
            cylinder(d = 5, h = 5, $fn = 48);                  // hole for peg from tank
            }
    multicolor(top_clr) color(top_clr) { 
        translate([0,0,th+tth*.7250])
            cylinder(d1 = td*.353, d2 = td*.010, h = t15*.08, $fn = 8);    
        translate([0,0,th+th/5]) cylinder(d1 = td/8, d2 = 0, h = t15/5, $fn = 4);    

    // hatch
    if ( hw > scale*2 ) {
        hw = scale*2;
        translate([td*.35,-td/(2*sdiv),th*1.12]) rotate([0,tangle,0]) cube([hw,hw,scale*.20]);
        }
    else translate([td*.35,-td/(2*sdiv),th*1.12]) rotate([0,tangle,0]) cube([hw,hw,scale*.20]);

    }
}

module supports(type,combined,xpieces) {   // type- full or partial, combined- for printing as one unit
    
    abth = scale*.40; // thickness of angle beam pieces, if too small won't print
 
    multicolor(support_clr) color(support_clr) {
        if (type == 1) {
        //long angled beams
            translate([-td*.25,-td*.25,0]) rotate([0,-sup_angle1,0]) 
                abeamu(scale*.5,scale*.5,bh*1.05);   // support angle beam pointing up
            translate([td*.25,-td*.25,0]) rotate([sup_angle1,0,90]) 
                abeamu(scale*.5,scale*.5,bh*1.05);   // support angle beam pointing up   
            }
        else {
            translate([-td*.25,-td*.25,0]) rotate([0,-sup_angle1,0]) 
                cube([scale*.5,scale*.125,bh*1.05]);   // support angle beam pointing up
            translate([td*.25,-td*.25,0]) rotate([sup_angle1,0,90]) 
                cube([scale*.125,scale*.5,bh*1.05]);   // support angle beam pointing up 
            
        }
        //horizontal beams
        difference() {
            union() {
                translate([-td*.445,-td*.25,bh+scale*.33 ]) rotate([-90,0,0]) 
                    abeamh(td*.89,scale*.5,scale*.5);   // support angle beam at bottom
                translate([-td*.25,-td*.25,0]) 
                    abeamh(td*.5,scale*.5,scale*.5);   // support angle beam at top
        
                //small angled crosspieces
                if ( xpieces == 1 ) {
                        opp2=bh*0.90;            //  opp. side-distance between horizontal pieces, same as height
                        adj2=td*(.65-.052);         // length of adjacent side
                        sup_angle2 = atan(adj2/opp2); // angle for bottom crosspieces
                        bl2 = opp2/cos(sup_angle2)*1.09;
                         translate([-td*.25,-td*.25,scale*.33]) rotate([0,sup_angle2,0]) 
                            abeamu(abth,abth,bl2);   // support angle #1 right (top)
                        translate([td*.25,-td*.25,scale*.33]) rotate([0,0,90]) rotate([-sup_angle2,0,0]) 
                            abeamu(abth,abth,bl2);   // support angle #1 left                          

                    }
                if ( xpieces == 2 ) {
                        opp2=bh*.5;               // distance between horizontal pieces, same for both sets
                        adj2=td*(.65-.065);
                        sup_angle2 = atan(adj2/opp2); // angle for bottom horizonal crosspieces
                        bl2 = opp2/cos(sup_angle2)*1.00; // crossbeam lenght (hypotenuse)
                        //bl2 = sqrt(adj2*adj2+opp2*opp2);
                        //echo(bl2,opp2/cos(sup_angle2));
                        adj4=td*(.84-.065);
                        sup_angle4 = atan(adj4/opp2); // angle for top horizontl 3 crosspieces
                        bl4 = opp2/cos(sup_angle4)*1.00;
                        translate([-td*.295 ,-td*.25,bh*.5+scale*.33 ]) rotate([-90,0,0]) 
                            abeamh(td*.63,scale*.5,scale*.5);   // support angle beam one up
                    
                        translate([-td*.25,-td*.25,scale*.33]) rotate([0,sup_angle2,0]) 
                            abeamu(abth,abth,bl2);   // support angle #1 right (top)
                        translate([td*.25,-td*.25,scale*.33]) rotate([0,0,90]) rotate([-sup_angle2,0,0]) 
                            abeamu(abth,abth,bl2);   // support angle #1 left   
                        translate([-td*.305,-td*.25,bh*.5+scale*.67]) rotate([0,sup_angle4,0]) 
                            abeamu(abth,abth,bl4);    // support angle #3 right
                        translate([td*.305,-td*.25,bh*.5+scale*.33]) rotate([0,0,90]) rotate([-sup_angle4,0,0])
                            abeamu(abth,abth,bl4); // sprt ang #3 left (bottom)
                    
                        translate([td*.335,-td*.25+scale*.25,bh*.5]) rotate([0,0,0]) // 2nd top left
                            mirror([0,0,1]) gussettf(scale*2, scale*.33,180-sup_angle1 ); 
                        mirror([1,0,0]) translate([td*.335,-td*.25+scale*.25,bh*.5]) rotate([0,0,0]) // 2nd top right
                            gussettf(scale*2, scale*.33,180+sup_angle1); 

                }
 
                if ( xpieces == 3 ) {
                        opp2=bh*.333;               // distance between horizontal pieces, same for all 3 sets
                        adj2=td*(.62-.065);
                        sup_angle2 = atan(adj2/opp2); // angle for bottom horizontl 3 crosspieces
                        adj3=td*(.76-.065);
                        sup_angle3 = atan(adj3/opp2); // angle for middle horizontl 3 crosspieces
                        adj4=td*(.89-.065);
                        sup_angle4 = atan(adj4/opp2); // angle for top horizontl 3 crosspieces
                    
                    translate([-td*.37,-td*.25,bh*.667+scale*.33 ]) rotate([-90,0,0]) 
                        abeamh(td*.74,scale*.5,scale*.5);   // support angle beam one up
                    translate([-td*.305,-td*.25,bh*.333+scale*.33 ]) rotate([-90,0,0]) 
                        abeamh(td*.610,scale*.5,scale*.5);   // support angle beam two up
                   
                    translate([-td*.25,-td*.25,scale*.33]) rotate([0,sup_angle2,0]) 
                        abeamu(abth,abth,opp2/cos(sup_angle2)*.94);   // support angle #1 right (top)
                    translate([td*.25,-td*.25,scale*.33]) rotate([0,0,90]) rotate([-sup_angle2,0,0]) 
                        abeamu(abth,abth,opp2/cos(sup_angle2)*.94);   // support angle #1 left   
                    translate([-td*.30,-td*.25,bh*.333+scale*.33]) rotate([0,sup_angle3,0]) 
                        abeamu(abth,abth,opp2/cos(sup_angle3)*.96);   // support angle #2 right
                    translate([td*.30,-td*.25,bh*.333+scale*.33]) rotate([0,0,90]) rotate([-sup_angle3,0,0]) 
                        abeamu(abth,abth,opp2/cos(sup_angle3)*.96);    // support angle #2 left
                    translate([-td*.375,-td*.25,bh*.667+scale*.33]) rotate([0,sup_angle4,0]) 
                        abeamu(abth,abth,opp2/cos(sup_angle4)*.975);    // support angle #3 right
                    translate([td*.375,-td*.25,bh*.667+scale*.33]) rotate([0,0,90]) rotate([-sup_angle4,0,0])
                        abeamu(abth,abth,opp2/cos(sup_angle4)*.975); // sprt ang #3 left (bottom)
                    
                    //  gussetts
                    translate([td*.305,-td*.25+scale*.25,bh*.335]) rotate([0,0,0]) // 2nd top left
                        mirror([0,0,1]) gussettf(scale*2, scale*.33,180-sup_angle1 ); 
                    translate([td*.374,-td*.25+scale*.25,bh*.673]) rotate([0,0,0]) // 3rd top
                        gussettf(scale*2, scale*.33, 180+sup_angle1); 
                    //translate([td*.422,-td*.25+scale*.0825,bh*1.01]) rotate([0,0,0]) // bottom
                        //gussett(scale*2, scale*.33, -sup_angle1);
                    mirror([1,0,0]) translate([td*.305,-td*.25+scale*.25,bh*.335]) rotate([0,0,0]) // 2nd top right
                        gussettf(scale*2, scale*.33,180+sup_angle1); 
                    mirror([1,0,0]) translate([td*.374,-td*.25+scale*.25,bh*.673]) rotate([0,0,0]) // 3rd top right 
                        gussettf(scale*2, scale*.33,180+sup_angle1); 

                    }
                }  
                
                if (!combined) {
                    if (type==1) {                                                     // make space for perp. uprights
                        translate([-td*.320,-td*.25,-td*.01]) rotate([0,-sup_angle1,0])   
                            translate([scale*1.02,scale*.19,0]) cube([scale*.5,scale*.35,bh*1.03]);
                        translate([td*.324,-td*.25,-td*.01]) rotate([sup_angle1,0,90])
                            translate([0,scale,0]) cube([scale*.5,scale*.55,bh*1.04]);
                    } else {                                                            // space for perp. uprights
                        translate([-td*.385+scale*.37,td*.25,-td*.05]) rotate([0,-sup_angle1*.94,0])
                        translate([scale,-td*.5+scale*.125,0]) cube([scale*.75,scale*.5,bh*1.18]);
                        translate([td*.294+scale*.25,-td*.05,td*.005]) rotate([sup_angle1*.97,0,90])
                            translate([-td*.195,scale*.40,-td*.05]) cube([scale*.5,scale*.75,bh*1.18]);                    
                    }
                }
            }
           
        translate([-td*.462,-td*.25+scale*.25,bh*1.005])  // bottom right
            gussett(scale*2, scale*.33, -sup_angle1); 
        mirror([1,0,0]) translate([-td*.462,-td*.25+scale*.25,bh*1.005])  // bottom left
            gussett(scale*2, scale*.33, -sup_angle1);   
        
        
        mirror([0,0,0]) translate([-td*.250,-td*.25+scale*.001,+bh*.005]) rotate([180,0,0]) //top left
            gussett(scale*2, scale*.33, sup_angle1); 
        mirror([1,0,0]) translate([-td*.250,-td*.25+scale*.001 ,+bh*.005]) rotate([180,0,0]) // top right
            gussett(scale*2, scale*.33, sup_angle1); 

    }
}

module combined_supports(sb,xb) {        // sb for printing the whole support structure at once, 
                                         // xb for # of intermediate crossbars 
    //supports(1);
    translate([+td*.01,0,ro]) rotate([sup_angle1,0,90]) supports(1,1,xb);
    translate([-td*.01,0,ro]) rotate([sup_angle1,0,-90]) supports(1,1,xb);
    translate([0,0,ro]) rotate([sup_angle1,0,0]) supports(0,1,xb);
    translate([0,0,ro]) rotate([sup_angle1,0,180]) supports(0,1,xb);
    multicolor(support_clr)  color(support_clr) {
        translate([0,0,bh*.05]) mating_plate();  
        inset = .0910;
        translate([-td/4,td*inset,scale*.25]) cube([td/2,scale/2,scale/4]);  //mating plate under supports
        translate([-td/4,-td*inset-scale/2,scale*.25]) cube([td/2,scale/2,scale/4]);
        translate([td*inset,-td*.245,scale*.25]) cube([scale/2,td*.49,scale/4]);
        translate([-td*inset-scale/2,-td*.245,scale*.25]) cube([scale/2,td*.49,scale/4]);
        }
    //value needs adjusting (sf=.175)- TD8=.002, TD10= .010, 
    multicolor(support_clr) color(support_clr) {  // sub-base
        if (sb == 1) {translate([-td*.5,td*.00,bh*1.0]) 
            sub_base();}
        else if (sb == 2) translate([-td/2,-td/2,bh*1.00+scale*.33]) {  // TD8=1, TD10=.965, TD12=
            base_plate();
            }
        }
    }
    
module ladder(h,t) {
    multicolor(ladder_clr) color(ladder_clr) {
    wm = 1.75; // width multiplier, width in fee
    sdiv = 5; // size divisor, what fraction of a foot will the pieces be
    //lprint = false; // set to true to get support pads for printing on ladders
    if ( lprint ) cube([2.5,scale*1.95,lh*6]); // hold down to be cut off
    difference() {
        cube([h,scale/sdiv,scale/(sdiv*1.0)]);
        //#translate([scale*3.1,-+scale/2+(scale/sdiv)*.5,-scale/8]) cube([scale/2,scale/2,scale]);
    }
    for (i = [scale:scale*1.5:h]) {
        translate([i,0,0]) cube([scale/sdiv,scale*wm,scale/sdiv]);
        }
    difference() {
        translate([0,scale*wm,0]) cube([h,scale/sdiv,lh*6]);
        //#translate([scale*3.1,wm*scale+scale/(sdiv*2),-scale/8]) cube([scale/2,scale/2,scale]);
    }

    if ( lprint ) translate([h-2.5,0,0]) cube([2.5,scale*1.95,lh*4]); // hold down to be cut off
    //optional curved railings on one end
    railings = t;
    if (railings) {
        if ( lprint )   {
            translate([scale*2.10,scale/sdiv,scale*.95]) rotate([90,0,0])
                rrings(sdiv);
            translate([scale*2.09,(wm*scale)+(scale/sdiv),scale*.95]) rotate([90,0,0])
                rrings(sdiv);
            translate([scale*2.09,0,0]) cube([.6,.6,scale*1.75]);   // ring support
            translate([scale*2.09,(wm*scale),0]) cube([.6,.6,scale*1.75]);  // ring support 
            }
        else {
            translate([0,scale/sdiv,scale*.95]) rotate([90,0,0])
                rrings(sdiv);
            translate([0,(wm*scale)+(scale/sdiv),scale*.95]) rotate([90,0,0])
                rrings(sdiv);
            }
        }
    }
}

module ladder_print()
    {
    lprint = true;
    ladder(75,0);  // add 5mm extra length for holddown pads that you will cut off
    translate([0,scale*3,0]) ladder(75,0);  //
    translate([0,-scale*3,0]) ladder(75,1);
    translate([0,scale*6,0]) ladder(75,1);
}
    
module sub_base() {
    td1 = td*0.95;
    td2 = td*1.00;
    translate([0,-td2/2,0]) {
        ibeamlbig(td2,scale,scale*2);    //big xbeam1
        translate([0,td1,0]) ibeamlbig(td2,scale,scale*2);
        abeamv(scale/2,td1+scale/2,scale/2);    // smaller crossbeam top
        translate([0,0,scale*2-scale/2]) abeamv(scale/2,td1+scale/4,scale/2);    //smaller xbeam bot 
        translate([scale*.15,0,scale*2-scale*.125]) cube([scale,td1+scale/4,lh*3]);    //smaller support pad bot 
        translate([td2,0,0]) rotate([0,270,0]) abeamv(scale/2,td1+scale/4,scale/2);    // smaller crossbeam top
        translate([td2,0,scale*2-scale/2]) rotate([0,270,0]) abeamv(scale/2,td1+scale/4,scale/2);    //smaller xbeam bot
        translate([td-scale*1.15,0,scale*2-scale*.125]) cube([scale,td1+scale/4,lh*3]);    //smaller support pad bot 
        }
    abl = sqrt(td1*td1*.25+scale*scale*4)*.97;
    a1 = atan((scale)/(td1*.5));
    translate([0,0,bh*.021]) rotate([a1,0,0]) abeamv(scale/2,abl,scale/2);  // angle beams
    mirror([0,1,0]) translate([0,0,bh*.021]) rotate([a1,0,0]) abeamv(scale/2,abl,scale/2);
    rotate([0,270,0]) translate([bh*.021,0,-td2]) rotate([0,0,360-a1]) abeamv(scale/2,abl,scale/2); // angle beams
    mirror([0,1,0]) rotate([0,270,0]) translate([bh*.021,0,-td2]) rotate([0,0,360-a1]) abeamv(scale/2,abl,scale/2);
    translate([td2/2-scale,td*.625-scale*1.75,scale*2-lh*2]) cube([scale*2,scale*1.75,lh*2]);  //ladder support plate
    translate([0,0,0]) cube([scale*.5,scale*.25,scale*2]);  // small cross beams support 1
    translate([td2-scale*.5,0,0]) cube([scale*.5,scale*.25,scale*2]);  // small cross beams support 1
    translate([0,-td*.2625,scale*.9]) cube([scale*.5,td*.525,scale*.125]);  // small cross beams support 2
    translate([td2-scale*.50,-td*.2625,scale*.9]) cube([scale*.5,td*.525,scale*.125]);  // small cross beams support 2
    }
   
module base_plate() {
    cs = td*.07;    // support cube size
    in1 = td*.005;   // short distance in
    in2 = td-cs-in1;        // long distance in
    difference() {
        cube([td,td,lh*2]); // add a small square base plate
        translate([td*.15,td*.15,-lh]) cube([td*.7,td*.7,lh*4]); // add a small square base plate
        }
    translate([in2,in2,-scale*.35]) cube([cs,cs,scale*.35]);
    translate([in1,in2,-scale*.35]) cube([cs,cs,scale*.35]);
    translate([in2,in1,-scale*.35]) cube([cs,cs,scale*.35]);
    translate([in1,in1,-scale*.35]) cube([cs,cs,scale*.35]);
    translate([td/2-scale,td-scale*0.15,0]) cube([scale*1.75,scale*2,lh*2]);
    }
   
module piping() {
    multicolor(pipe_clr) color(pipe_clr) {
        cylinder(h = bh*1.18, d = scale*1.5);
        translate([0,0,th*1.13]) cylinder(h = th*.1, d = scale*.3);
    }
    multicolor(pipe_clr) color(pipe_clr) cube([td*.24,td*.24,lh*3],center=true);
}

module full_tank() {
    translate([0,0,scale*1.12]) tank();
    translate([0,0,scale+t13-t12]) rotate([0,0,-45]) top();
    translate([0,0,0]) tank_base(deck);  // 0=no deck, 1=partial deck, 2=half deck, 3=full deck
    rotate([180,0,90]) combined_supports(bottom_base,xb);
    if (bottom_base == 1) translate([0,0,-bh-scale*2+lh*2]) piping();
    else if (bottom_base==2) translate([0,0,-bh*1.03-scale*.33]) piping();
    if (deck > 0 ) { 
        translate([td/2,-td/4+scale*2.6,scale*1.75])rotate([0,90,0]) ladder(bh*1.170,0);
        translate([td*.505,-td*.565+scale*2.6,bh*1.05])rotate([180,90,315]) ladder(th*1.175,1);
    }
}

// helper modules    

module tank_band(o1,h1) {  // vertical round tank segments with bands, pass vertical offset and band height
        multicolor(tbody_clr) translate([0,0,o1-wh]) color(tbody_clr) difference() {
            $fn = ntb;
            cylinder(h = h1, d = td);       //main tank body pieces
            //echo(o1,th);
            if (o1<(th*.95)) { cylinder(h=h1*1.25, d = 5, $fn = 24); }  //hole for peg in base
            if (tank_boards_groove) {    // add a small but potentially visible groove between boards
                // adjust the two variables below to get the minimum visible effect
                inset = scale*2; //how far in the groove goes, not very important
                groove_width = lh*.75; // the width of the groove, aims for the smallest distance your slicer will render
                for ( i = [0:360/ntb:360]) {
                    //echo(ntb);
                    rotate([0,0,i]) translate([td*.5-lh*.75,0,0]) cube([inset,groove_width,h1]);
                    }
                }
           }  
        // tank bands
        if ( nlb < 3 ) {
            multicolor(band_clr)translate([0,0,o1]) color(band_clr) difference() {          
                cylinder(h = wh, d = td+wo);
                if (o1<(th*.25)) { cylinder(h = 5, d = 5);}
                }
            }
        else {
            multicolor(band_clr) color(band_clr) {
                translate([0,0,o1])  difference() {          
                    cylinder(h = lh, d = td+wo/2);
                    if (o1<(th*.25)) { cylinder(h = 5, d = 5);}
                    }  
                translate([0,0,o1+lh*1]) difference() {          
                    cylinder(h = lh, d = td+wo);
                    if (o1<(th*.25)) { cylinder(h = 5, d = 5);}
                    }
                translate([0,0,o1+lh*2]) difference() {          
                    cylinder(h = lh, d = td+wo/2);
                    if (o1<(th*.25)) { cylinder(h = 5, d = 5);}
                    }
                }                      
            }   
        }
    
module ibeaml(x,y,z) {   // ibeam lengthwise
    thp = .25;      // % thickness of top and bottom plates
    bwp = .33;      // % 
    translate([0,0,0]) cube([x,y,z*thp]);
    //translate([0,scale*.21,0]) rotate([25,0,0]) cube([x,y*.5,z*thp]);              //slant inside corners
    //translate([0,scale*.34,scale*.21]) rotate([-25,0,0]) cube([x,y*.5,z*thp]);
    translate([0,y*(1-bwp)/2,z*thp]) cube([x,y*bwp,z*(1-2*thp)]);
    translate([0,0,z*(1-thp)]) cube([x,y,z*thp]);
    //translate([0,scale*.05,z-scale*.51]) rotate([-25,0,0]) cube([x,y*.5,z*thp]);              //slant inside corners
    //translate([0,scale*.52,z-scale*.71]) rotate([25,0,0]) cube([x,y*.5,z*thp]);
    }

module ibeamc(x,y,z) {  // ibeam crosswise
    thp = .25;
    bwp = .33;
    translate([0,0,0]) cube([x,y,z*thp]);

    translate([x*(1-bwp)/2,0,z*thp]) cube([x*bwp,y,z*(1-2*thp)]);
    translate([0,0,z*(1-thp)]) cube([x,y,z*thp]);
    }
    
module ibeamo(x,y,z) {  // ibeam with center cutouts
    thp = .25;
    bwp = 1.0;
    translate([0,0,0]) cube([x,y,z*thp]);
    //translate([x*(1-bwp)/2,0,z*thp]) cube([x*bwp,y,z*(1-2*thp)]);
    for (i = [0:x/5.5:x]) {
        //echo("i = ",i);
        translate([x*(1-bwp)/2,i*y,z*thp]) cube([x*bwp,scale*.25,z*(1-2*thp)]);
        }
    translate([0,0,z*(1-thp)]) cube([x,y,z*thp]);
    }
    
module ibeamr(x,y,z) {  // railings
    thp = .25;
    bwp = .33;
    //echo(x,y,z);
    translate([0,0,z-(scale*1.5)]) cube([x,y*1.01,z*thp/2]);
    for (i = [0:x/1.8:x]) {
        translate([0,i*y,(z-scale)*thp/2]) cube([x,scale*.2,z]);
        }
    translate([0,y-x/2,z-(scale*1.5)]) cube([x,scale*.2,z]);
    translate([0,0,z]) cube([x,y*1.01,z*thp/2]);
    }    
    
module ibeamlbig(x,y,z) {   // ibeam lengthwise
    thp = .25;      // % thickness of top and bottom plates
    bwp = .33;      // % 
    translate([0,0,0]) cube([x,y,z*thp]);
    translate([0,scale*.21,0]) rotate([25,0,0]) cube([x,y*.5,z*thp]);              //slant inside corners
    translate([0,scale*.34,scale*.21]) rotate([-25,0,0]) cube([x,y*.5,z*thp]);
    translate([0,y*(1-bwp)/2,z*thp]) cube([x,y*bwp,z*(1-2*thp)]);
    translate([0,0,z*(1-thp)]) cube([x,y,z*thp]);
    translate([0,-z*thp,z-thp*1.75]) cube([x,y*2,lh*3]);
    //translate([0,-z*thp,z-thp*1.75]) cube([y*2,x,lh*3]);
    translate([0,scale*.05,z-scale*.51]) rotate([-25,0,0]) cube([x,y*.5,z*thp]);              //slant inside corners
    translate([0,scale*.52,z-scale*.71]) rotate([25,0,0]) cube([x,y*.5,z*thp]);
    }  
    
module abeamu(x,y,z) {  // angle beams with length on z axis
    thp = .375;
    translate([0,0,0]) cube([x*thp,y,z]);
    translate([0,0,0]) cube([x,y*thp,z]);
    }

module abeamh(x,y,z) {  // angle beams with length on x axis
    thp = .375;
    translate([0,0,0]) cube([x,y,z*thp]);
    translate([0,0,0]) cube([x,y*thp,z]);
    }

module abeamv(x,y,z) {  // angle beams with length on y axis
    thp = .375;
    translate([0,0,0]) cube([x,y,z*thp]);
    translate([0,0,0]) cube([x*thp,y,z]);
    }

module gussett(gd,gh,angle) {
    
    rotate([0,angle,0]) rotate([90,270,0]) difference() {
        cylinder(d=gd, h=gh*.75);
        translate([-gd*.55,-.25,-1.5]) cube([gd*1.1,gd,gh+1.5]);
        translate([-.25,-scale*1.2,-scale/2]) rotate([0,0,angle]) cube([gd*1.2,gd*1.2,gh+1.5]);
        }
    }    
    
module gussettf(gd,gh,angle) {
    
    rotate([90,90,0]) rotate([0,0,-angle]) difference() {
        cylinder(d=gd, h=gh*.75);
        //translate([-gd*.55,-.25,0]) cube([gd*1.1,gd,gh+.5]);
        translate([-gd*.75,-gd,-gh/2]) cube([gd*1.3,gd,gh+.5]);
        }
    }    
    
module mating_plate() {
    difference() {
        translate([-td*.24,-td*.24,-bh*.050]) cube([td*.49,td*.49,lh*4]);
        translate([-td*.089,-td*.089,-bh*.07]) cube([td*.18,td*.18,scale*1.25]);
        }
    in = .183;  //inset for mating blocks, adjust to fit, smaller moves blocks in
    translate([-td*in,-td*in,-bh*.055]) rotate([0,0,45])
        cylinder(d1=td*.057,d2=td*.067,h=scale*.5,$fn=4,center=true);
    translate([-td*in,td*in,-bh*.055]) rotate([0,0,45])        
        cylinder(d1=td*.057,d2=td*.067,h=scale*.5,$fn=4,center=true);
    translate([td*in,-td*in,-bh*.055]) rotate([0,0,45])        
        cylinder(d1=td*.057,d2=td*.067,h=scale*.5,$fn=4,center=true);
    translate([td*in,td*in,-bh*.055]) rotate([0,0,45])        
        cylinder(d1=td*.057,d2=td*.067,h=scale*.5,$fn=4,center=true);   
    }
    
module rrings(sdiv) {    
    difference() {
            cylinder(d=scale*1.75, h=scale/sdiv);
            cylinder(d=scale*1.25, h = scale/3);
            translate([scale*.18,-scale*.70,-2.0]) cube([scale*1,scale*2.25,scale*1.75]);
            }    
        }

module deck_trapezoid() {
    //#polygon([[td*.5,td*.25],[td,td*.25],[td*.25,td*.25],[td*.25,td*.5]]);
    x1 = td*.5;
    y1 = td*.25;
    x2 = x1+scale*2.25;
    y2 = y1;
    x3 = td*.25;
    y3 = td*.5+scale*2.25-scale*.33;
    x4 = x3;
    y4 = y3-scale*2;
    //#polygon([[0,0],[0,10],[20,20],[20,10]]);
    polygon([[x1,y1],[x2,y2],[x3,y3],[x4,y4]]);
}


// Multicolor helper function for splitting out separate colors to individual stls.
// With thanks to Erik Nygren - https://erik.nygren.org/2018-3dprint-multicolor-openscad.html

/* Similar to the color function, but can be used for generating multi-color models for printing.
 * The global current_color variable indicates the color to print.
 */
module multicolor(color) {
    if (current_color != "ALL" && current_color != color) { 
        // ignore our children.
        // (I originally used "scale([0,0,0])" which also works but isn't needed.) 
    } else {
        color(color)
        children();
    }        
}
