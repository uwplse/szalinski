// By 247generator | Copyright 2018
// todo: masking for backlit numbers

/*[components & display]*/
display_style = 1; //[0:Assembled Display,1:Exploded Display]
clock_parts = 1; //[0:No Clock,1:Show all Parts,2:Backing Only,3:Numbers Only]
track_parts = 1; //[0:No Track,1:Show full LED Track,2:Half,4:Quarter,5:Soldering Jig]
circuit_display = 1; //[0:Hide LED circuit,1:Show LED circuit]
light_diffuser_part = 1; //[0:No LED Diffuser,1:Show for Display,2:Show to Print]
light_number_ring = 0; //[0:No Number Ring,1:Show Numbers Ring,2:Show for Export to paper printer]
rounded_light_display = 1; //[0:No Rounded Display,1:Show Rounded Display,2:Show Rounded Display to Print]

/*[exploded display positions]*/
clock_position = 0; //[0:0]
track_position = 15; //[0:100]
circuit_position = 35; //[0:100]
diffuser_position = 50; //[0:100]
60numbers_position = 55; //[0:100]
display_position = 75; //[0:100]

/*[clock backing options]*/
// in addition to the track backing
clock_backing_thickness = 2.0; //[1:10]
// for hanging the clock on a wall with a screw in the wall
screw_head_opening = 9.3;
screw_shaft_opening = 4.0;
// keep in mind 12 number embossing depth and total thickness
screw_depth = 5.0;
// the amount of plastic keeping the screw from pulling out
screw_retention_depth = 1.6;

/*[clock options]*/
letter_height = 1.5;
letter_emboss = 0.0;
// number to divide the backing enlargement by to get font size
letter_scale = 2.0;
letter_detail = 60;
//Download: fonts.google.com (used in thingiverse customizer) 
font = "Libre Baskerville"; // [Arial, ABeeZee, Abel, Abril Fatface, Aclonica, Acme, Actor, Adamina, Advent Pro, Aguafina Script, Akronim, Aladin, Aldrich, Alef, Alegreya, Alegreya SC, Alegreya Sans, Alegreya Sans SC, Alex Brush, Alfa Slab One, Alice, Alike, Alike Angular, Allan, Allerta, Allerta Stencil, Allura, Almendra, Almendra Display, Almendra SC, Amarante, Amaranth, Amatic SC, Amethysta, Amiri, Amita, Anaheim, Andada, Andika, Angkor, Annie Use Your Telescope, Anonymous Pro, Antic, Antic Didone, Antic Slab, Anton, Arapey, Arbutus, Arbutus Slab, Architects Daughter, Archivo Black, Archivo Narrow, Arimo, Arizonia, Armata, Artifika, Arvo, Arya, Asap, Asar, Asset, Astloch, Asul, Atomic Age, Aubrey, Audiowide, Autour One, Average, Average Sans, Averia Gruesa Libre, Averia Libre, Averia Sans Libre, Averia Serif Libre, Bad Script, Balthazar, Bangers, Basic, Battambang, Baumans, Bayon, Belgrano, Belleza, BenchNine, Bentham, Berkshire Swash, Bevan, Bigelow Rules, Bigshot One, Bilbo, Bilbo Swash Caps, Biryani, Bitter, Black Ops One, Bokor, Bonbon, Boogaloo, Bowlby One, Bowlby One SC, Brawler, Bree Serif, Bubblegum Sans, Bubbler One, Buda, Buenard, Butcherman, Butterfly Kids, Cabin, Cabin Condensed, Cabin Sketch, Caesar Dressing, Cagliostro, Calligraffitti, Cambay, Cambo, Candal, Cantarell, Cantata One, Cantora One, Capriola, Cardo, Carme, Carrois Gothic, Carrois Gothic SC, Carter One, Catamaran, Caudex, Caveat, Caveat Brush, Cedarville Cursive, Ceviche One, Changa One, Chango, Chau Philomene One, Chela One, Chelsea Market, Chenla, Cherry Cream Soda, Cherry Swash, Chewy, Chicle, Chivo, Chonburi, Cinzel, Cinzel Decorative, Clicker Script, Coda, Coda Caption, Codystar, Combo, Comfortaa, Coming Soon, Concert One, Condiment, Content, Contrail One, Convergence, Cookie, Copse, Corben, Courgette, Cousine, Coustard, Covered By Your Grace, Crafty Girls, Creepster, Crete Round, Crimson Text, Croissant One, Crushed, Cuprum, Cutive, Cutive Mono, Damion, Dancing Script, Dangrek, Dawning of a New Day, Days One, Dekko, Delius, Delius Swash Caps, Delius Unicase, Della Respira, Denk One, Devonshire, Dhurjati, Didact Gothic, Diplomata, Diplomata SC, Domine, Donegal One, Doppio One, Dorsa, Dosis, Dr Sugiyama, Droid Sans, Droid Sans Mono, Droid Serif, Duru Sans, Dynalight, EB Garamond, Eagle Lake, Eater, Economica, Eczar, Ek Mukta, Electrolize, Elsie, Elsie Swash Caps, Emblema One, Emilys Candy, Engagement, Englebert, Enriqueta, Erica One, Esteban, Euphoria Script, Ewert, Exo, Exo 2, Expletus Sans, Fanwood Text, Fascinate, Fascinate Inline, Faster One, Fasthand, Fauna One, Federant, Federo, Felipa, Fenix, Finger Paint, Fira Mono, Fira Sans, Fjalla One, Fjord One, Flamenco, Flavors, Fondamento, Fontdiner Swanky, Forum, Francois One, Freckle Face, Fredericka the Great, Fredoka One, Freehand, Fresca, Frijole, Fruktur, Fugaz One, GFS Didot, GFS Neohellenic, Gabriela, Gafata, Galdeano, Galindo, Gentium Basic, Gentium Book Basic, Geo, Geostar, Geostar Fill, Germania One, Gidugu, Gilda Display, Give You Glory, Glass Antiqua, Glegoo, Gloria Hallelujah, Goblin One, Gochi Hand, Gorditas, Goudy Bookletter 1911, Graduate, Grand Hotel, Gravitas One, Great Vibes, Griffy, Gruppo, Gudea, Gurajada, Habibi, Halant, Hammersmith One, Hanalei, Hanalei Fill, Handlee, Hanuman, Happy Monkey, Headland One, Henny Penny, Herr Von Muellerhoff, Hind, Hind Siliguri, Hind Vadodara, Holtwood One SC, Homemade Apple, Homenaje, IM Fell DW Pica, IM Fell DW Pica SC, IM Fell Double Pica, IM Fell Double Pica SC, IM Fell English, IM Fell English SC, IM Fell French Canon, IM Fell French Canon SC, IM Fell Great Primer, IM Fell Great Primer SC, Iceberg, Iceland, Imprima, Inconsolata, Inder, Indie Flower, Inika, Inknut Antiqua, Irish Grover, Istok Web, Italiana, Italianno, Itim, Jacques Francois, Jacques Francois Shadow, Jaldi, Jim Nightshade, Jockey One, Jolly Lodger, Josefin Sans, Josefin Slab, Joti One, Judson, Julee, Julius Sans One, Junge, Jura, Just Another Hand, Just Me Again Down Here, Kadwa, Kalam, Kameron, Kantumruy, Karla, Karma, Kaushan Script, Kavoon, Kdam Thmor, Keania One, Kelly Slab, Kenia, Khand, Khmer, Khula, Kite One, Knewave, Kotta One, Koulen, Kranky, Kreon, Kristi, Krona One, Kurale, La Belle Aurore, Laila, Lakki Reddy, Lancelot, Lateef, Lato, League Script, Leckerli One, Ledger, Lekton, Lemon, Liberation Sans, Liberation Serif, Libre Baskerville, Life Savers, Lilita One, Lily Script One, Limelight, Linden Hill, Lobster, Lobster Two, Londrina Outline, Londrina Shadow, Londrina Sketch, Londrina Solid, Lora, Love Ya Like A Sister, Loved by the King, Lovers Quarrel, Luckiest Guy, Lusitana, Lustria, Macondo, Macondo Swash Caps, Magra, Maiden Orange, Mako, Mallanna, Mandali, Marcellus, Marcellus SC, Marck Script, Margarine, Marko One, Marmelad, Martel, Martel Sans, Marvel, Mate, Mate SC, Maven Pro, McLaren, Meddon, MedievalSharp, Medula One, Megrim, Meie Script, Merienda, Merienda One, Merriweather, Merriweather Sans, Metal, Metal Mania, Metamorphous, Metrophobic, Michroma, Milonga, Miltonian, Miltonian Tattoo, Miniver, Miss Fajardose, Modak, Modern Antiqua, Molengo, Molle, Monda, Monofett, Monoton, Monsieur La Doulaise, Montaga, Montez, Montserrat, Montserrat Alternates, Montserrat Subrayada, Moul, Moulpali, Mountains of Christmas, Mouse Memoirs, Mr Bedfort, Mr Dafoe, Mr De Haviland, Mrs Saint Delafield, Mrs Sheppards, Muli, Mystery Quest, NTR, Neucha, Neuton, New Rocker, News Cycle, Niconne, Nixie One, Nobile, Nokora, Norican, Nosifer, Nothing You Could Do, Noticia Text, Noto Sans, Noto Serif, Nova Cut, Nova Flat, Nova Mono, Nova Oval, Nova Round, Nova Script, Nova Slim, Nova Square, Numans, Nunito, Odor Mean Chey, Offside, Old Standard TT, Oldenburg, Oleo Script, Oleo Script Swash Caps, Open Sans, Open Sans Condensed, Oranienbaum, Orbitron, Oregano, Orienta, Original Surfer, Oswald, Over the Rainbow, Overlock, Overlock SC, Ovo, Oxygen, Oxygen Mono, PT Mono, PT Sans, PT Sans Caption, PT Sans Narrow, PT Serif, PT Serif Caption, Pacifico, Palanquin, Palanquin Dark, Paprika, Parisienne, Passero One, Passion One, Pathway Gothic One, Patrick Hand, Patrick Hand SC, Patua One, Paytone One, Peddana, Peralta, Permanent Marker, Petit Formal Script, Petrona, Philosopher, Piedra, Pinyon Script, Pirata One, Plaster, Play, Playball, Playfair Display, Playfair Display SC, Podkova, Poiret One, Poller One, Poly, Pompiere, Pontano Sans, Poppins, Port Lligat Sans, Port Lligat Slab, Pragati Narrow, Prata, Preahvihear, Press Start 2P, Princess Sofia, Prociono, Prosto One, Puritan, Purple Purse, Quando, Quantico, Quattrocento, Quattrocento Sans, Questrial, Quicksand, Quintessential, Qwigley, Racing Sans One, Radley, Rajdhani, Raleway, Raleway Dots, Ramabhadra, Ramaraja, Rambla, Rammetto One, Ranchers, Rancho, Ranga, Rationale, Ravi Prakash, Redressed, Reenie Beanie, Revalia, Rhodium Libre, Ribeye, Ribeye Marrow, Righteous, Risque, Roboto, Roboto Condensed, Roboto Mono, Roboto Slab, Rochester, Rock Salt, Rokkitt, Romanesco, Ropa Sans, Rosario, Rosarivo, Rouge Script, Rozha One, Rubik, Rubik Mono One, Rubik One, Ruda, Rufina, Ruge Boogie, Ruluko, Rum Raisin, Ruslan Display, Russo One, Ruthie, Rye, Sacramento, Sahitya, Sail, Salsa, Sanchez, Sancreek, Sansita One, Sarala, Sarina, Sarpanch, Satisfy, Scada, Scheherazade, Schoolbell, Seaweed Script, Sevillana, Seymour One, Shadows Into Light, Shadows Into Light Two, Shanti, Share, Share Tech, Share Tech Mono, Shojumaru, Short Stack, Siemreap, Sigmar One, Signika, Signika Negative, Simonetta, Sintony, Sirin Stencil, Six Caps, Skranji, Slabo 13px, Slabo 27px, Slackey, Smokum, Smythe, Sniglet, Snippet, Snowburst One, Sofadi One, Sofia, Sonsie One, Sorts Mill Goudy, Source Code Pro, Source Sans Pro, Source Serif Pro, Special Elite, Spicy Rice, Spinnaker, Spirax, Squada One, Sree Krushnadevaraya, Stalemate, Stalinist One, Stardos Stencil, Stint Ultra Condensed, Stint Ultra Expanded, Stoke, Strait, Sue Ellen Francisco, Sumana, Sunshiney, Supermercado One, Sura, Suranna, Suravaram, Suwannaphum, Swanky and Moo Moo, Syncopate, Tangerine, Taprom, Tauri, Teko, Telex, Tenali Ramakrishna, Tenor Sans, Text Me One, The Girl Next Door, Tienne, Tillana, Timmana, Tinos, Titan One, Titillium Web, Trade Winds, Trocchi, Trochut, Trykker, Tulpen One, Ubuntu, Ubuntu Condensed, Ubuntu Mono, Ultra, Uncial Antiqua, Underdog, Unica One, UnifrakturCook, UnifrakturMaguntia, Unkempt, Unlock, Unna, VT323, Vampiro One, Varela, Varela Round, Vast Shadow, Vesper Libre, Vibur, Vidaloka, Viga, Voces, Volkhov, Vollkorn, Voltaire, Waiting for the Sunrise, Wallpoet, Walter Turncoat, Warnes, Wellfleet, Wendy One, Wingdings, Wire One, Work Sans, Yanone Kaffeesatz, Yantramanav, Yellowtail, Yeseva One, Yesteryear, Zeyada]

// a space for numbers this much bigger than the LED track
backing_enlargement = 29;
// to add space outside the numbers, 0 for none
outside_border_width = 0.0;
// height of the space outside the numbers making an outer lip (negative for bevel)
outside_border_height = 0.0;
// half hour dot size
mark_circle_diameter = 4.0;

/*[track options]*/
// may need 0.5mm reduction for multi-section track
track_inner_diameter = 145;
track_outer_diameter = 159;
// this space allows the circuits to sit flat with soldered joints
backing_thickness = 1.5;
edge_width = 3;
// on top of backing
edge_thickness = 3.3;

/*[light diffuser options]*/
// thickness of the light diffuser (affects clock thickness)
led_diffuser_thickness = 3.0; //[1:0.5:10]
// NOTE: only select Track if you don't plan on using the clock backing
connect_part = 2; // [2:Track,3:Clock]

/*[light display options]*/
// thickness of the top diffuser for display
led_display_thickness = 3.0; //[3:0.5:10]
light_display_numbers = 0; //[0:No Numbers,1:60 Embossed Numbers,2:60 Raised Numbers]
small_numbers_detail = 20;

/*[advanced options]*/
large_circle_resolution = 300;
small_circle_resolution = 40;
// track <-> clock <-> diffuser
space_between_connecting_parts = 0.3;
// diameter reduction of track section puzzle hole to make fit tighter
key_hole_shrink = 0.0;
// diameter reduction of track section puzzle key to give slack
connector_key_shrink = 0.0;

/*[hidden]*/
//
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// THESE RESET THE OpenSCAD VIEW EVERY PREVIEW
// comment them out if you're working on a certain part
//
// view port
// $vpd=530; $vpr=[45,0,45]; $vpt=[ 6, -6, 26 ];
//
//
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

diffuser_thickness = led_diffuser_thickness+0.2;
letter_size = backing_enlargement/letter_scale;
wire_hole = (track_inner_diameter + ((track_outer_diameter-track_inner_diameter)/2))/2 * sin(45);
soldering_holder = (track_outer_diameter/2)-edge_width;
track_width = (track_outer_diameter-track_inner_diameter)/2;
outermost_ring=(track_outer_diameter/2)+edge_width+backing_enlargement+outside_border_width;
diffuser_inner_ring=(track_inner_diameter/2)-(edge_width*(connect_part-1))-space_between_connecting_parts*2;
backing_inner_ring=(track_inner_diameter/2)-(edge_width*2)-space_between_connecting_parts;

// straightening re-alignment
rotate ([0,0,45]){

// a ring of numbers that would be easier to print on transparency with laser or inkjet printer
if (light_number_ring >= 1 && display_style == 0){
    color ("gray") translate ([0,0,edge_thickness+backing_thickness+diffuser_thickness-0.1]) { numbers_display (); }
}else if (light_number_ring >= 1 && display_style == 1) {
    color ("gray") translate ([0,0,60numbers_position+edge_thickness+backing_thickness+diffuser_thickness-0.1]) { numbers_display (); }
}
// a ring of material that sits flush with the clock to diffuse the LEDs harsh light
if (light_diffuser_part == 1 && display_style == 0) { color ("Gainsboro") translate ([0,0,-0.1]) 
        light_diffuser (); 
}else if (light_diffuser_part == 1 && display_style == 1) {color ("Gainsboro") translate ([0,0,diffuser_position])
            light_diffuser ();
}else if (light_diffuser_part == 2) {rotate ([180,0,0]) {
        light_diffuser ();}
        }
// a secondary diffuser to go on top of the flush diffuser, if you want it to sit above for a more finished look        
if (rounded_light_display == 1 && display_style == 0) {color ("Beige") translate ([0,0,-0.1]) 
        light_display (); 
}else if (rounded_light_display == 1 && display_style == 1) {color ("Beige") translate ([0,0,display_position])
            light_display ();
}else if (rounded_light_display == 2) {rotate ([180,0,0]) {
        light_display ();}
    }
    

    
// make the track and rorate for clock alignment
if (track_parts > 0 && light_diffuser_part < 2 && display_style == 0) { 
   color ("gray") rotate ([0,0,3]){
union () {
    connector();
 difference () {
    rings();
    blanks();
}}}
// make the track above the clock
}else if (track_parts > 0 && display_style == 1){
color ("gray") rotate ([0,0,3]) translate ([0,0,track_position]) {
union () {
    connector();
 difference () {
    rings();
    blanks();
}}}
}
/* make the track on it's own as originally designed
}else{
    union () {
    connector();
 difference () {
    rings();
    blanks();}
    }}}
*/
if (clock_parts > 0  && light_diffuser_part < 2){
 //  union () { //switch to union for debug
 difference () {
    union () {
// make backing if we aren't printing just the numbers
if (clock_parts < 3){
        color ("Beige")
    backing();
}
// make raised numbers if not embossing and not in backing-only mode
if (clock_parts == 2){}else{
   if (letter_emboss == 0)     color ("SteelBlue") {
    numbers(12,30,-(track_outer_diameter+edge_width*2+backing_enlargement)/2,letter_size);
    marks(12,30);
            }
        }

        
        }
// Start of difference subtractive parts
// subtract holes for wiring and hanging
    holes();
// subtract embossing unless embossing is 0   
       if (letter_emboss > 0) translate ([0,0,-letter_emboss]) color("white"){
                numbers(12,30,-(track_outer_diameter+edge_width*2+backing_enlargement)/2,letter_size);
                marks(12,30);
    }}}
    
// make a circuit of LEDs for display
    if (circuit_display == 1 && display_style == 0) {
        rotate ([0,0,3]) translate ([0,0,0.1])
        circuit ();
    }
    else if (circuit_display == 1 && display_style == 1) {
        rotate ([0,0,3]) translate ([0,0,circuit_position])
        circuit ();
    
    }
    
} // end of re-alignment rotation


//
//
// END OF BUILD
// *****************************************************************
// *****************************************************************
// START OF MODULES  
//   
//      
    

    module circuit (){
// rough approximation for display purposes only, most circuits aren't even green.
        LEDxy = 4.9;
        LEDz = 1.65;
        circuit_thickness = 1.5;
        amount = 60;
        degrees = 6;
        breaks = 4;
        position = (track_outer_diameter-track_width)/2;
// 5050 LEDs
        rotate([0,0,42])
    for (number=[1:amount])
        rotate([0,0,-number*degrees]) translate ([position,0,LEDz/2+circuit_thickness+backing_thickness-0.1]) 
    {
         difference () {color ("silver") cube ([LEDxy,LEDxy,LEDz], center=true); translate([0,0,(LEDz/2)-0.2]) color ("white") cylinder (r=(LEDxy/2)-0.5,h=0.3,$fn=12);}
    }
// circuit board
        translate ([0,0,backing_thickness]) color ("green")
        difference () {
    cylinder (h=circuit_thickness, r=track_outer_diameter/2-0.5, $fn=large_circle_resolution);
    translate ([0,0,-0.2]) {
    cylinder (h=circuit_thickness+0.4, r=track_inner_diameter/2+0.5, $fn=large_circle_resolution);}
// gaps from the 4 quarter sections of circle circuit
rotate ([0,0,-45])
for (number=[1:breaks])
    rotate([0,0,-number*360/breaks]) translate ([position,0,circuit_thickness/2]) 
    cube ([track_width,circuit_thickness*1.5,circuit_thickness+0.2], center=true);
}
// wires that get soldered
rotate ([0,0,-45])
for (number=[1:breaks])
    rotate([0,0,-number*360/breaks]) translate ([0,0,backing_thickness-(circuit_thickness/6)+0.1]) color ("brown") {
        translate ([position+1.5,0,0])
        cube ([circuit_thickness/3,6,circuit_thickness/3], center=true);
        if (number > 1) {translate ([position,0,0])
        cube ([circuit_thickness/3,6,circuit_thickness/3], center=true); }
        translate ([position-1.5,0,0])
        cube ([circuit_thickness/3,6,circuit_thickness/3], center=true);
    }}
    
module numbers_display () {
         
            difference () {
                difference () {
     cylinder (h=backing_thickness/2, r=(track_outer_diameter/2)+edge_width, $fn=large_circle_resolution);
    translate ([0,0,-0.1]) {
    cylinder (h=(backing_thickness/2)+0.2, r=(track_inner_diameter/2)-edge_width, $fn=large_circle_resolution);}
} if (light_number_ring == 2) {
    translate ([0,0,-0.1])     sm_numbers(60,6,(track_outer_diameter-track_width)/2,track_width*.6);
} else { translate ([0,0,0.2])     sm_numbers(60,6,(track_outer_diameter-track_width)/2,track_width*.6);
}
            }
        }
    
module light_diffuser () {
    base_thickness = edge_thickness+backing_thickness;

    difference () {
        union () {
// inner connecting ring
        cylinder (h=base_thickness+led_diffuser_thickness, r=diffuser_inner_ring, $fn=large_circle_resolution);
// light diffuser above the LEDs
        translate ([0,0,base_thickness]) {
    cylinder (h=led_diffuser_thickness, r=(track_outer_diameter/2)+(edge_width)+space_between_connecting_parts, $fn=large_circle_resolution);
        }}
// subtract for an open center
    translate ([0,0,-0.1]) {
    cylinder (h=base_thickness+led_diffuser_thickness+0.2, r=(track_inner_diameter/2)-(edge_width*connect_part)-space_between_connecting_parts, $fn=large_circle_resolution);}
}
}

module light_display () {
    base_thickness = edge_thickness+backing_thickness;
    translate ([0,0,0.0]){
    difference () {
        union () {
// inner connecting ring
        translate ([0,0,-clock_backing_thickness]) cylinder (h=clock_backing_thickness+base_thickness+led_diffuser_thickness+led_display_thickness-3, 
            r=backing_inner_ring-space_between_connecting_parts-edge_width, $fn=large_circle_resolution);
// light diffuser above the LEDs and flush diffuser
        translate ([0,0,base_thickness+(led_diffuser_thickness)]) {
    rcylinder (h=led_display_thickness, 
            r1=(track_outer_diameter/2)+(edge_width*3)+space_between_connecting_parts, b=3);
        }
//  SMALL RAISED NUMBERS
   if (light_display_numbers == 2) {
        translate ([0,0,0.5+base_thickness+led_diffuser_thickness+led_display_thickness-1])
    sm_numbers(60,6,(track_outer_diameter-track_width)/2,track_width*.6);
   } //
        }
//  SMALL EMBOSSED NUMBERS
   if (light_display_numbers == 1) {
        translate ([0,0,0.5+base_thickness+led_diffuser_thickness+led_display_thickness-1])
    sm_numbers(60,6,(track_outer_diameter-track_width)/2,track_width*.6);
   } //
// subtract for an open center
    translate ([0,0,base_thickness+(led_diffuser_thickness)+0.001]) {
    rncylinder (h=(led_display_thickness), r=backing_inner_ring-(edge_width*2), b=3);}
    translate ([0,0,-clock_backing_thickness-0.1]) {
    cylinder (h=clock_backing_thickness+base_thickness+(led_diffuser_thickness+led_display_thickness)+0.2, r=backing_inner_ring-(edge_width*2), $fn=large_circle_resolution);}
}}
}
module rcylinder(r1=10,h=10,b=2){
{translate([0,0,0]) 
    hull(){
        rotate_extrude($fn=large_circle_resolution) 
        translate([r1-b,h-b,0]) intersection () { circle(r = b,$fn=small_circle_resolution); square(b); }
        translate([0, 0, 0]) cylinder(h=h-b,r=r1,$fn=large_circle_resolution);
        }
        }
    }
module rncylinder(r=10,h=10,b=2){
{translate([0,0,0]) 
    
        rotate_extrude($fn=large_circle_resolution) 
        translate([r-0.1,h-b,0]) difference () { square(b); translate ([b+0.1,0]) circle(r = b,$fn=small_circle_resolution); }

        }
    }
module backing(){
    
    base_thickness = edge_thickness+backing_thickness;
    
    // backing under raised or embossed numbers
difference () {
    cylinder (h=base_thickness+diffuser_thickness-0.2, r=(track_outer_diameter/2)+edge_width+backing_enlargement, $fn=large_circle_resolution);
    translate ([0,0,-0.1]) {
    cylinder (h=base_thickness+diffuser_thickness+0.2, r=(track_outer_diameter/2)+edge_width+space_between_connecting_parts, $fn=large_circle_resolution);}
}
// inner backing track ring

difference () {
    cylinder (h=base_thickness, r=(track_inner_diameter/2)-edge_width-space_between_connecting_parts, $fn=large_circle_resolution);
    translate ([0,0,-0.1]) {
    cylinder (h=base_thickness+0.2, r=backing_inner_ring, $fn=large_circle_resolution);}
}
// outer ring to match height of light diffuser
if (outside_border_width > 0) {
difference () {
    cylinder (h=base_thickness+diffuser_thickness+outside_border_height, r=outermost_ring, $fn=large_circle_resolution);
    translate ([0,0,-0.1]) {
    cylinder (h=base_thickness+diffuser_thickness+outside_border_height+0.2, r=outermost_ring-outside_border_width, $fn=large_circle_resolution);}
}}
// backing under everything

    translate ([0,0,-clock_backing_thickness]) {
difference () {
    cylinder (h=clock_backing_thickness, r=(track_outer_diameter/2)+edge_width+backing_enlargement+outside_border_width, $fn=large_circle_resolution);
    translate ([0,0,-0.1]) {
    cylinder (h=clock_backing_thickness+0.2, r=(backing_inner_ring)-(edge_width), $fn=large_circle_resolution);}
        }
    }
}

module numbers(amount, degrees, position, size){
    rotate([0,0,225])
    for (number=[1:amount])
        rotate([0,0,-number*degrees]) translate ([position,0,edge_thickness+backing_thickness+diffuser_thickness-0.2]) 
    {
        if (letter_emboss > 0) {
        rotate([0,0,90+number*degrees])letter(str(number),size,font,letter_detail,letter_emboss);
     }else{
                 rotate([0,0,90+number*degrees])letter(str(number),size,font,letter_detail,letter_height);

     }
            }
}
module sm_numbers(amount, degrees, position, size){
    rotate([0,0,45])
    for (number=[1:amount])
        rotate([0,0,-number*degrees]) translate ([position,0,0]) 
    {
        rotate([0,0,270+number*degrees])letter(str(number),size,"Arial:style=Bold",small_numbers_detail,1);
    }
}
module letter(txt,size,font,detail,height) {
     
  linear_extrude(height = height) {
    text(txt, size = size, font = font, halign = "center", valign = "center", $fn = detail);}
 
    }
    
module marks(amount, degrees){
    for (number=[1:amount])
    rotate([0,0,-number*degrees]) 
    translate ([-(track_outer_diameter+edge_width*2+backing_enlargement)/2,0,edge_thickness+backing_thickness+diffuser_thickness-0.2])    
    {
        if (letter_emboss > letter_height) {
      cylinder (h=(letter_emboss), r=mark_circle_diameter/2, $fn=small_circle_resolution);}
      else {
      cylinder (h=(letter_height), r=mark_circle_diameter/2, $fn=small_circle_resolution);}
    }}
module holes(){
// hanging screw hole
    rotate([0,0,225]) translate ([-(track_outer_diameter+backing_enlargement)/2,0,-clock_backing_thickness]) {
        
    translate ([0,0,-0.1]) {cylinder (h=screw_depth+0.2, r=screw_head_opening/2, $fn=small_circle_resolution);}
    
    // hanging screw head inner slot
    hull (){
    translate ([0,0,screw_retention_depth-0.1]) {cylinder (h=(screw_depth)+0.2, r=(screw_head_opening/2), $fn=small_circle_resolution);}
    
    translate ([-screw_head_opening,0,screw_retention_depth-0.1]){cylinder (h=(screw_depth)+0.2, r=(screw_head_opening/2), $fn=small_circle_resolution);}
}
    // hanging screw shaft slot
        hull (){
    translate ([0,0,-0.1]) {cylinder (h=(screw_depth)+0.2, r=(screw_shaft_opening/2), $fn=small_circle_resolution);}
    
    translate ([-screw_shaft_opening-screw_head_opening/2,0,-0.1]){cylinder (h=(screw_depth)+0.2, r=(screw_shaft_opening/2), $fn=small_circle_resolution);}
}
}
// clock wiring shaft
    hole_length = ((track_outer_diameter/2)+edge_width*2+backing_enlargement+outside_border_width)-(track_inner_diameter/2);
    wire_hole = ((track_inner_diameter+hole_length)/2)-edge_width;

    rotate([0,0,46]) translate ([-wire_hole-0.2,0,(diffuser_thickness)/2]) rotate([0,0,-7]) color("Gray"){
        cube ([hole_length+0.4,(track_outer_diameter-track_inner_diameter)/2,((clock_backing_thickness/2+diffuser_thickness))], center=true);}
    }
    
 
    
    
module rings(){
    // outer edge
difference () {
    cylinder (h=edge_thickness+backing_thickness, r=(track_outer_diameter/2)+edge_width, $fn=large_circle_resolution);
    translate ([0,0,-0.1]) {
    cylinder (h=edge_thickness+backing_thickness+0.2, r=track_outer_diameter/2, $fn=large_circle_resolution);}
}
// backing under circuit
difference () {
    cylinder (h=backing_thickness, r=track_outer_diameter/2, $fn=large_circle_resolution);
    translate ([0,0,-0.1]) {
    cylinder (h=backing_thickness+0.2, r=track_inner_diameter/2, $fn=large_circle_resolution);}
}
// inner edge
difference () {
    cylinder (h=edge_thickness+backing_thickness+0.2, r=track_inner_diameter/2, $fn=large_circle_resolution);
    translate ([0,0,-0.5]) {
    cylinder (h=edge_thickness+backing_thickness+1, r=(track_inner_diameter/2)-edge_width, $fn=large_circle_resolution);}
}
}
module blanks(){
    union (){
        if (track_parts > 1){
// remove half the track rectangle
    translate ([-(track_outer_diameter/2)-edge_width,0,-1]) color("green"){

    cube ([(track_outer_diameter+edge_width*2),(track_outer_diameter/2)+edge_width*2,edge_thickness*2]);}
if (track_parts >= 4){
// remove a quarter track square
    translate ([0,-(track_outer_diameter/2)-edge_width,-1]) color("red"){
    cube ([(track_outer_diameter/2)+edge_width,0.2+(track_outer_diameter/2)+edge_width,edge_thickness*2]);}
}
}
// wiring holes
if (track_parts == 5) {  
// remove a big section for soldering them together
    translate ([-wire_hole,-wire_hole,backing_thickness/2]) rotate([0,0,45])color("purple"){
        cube ([((track_outer_diameter-track_inner_diameter)/2)+edge_width/2,(track_outer_diameter-track_inner_diameter),(edge_thickness+backing_thickness)*2], center=true);}
    }
// normal wiring holes
    translate ([-wire_hole,-wire_hole,backing_thickness/2]) rotate([0,0,45])color("blue"){
        cube ([(track_outer_diameter-track_inner_diameter)/2,(track_outer_diameter-track_inner_diameter)/2,backing_thickness+0.2], center=true);}
    translate ([wire_hole,-wire_hole,backing_thickness/2]) rotate([0,0,45])color("blue"){
        cube ([(track_outer_diameter-track_inner_diameter)/2,(track_outer_diameter-track_inner_diameter)/2,backing_thickness+0.2], center=true);}
    translate ([wire_hole,wire_hole,backing_thickness/2]) rotate([0,0,45])color("blue"){
        cube ([(track_outer_diameter-track_inner_diameter)/2,(track_outer_diameter-track_inner_diameter)/2,backing_thickness+0.2], center=true);}
    translate ([-wire_hole,wire_hole,backing_thickness/2]) rotate([0,0,45])color("blue"){
        cube ([(track_outer_diameter-track_inner_diameter)/2,(track_outer_diameter-track_inner_diameter)/2,backing_thickness+0.2], center=true);}
//snap together connector hole
    if (track_parts > 1 && track_parts < 5){
    translate ([-(track_outer_diameter/2)+(track_outer_diameter-track_inner_diameter)/4,-2,-0.1])color("cyan"){
    cylinder (h=backing_thickness+0.2, r=((track_outer_diameter-track_inner_diameter)/4)-key_hole_shrink/2, $fn=small_circle_resolution);
    }
    }
}}
module connector(){
    if (track_parts == 5){//don't bother making a connector for the soldering helper 
        }else{ // make a connector
    translate ([2,-(track_outer_diameter/2)+(track_outer_diameter-track_inner_diameter)/4,0]){
    cylinder (h=backing_thickness, r=(track_outer_diameter-track_inner_diameter)/4-(connector_key_shrink/2), $fn=small_circle_resolution);
    }
}
    if (track_parts == 2){
    translate ([(track_outer_diameter/2)-(track_outer_diameter-track_inner_diameter)/4,2,0]){
    cylinder (h=backing_thickness, r=(track_outer_diameter-track_inner_diameter)/4-(connector_key_shrink/2), $fn=small_circle_resolution);
    }}
    }

echo ("track width", track_width);
echo ("inner track diameter", ((track_inner_diameter/2)-edge_width)*2);
echo ("diffuser connect ring", diffuser_inner_ring*2);
echo ("backing connect ring", backing_inner_ring*2);
echo ("clock outer diameter", outermost_ring*2);
    
