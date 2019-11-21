// Wall Letter Generator
// Pushpin edition
//
// Author: Erick Neilson 247generator@thingiverse - Copyright 2018
//
// This code generates big letters with rounded top edges that you can use push-pins
// to flush mount to drywall. The holes need to be moved into good positions manually, and
// keeping at least two aligned makes installation easier, especially for asymmetric fonts.
//
// Change the hole size to work with a small screw instead of push-pin in order to fit them in smaller fonts.
//
// The hanging holes appear to be completely open in fast preview to make them easier to 
// position correctly, but they will render properly in the full resolution STL.  
//
// pardon the mess.
//
//


/* [Main Settings] */


// this reduces curve complexity by a quarter for fast preview and shows the full holes for locating - remember to turn off preview before clicking Create Thing
PREVIEW_mode = 0.25; //[0.25:Fast Preview Mode,1:Full Resolution Render Mode]
// the default view is the bottom (back), so to quickly check the top (front):
 flip_over = 0; //[0:Normal Rotation,1:Flip Upside Down]
 rotation = flip_over * [0,180,0];

// (single letter) some fonts can use codes like \u263A (smile) see https://en.wikipedia.org/wiki/Miscellaneous_Symbols
text ="W";

/* [Positions and Colors] */

// how many hanging holes
holes = 4;//[0:4]

letter_color = "Gold";
letter_x = 0;
letter_y = 0;

color1 = "Pink";
hole1_x = 68;
hole1_y = 40;

color2 = "Lime";
hole2_x = -64;
hole2_y = 40;

color3 = "Turquoise";
hole3_x = -34;
hole3_y = -47;

color4 = "Red";
hole4_x = 37;
hole4_y = -47;

/* [Additional Options] */

// Google fonts
font = "Liberation Sans"; // [Arial, ABeeZee, Abel, Abril Fatface, Aclonica, Acme, Actor, Adamina, Advent Pro, Aguafina Script, Akronim, Aladin, Aldrich, Alef, Alegreya, Alegreya SC, Alegreya Sans, Alegreya Sans SC, Alex Brush, Alfa Slab One, Alice, Alike, Alike Angular, Allan, Allerta, Allerta Stencil, Allura, Almendra, Almendra Display, Almendra SC, Amarante, Amaranth, Amatic SC, Amethysta, Amiri, Amita, Anaheim, Andada, Andika, Angkor, Annie Use Your Telescope, Anonymous Pro, Antic, Antic Didone, Antic Slab, Anton, Arapey, Arbutus, Arbutus Slab, Architects Daughter, Archivo Black, Archivo Narrow, Arimo, Arizonia, Armata, Artifika, Arvo, Arya, Asap, Asar, Asset, Astloch, Asul, Atomic Age, Aubrey, Audiowide, Autour One, Average, Average Sans, Averia Gruesa Libre, Averia Libre, Averia Sans Libre, Averia Serif Libre, Bad Script, Balthazar, Bangers, Basic, Battambang, Baumans, Bayon, Belgrano, Belleza, BenchNine, Bentham, Berkshire Swash, Bevan, Bigelow Rules, Bigshot One, Bilbo, Bilbo Swash Caps, Biryani, Bitter, Black Ops One, Bokor, Bonbon, Boogaloo, Bowlby One, Bowlby One SC, Brawler, Bree Serif, Bubblegum Sans, Bubbler One, Buda, Buenard, Butcherman, Butterfly Kids, Cabin, Cabin Condensed, Cabin Sketch, Caesar Dressing, Cagliostro, Calligraffitti, Cambay, Cambo, Candal, Cantarell, Cantata One, Cantora One, Capriola, Cardo, Carme, Carrois Gothic, Carrois Gothic SC, Carter One, Catamaran, Caudex, Caveat, Caveat Brush, Cedarville Cursive, Ceviche One, Changa One, Chango, Chau Philomene One, Chela One, Chelsea Market, Chenla, Cherry Cream Soda, Cherry Swash, Chewy, Chicle, Chivo, Chonburi, Cinzel, Cinzel Decorative, Clicker Script, Coda, Coda Caption, Codystar, Combo, Comfortaa, Coming Soon, Concert One, Condiment, Content, Contrail One, Convergence, Cookie, Copse, Corben, Courgette, Cousine, Coustard, Covered By Your Grace, Crafty Girls, Creepster, Crete Round, Crimson Text, Croissant One, Crushed, Cuprum, Cutive, Cutive Mono, Damion, Dancing Script, Dangrek, Dawning of a New Day, Days One, Dekko, Delius, Delius Swash Caps, Delius Unicase, Della Respira, Denk One, Devonshire, Dhurjati, Didact Gothic, Diplomata, Diplomata SC, Domine, Donegal One, Doppio One, Dorsa, Dosis, Dr Sugiyama, Droid Sans, Droid Sans Mono, Droid Serif, Duru Sans, Dynalight, EB Garamond, Eagle Lake, Eater, Economica, Eczar, Ek Mukta, Electrolize, Elsie, Elsie Swash Caps, Emblema One, Emilys Candy, Engagement, Englebert, Enriqueta, Erica One, Esteban, Euphoria Script, Ewert, Exo, Exo 2, Expletus Sans, Fanwood Text, Fascinate, Fascinate Inline, Faster One, Fasthand, Fauna One, Federant, Federo, Felipa, Fenix, Finger Paint, Fira Mono, Fira Sans, Fjalla One, Fjord One, Flamenco, Flavors, Fondamento, Fontdiner Swanky, Forum, Francois One, Freckle Face, Fredericka the Great, Fredoka One, Freehand, Fresca, Frijole, Fruktur, Fugaz One, GFS Didot, GFS Neohellenic, Gabriela, Gafata, Galdeano, Galindo, Gentium Basic, Gentium Book Basic, Geo, Geostar, Geostar Fill, Germania One, Gidugu, Gilda Display, Give You Glory, Glass Antiqua, Glegoo, Gloria Hallelujah, Goblin One, Gochi Hand, Gorditas, Goudy Bookletter 1911, Graduate, Grand Hotel, Gravitas One, Great Vibes, Griffy, Gruppo, Gudea, Gurajada, Habibi, Halant, Hammersmith One, Hanalei, Hanalei Fill, Handlee, Hanuman, Happy Monkey, Headland One, Henny Penny, Herr Von Muellerhoff, Hind, Hind Siliguri, Hind Vadodara, Holtwood One SC, Homemade Apple, Homenaje, IM Fell DW Pica, IM Fell DW Pica SC, IM Fell Double Pica, IM Fell Double Pica SC, IM Fell English, IM Fell English SC, IM Fell French Canon, IM Fell French Canon SC, IM Fell Great Primer, IM Fell Great Primer SC, Iceberg, Iceland, Imprima, Inconsolata, Inder, Indie Flower, Inika, Inknut Antiqua, Irish Grover, Istok Web, Italiana, Italianno, Itim, Jacques Francois, Jacques Francois Shadow, Jaldi, Jim Nightshade, Jockey One, Jolly Lodger, Josefin Sans, Josefin Slab, Joti One, Judson, Julee, Julius Sans One, Junge, Jura, Just Another Hand, Just Me Again Down Here, Kadwa, Kalam, Kameron, Kantumruy, Karla, Karma, Kaushan Script, Kavoon, Kdam Thmor, Keania One, Kelly Slab, Kenia, Khand, Khmer, Khula, Kite One, Knewave, Kotta One, Koulen, Kranky, Kreon, Kristi, Krona One, Kurale, La Belle Aurore, Laila, Lakki Reddy, Lancelot, Lateef, Lato, League Script, Leckerli One, Ledger, Lekton, Lemon, Liberation Sans, Liberation Serif, Libre Baskerville, Life Savers, Lilita One, Lily Script One, Limelight, Linden Hill, Lobster, Lobster Two, Londrina Outline, Londrina Shadow, Londrina Sketch, Londrina Solid, Lora, Love Ya Like A Sister, Loved by the King, Lovers Quarrel, Luckiest Guy, Lusitana, Lustria, Macondo, Macondo Swash Caps, Magra, Maiden Orange, Mako, Mallanna, Mandali, Marcellus, Marcellus SC, Marck Script, Margarine, Marko One, Marmelad, Martel, Martel Sans, Marvel, Mate, Mate SC, Maven Pro, McLaren, Meddon, MedievalSharp, Medula One, Megrim, Meie Script, Merienda, Merienda One, Merriweather, Merriweather Sans, Metal, Metal Mania, Metamorphous, Metrophobic, Michroma, Milonga, Miltonian, Miltonian Tattoo, Miniver, Miss Fajardose, Modak, Modern Antiqua, Molengo, Molle, Monda, Monofett, Monoton, Monsieur La Doulaise, Montaga, Montez, Montserrat, Montserrat Alternates, Montserrat Subrayada, Moul, Moulpali, Mountains of Christmas, Mouse Memoirs, Mr Bedfort, Mr Dafoe, Mr De Haviland, Mrs Saint Delafield, Mrs Sheppards, Muli, Mystery Quest, NTR, Neucha, Neuton, New Rocker, News Cycle, Niconne, Nixie One, Nobile, Nokora, Norican, Nosifer, Nothing You Could Do, Noticia Text, Noto Sans, Noto Serif, Nova Cut, Nova Flat, Nova Mono, Nova Oval, Nova Round, Nova Script, Nova Slim, Nova Square, Numans, Nunito, Odor Mean Chey, Offside, Old Standard TT, Oldenburg, Oleo Script, Oleo Script Swash Caps, Open Sans, Open Sans Condensed, Oranienbaum, Orbitron, Oregano, Orienta, Original Surfer, Oswald, Over the Rainbow, Overlock, Overlock SC, Ovo, Oxygen, Oxygen Mono, PT Mono, PT Sans, PT Sans Caption, PT Sans Narrow, PT Serif, PT Serif Caption, Pacifico, Palanquin, Palanquin Dark, Paprika, Parisienne, Passero One, Passion One, Pathway Gothic One, Patrick Hand, Patrick Hand SC, Patua One, Paytone One, Peddana, Peralta, Permanent Marker, Petit Formal Script, Petrona, Philosopher, Piedra, Pinyon Script, Pirata One, Plaster, Play, Playball, Playfair Display, Playfair Display SC, Podkova, Poiret One, Poller One, Poly, Pompiere, Pontano Sans, Poppins, Port Lligat Sans, Port Lligat Slab, Pragati Narrow, Prata, Preahvihear, Press Start 2P, Princess Sofia, Prociono, Prosto One, Puritan, Purple Purse, Quando, Quantico, Quattrocento, Quattrocento Sans, Questrial, Quicksand, Quintessential, Qwigley, Racing Sans One, Radley, Rajdhani, Raleway, Raleway Dots, Ramabhadra, Ramaraja, Rambla, Rammetto One, Ranchers, Rancho, Ranga, Rationale, Ravi Prakash, Redressed, Reenie Beanie, Revalia, Rhodium Libre, Ribeye, Ribeye Marrow, Righteous, Risque, Roboto, Roboto Condensed, Roboto Mono, Roboto Slab, Rochester, Rock Salt, Rokkitt, Romanesco, Ropa Sans, Rosario, Rosarivo, Rouge Script, Rozha One, Rubik, Rubik Mono One, Rubik One, Ruda, Rufina, Ruge Boogie, Ruluko, Rum Raisin, Ruslan Display, Russo One, Ruthie, Rye, Sacramento, Sahitya, Sail, Salsa, Sanchez, Sancreek, Sansita One, Sarala, Sarina, Sarpanch, Satisfy, Scada, Scheherazade, Schoolbell, Seaweed Script, Sevillana, Seymour One, Shadows Into Light, Shadows Into Light Two, Shanti, Share, Share Tech, Share Tech Mono, Shojumaru, Short Stack, Siemreap, Sigmar One, Signika, Signika Negative, Simonetta, Sintony, Sirin Stencil, Six Caps, Skranji, Slabo 13px, Slabo 27px, Slackey, Smokum, Smythe, Sniglet, Snippet, Snowburst One, Sofadi One, Sofia, Sonsie One, Sorts Mill Goudy, Source Code Pro, Source Sans Pro, Source Serif Pro, Special Elite, Spicy Rice, Spinnaker, Spirax, Squada One, Sree Krushnadevaraya, Stalemate, Stalinist One, Stardos Stencil, Stint Ultra Condensed, Stint Ultra Expanded, Stoke, Strait, Sue Ellen Francisco, Sumana, Sunshiney, Supermercado One, Sura, Suranna, Suravaram, Suwannaphum, Swanky and Moo Moo, Syncopate, Tangerine, Taprom, Tauri, Teko, Telex, Tenali Ramakrishna, Tenor Sans, Text Me One, The Girl Next Door, Tienne, Tillana, Timmana, Tinos, Titan One, Titillium Web, Trade Winds, Trocchi, Trochut, Trykker, Tulpen One, Ubuntu, Ubuntu Condensed, Ubuntu Mono, Ultra, Uncial Antiqua, Underdog, Unica One, UnifrakturCook, UnifrakturMaguntia, Unkempt, Unlock, Unna, VT323, Vampiro One, Varela, Varela Round, Vast Shadow, Vesper Libre, Vibur, Vidaloka, Viga, Voces, Volkhov, Vollkorn, Voltaire, Waiting for the Sunrise, Wallpoet, Walter Turncoat, Warnes, Wellfleet, Wendy One, Wingdings, Wire One, Work Sans, Yanone Kaffeesatz, Yantramanav, Yellowtail, Yeseva One, Yesteryear, Zeyada]
// font size
letter_size = 120;
// 60+ makes curvy letters look smoother 
rendered_letter_detail = 32; //[32:2:128]
// added space above the screw hole recess to the top surface of the letter
top_shell = 1.5;
// radius of the ball used to round the edges
rounded_corners = 4.0; 
// How curved or polygonal the above rounded edges are
rendered_corner_detail = 32; //[32:2:96]
// for hanging on a wall with screws or pushpins in the wall
screw_head_opening = 9.5;
// make this a bit smaller than the pin to retain pushpins / tacks
screw_shaft_opening = 1.4;
// also most of the total letter thickness
screw_depth = 12.7;
// the amount of plastic keeping the screw or pin from pulling out (between the wall and head)
screw_retention_depth = 0.8;
// hanging hole complexity
rendered_curve_detail = 32; //[32:2:96]


/* [Printer Build Plate] */

// The letter is not automatically centered on the bed, this section is just intended for checking the relative font size.
print_bed_notes = 0; // [0:Q and W tend to be largest letters for checking,1:Also avoid creating it flipped over,2:use Normal Rotation in the first section]
// Check the size of the letter against your printer bed size
show_print_bed = 0; // [0:Hide the print bed,1:Show the circular print bed, 2:Show the rectangular print bed]
circular_bed_diameter = 230;
rectangular_bed_x = 200;
rectangular_bed_y = 280;
bed_height = 2;


/* [Hidden] */

// thingiverse customizer: show us the back by default
// preview[view:north, tilt:bottom]
// equivalent to this in OpenSCAD:
// $vpr = [ 175, 0.00, 180 ] ;

//  $vpr = [ 60, 0.00, 45 ] ;  // This appears to be the default rotational view of thingiverse customizer.


detail_reduction=PREVIEW_mode;
letter_detail=rendered_letter_detail*detail_reduction;
corner_detail=rendered_corner_detail*detail_reduction;
curve_detail=rendered_curve_detail*(detail_reduction*2);


//
// END OF PARAMETERS
//
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
// START OF BUILD
//



// Add up all the internal parts height and then subtract the rounded corners which get added on in all directions except -Z (down)
letter_height = screw_retention_depth + screw_depth + top_shell - rounded_corners;

// Rotate everything to make it easier to see the hole positions

rotate (rotation) {



// printer build plate size & shape preview mechanism, mostly for thingiverse customizer since it has no measurements.

if (show_print_bed == 1) {
    translate ([0,0,-(bed_height/2)-0.1])
    %cylinder (r=circular_bed_diameter/2,h=bed_height,$fn=64, center = true);
}
if (show_print_bed == 2) {
    translate ([0,0,-(bed_height/2)-0.1])
    %cube ([rectangular_bed_x,rectangular_bed_y,bed_height], center = true);
}



difference () { translate ([letter_x,letter_y,0])color (letter_color)  letter(text); 
    if (holes > 0) {
        translate ([hole1_x,hole1_y,0])color (color1) hanger_hole (screw_depth,screw_head_opening,screw_shaft_opening,screw_retention_depth);}
    if (holes > 1) {
        translate ([hole2_x,hole2_y,0])color (color2) hanger_hole (screw_depth,screw_head_opening,screw_shaft_opening,screw_retention_depth);}
    if (holes > 2) {
        translate ([hole3_x,hole3_y,0])color (color3) hanger_hole (screw_depth,screw_head_opening,screw_shaft_opening,screw_retention_depth);}
    if (holes > 3) {
        translate ([hole4_x,hole4_y,0])color (color4) hanger_hole (screw_depth,screw_head_opening,screw_shaft_opening,screw_retention_depth);}
}
        
}


//
// END OF BUILD
//
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
// START OF MODULES
//



module hanger_hole (screw_depth,screw_head_opening,screw_shaft_opening,screw_retention_depth) {
    $fn = curve_detail;
    rotate ([0,0,-90]){
// main hanging screw/tack hole
        translate ([0,0,-0.1]) {
            cylinder (h=screw_depth+0.2, r=screw_head_opening/2);
        }

// hanging screw/tack recessed inner slot
        preview_depth_adjust = round(PREVIEW_mode) * screw_retention_depth-0.1;
        hull (){
            translate ([0,0,preview_depth_adjust]) {cylinder (h=(screw_depth)+0.2, r=(screw_head_opening/2));}
            translate ([-screw_head_opening,0,preview_depth_adjust]){cylinder (h=(screw_depth)+0.2, r=(screw_head_opening/2));}
        }
// hanging screw/tack shaft slot
        hull (){
            translate ([0,0,-0.1]) {cylinder (h=(screw_depth)+0.2, r=(screw_shaft_opening/2) );}
            translate ([-screw_head_opening/1.25,0,-0.1]){cylinder (h=(screw_depth)+0.2, r=(screw_shaft_opening/2) );}
        }
    }
} 

module letter(l) {
    letter_fn = letter_detail;
    rounding_fn = corner_detail;
    minkowski () {
        difference () { sphere (r=rounded_corners, $fn=rounding_fn); translate ([0,0,-rounded_corners]) cube (rounded_corners*2,center = true);}
        linear_extrude(height = letter_height) {
            text(l, size = letter_size, font = font, halign = "center", valign = "center", $fn = letter_fn);
        }
    }
}
