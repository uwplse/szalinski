//
// LEGO DUPLO BRICK GENERATOR
//
// Author: Emanuele Iannone (emanuele@fondani.it)
//
// Url: https://www.thingiverse.com/thing:3113862
//
// Modified for colour letters on top, rounded
// edges, ridges and corners, and sloped stud tops 
//
// by 247generator@thingiverse - 2018
//
// https://www.thingiverse.com/thing:3122711
//

/* [Main] */

// size along X axis (in studs)
X_size = 2; // [1:35]

// size along Y axis (in studs)
Y_size = 2; // [1:35]

// (1 = standard brick height, 0.5 = base or cap)
Height_factor = 1; // [0.5,1,2,3,4,5]

// brick or a thin base plate
base_type = 1; // [1:Brick, 2:Base Plate]

// letters or studs on top
Studs = 1; // [0:Letters, 1:Studs]

// add extended triangular support ridges for taller bricks
Extended_Ridges = 1; // [0:No extended ridges, 1:Add extended ridges]

// easier printing and stronger (safer) center cylinder
print_helper = 2; // [0:Normal 4 section flex cylinder, 1:Full circle at bottom, 2:Solid center cylinder]

/* [Color text options] */

// accepts codes like \u263A or \u00F7 for symbols: https://en.wikipedia.org/wiki/Miscellaneous_Symbols
text ="A";
// font = "Segoe Print:style=Regular"; // this line is for local fonts, the next line-list is for thingiverse customizer only
 font = "Liberation Sans"; // [Arial, ABeeZee, Abel, Abril Fatface, Aclonica, Acme, Actor, Adamina, Advent Pro, Aguafina Script, Akronim, Aladin, Aldrich, Alef, Alegreya, Alegreya SC, Alegreya Sans, Alegreya Sans SC, Alex Brush, Alfa Slab One, Alice, Alike, Alike Angular, Allan, Allerta, Allerta Stencil, Allura, Almendra, Almendra Display, Almendra SC, Amarante, Amaranth, Amatic SC, Amethysta, Amiri, Amita, Anaheim, Andada, Andika, Angkor, Annie Use Your Telescope, Anonymous Pro, Antic, Antic Didone, Antic Slab, Anton, Arapey, Arbutus, Arbutus Slab, Architects Daughter, Archivo Black, Archivo Narrow, Arimo, Arizonia, Armata, Artifika, Arvo, Arya, Asap, Asar, Asset, Astloch, Asul, Atomic Age, Aubrey, Audiowide, Autour One, Average, Average Sans, Averia Gruesa Libre, Averia Libre, Averia Sans Libre, Averia Serif Libre, Bad Script, Balthazar, Bangers, Basic, Battambang, Baumans, Bayon, Belgrano, Belleza, BenchNine, Bentham, Berkshire Swash, Bevan, Bigelow Rules, Bigshot One, Bilbo, Bilbo Swash Caps, Biryani, Bitter, Black Ops One, Bokor, Bonbon, Boogaloo, Bowlby One, Bowlby One SC, Brawler, Bree Serif, Bubblegum Sans, Bubbler One, Buda, Buenard, Butcherman, Butterfly Kids, Cabin, Cabin Condensed, Cabin Sketch, Caesar Dressing, Cagliostro, Calligraffitti, Cambay, Cambo, Candal, Cantarell, Cantata One, Cantora One, Capriola, Cardo, Carme, Carrois Gothic, Carrois Gothic SC, Carter One, Catamaran, Caudex, Caveat, Caveat Brush, Cedarville Cursive, Ceviche One, Changa One, Chango, Chau Philomene One, Chela One, Chelsea Market, Chenla, Cherry Cream Soda, Cherry Swash, Chewy, Chicle, Chivo, Chonburi, Cinzel, Cinzel Decorative, Clicker Script, Coda, Coda Caption, Codystar, Combo, Comfortaa, Coming Soon, Concert One, Condiment, Content, Contrail One, Convergence, Cookie, Copse, Corben, Courgette, Cousine, Coustard, Covered By Your Grace, Crafty Girls, Creepster, Crete Round, Crimson Text, Croissant One, Crushed, Cuprum, Cutive, Cutive Mono, Damion, Dancing Script, Dangrek, Dawning of a New Day, Days One, Dekko, Delius, Delius Swash Caps, Delius Unicase, Della Respira, Denk One, Devonshire, Dhurjati, Didact Gothic, Diplomata, Diplomata SC, Domine, Donegal One, Doppio One, Dorsa, Dosis, Dr Sugiyama, Droid Sans, Droid Sans Mono, Droid Serif, Duru Sans, Dynalight, EB Garamond, Eagle Lake, Eater, Economica, Eczar, Ek Mukta, Electrolize, Elsie, Elsie Swash Caps, Emblema One, Emilys Candy, Engagement, Englebert, Enriqueta, Erica One, Esteban, Euphoria Script, Ewert, Exo, Exo 2, Expletus Sans, Fanwood Text, Fascinate, Fascinate Inline, Faster One, Fasthand, Fauna One, Federant, Federo, Felipa, Fenix, Finger Paint, Fira Mono, Fira Sans, Fjalla One, Fjord One, Flamenco, Flavors, Fondamento, Fontdiner Swanky, Forum, Francois One, Freckle Face, Fredericka the Great, Fredoka One, Freehand, Fresca, Frijole, Fruktur, Fugaz One, GFS Didot, GFS Neohellenic, Gabriela, Gafata, Galdeano, Galindo, Gentium Basic, Gentium Book Basic, Geo, Geostar, Geostar Fill, Germania One, Gidugu, Gilda Display, Give You Glory, Glass Antiqua, Glegoo, Gloria Hallelujah, Goblin One, Gochi Hand, Gorditas, Goudy Bookletter 1911, Graduate, Grand Hotel, Gravitas One, Great Vibes, Griffy, Gruppo, Gudea, Gurajada, Habibi, Halant, Hammersmith One, Hanalei, Hanalei Fill, Handlee, Hanuman, Happy Monkey, Headland One, Henny Penny, Herr Von Muellerhoff, Hind, Hind Siliguri, Hind Vadodara, Holtwood One SC, Homemade Apple, Homenaje, IM Fell DW Pica, IM Fell DW Pica SC, IM Fell Double Pica, IM Fell Double Pica SC, IM Fell English, IM Fell English SC, IM Fell French Canon, IM Fell French Canon SC, IM Fell Great Primer, IM Fell Great Primer SC, Iceberg, Iceland, Imprima, Inconsolata, Inder, Indie Flower, Inika, Inknut Antiqua, Irish Grover, Istok Web, Italiana, Italianno, Itim, Jacques Francois, Jacques Francois Shadow, Jaldi, Jim Nightshade, Jockey One, Jolly Lodger, Josefin Sans, Josefin Slab, Joti One, Judson, Julee, Julius Sans One, Junge, Jura, Just Another Hand, Just Me Again Down Here, Kadwa, Kalam, Kameron, Kantumruy, Karla, Karma, Kaushan Script, Kavoon, Kdam Thmor, Keania One, Kelly Slab, Kenia, Khand, Khmer, Khula, Kite One, Knewave, Kotta One, Koulen, Kranky, Kreon, Kristi, Krona One, Kurale, La Belle Aurore, Laila, Lakki Reddy, Lancelot, Lateef, Lato, League Script, Leckerli One, Ledger, Lekton, Lemon, Liberation Sans, Liberation Serif, Libre Baskerville, Life Savers, Lilita One, Lily Script One, Limelight, Linden Hill, Lobster, Lobster Two, Londrina Outline, Londrina Shadow, Londrina Sketch, Londrina Solid, Lora, Love Ya Like A Sister, Loved by the King, Lovers Quarrel, Luckiest Guy, Lusitana, Lustria, Macondo, Macondo Swash Caps, Magra, Maiden Orange, Mako, Mallanna, Mandali, Marcellus, Marcellus SC, Marck Script, Margarine, Marko One, Marmelad, Martel, Martel Sans, Marvel, Mate, Mate SC, Maven Pro, McLaren, Meddon, MedievalSharp, Medula One, Megrim, Meie Script, Merienda, Merienda One, Merriweather, Merriweather Sans, Metal, Metal Mania, Metamorphous, Metrophobic, Michroma, Milonga, Miltonian, Miltonian Tattoo, Miniver, Miss Fajardose, Modak, Modern Antiqua, Molengo, Molle, Monda, Monofett, Monoton, Monsieur La Doulaise, Montaga, Montez, Montserrat, Montserrat Alternates, Montserrat Subrayada, Moul, Moulpali, Mountains of Christmas, Mouse Memoirs, Mr Bedfort, Mr Dafoe, Mr De Haviland, Mrs Saint Delafield, Mrs Sheppards, Muli, Mystery Quest, NTR, Neucha, Neuton, New Rocker, News Cycle, Niconne, Nixie One, Nobile, Nokora, Norican, Nosifer, Nothing You Could Do, Noticia Text, Noto Sans, Noto Serif, Nova Cut, Nova Flat, Nova Mono, Nova Oval, Nova Round, Nova Script, Nova Slim, Nova Square, Numans, Nunito, Odor Mean Chey, Offside, Old Standard TT, Oldenburg, Oleo Script, Oleo Script Swash Caps, Open Sans, Open Sans Condensed, Oranienbaum, Orbitron, Oregano, Orienta, Original Surfer, Oswald, Over the Rainbow, Overlock, Overlock SC, Ovo, Oxygen, Oxygen Mono, PT Mono, PT Sans, PT Sans Caption, PT Sans Narrow, PT Serif, PT Serif Caption, Pacifico, Palanquin, Palanquin Dark, Paprika, Parisienne, Passero One, Passion One, Pathway Gothic One, Patrick Hand, Patrick Hand SC, Patua One, Paytone One, Peddana, Peralta, Permanent Marker, Petit Formal Script, Petrona, Philosopher, Piedra, Pinyon Script, Pirata One, Plaster, Play, Playball, Playfair Display, Playfair Display SC, Podkova, Poiret One, Poller One, Poly, Pompiere, Pontano Sans, Poppins, Port Lligat Sans, Port Lligat Slab, Pragati Narrow, Prata, Preahvihear, Press Start 2P, Princess Sofia, Prociono, Prosto One, Puritan, Purple Purse, Quando, Quantico, Quattrocento, Quattrocento Sans, Questrial, Quicksand, Quintessential, Qwigley, Racing Sans One, Radley, Rajdhani, Raleway, Raleway Dots, Ramabhadra, Ramaraja, Rambla, Rammetto One, Ranchers, Rancho, Ranga, Rationale, Ravi Prakash, Redressed, Reenie Beanie, Revalia, Rhodium Libre, Ribeye, Ribeye Marrow, Righteous, Risque, Roboto, Roboto Condensed, Roboto Mono, Roboto Slab, Rochester, Rock Salt, Rokkitt, Romanesco, Ropa Sans, Rosario, Rosarivo, Rouge Script, Rozha One, Rubik, Rubik Mono One, Rubik One, Ruda, Rufina, Ruge Boogie, Ruluko, Rum Raisin, Ruslan Display, Russo One, Ruthie, Rye, Sacramento, Sahitya, Sail, Salsa, Sanchez, Sancreek, Sansita One, Sarala, Sarina, Sarpanch, Satisfy, Scada, Scheherazade, Schoolbell, Seaweed Script, Sevillana, Seymour One, Shadows Into Light, Shadows Into Light Two, Shanti, Share, Share Tech, Share Tech Mono, Shojumaru, Short Stack, Siemreap, Sigmar One, Signika, Signika Negative, Simonetta, Sintony, Sirin Stencil, Six Caps, Skranji, Slabo 13px, Slabo 27px, Slackey, Smokum, Smythe, Sniglet, Snippet, Snowburst One, Sofadi One, Sofia, Sonsie One, Sorts Mill Goudy, Source Code Pro, Source Sans Pro, Source Serif Pro, Special Elite, Spicy Rice, Spinnaker, Spirax, Squada One, Sree Krushnadevaraya, Stalemate, Stalinist One, Stardos Stencil, Stint Ultra Condensed, Stint Ultra Expanded, Stoke, Strait, Sue Ellen Francisco, Sumana, Sunshiney, Supermercado One, Sura, Suranna, Suravaram, Suwannaphum, Swanky and Moo Moo, Syncopate, Tangerine, Taprom, Tauri, Teko, Telex, Tenali Ramakrishna, Tenor Sans, Text Me One, The Girl Next Door, Tienne, Tillana, Timmana, Tinos, Titan One, Titillium Web, Trade Winds, Trocchi, Trochut, Trykker, Tulpen One, Ubuntu, Ubuntu Condensed, Ubuntu Mono, Ultra, Uncial Antiqua, Underdog, Unica One, UnifrakturCook, UnifrakturMaguntia, Unkempt, Unlock, Unna, VT323, Vampiro One, Varela, Varela Round, Vast Shadow, Vesper Libre, Vibur, Vidaloka, Viga, Voces, Volkhov, Vollkorn, Voltaire, Waiting for the Sunrise, Wallpoet, Walter Turncoat, Warnes, Wellfleet, Wendy One, Wingdings, Wire One, Work Sans, Yanone Kaffeesatz, Yantramanav, Yellowtail, Yeseva One, Yesteryear, Zeyada]
// some fonts need to scale up or down from what works with the default font (check Q and W)
letter_scale = 3; // [1.1:0.1:16]
letter_height = 2; //[0.1:0.1:5]
// make the brick and letter for mono or dual color printers
multi_material = 0; // [0:Single color, 1:Dual color base,2:Dual color letter only]
// how far the letter embosses into the brick
letter_inset = 0.4; //[0:0.1:2]
// low numbers for quick previewing, 60+ segments look smooth
letter_detail = 40; //[16:2:100]

/* [Advanced] */
// size of a single stud section
base_unit = 15.75;
// standard height of a block (0.1 added to make up for first layer adhesion squish)
std_height = 19.35;
// vertical walls thickness
wall_thickness = 1.2;
// top surface thickness
roof_thickness = 1.4;
// thin base plate thickness (minimum of double rounded corners)
base_plate_thickness = 1.8;
// stud outer radius
stud_radius = 4.7;
// height of the gripping section of the stud
stud_height = 4.0;
// height of the guiding section of the stud
stud_guide = 0.7;
// internal cylinder outer radius
cyl_radius = 6.6;
// internal cylinder thickness
cyl_thickness = 1.2;
// size of cylinder-roof support triangles
triangle_size = 14;
// grip thickness
ridge_thickness = 1.2;
// ridge extension (controls grip)
ridge_width = 3.1;
// cylinder curve segments / complexity
curve_detail = 60; //[16:2:100]
// Duplo has unsharp corners for safety, printing thinner layers improves roundness
rounded_corners = 0.9; //[0.0:0.1:2.0]
// how curved or polygonal the above rounded corners are
corner_detail = 5; //[5:1:60]
// 


letter_size = ((base_unit * min(X_size,Y_size))-(base_unit * min(X_size,Y_size))/letter_scale);
origin = (std_height*Height_factor)-letter_inset;

// Make a a normal brick, a thin base plate, or just a floating letter for multi material 
if (base_type == 1 && multi_material == 2){
    translate([(base_unit * X_size)/2, (base_unit * Y_size)/2, origin]) color ("green")  letter(text);   }else if (base_type == 2){
        base_plate(X_size, Y_size, base_plate_thickness);
        }else{
            brick(X_size, Y_size, Height_factor, Studs);
        }
        


module brick(nx, ny, heightfact, studs=true){
    height = heightfact * std_height;
    dx = nx * base_unit;
    dy = ny * base_unit;
    
    union() {
        // Shell
        difference() {
                rcube([dx, dy, height], rounded_corners);
            translate(v=[wall_thickness, wall_thickness, -1]) {
                cube([dx - (wall_thickness * 2), dy - (wall_thickness * 2), height - roof_thickness + 1]);
            }
            if (multi_material == 1 && studs == 0){
        // Emboss text
    translate([(base_unit * X_size)/2, (base_unit * Y_size)/2, origin]) color("yellow") letter(text);   
        }
    }
    
        // Studs
        if (studs) for (r=[0:nx-1])for (c=[0:ny-1]){
            stud((base_unit/2) + r * base_unit, base_unit/2 + c * base_unit, height, stud_radius);
        // Letter top block
        }else if (multi_material == 0){
    translate([(base_unit * X_size)/2, (base_unit * Y_size)/2, origin]) color ("green")  letter(text);   
        }
        // Internal cylinders
        if (nx > 1 && ny > 1) for(r=[1:nx-1]) for(c=[1:ny-1]) {
            internal_cyl(base_unit * r, base_unit * c, height - roof_thickness + 0.1);
        }
    
        // Ridges
        ridgeset(0, 0, 0, nx, height);
        ridgeset(dx, dy, 180, nx, height);
        ridgeset(0, dy, -90, ny, height);
        ridgeset(dx, 0, 90, ny, height);
    }
}

module base_plate (nx, ny, height) {
    dx = nx * base_unit;
    dy = ny * base_unit;
        
    // plate
    //translate ([ dx/2, dy/2, (height/4)*3]) { linear_extrude ( height = (height/4), scale = 0.98)  square([dx, dy], center = true);}
        rcube ([dx, dy, (height)], rounded_corners);
        
    // studs
    for (r=[0:nx-1])for (c=[0:ny-1]){
            stud((base_unit/2) + r * base_unit, base_unit/2 + c * base_unit, height, stud_radius);}
    }

module letter(l) {
  linear_extrude(height = letter_height+0.1) {
    text(l, size = letter_size, font = font, halign = "center", valign = "center", $fn = letter_detail);
  }
}

module stud(x, y, z, r){
  translate(v=[x, y, stud_height/2 + z]){
    difference(){
       union(){
           cylinder(h=stud_height, r=r, center=true, $fn=curve_detail);
        translate([0,0,((stud_height+stud_guide)/2)]){color ("green") cylinder(h=stud_guide, r1=r, r2=r-(r*0.12), center=true, $fn=curve_detail);}}
       cylinder(h=(stud_height+stud_guide)*1.5, r1=r-2.4, r2=r-1.2, center=true, $fn=curve_detail);
    }
  }
}

module internal_cyl(x, y, h) {
    
    translate(v=[x, y, 0]) difference() {
        union() {
            cylinder(h=h, r=cyl_radius, $fn=curve_detail);
            translate([0,0,h]) {
                if (Height_factor >= 1) {   // normal triangular ridges
                rotate([-90,0,45]) linear_extrude(height = ridge_thickness, center=true)
                    polygon([[-base_unit*0.8,0],[base_unit*0.8,0],[0,triangle_size]]);
                rotate([-90,0,-45]) linear_extrude(height = ridge_thickness, center=true)
                    polygon([[-base_unit*0.8,0],[base_unit*0.8,0],[0,triangle_size]]);
                }else{                      // smaller triangular ridges for short bricks
                rotate([-90,0,45]) linear_extrude(height = ridge_thickness, center=true)
                    polygon([[-base_unit*0.8,0],[base_unit*0.8,0],[0,min(triangle_size,6)]]);
                rotate([-90,0,-45]) linear_extrude(height = ridge_thickness, center=true)
                    polygon([[-base_unit*0.8,0],[base_unit*0.8,0],[0,min(triangle_size,6)]]);
                    
                    }}
        }
        cylinder(h=h*3, r=cyl_radius-cyl_thickness, center=true, $fn=curve_detail);   
        
  // split cylynder at bottom (or not) for flex grip
        if (print_helper < 2) { translate ([0,0,2.9+print_helper*0.5]){        
        cube(size=[cyl_radius*2, 1.2, 6.1-print_helper], center=true); 
        cube(size=[1.2, cyl_radius*2, 6.1-print_helper], center=true); 
    }}
    }
}

module ridgeset(x, y, angle, n, height){
    translate([x, y, 0]) rotate([0, 0, angle]) {
        for (i=[1:2*n-1]){
  // Extended Ridge
            translate([(i*base_unit - ridge_thickness)/2,0,0]) rotate([90,0,90]) {
                {translate([(wall_thickness-0.2),0,0]){ // keeps them from sticking out of outside rounded corners
                if (Extended_Ridges && Height_factor > 1) {
                    linear_extrude(height = ridge_thickness, center=false) 
                        polygon([[0,height - std_height-roof_thickness],[0,height],[10,height]]);
                }
                if (i % 2)  
  // standard ridge
                    union () {
                        translate ([ridge_width-(ridge_width/1.79),ridge_width/4,0]) cylinder (r=ridge_width/4, h=ridge_thickness, $fn=corner_detail);
                    translate ([0,(ridge_width/6),0]) cube([ridge_width-wall_thickness+0.2, height-roof_thickness-(ridge_width/6), ridge_thickness]);
                        cube([(ridge_width-wall_thickness+0.2)/1.5, height-roof_thickness-(ridge_width/8), ridge_thickness]);
                }}
            }  
        }}
    }
}
// Rounded primitives for openscad
// (c) 2013 Wouter Robers 
// crude hack for centering and 0 rounding fail - 2018 by 247generator
module rcube(Size=[10,10,10],b=1,center=false)
{$fn=corner_detail;b=b+0.00001;if (center==true){m=0;translate([(Size[0]*m),(Size[1]*m),(Size[2]*m)]){hull(){for(x=[-(Size[0]/2-b),(Size[0]/2-b)]){for(y=[-(Size[1]/2-b),(Size[1]/2-b)]){for(z=[-(Size[2]/2-b),(Size[2]/2-b)]){ translate([x,y,z]) sphere(b);}}}}}}else{m=0.5;translate([(Size[0]*m),(Size[1]*m),(Size[2]*m)]){hull(){for(x=[-(Size[0]/2-b),(Size[0]/2-b)]){for(y=[-(Size[1]/2-b),(Size[1]/2-b)]){for(z=[-(Size[2]/2-b),(Size[2]/2-b)]){ translate([x,y,z]) sphere(b);}}}}}}}
