// Some overall dimension
A = 100;

// Another overall dimension
B = 38;

///////////////////////////////////////////////////////////////////
// STYLE PARAMETERS

/* [Style Settings] */

// controls scaling of elements in random subsequence1
// number from 0 (min allowable) to 10 (max allowable)
style1 = 3.5;

// controls likelihood of true/false in random subsequence2
// number from 0 (always false) to 10 (always true)
style2 = 6;

///////////////////////////////////////////////////////////////////
// RANDOM SEED

/* [Choose Random Seed] */

// USE THIS ONE WITH OPENSCAD
// comment this out if using Customizer
// OpenSCAD chooses a random seed
random_seed = floor(rands(1,5,1)[0]);

// USE THIS ONE WITH CUSTOMIZER
// comment this out if using OpenSCAD
// Click anywhere in the slider to choose a seed
//random_seed = 8675309; // [1:1:9999999]

// OR TYPE IN A SEED MANUALLY
// works both in OpenSCAD and Customizer
// Overrides the slider seed unless set to 0
custom_seed = 0;

// set the random snowflake seed
seed = (custom_seed==0) ? random_seed : custom_seed;

// Show random seed? (it won't print even if you say yes)
show_seed = "yes"; //[yes:Yes,no:No]

// Create a string to output the random seed
// thank you laird for showing me how to do this with your code
// from http://www.thingiverse.com/thing:188481
labelString=str(floor(seed/1000000)%10, floor(seed/100000)%10, 
floor(seed/10000)%10, floor(seed/1000)%10, 
floor(seed/100)%10, floor(seed/10)%10, 
floor(seed/1)%10);

//Type Your Name Here
text="Name";
// simple textmaker

// preview[view:south, tilt:top]

$fn = 100*1;

rotate([42,0,0]) 
if(show_seed=="yes"){
translate([-26.5,-19.5,21.5]) 
color("blue")
linear_extrude(height=1.5)

text("Text",size=15,halign="false",center=true);
    }

// See http://www.google.com/fonts
font = "Architects Daughter"; //[ABeeZee,Abel,Abril Fatface,Aclonica,Acme,Actor,Adamina,Advent Pro,Aguafina Script,Akronim,Aladin,Aldrich,Alef,Alegreya,Alegreya Sans,Alegreya Sans SC,Alegreya SC,Alex Brush,Alfa Slab One,Alice,Alike,Alike Angular,Allan,Allerta,Allerta Stencil,Allura,Almendra,Almendra Display,Almendra SC,Amarante,Amaranth,Amatic SC,Amethysta,Amiri,Anaheim,Andada,Andada SC,Andika,Angkor,Annie Use Your Telescope,Anonymous Pro,Antic,Antic Didone,Antic Slab,Anton,Antonio,Arapey,Arbutus,Arbutus Slab,Architects Daughter,Archivo Black,Archivo Narrow,Arimo,Arizonia,Armata,Artifika,Arvo,Asap,Asset,Astloch,Asul,Atomic Age,Aubrey,Audiowide,Autour One,Average,Average Sans,Averia Gruesa Libre,Averia Libre,Averia Sans Libre,Averia Serif Libre,Bad Script,Balthazar,Bangers,Basic,Battambang,Baumans,Bayon,Belgrano,Belleza,BenchNine,Bentham,Berkshire Swash,Bevan,Bhavuka,Bigelow Rules,Bigshot One,Bilbo,Bilbo Swash Caps,Bitter,Black Ops One,Bokor,Bonbon,Boogaloo,Bowlby One,Bowlby One SC,Brawler,Bree Serif,Bruno Ace,Bruno Ace SC,Bubblegum Sans,Bubbler One,Buda,Buenard,Butcherman,Butcherman Caps,Butterfly Kids,Cabin,Cabin Condensed,Cabin Sketch,Caesar Dressing,Cagliostro,Calligraffitti,Cambay,Cambo,Candal,Cantarell,Cantata One,Cantora One,Capriola,Cardo,Carme,Carrois Gothic,Carrois Gothic SC,Carter One,Caudex,Cedarville Cursive,Ceviche One,Changa,Changa One,Chango,Chau Philomene One,Chela One,Chelsea Market,Chenla,Cherry Cream Soda,Cherry Swash,Chewy,Chicle,Chivo,Cinzel,Cinzel Decorative,Clara,Clicker Script,Coda,Coda Caption,Codystar,Combo,Comfortaa,Coming Soon,Concert One,Condiment,Content,Contrail One,Convergence,Cookie,Copse,Corben,Courgette,Cousine,Coustard,Covered By Your Grace,Crafty Girls,Creepster,Creepster Caps,Crete Round,Crimson Text,Croissant One,Crushed,Cuprum,Cutive,Cutive Mono,Damion,Dancing Script,Dangrek,Dawning of a New Day,Days One,Dekko,Delius,Delius Swash Caps,Delius Unicase,Della Respira,Denk One,Devonshire,Dhurjati,Dhyana,Didact Gothic,Dinah,Diplomata,Diplomata SC,Domine,Donegal One,Doppio One,Dorsa,Dosis,Droid Arabic Kufi,Droid Arabic Naskh,Droid Sans,Droid Sans Ethiopic,Droid Sans Mono,Droid Sans Thai,Droid Serif,Droid Serif Thai,Dr Sugiyama,Duru Sans,Dynalight,Eagle Lake,Eater,Eater Caps,EB Garamond,Economica,Eczar,Ek Mukta,Electrolize,Elsie,Elsie Swash Caps,Emblema One,Emilys Candy,Encode Sans,Encode Sans Compressed,Encode Sans Condensed,Encode Sans Narrow,Encode Sans Wide,Engagement,Englebert,Enriqueta,Erica One,Esteban,Euphoria Script,Ewert,Exo,Exo 2,Expletus Sans,Fanwood Text,Fascinate,Fascinate Inline,Faster One,Fasthand,Fauna One,Federant,Federo,Felipa,Fenix,Finger Paint,Fira Mono,Fira Sans,Fjalla One,Fjord One,Flamenco,Flavors,Fondamento,Fontdiner Swanky,Forum,Francois One,Freckle Face,Fredericka the Great,Fredoka One,Freehand,Fresca,Frijole,Fruktur,Fugaz One,Gabriela,Gafata,Galdeano,Galindo,Gentium Basic,Gentium Book Basic,Geo,Geostar,Geostar Fill,Germania One,GFS Didot,GFS Neohellenic,Gidugu,Gilda Display,Give You Glory,Glass Antiqua,Glegoo,Gloria Hallelujah,Goblin One,Gochi Hand,Gorditas,Goudy Bookletter 1911,Graduate,Grand Hotel,Gravitas One,Great Vibes,Griffy,Gruppo,Gudea,Gurajada,Habibi,Halant,Hammersmith One,Hanalei,Hanalei Fill,Handlee,Hanuman,Happy Monkey,Headland One,Henny Penny,Hermeneus One,Herr Von Muellerhoff,Hind,Holtwood One SC,Homemade Apple,Homenaje,Iceberg,Iceland,IM Fell Double Pica,IM Fell Double Pica SC,IM Fell DW Pica,IM Fell DW Pica SC,IM Fell English,IM Fell English SC,IM Fell French Canon,IM Fell French Canon SC,IM Fell Great Primer,IM Fell Great Primer SC,Imprima,Inconsolata,Inder,Indie Flower,Inika,Inknut Antiqua,Irish Grover,Irish Growler,Istok Web,Italiana,Italianno,Jacques Francois,Jacques Francois Shadow,Jaldi,Jim Nightshade,Jockey One,Jolly Lodger,Josefin Sans,Josefin Sans Std Light,Josefin Slab,Joti One,Judson,Julee,Julius Sans One,Junge,Jura,Just Another Hand,Just Me Again Down Here,Kadwa,Kalam,Kameron,Kantumruy,Karla,Karla Tamil Inclined,Karla Tamil Upright,Karma,Kaushan Script,Kavoon,Kdam Thmor,Keania One,Kelly Slab,Kenia,Khand,Khmer,Khula,Kite One,Knewave,Kotta One,Koulen,Kranky,Kreon,Kristi,Krona One,La Belle Aurore,Laila,Lakki Reddy,Lancelot,Lateef,Lato,League Script,Leckerli One,Ledger,Lekton,Lemon,Lemon One,Liberation Sans ,Libre Baskerville,Libre Caslon Text,Life Savers,Lilita One,Lily Script One,Limelight,Linden Hill,Lobster,Lobster Two,Lohit Bengali,Lohit Tamil,Londrina Outline,Londrina Shadow,Londrina Sketch,Londrina Solid,Lora,Loved by the King,Lovers Quarrel,Love Ya Like A Sister,Luckiest Guy,Lusitana,Lustria,Macondo,Macondo Swash Caps,Magra,Maiden Orange,Mako,Mallanna,Mandali,Marcellus,Marcellus SC,Marck Script,Margarine,Marko One,Marmelad,Martel Sans,Marvel,Mate,Mate SC,Maven Pro,McLaren,Meddon,MedievalSharp,Medula One,Megrim,Meie Script,Merge One,Merienda,Merienda One,Merriweather,Merriweather Sans,Mervale Script,Metal,Metal Mania,Metamorphous,Metrophobic,Miama,Michroma,Milonga,Miltonian,Miltonian Tattoo,Miniver,Miss Fajardose,Miss Saint Delafield,Modak,Modern Antiqua,Molengo,Molle,Monda,Monofett,Monoton,Monsieur La Doulaise,Montaga,Montez,Montserrat,Montserrat Alternates,Montserrat Subrayada,Moul,Moulpali,Mountains of Christmas,Mouse Memoirs,Mr Bedford,Mr Bedfort,Mr Dafoe,Mr De Haviland,Mrs Sheppards,Mrs Saint Delafield,Muli,Mystery Quest,Nanum Brush Script,Nanum Gothic,Nanum Gothic Coding,Nanum Myeongjo,Nanum Pen Script,NATS,Neucha,Neuton,New Rocker,News Cycle,Niconne,Nixie One,Nobile,Nokora,Norican,Nosifer,Nosifer Caps,Nothing You Could Do,Noticia Text,Noto Sans,Noto Sans Hebrew,Noto Sans Symbols,Noto Sans UI,Noto Serif,Nova Cut,Nova Flat,Nova Mono,Nova Oval,Nova Round,Nova Script,Nova Slim,Nova Square,NTR,Numans,Nunito,Odor Mean Chey,Offside,OFL Sorts Mill Goudy TT,Oldenburg,Old Standard TT,Oleo Script,Oleo Script Swash Caps,Open Sans,Open Sans Condensed,Oranienbaum,Orbitron,Oregano,Orienta,Original Surfer,Oswald,Overlock,Overlock SC,Over the Rainbow,Ovo,Oxygen,Oxygen Mono,Pacifico,Palanquin,Palanquin Dark,Paprika,Parisienne,Passero One,Passion One,Pathway Gothic One,Patrick Hand,Patrick Hand SC,Patua One,Paytone One,Pecita,Peddana,Peralta,Permanent Marker,Petit Formal Script,Petrona,Phetsarath,Philosopher,Piedra,Pinyon Script,Pirata One,Plaster,Play,Playball,Playfair Display,Playfair Display SC,Podkova,Poetsen One,Poiret One,Poller One,Poly,Pompiere,Ponnala,Pontano Sans,Poppins,Porter Sans Block,Port Lligat Sans,Port Lligat Slab,Prata,Preahvihear,Press Start 2P,Princess Sofia,Prociono,Prosto One,PT Mono,PT Sans,PT Sans Caption,PT Sans Narrow,PT Serif,PT Serif Caption,Puralecka Narrow,Puritan,Purple Purse,Quando,Quantico,Quattrocento,Quattrocento Sans,Questrial,Quicksand,Quintessential,Qwigley,Racing Sans One,Radley,Rajdhani,Raleway,Raleway Dots,Ramabhadra,Ramaraja,Rambla,Rammetto One,Ranchers,Rancho,Ranga,Rationale,Ravi Prakash,Redacted,Redacted Script,Redressed,Reenie Beanie,Revalia,Ribeye,Ribeye Marrow,Righteous,Risque,Roboto,Roboto Condensed,Roboto Slab,Rochester,Rock Salt,Rokkitt,Romanesco,Ropa Sans,Rosario,Rosarivo,Rouge Script,Rozha One,Rubik Mono One,Rubik One,Ruda,Rufina,Ruge Boogie,Ruluko,Rum Raisin,Ruslan Display,Russo One,Ruthie,Rye,Sacramento,Sail,Salsa,Sanchez,Sancreek,Sansation,Sansita One,Sarabun,Sarala,Sarina,Sarpanch,Satisfy,Scada,Scheherazade,Schoolbell,Seaweed Script,Sedan,Sedan SC,Sevillana,Seymour One,Shadows Into Light,Shadows Into Light Two,Shanti,Share,Share Tech,Share Tech Mono,Shojumaru,Short Stack,Siamreap,Siemreap,Sigmar One,Signika,Signika Negative,Simonetta,Sintony,Sirin Stencil,Six Caps,Skranji,Slabo 13px,Slabo 27px,Slackey,Smokum,Smythe,Sniglet,Snippet,Snowburst One,Sofadi One,Sofia,Sonsie One,Sorts Mill Goudy,Source Code Pro,Source Sans Pro,Source Serif Pro,Special Elite,Spicy Rice,Spinnaker,Spirax,Squada One,Sree Krushnadevaraya,Stalemate,Stalinist One,Stalin One,Stardos Stencil,Stint Ultra Condensed,Stint Ultra Expanded,Stoke,Strait,Strong,Sue Ellen Francisco,Sunshiney,Supermercado One,Suranna,Suravaram,Suwannaphum,Swanky and Moo Moo,Syncopate,Tangerine,Taprom,Tauri,Teko,Telex,Tenali Ramakrishna,Tenor Sans,Terminal Dosis,Terminal Dosis Light,Text Me One,Thabit,The Girl Next Door,Tienne,Tillana,Timmana,Tinos,Titan One,Titillium Web,Trade Winds,Trocchi,Trochut,Trykker,Tuffy,Tulpen One,Ubuntu,Ubuntu Condensed,Ubuntu Mono,Ultra,Uncial Antiqua,Underdog,Unica One,UnifrakturCook,UnifrakturMaguntia,Unkempt,Unlock,Unna,Vampiro One,Varela,Varela Round,Vast Shadow,Vesper Libre,Vibur,Vidaloka,Viga,Voces,Volkhov,Vollkorn,Voltaire,VT323,Waiting for the Sunrise,Wallpoet,Walter Turncoat,Warnes,Wellfleet,Wendy One,Wire One,Yanone Kaffeesatz,Yellowtail,Yeseva One,Yesteryear,Zeyada]

// font size
size = 20;

// height of letters
extrude = 5;

// for adjusting the space between letters
spacing = 1;

web = 0; //[0:Separate letters,1:Web base connecting letters]

direction = "ltr"; //["ltr":Left to Right,"ttb":Top to Bottom]

// the text
linear_extrude(extrude)
text(   text, size, 
        font=font, 
        spacing=spacing, direction=direction);

// the base        
linear_extrude(web)
offset(r=-size)
offset(r=size)
text(   text, size, 
        font=font, 
        spacing=spacing, direction=direction);

// Output the random seed in the log
echo(labelString);

///////////////////////////////////////////////////////////////////
// RANDOM SEQUENCES

// construct the main random sequence
// a list of random real numbers in [0,10] based on the chosen seed
maxSteps=30*1;
random = rands(0,10,maxSteps,seed);
echo(random);

// subsequence of 10 items from the main sequence
// weighted by style1
subrandom1 = [for(i=[0:10-1]) random[i]*style1];
echo(subrandom1);

// subsequence of another 10 items from the main sequence
// output as true/false verdicts by comparison to style2
subrandom2 = [for(i=[10:10+10-1]) random[i]<=style2]; 
echo(subrandom2);

///////////////////////////////////////////////////////////////////
// RENDERS

// example: flat base based on overall size parameters
color("darkslateblue")

translate([-50,-19,0])
cube([A,B,10],center=false);

// example: cubes 
// heights based on subrandom1, visibility based on subrandom2
color("steelblue")
for (i=[0:3-1]){
if (subrandom2[i]==true){
translate([(i-5)*(A/12)+A/24,0,5+subrandom1[i]/2]) 
cube([8.5,8.5,subrandom1[i]],center=true);
translate([(i-5)*(A/12)+A/24,7.5,5+subrandom1[i]/2]) 
cube([8.5,8.5,subrandom1[i]],center=true);
translate([(i-5)*(A/12)+A/24,-7.5,5+subrandom1[i]/2]) 
cube([8.5,8.5,subrandom1[i]],center=true); 
}
}

///////////////////////////////////////////////////////////////////
color("pink")
  translate([25,0,4])
cube([10,10,15],center=false); 
color("grey")
  translate([20,-5,4])
cube([10,10,25],center=false);  
color("red")
  translate([25,-10,4])
cube([10,10,20],center=false);  

translate([40,0,9])
sphere(6);
color("red")
translate([42,5,9])
sphere(5);

////// mario ////
color("red")
rotate(180)
resize([15,15,15])
translate([-110,5,250])
import("/Users/thihaaung/Desktop/mario01.stl");

///////
module prism(l, w, h){
       color("red")
    polyhedron(
 points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
 faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
    
       );}
   
       translate ([-A/2,-(B/2)-15,0])
       prism(100, 15, 10);

// MODULES

// put shapes here
// simple custom polybowl

/* [Size] */

// width of the bowl (in mm)

diameter = 9;
radius = diameter/2;

// height of the main part (in mm)
bodyHeight = 28;

// height of the base and lower rim (in mm)
baseHeight = .5;

// height of the upper rim (in mm)
rimHeight = 0.5;

/* [Style] */

// number of polygon sides
sides = 7;

// thickness of the bowl (keep above 1.5 mm)
thickness = 1.5;

// degrees that the bowl shape will twist
bodyTwist = 50;

// factor by which bowl shape will scale out/in
bodyFlare = 1.2;

///////
// RENDERS

// base
linear_extrude( height = baseHeight )
    polyShape( solid="yes" );

// body
color("palegreen")
translate([0,0,baseHeight])
linear_extrude( height = bodyHeight+10, twist = bodyTwist,
                scale = bodyFlare, slices = 2*bodyHeight )
    polyShape( solid="no" ); // change to yes for solid bowl
    
// rim
color("green")
translate([0,0,bodyHeight+baseHeight+10])
rotate(-bodyTwist)
scale(bodyFlare)
linear_extrude( height = rimHeight )
    polyShape( solid="no" ); // change to yes for solid bowl


//////////////////////////////////////////////////////
// MODULES

module polyShape(solid){
    difference(){
        // start with outer shape
        offset( r=5, $fn=48 )
            circle( r=radius, $fn=sides );
        // take away inner shape
        if (solid=="no"){
        offset( r=5-thickness, $fn=48 )
            circle( r=radius, $fn=sides );
        }
    }
}
///