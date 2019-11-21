//---------------------------------
// Customizable 12 Dice
// Author: Monique de Wilt
// Website: Mowidesign.com
// Thanks to:  Werner Stein for adding dual color and streamlining code
// License: CC Attribution - Non-Commercial - Share Alike license. Version 2.4b (c) April 2015 please refer the complete license here: http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode
// Date: 17-april-2015
// Description: this is a customizable design to make your own 12 sided dice with numbers, text or symbols
// Off course you can change the size and the texts and furthermore you can choose a dualcolor dice. For the perfectionists there is also the possibility to change the font,the size of the texts, and the depth of the texts.
//----------------------------------
// preview[view:south, tilt:top]

/* [Essentials] */
// in mm
Size= 30; // [10:300]
//to show
part="SingleColorDice"; //[SingleColorDice,DualDice,DualLetters]
// use any letters, numbers or unicodes, see http://en.wikipedia.org/wiki/List_of_Unicode_characters
Text1= "1";
Text2= "2";
Text3= "3";
Text4= "A";
Text5= "B";
Text6= "C";
Text7= "Yes";
Text8= "No";
Text9= "\u00A9";
Text10= "\u221A";
Text11= "?";
Text12= "&";
/* [Tweaks] */
// preview here: http://www.google.com/fonts some fonts may not have all the unicode symbols
font = "Arial"; //[ABeeZee,Abel,Abril Fatface,Aclonica,Acme,Actor,Adamina,Advent Pro,Aguafina Script,Akronim,Aladin,Aldrich,Alef,Alegreya,Alegreya Sans,Alegreya Sans SC,Alegreya SC,Alex Brush,Alfa Slab One,Alice,Alike,Alike Angular,Allan,Allerta,Allerta Stencil,Allura,Almendra,Almendra Display,Almendra SC,Amarante,Amaranth,Amatic SC,Amethysta,Amiri,Anaheim,Andada,Andada SC,Andika,Angkor,Annie Use Your Telescope,Anonymous Pro,Antic,Antic Didone,Antic Slab,Anton,Antonio,Arapey,Arbutus,Arbutus Slab,Architects Daughter,Archivo Black,Archivo Narrow,Arial,Arial Black,Arimo,Arizonia,Armata,Artifika,Arvo,Asap,Asset,Astloch,Asul,Atomic Age,Aubrey,Audiowide,Autour One,Average,Average Sans,Averia Gruesa Libre,Averia Libre,Averia Sans Libre,Averia Serif Libre,Bad Script,Balthazar,Bangers,Basic,Battambang,Baumans,Bayon,Belgrano,Belleza,BenchNine,Bentham,Berkshire Swash,Bevan,Bhavuka,Bigelow Rules,Bigshot One,Bilbo,Bilbo Swash Caps,Bitter,Black Ops One,Bokor,Bonbon,Boogaloo,Bowlby One,Bowlby One SC,Brawler,Bree Serif,Bruno Ace,Bruno Ace SC,Bubblegum Sans,Bubbler One,Buda,Buenard,Butcherman,Butcherman Caps,Butterfly Kids,Cabin,Cabin Condensed,Cabin Sketch,Caesar Dressing,Cagliostro,Calligraffitti,Cambay,Cambo,Candal,Cantarell,Cantata One,Cantora One,Capriola,Cardo,Carme,Carrois Gothic,Carrois Gothic SC,Carter One,Caudex,Cedarville Cursive,Ceviche One,Changa,Changa One,Chango,Chau Philomene One,Chela One,Chelsea Market,Chenla,Cherry Cream Soda,Cherry Swash,Chewy,Chicle,Chivo,Cinzel,Cinzel Decorative,Clara,Clicker Script,Coda,Coda Caption,Codystar,Combo,Comfortaa,Comic Sans MS,Coming Soon,Concert One,Condiment,Content,Contrail One,Convergence,Cookie,Copse,Corben,Courgette,Cousine,Coustard,Covered By Your Grace,Crafty Girls,Creepster,Creepster Caps,Crete Round,Crimson Text,Croissant One,Crushed,Cuprum,Cutive,Cutive Mono,Damion,Dancing Script,Dangrek,Dawning of a New Day,Days One,DejaVu Sans,Dekko,Delius,Delius Swash Caps,Delius Unicase,Della Respira,Denk One,Devonshire,Dhurjati,Dhyana,Didact Gothic,Dinah,Diplomata,Diplomata SC,Domine,Donegal One,Doppio One,Dorsa,Dosis,Droid Arabic Kufi,Droid Arabic Naskh,Droid Sans,Droid Sans Ethiopic,Droid Sans Mono,Droid Sans Thai,Droid Serif,Droid Serif Thai,Dr Sugiyama,Duru Sans,Dynalight,Eagle Lake,Eater,Eater Caps,EB Garamond,Economica,Eczar,Ek Mukta,Electrolize,Elsie,Elsie Swash Caps,Emblema One,Emilys Candy,Encode Sans,Encode Sans Compressed,Encode Sans Condensed,Encode Sans Narrow,Encode Sans Wide,Engagement,Englebert,Enriqueta,Erica One,Esteban,Euphoria Script,Ewert,Exo,Exo 2,Expletus Sans,Fanwood Text,Fascinate,Fascinate Inline,Faster One,Fasthand,Fauna One,Federant,Federo,Felipa,Fenix,Finger Paint,Fira Mono,Fira Sans,Fjalla One,Fjord One,Flamenco,Flavors,Fondamento,Fontdiner Swanky,Forum,Francois One,Freckle Face,Fredericka the Great,Fredoka One,Freehand,Fresca,Frijole,Fruktur,Fugaz One,Gabriela,Gafata,Galdeano,Galindo,Geneva,Gentium Basic,Gentium Book Basic,Geo,Geostar,Geostar Fill,Germania One,GFS Didot,GFS Neohellenic,Gidugu,Gilda Display,Give You Glory,Glass Antiqua,Glegoo,Gloria Hallelujah,Goblin One,Gochi Hand,Gorditas,Goudy Bookletter 1911,Graduate,Grand Hotel,Gravitas One,Great Vibes,Griffy,Gruppo,Gudea,Gurajada,Habibi,Halant,Hammersmith One,Hanalei,Hanalei Fill,Handlee,Hanuman,Happy Monkey,Headland One,Helvetica,Henny Penny,Hermeneus One,Herr Von Muellerhoff,Hind,Holtwood One SC,Homemade Apple,Homenaje,Iceberg,Iceland,IM Fell Double Pica,IM Fell Double Pica SC,IM Fell DW Pica,IM Fell DW Pica SC,IM Fell English,IM Fell English SC,IM Fell French Canon,IM Fell French Canon SC,IM Fell Great Primer,IM Fell Great Primer SC,Imprima,Inconsolata,Inder,Indie Flower,Inika,Inknut Antiqua,Irish Grover,Irish Growler,Istok Web,Italiana,Italianno,Jacques Francois,Jacques Francois Shadow,Jaldi,Jim Nightshade,Jockey One,Jolly Lodger,Josefin Sans,Josefin Sans Std Light,Josefin Slab,Joti One,Judson,Julee,Julius Sans One,Junge,Jura,Just Another Hand,Just Me Again Down Here,Kadwa,Kalam,Kameron,Kantumruy,Karla,Karla Tamil Inclined,Karla Tamil Upright,Karma,Kaushan Script,Kavoon,Kdam Thmor,Keania One,Kelly Slab,Kenia,Khand,Khmer,Khula,Kite One,Knewave,Kotta One,Koulen,Kranky,Kreon,Kristi,Krona One,La Belle Aurore,Laila,Lakki Reddy,Lancelot,Lateef,Lato,League Script,Leckerli One,Ledger,Lekton,Lemon,Lemon One,Liberation Sans ,Libre Baskerville,Libre Caslon Text,Life Savers,Lilita One,Lily Script One,Limelight,Linden Hill,Lobster,Lobster Two,Lohit Bengali,Lohit Tamil,Londrina Outline,Londrina Shadow,Londrina Sketch,Londrina Solid,Lora,Loved by the King,Lovers Quarrel,Love Ya Like A Sister,Luckiest Guy,Lusitana,Lustria,Macondo,Macondo Swash Caps,Magra,Maiden Orange,Mako,Mallanna,Mandali,Marcellus,Marcellus SC,Marck Script,Margarine,Marko One,Marmelad,Martel Sans,Marvel,Mate,Mate SC,Maven Pro,McLaren,Meddon,MedievalSharp,Medula One,Megrim,Meie Script,Merge One,Merienda,Merienda One,Merriweather,Merriweather Sans,Mervale Script,Metal,Metal Mania,Metamorphous,Metrophobic,Miama,Michroma,Milonga,Miltonian,Miltonian Tattoo,Miniver,Miss Fajardose,Miss Saint Delafield,Modak,Modern Antiqua,Molengo,Molle,Monda,Monofett,Monoton,Monsieur La Doulaise,Montaga,Montez,Montserrat,Montserrat Alternates,Montserrat Subrayada,Moul,Moulpali,Mountains of Christmas,Mouse Memoirs,Mr Bedford,Mr Bedfort,Mr Dafoe,Mr De Haviland,Mrs Sheppards,Mrs Saint Delafield,Muli,Mystery Quest,Nanum Brush Script,Nanum Gothic,Nanum Gothic Coding,Nanum Myeongjo,Nanum Pen Script,NATS,Neucha,Neuton,New Rocker,News Cycle,Niconne,Nixie One,Nobile,Nokora,Norican,Nosifer,Nosifer Caps,Nothing You Could Do,Noticia Text,Noto Sans,Noto Sans Hebrew,Noto Sans Symbols,Noto Sans UI,Noto Serif,Nova Cut,Nova Flat,Nova Mono,Nova Oval,Nova Round,Nova Script,Nova Slim,Nova Square,NTR,Numans,Nunito,Odor Mean Chey,Offside,OFL Sorts Mill Goudy TT,Oldenburg,Old Standard TT,Oleo Script,Oleo Script Swash Caps,Open Sans,Open Sans Condensed,Oranienbaum,Orbitron,Oregano,Orienta,Original Surfer,Oswald,Overlock,Overlock SC,Over the Rainbow,Ovo,Oxygen,Oxygen Mono,Pacifico,Palanquin,Palanquin Dark,Paprika,Parisienne,Passero One,Passion One,Pathway Gothic One,Patrick Hand,Patrick Hand SC,Patua One,Paytone One,Pecita,Peddana,Peralta,Permanent Marker,Petit Formal Script,Petrona,Phetsarath,Philosopher,Piedra,Pinyon Script,Pirata One,Plaster,Play,Playball,Playfair Display,Playfair Display SC,Podkova,Poetsen One,Poiret One,Poller One,Poly,Pompiere,Ponnala,Pontano Sans,Poppins,Porter Sans Block,Port Lligat Sans,Port Lligat Slab,Prata,Preahvihear,Press Start 2P,Princess Sofia,Prociono,Prosto One,PT Mono,PT Sans,PT Sans Caption,PT Sans Narrow,PT Serif,PT Serif Caption,Puralecka Narrow,Puritan,Purple Purse,Quando,Quantico,Quattrocento,Quattrocento Sans,Questrial,Quicksand,Quintessential,Qwigley,Racing Sans One,Radley,Rajdhani,Raleway,Raleway Dots,Ramabhadra,Ramaraja,Rambla,Rammetto One,Ranchers,Rancho,Ranga,Rationale,Ravi Prakash,Redacted,Redacted Script,Redressed,Reenie Beanie,Revalia,Ribeye,Ribeye Marrow,Righteous,Risque,Roboto,Roboto Condensed,Roboto Slab,Rochester,Rock Salt,Rokkitt,Romanesco,Ropa Sans,Rosario,Rosarivo,Rouge Script,Rozha One,Rubik Mono One,Rubik One,Ruda,Rufina,Ruge Boogie,Ruluko,Rum Raisin,Ruslan Display,Russo One,Ruthie,Rye,Sacramento,Sail,Salsa,Sanchez,Sancreek,Sansation,Sansita One,Sarabun,Sarala,Sarina,Sarpanch,Satisfy,Scada,Scheherazade,Schoolbell,Seaweed Script,Sedan,Sedan SC,Sevillana,Seymour One,Shadows Into Light,Shadows Into Light Two,Shanti,Share,Share Tech,Share Tech Mono,Shojumaru,Short Stack,Siamreap,Siemreap,Sigmar One,Signika,Signika Negative,Simonetta,Sintony,Sirin Stencil,Six Caps,Skranji,Slabo 13px,Slabo 27px,Slackey,Smokum,Smythe,Sniglet,Snippet,Snowburst One,Sofadi One,Sofia,Sonsie One,Sorts Mill Goudy,Source Code Pro,Source Sans Pro,Source Serif Pro,Special Elite,Spicy Rice,Spinnaker,Spirax,Squada One,Sree Krushnadevaraya,Stalemate,Stalinist One,Stalin One,Stardos Stencil,Stint Ultra Condensed,Stint Ultra Expanded,Stoke,Strait,Strong,Sue Ellen Francisco,Sunshiney,Supermercado One,Suranna,Suravaram,Suwannaphum,Swanky and Moo Moo,Syncopate,Tahoma,Tangerine,Taprom,Tauri,Teko,Telex,Tenali Ramakrishna,Tenor Sans,Terminal Dosis,Terminal Dosis Light,Text Me One,Thabit,The Girl Next Door,Tienne,Tillana,Timmana,Tinos,Titan One,Titillium Web,Trade Winds,Trocchi,Trochut,Trykker,Tuffy,Tulpen One,Ubuntu,Ubuntu Condensed,Ubuntu Mono,Ultra,Uncial Antiqua,Underdog,Unica One,UnifrakturCook,UnifrakturMaguntia,Unkempt,Unlock,Unna,Vampiro One,Varela,Varela Round,Vast Shadow,Verdana,Vesper Libre,Vibur,Vidaloka,Viga,Voces,Volkhov,Vollkorn,Voltaire,VT323,Waiting for the Sunrise,Wallpoet,Walter Turncoat,Warnes,Wellfleet,Wendy One,Wire One,Yanone Kaffeesatz,Yellowtail,Yeseva One,Yesteryear,Zeyada]

//Scale specific texts if necessary
S1= 1;
S2= 1;
S3= 1;
S4= 1;
S5= 1;
S6= 1;
S7= 0.6;
S8= 0.7;
S9= 1;
S10= 1;
S11= 1;
S12= 1;

// in mm
letter_depth = 1; 

// in mm, should be bigger than your nozzlesize
dual_color_depth = 5;

//of dice
print_quality=80; //[80:standard,100:high,150:very high,200:best]

/* [Hidden] */
letter_size = 0.35*Size;
p = Size / 2 - letter_depth - (part=="SingleColorDice" ? 0 : dual_color_depth); // position from where the letters are extruded 
scales=[[S1,S2],[S3,S4],[S5,S6],[S7,S8],[S9,S10],[S11,S12]];
letters=[[Text1,Text2],[Text3,Text4],[Text5,Text6],[Text7,Text8],[Text9,Text10],[Text11,Text12]];

function get_letter_depth() = (
part=="SingleColorDice" ? letter_depth : (
part=="DualDice" ? letter_depth + dual_color_depth + .1 : dual_color_depth)
);

module letter(l)
// Use linear_extrude() to make the letters 3D objects 
linear_extrude(height = get_letter_depth(), convexity=20) 
text(str(l), size = letter_size, font = font, halign = "center", valign = "center", $fn = print_quality/5);

module dodecahedron()
intersection_for(v=[[0,0,0],[1,0,116.565],[2,72,116.565],[3,2*72,116.565],[4,3*72,116.565],[5,4*72,116.565]])
assign(i=v[0],b=v[1],a=v[2])
rotate([0,0,b])
rotate([a,0,0])
cube([Size*1.2,Size*1.2,Size], center = true); //Cubes

module print_letters()
for(v=[[0,0,0],[1,0,116.565],[2,72,116.565],[3,2*72,116.565],[4,3*72,116.565],[5,4*72,116.565]])
assign(i=v[0],b=v[1],a=v[2])
rotate([0,0,b])
rotate([a,0,0])
for(j=[0,1])
rotate ([180*j, 0, 0]) 
translate([0, 0, p])
scale([scales[i][j],scales[i][j],1])
letter(letters[i][j]);

module Dice()
difference()
{
intersection() //intersect a sphere and the dodecahedron
{
sphere(0.57*Size,$fn=print_quality);
dodecahedron();
}
print_letters();
}
if(part=="DualLetters")
print_letters();
else
Dice();
