// preview[view:south, tilt:top]

$fn=16*1;



E = 0.01*1; // epsilon value -- a small value big enough to avoid dumb roundings

/* [General] */

// Text to be displayed
content="Please ring bell";

// Width of the text (mm)
text_width=50; // [1:150]

// Height of the text (mm)
text_height = 10; // [1:50]

// Thickness of the bottom plate (mm)
base_thickness=0.4;

// Extra space around the test (mm)
margin=4; // [0:10]

// What kind of shape on the corners?
margin_type = "chamfer"; //[round,square,chamfer]

// Add mounting holes?
holes = "left+right"; // [none,top,left,right,left+right,corners]

// Mounting hole diameter (mm)
hole_dia = 4; // [1:20]

// Width of the raised border, in tenths of a millimeter (0.1mm's)
border_width_tenths = 10; // [0:50]
border_width = min([margin,border_width_tenths/10]);

// Vertical thickness of the border. Optional, set to 0 to disable (mm)
border_thickness = 1; // [0:20];

/* [Font] */

// Please refer: http://www.google.com/fonts
font_name="Helvetica"; //[ABeeZee,Abel,Abril Fatface,Aclonica,Acme,Actor,Adamina,Advent Pro,Aguafina Script,Akronim,Aladin,Aldrich,Alef,Alegreya,Alegreya Sans,Alegreya Sans SC,Alegreya SC,Alex Brush,Alfa Slab One,Alice,Alike,Alike Angular,Allan,Allerta,Allerta Stencil,Allura,Almendra,Almendra Display,Almendra SC,Amarante,Amaranth,Amatic SC,Amethysta,Amiri,Anaheim,Andada,Andada SC,Andika,Angkor,Annie Use Your Telescope,Anonymous Pro,Antic,Antic Didone,Antic Slab,Anton,Antonio,Arapey,Arbutus,Arbutus Slab,Architects Daughter,Archivo Black,Archivo Narrow,Arimo,Arizonia,Armata,Artifika,Arvo,Asap,Asset,Astloch,Asul,Atomic Age,Aubrey,Audiowide,Autour One,Average,Average Sans,Averia Gruesa Libre,Averia Libre,Averia Sans Libre,Averia Serif Libre,Bad Script,Balthazar,Bangers,Basic,Battambang,Baumans,Bayon,Belgrano,Belleza,BenchNine,Bentham,Berkshire Swash,Bevan,Bhavuka,Bigelow Rules,Bigshot One,Bilbo,Bilbo Swash Caps,Bitter,Black Ops One,Bokor,Bonbon,Boogaloo,Bowlby One,Bowlby One SC,Brawler,Bree Serif,Bruno Ace,Bruno Ace SC,Bubblegum Sans,Bubbler One,Buda,Buenard,Butcherman,Butcherman Caps,Butterfly Kids,Cabin,Cabin Condensed,Cabin Sketch,Caesar Dressing,Cagliostro,Calligraffitti,Cambay,Cambo,Candal,Cantarell,Cantata One,Cantora One,Capriola,Cardo,Carme,Carrois Gothic,Carrois Gothic SC,Carter One,Caudex,Cedarville Cursive,Ceviche One,Changa,Changa One,Chango,Chau Philomene One,Chela One,Chelsea Market,Chenla,Cherry Cream Soda,Cherry Swash,Chewy,Chicle,Chivo,Cinzel,Cinzel Decorative,Clara,Clicker Script,Coda,Coda Caption,Codystar,Combo,Comfortaa,Coming Soon,Concert One,Condiment,Content,Contrail One,Convergence,Cookie,Copse,Corben,Courgette,Cousine,Coustard,Covered By Your Grace,Crafty Girls,Creepster,Creepster Caps,Crete Round,Crimson Text,Croissant One,Crushed,Cuprum,Cutive,Cutive Mono,Damion,Dancing Script,Dangrek,Dawning of a New Day,Days One,Dekko,Delius,Delius Swash Caps,Delius Unicase,Della Respira,Denk One,Devonshire,Dhurjati,Dhyana,Didact Gothic,Dinah,Diplomata,Diplomata SC,Domine,Donegal One,Doppio One,Dorsa,Dosis,Droid Arabic Kufi,Droid Arabic Naskh,Droid Sans,Droid Sans Ethiopic,Droid Sans Mono,Droid Sans Thai,Droid Serif,Droid Serif Thai,Dr Sugiyama,Duru Sans,Dynalight,Eagle Lake,Eater,Eater Caps,EB Garamond,Economica,Eczar,Ek Mukta,Electrolize,Elsie,Elsie Swash Caps,Emblema One,Emilys Candy,Encode Sans,Encode Sans Compressed,Encode Sans Condensed,Encode Sans Narrow,Encode Sans Wide,Engagement,Englebert,Enriqueta,Erica One,Esteban,Euphoria Script,Ewert,Exo,Exo 2,Expletus Sans,Fanwood Text,Fascinate,Fascinate Inline,Faster One,Fasthand,Fauna One,Federant,Federo,Felipa,Fenix,Finger Paint,Fira Mono,Fira Sans,Fjalla One,Fjord One,Flamenco,Flavors,Fondamento,Fontdiner Swanky,Forum,Francois One,Freckle Face,Fredericka the Great,Fredoka One,Freehand,Fresca,Frijole,Fruktur,Fugaz One,Gabriela,Gafata,Galdeano,Galindo,Gentium Basic,Gentium Book Basic,Geo,Geostar,Geostar Fill,Germania One,GFS Didot,GFS Neohellenic,Gidugu,Gilda Display,Give You Glory,Glass Antiqua,Glegoo,Gloria Hallelujah,Goblin One,Gochi Hand,Gorditas,Goudy Bookletter 1911,Graduate,Grand Hotel,Gravitas One,Great Vibes,Griffy,Gruppo,Gudea,Gurajada,Habibi,Halant,Hammersmith One,Hanalei,Hanalei Fill,Handlee,Hanuman,Happy Monkey,Headland One,Helvetica,Henny Penny,Hermeneus One,Herr Von Muellerhoff,Hind,Holtwood One SC,Homemade Apple,Homenaje,Iceberg,Iceland,IM Fell Double Pica,IM Fell Double Pica SC,IM Fell DW Pica,IM Fell DW Pica SC,IM Fell English,IM Fell English SC,IM Fell French Canon,IM Fell French Canon SC,IM Fell Great Primer,IM Fell Great Primer SC,Imprima,Inconsolata,Inder,Indie Flower,Inika,Inknut Antiqua,Irish Grover,Irish Growler,Istok Web,Italiana,Italianno,Jacques Francois,Jacques Francois Shadow,Jaldi,Jim Nightshade,Jockey One,Jolly Lodger,Josefin Sans,Josefin Sans Std Light,Josefin Slab,Joti One,Judson,Julee,Julius Sans One,Junge,Jura,Just Another Hand,Just Me Again Down Here,Kadwa,Kalam,Kameron,Kantumruy,Karla,Karla Tamil Inclined,Karla Tamil Upright,Karma,Kaushan Script,Kavoon,Kdam Thmor,Keania One,Kelly Slab,Kenia,Khand,Khmer,Khula,Kite One,Knewave,Kotta One,Koulen,Kranky,Kreon,Kristi,Krona One,La Belle Aurore,Laila,Lakki Reddy,Lancelot,Lateef,Lato,League Script,Leckerli One,Ledger,Lekton,Lemon,Lemon One,Liberation Sans ,Libre Baskerville,Libre Caslon Text,Life Savers,Lilita One,Lily Script One,Limelight,Linden Hill,Lobster,Lobster Two,Lohit Bengali,Lohit Tamil,Londrina Outline,Londrina Shadow,Londrina Sketch,Londrina Solid,Lora,Loved by the King,Lovers Quarrel,Love Ya Like A Sister,Luckiest Guy,Lusitana,Lustria,Macondo,Macondo Swash Caps,Magra,Maiden Orange,Mako,Mallanna,Mandali,Marcellus,Marcellus SC,Marck Script,Margarine,Marko One,Marmelad,Martel Sans,Marvel,Mate,Mate SC,Maven Pro,McLaren,Meddon,MedievalSharp,Medula One,Megrim,Meie Script,Merge One,Merienda,Merienda One,Merriweather,Merriweather Sans,Mervale Script,Metal,Metal Mania,Metamorphous,Metrophobic,Miama,Michroma,Milonga,Miltonian,Miltonian Tattoo,Miniver,Miss Fajardose,Miss Saint Delafield,Modak,Modern Antiqua,Molengo,Molle,Monda,Monofett,Monoton,Monsieur La Doulaise,Montaga,Montez,Montserrat,Montserrat Alternates,Montserrat Subrayada,Moul,Moulpali,Mountains of Christmas,Mouse Memoirs,Mr Bedford,Mr Bedfort,Mr Dafoe,Mr De Haviland,Mrs Sheppards,Mrs Saint Delafield,Muli,Mystery Quest,Nanum Brush Script,Nanum Gothic,Nanum Gothic Coding,Nanum Myeongjo,Nanum Pen Script,NATS,Neucha,Neuton,New Rocker,News Cycle,Niconne,Nixie One,Nobile,Nokora,Norican,Nosifer,Nosifer Caps,Nothing You Could Do,Noticia Text,Noto Sans,Noto Sans Hebrew,Noto Sans Symbols,Noto Sans UI,Noto Serif,Nova Cut,Nova Flat,Nova Mono,Nova Oval,Nova Round,Nova Script,Nova Slim,Nova Square,NTR,Numans,Nunito,Odor Mean Chey,Offside,OFL Sorts Mill Goudy TT,Oldenburg,Old Standard TT,Oleo Script,Oleo Script Swash Caps,Open Sans,Open Sans Condensed,Oranienbaum,Orbitron,Oregano,Orienta,Original Surfer,Oswald,Overlock,Overlock SC,Over the Rainbow,Ovo,Oxygen,Oxygen Mono,Pacifico,Palanquin,Palanquin Dark,Paprika,Parisienne,Passero One,Passion One,Pathway Gothic One,Patrick Hand,Patrick Hand SC,Patua One,Paytone One,Pecita,Peddana,Peralta,Permanent Marker,Petit Formal Script,Petrona,Phetsarath,Philosopher,Piedra,Pinyon Script,Pirata One,Plaster,Play,Playball,Playfair Display,Playfair Display SC,Podkova,Poetsen One,Poiret One,Poller One,Poly,Pompiere,Ponnala,Pontano Sans,Poppins,Porter Sans Block,Port Lligat Sans,Port Lligat Slab,Prata,Preahvihear,Press Start 2P,Princess Sofia,Prociono,Prosto One,PT Mono,PT Sans,PT Sans Caption,PT Sans Narrow,PT Serif,PT Serif Caption,Puralecka Narrow,Puritan,Purple Purse,Quando,Quantico,Quattrocento,Quattrocento Sans,Questrial,Quicksand,Quintessential,Qwigley,Racing Sans One,Radley,Rajdhani,Raleway,Raleway Dots,Ramabhadra,Ramaraja,Rambla,Rammetto One,Ranchers,Rancho,Ranga,Rationale,Ravi Prakash,Redacted,Redacted Script,Redressed,Reenie Beanie,Revalia,Ribeye,Ribeye Marrow,Righteous,Risque,Roboto,Roboto Condensed,Roboto Slab,Rochester,Rock Salt,Rokkitt,Romanesco,Ropa Sans,Rosario,Rosarivo,Rouge Script,Rozha One,Rubik Mono One,Rubik One,Ruda,Rufina,Ruge Boogie,Ruluko,Rum Raisin,Ruslan Display,Russo One,Ruthie,Rye,Sacramento,Sail,Salsa,Sanchez,Sancreek,Sansation,Sansita One,Sarabun,Sarala,Sarina,Sarpanch,Satisfy,Scada,Scheherazade,Schoolbell,Seaweed Script,Sedan,Sedan SC,Sevillana,Seymour One,Shadows Into Light,Shadows Into Light Two,Shanti,Share,Share Tech,Share Tech Mono,Shojumaru,Short Stack,Siamreap,Siemreap,Sigmar One,Signika,Signika Negative,Simonetta,Sintony,Sirin Stencil,Six Caps,Skranji,Slabo 13px,Slabo 27px,Slackey,Smokum,Smythe,Sniglet,Snippet,Snowburst One,Sofadi One,Sofia,Sonsie One,Sorts Mill Goudy,Source Code Pro,Source Sans Pro,Source Serif Pro,Special Elite,Spicy Rice,Spinnaker,Spirax,Squada One,Sree Krushnadevaraya,Stalemate,Stalinist One,Stalin One,Stardos Stencil,Stint Ultra Condensed,Stint Ultra Expanded,Stoke,Strait,Strong,Sue Ellen Francisco,Sunshiney,Supermercado One,Suranna,Suravaram,Suwannaphum,Swanky and Moo Moo,Syncopate,Tangerine,Taprom,Tauri,Teko,Telex,Tenali Ramakrishna,Tenor Sans,Terminal Dosis,Terminal Dosis Light,Text Me One,Thabit,The Girl Next Door,Tienne,Tillana,Timmana,Tinos,Titan One,Titillium Web,Trade Winds,Trocchi,Trochut,Trykker,Tuffy,Tulpen One,Ubuntu,Ubuntu Condensed,Ubuntu Mono,Ultra,Uncial Antiqua,Underdog,Unica One,UnifrakturCook,UnifrakturMaguntia,Unkempt,Unlock,Unna,Vampiro One,Varela,Varela Round,Vast Shadow,Vesper Libre,Vibur,Vidaloka,Viga,Voces,Volkhov,Vollkorn,Voltaire,VT323,Waiting for the Sunrise,Wallpoet,Walter Turncoat,Warnes,Wellfleet,Wendy One,Wire One,Yanone Kaffeesatz,Yellowtail,Yeseva One,Yesteryear,Zeyada]

// Not all fonts support all weight styles, though most support 'normal' and 'bold' at least.
font_weight = "medium"; // [thin,light,normal,medium,bold,ultra-bold]

// Italic?
is_font_italic = "no"; // [no,yes]
font_italic = is_font_italic=="yes" ? true : false;

font = str(font_name,":style=",font_weight,font_italic?" italic":"");

// You can increase or decrease the thickness of the font with this.
text_fatness_percent = 0; // [-10:10]
text_fatness = text_fatness_percent/100 * text_height;

// Thickness (depth) of the text (-2 means "cut through", -1 means "cut into", 0 means "very subtly raised", other numbers set the raised text height in mm)
text_thickness_set = 2; // [-2:20]
text_thickness = 
    text_thickness_set==-2 ? -base_thickness :
    text_thickness_set==-1 ? -base_thickness/2 :
    text_thickness_set== 0 ? 0.1 :
    text_thickness_set;

color_text = [0.4,0.5,1.0]*1;
color_back = [0.2,0.2,0.9]*1;

/* ------------------------------ */

hole_margin_x = 
    holes=="left" ? 1*(hole_dia + margin) :
    holes=="right" ? 1*(hole_dia + margin) :
    holes=="left+right" ? 2*(hole_dia + margin) :
    holes=="corners" ? 2*(hole_dia + margin) : 
    0;
hole_margin_y = 
    holes=="top" ? 1*(hole_dia + margin) :
    holes=="corners" ? 1/2*(hole_dia + margin) :
    0;

text_nudge_x = 
    holes=="left"  ?  1/2*(hole_dia + margin) :
    holes=="right" ? -1/2*(hole_dia + margin) :
    0;

content_width  = hole_margin_x + text_width;
content_height = hole_margin_y + text_height;

module the_text() {
    color(color_text)
        translate([content_width/2+text_nudge_x,0,text_thickness<0 ? text_thickness-E : 0]) 
        linear_extrude(abs(text_thickness)+2*E) 
        offset(r=text_fatness)
        resize([text_width,text_height,0]) 
        text(content,font=font,halign="center",valign="bottom");
}

module base2d() {
    offset(
            delta   = (margin_type!="round"?margin:undef), 
            r       = (margin_type=="round"?margin:undef), 
            chamfer =  margin_type=="chamfer"
        )
        square([content_width,content_height]);
}

difference() {
    union() {
        translate([0,0,-base_thickness]) {
            color(color_back) linear_extrude(base_thickness,convexity=10) {
                difference() {
                    base2d();
                    if (holes=="left") {
                        translate([hole_dia/2,content_height/2]) circle(d=hole_dia);
                    } else if (holes=="right") {
                        translate([content_width-hole_dia/2,content_height/2]) circle(d=hole_dia);
                    } else if (holes=="left+right") {
                        translate([hole_dia/2,content_height/2]) circle(d=hole_dia);
                        translate([content_width-hole_dia/2,content_height/2]) circle(d=hole_dia);
                    } else if (holes=="top") {
                        translate([content_width/2,content_height-hole_dia/2]) circle(d=hole_dia);
                    } else if (holes=="corners") {
                        translate([hole_dia/2,content_height-hole_dia/2]) circle(d=hole_dia);
                        translate([hole_dia/2,hole_dia/2]) circle(d=hole_dia);
                        translate([content_width-hole_dia/2,content_height-hole_dia/2]) circle(d=hole_dia);
                        translate([content_width-hole_dia/2,hole_dia/2]) circle(d=hole_dia);
                    }
                }
            }
        }
        color(color_back) linear_extrude(border_thickness)
            difference() {
                base2d();
                offset(delta=-border_width) base2d();
            }
            
    }
    if (text_thickness<0) {
        the_text();
    }
}

if (text_thickness>=0) {
    the_text();
}