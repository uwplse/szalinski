use <utils/hsvtorgb.scad>

// Jesse Campbell
// Designed in early 2017
// http://www.jbcse.com
// jcamp@gmx.com
// http://www.breakitbracelets.com/customize

/* [Globals] */

// Detail Level
$fn = 100;

/* [Text] */
text = "your text here";

font = "Lemon"; // [ABeeZee,Abel,Abhaya Libre,Abril Fatface,Aclonica,Acme,Actor,Adamina,Advent Pro,Aguafina Script,Akronim,Aladin,Aldrich,Alef,Alegreya,Alegreya SC,Alegreya Sans,Alegreya Sans SC,Alex Brush,Alfa Slab One,Alice,Alike,Alike Angular,Allan,Allerta,Allerta Stencil,Allura,Almendra,Almendra Display,Almendra SC,Amarante,Amaranth,Amatic SC,Amethysta,Amiko,Amiri,Amita,Anaheim,Andada,Andika,Angkor,Annie Use Your Telescope,Anonymous Pro,Antic,Antic Didone,Antic Slab,Anton,Arapey,Arbutus,Arbutus Slab,Architects Daughter,Archivo,Archivo Black,Archivo Narrow,Aref Ruqaa,Arima Madurai,Arimo,Arizonia,Armata,Arsenal,Artifika,Arvo,Arya,Asap,Asap Condensed,Asar,Asset,Assistant,Astloch,Asul,Athiti,Atma,Atomic Age,Aubrey,Audiowide,Autour One,Average,Average Sans,Averia Gruesa Libre,Averia Libre,Averia Sans Libre,Averia Serif Libre,Bad Script,Bahiana,Baloo,Baloo Bhai,Baloo Bhaijaan,Baloo Bhaina,Baloo Chettan,Baloo Da,Baloo Paaji,Baloo Tamma,Baloo Tammudu,Baloo Thambi,Balthazar,Bangers,Barlow,Barlow Condensed,Barlow Semi Condensed,Barrio,Basic,Battambang,Baumans,Bayon,Belgrano,Bellefair,Belleza,BenchNine,Bentham,Berkshire Swash,Bevan,Bigelow Rules,Bigshot One,Bilbo,Bilbo Swash Caps,BioRhyme,BioRhyme Expanded,Biryani,Bitter,Black And White Picture,Black Han Sans,Black Ops One,Bokor,Bonbon,Boogaloo,Bowlby One,Bowlby One SC,Brawler,Bree Serif,Bubblegum Sans,Bubbler One,Buda,Buenard,Bungee,Bungee Hairline,Bungee Inline,Bungee Outline,Bungee Shade,Butcherman,Butterfly Kids,Cabin,Cabin Condensed,Cabin Sketch,Caesar Dressing,Cagliostro,Cairo,Calligraffitti,Cambay,Cambo,Candal,Cantarell,Cantata One,Cantora One,Capriola,Cardo,Carme,Carrois Gothic,Carrois Gothic SC,Carter One,Catamaran,Caudex,Caveat,Caveat Brush,Cedarville Cursive,Ceviche One,Changa,Changa One,Chango,Chathura,Chau Philomene One,Chela One,Chelsea Market,Chenla,Cherry Cream Soda,Cherry Swash,Chewy,Chicle,Chivo,Chonburi,Cinzel,Cinzel Decorative,Clicker Script,Coda,Coda Caption,Codystar,Coiny,Combo,Comfortaa,Coming Soon,Concert One,Condiment,Content,Contrail One,Convergence,Cookie,Copse,Corben,Cormorant,Cormorant Garamond,Cormorant Infant,Cormorant SC,Cormorant Unicase,Cormorant Upright,Courgette,Cousine,Coustard,Covered By Your Grace,Crafty Girls,Creepster,Crete Round,Crimson Text,Croissant One,Crushed,Cuprum,Cute Font,Cutive,Cutive Mono,Damion,Dancing Script,Dangrek,David Libre,Dawning of a New Day,Days One,Dekko,Delius,Delius Swash Caps,Delius Unicase,Della Respira,Denk One,Devonshire,Dhurjati,Didact Gothic,Diplomata,Diplomata SC,Do Hyeon,Dokdo,Domine,Donegal One,Doppio One,Dorsa,Dosis,Dr Sugiyama,Duru Sans,Dynalight,EB Garamond,Eagle Lake,East Sea Dokdo,Eater,Economica,Eczar,El Messiri,Electrolize,Elsie,Elsie Swash Caps,Emblema One,Emilys Candy,Encode Sans,Encode Sans Condensed,Encode Sans Expanded,Encode Sans Semi Condensed,Encode Sans Semi Expanded,Engagement,Englebert,Enriqueta,Erica One,Esteban,Euphoria Script,Ewert,Exo,Exo 2,Expletus Sans,Fanwood Text,Farsan,Fascinate,Fascinate Inline,Faster One,Fasthand,Fauna One,Faustina,Federant,Federo,Felipa,Fenix,Finger Paint,Fira Mono,Fira Sans,Fira Sans Condensed,Fira Sans Extra Condensed,Fjalla One,Fjord One,Flamenco,Flavors,Fondamento,Fontdiner Swanky,Forum,Francois One,Frank Ruhl Libre,Freckle Face,Fredericka the Great,Fredoka One,Freehand,Fresca,Frijole,Fruktur,Fugaz One,GFS Didot,GFS Neohellenic,Gabriela,Gaegu,Gafata,Galada,Galdeano,Galindo,Gamja Flower,Gentium Basic,Gentium Book Basic,Geo,Geostar,Geostar Fill,Germania One,Gidugu,Gilda Display,Give You Glory,Glass Antiqua,Glegoo,Gloria Hallelujah,Goblin One,Gochi Hand,Gorditas,Gothic A1,Goudy Bookletter 1911,Graduate,Grand Hotel,Gravitas One,Great Vibes,Griffy,Gruppo,Gudea,Gugi,Gurajada,Habibi,Halant,Hammersmith One,Hanalei,Hanalei Fill,Handlee,Hanuman,Happy Monkey,Harmattan,Headland One,Heebo,Helvetica,Henny Penny,Herr Von Muellerhoff,Hi Melody,Hind,Hind Guntur,Hind Madurai,Hind Siliguri,Hind Vadodara,Holtwood One SC,Homemade Apple,Homenaje,IBM Plex Mono,IBM Plex Sans,IBM Plex Sans Condensed,IBM Plex Serif,IM Fell DW Pica,IM Fell DW Pica SC,IM Fell Double Pica,IM Fell Double Pica SC,IM Fell English,IM Fell English SC,IM Fell French Canon,IM Fell French Canon SC,IM Fell Great Primer,IM Fell Great Primer SC,Iceberg,Iceland,Imprima,Inconsolata,Inder,Indie Flower,Inika,Inknut Antiqua,Irish Grover,Istok Web,Italiana,Italianno,Itim,Jacques Francois,Jacques Francois Shadow,Jaldi,Jim Nightshade,Jockey One,Jolly Lodger,Jomhuria,Josefin Sans,Josefin Slab,Joti One,Jua,Judson,Julee,Julius Sans One,Junge,Jura,Just Another Hand,Just Me Again Down Here,Kadwa,Kalam,Kameron,Kanit,Kantumruy,Karla,Karma,Katibeh,Kaushan Script,Kavivanar,Kavoon,Kdam Thmor,Keania One,Kelly Slab,Kenia,Khand,Khmer,Khula,Kirang Haerang,Kite One,Knewave,Kotta One,Koulen,Kranky,Kreon,Kristi,Krona One,Kumar One,Kumar One Outline,Kurale,La Belle Aurore,Laila,Lakki Reddy,Lalezar,Lancelot,Lateef,Lato,League Script,Leckerli One,Ledger,Lekton,Lemon,Lemonada,Libre Barcode 128,Libre Barcode 128 Text,Libre Barcode 39,Libre Barcode 39 Extended,Libre Barcode 39 Extended Text,Libre Barcode 39 Text,Libre Baskerville,Libre Franklin,Life Savers,Lilita One,Lily Script One,Limelight,Linden Hill,Lobster,Lobster Two,Londrina Outline,Londrina Shadow,Londrina Sketch,Londrina Solid,Lora,Love Ya Like A Sister,Loved by the King,Lovers Quarrel,Luckiest Guy,Lusitana,Lustria,Macondo,Macondo Swash Caps,Mada,Magra,Maiden Orange,Maitree,Mako,Mallanna,Mandali,Manuale,Marcellus,Marcellus SC,Marck Script,Margarine,Marko One,Marmelad,Martel,Martel Sans,Marvel,Mate,Mate SC,Maven Pro,McLaren,Meddon,MedievalSharp,Medula One,Meera Inimai,Megrim,Meie Script,Merienda,Merienda One,Merriweather,Merriweather Sans,Metal,Metal Mania,Metamorphous,Metrophobic,Michroma,Milonga,Miltonian,Miltonian Tattoo,Mina,Miniver,Miriam Libre,Mirza,Miss Fajardose,Mitr,Modak,Modern Antiqua,Mogra,Molengo,Molle,Monda,Monofett,Monoton,Monsieur La Doulaise,Montaga,Montez,Montserrat,Montserrat Alternates,Montserrat Subrayada,Moul,Moulpali,Mountains of Christmas,Mouse Memoirs,Mr Bedfort,Mr Dafoe,Mr De Haviland,Mrs Saint Delafield,Mrs Sheppards,Mukta,Mukta Mahee,Mukta Malar,Mukta Vaani,Muli,Mystery Quest,NTR,Nanum Brush Script,Nanum Gothic,Nanum Gothic Coding,Nanum Myeongjo,Nanum Pen Script,Neucha,Neuton,New Rocker,News Cycle,Niconne,Nixie One,Nobile,Nokora,Norican,Nosifer,Nothing You Could Do,Noticia Text,Noto Sans,Noto Serif,Nova Cut,Nova Flat,Nova Mono,Nova Oval,Nova Round,Nova Script,Nova Slim,Nova Square,Numans,Nunito,Nunito Sans,Odor Mean Chey,Offside,Old Standard TT,Oldenburg,Oleo Script,Oleo Script Swash Caps,Open Sans,Open Sans Condensed,Oranienbaum,Orbitron,Oregano,Orienta,Original Surfer,Oswald,Over the Rainbow,Overlock,Overlock SC,Overpass,Overpass Mono,Ovo,Oxygen,Oxygen Mono,PT Mono,PT Sans,PT Sans Caption,PT Sans Narrow,PT Serif,PT Serif Caption,Pacifico,Padauk,Palanquin,Palanquin Dark,Pangolin,Paprika,Parisienne,Passero One,Passion One,Pathway Gothic One,Patrick Hand,Patrick Hand SC,Pattaya,Patua One,Pavanam,Paytone One,Peddana,Peralta,Permanent Marker,Petit Formal Script,Petrona,Philosopher,Piedra,Pinyon Script,Pirata One,Plaster,Play,Playball,Playfair Display,Playfair Display SC,Podkova,Poiret One,Poller One,Poly,Pompiere,Pontano Sans,Poor Story,Poppins,Port Lligat Sans,Port Lligat Slab,Pragati Narrow,Prata,Preahvihear,Press Start 2P,Pridi,Princess Sofia,Prociono,Prompt,Prosto One,Proza Libre,Puritan,Purple Purse,Quando,Quantico,Quattrocento,Quattrocento Sans,Questrial,Quicksand,Quintessential,Qwigley,Racing Sans One,Radley,Rajdhani,Rakkas,Raleway,Raleway Dots,Ramabhadra,Ramaraja,Rambla,Rammetto One,Ranchers,Rancho,Ranga,Rasa,Rationale,Ravi Prakash,Redressed,Reem Kufi,Reenie Beanie,Revalia,Rhodium Libre,Ribeye,Ribeye Marrow,Righteous,Risque,Roboto,Roboto Condensed,Roboto Mono,Roboto Slab,Rochester,Rock Salt,Rokkitt,Romanesco,Ropa Sans,Rosario,Rosarivo,Rouge Script,Rozha One,Rubik,Rubik Mono One,Ruda,Rufina,Ruge Boogie,Ruluko,Rum Raisin,Ruslan Display,Russo One,Ruthie,Rye,Sacramento,Sahitya,Sail,Saira,Saira Condensed,Saira Extra Condensed,Saira Semi Condensed,Salsa,Sanchez,Sancreek,Sansita,Sarala,Sarina,Sarpanch,Satisfy,Scada,Scheherazade,Schoolbell,Scope One,Seaweed Script,Secular One,Sedgwick Ave,Sedgwick Ave Display,Sevillana,Seymour One,Shadows Into Light,Shadows Into Light Two,Shanti,Share,Share Tech,Share Tech Mono,Shojumaru,Short Stack,Shrikhand,Siemreap,Sigmar One,Signika,Signika Negative,Simonetta,Sintony,Sirin Stencil,Six Caps,Skranji,Slabo 13px,Slabo 27px,Slackey,Smokum,Smythe,Sniglet,Snippet,Snowburst One,Sofadi One,Sofia,Song Myung,Sonsie One,Sorts Mill Goudy,Source Code Pro,Source Sans Pro,Source Serif Pro,Space Mono,Special Elite,Spectral,Spectral SC,Spicy Rice,Spinnaker,Spirax,Squada One,Sree Krushnadevaraya,Sriracha,Stalemate,Stalinist One,Stardos Stencil,Stint Ultra Condensed,Stint Ultra Expanded,Stoke,Strait,Stylish,Sue Ellen Francisco,Suez One,Sumana,Sunflower,Sunshiney,Supermercado One,Sura,Suranna,Suravaram,Suwannaphum,Swanky and Moo Moo,Syncopate,Tajawal,Tangerine,Taprom,Tauri,Taviraj,Teko,Telex,Tenali Ramakrishna,Tenor Sans,Text Me One,The Girl Next Door,Tienne,Tillana,Timmana,Tinos,Titan One,Titillium Web,Trade Winds,Trirong,Trocchi,Trochut,Trykker,Tulpen One,Ubuntu,Ubuntu Condensed,Ubuntu Mono,Ultra,Uncial Antiqua,Underdog,Unica One,UnifrakturCook,UnifrakturMaguntia,Unkempt,Unlock,Unna,VT323,Vampiro One,Varela,Varela Round,Vast Shadow,Vesper Libre,Vibur,Vidaloka,Viga,Voces,Volkhov,Vollkorn,Vollkorn SC,Voltaire,Waiting for the Sunrise,Wallpoet,Walter Turncoat,Warnes,Wellfleet,Wendy One,Wire One,Work Sans,Yanone Kaffeesatz,Yantramanav,Yatra One,Yellowtail,Yeon Sung,Yeseva One,Yesteryear,Yrsa,Zeyada,Zilla Slab,Zilla Slab Highlight]

size = 6.5; // [5:0.1:10]
spacing = 1; // [0.5:0.05:2]

/* [Band Size] */

diameter = 65; // [15:89]
thickness = 3.5; // [3:0.1:5]
height = 10; // [7:15]
clasp = "no"; // [no, yes]
claspSizes = 5; // [2:7]

/* [Color] */

hue = 306; // [0:360]
saturation = 0.5; // [0:0.01:1]
brightness = 0.8; // [0:0.01:1]
alpha = 0.66; // [0:0.01:1]

color(hsvToRGB(hue,saturation,brightness,alpha)){
    difference(){
        union(){
            makeBand(diameter, thickness, height);
            addOuterText(text, size, spacing, font, diameter, thickness, height);
        }
        if(clasp == "yes"){                
            claspCutout(130);            
        }
    }
    if(clasp == "yes"){
        clasp(holes=claspSizes, 130);
        addClaspNubs(130); 
    }
}

module makeBand(diameter, thickness, height){
    difference(){
        cylinder(d=diameter+thickness,h=height);
        translate([0,0,-1])
        cylinder(d=diameter,h=height+2);
    }
    
    translate([0,0,height]){
        rotate_extrude(){
            translate([diameter/2+thickness/4, 0, 0]){
                scale([1,2,1]){
                    circle(d = thickness/2);
                }
            }
        }
    }
}

module addOuterText(text, size, spacing, font, diameter, thickness, height){
    text_on_cylinder(t=text,r1=(diameter+thickness)/2,r2=(diameter+thickness)/2,h=height/2, font=font, direction="ttb", size=size, spacing=spacing);
}

module addClaspNubs(claspAngle){
    rotate([0,0,claspAngle]){
        for(i=[-1:2:1]){
            translate([diameter/2-thickness/2+2.5,i*5/2,0]){
                cylinder(d=4,h=height);
                translate([0,0,height]){
                    sphere(d=4);            
                }
            }
        }
    }
}

module claspCutout(claspAngle){
    rotate([0,0,claspAngle]){
        translate([diameter/2-1,-5/2,-height/2]){
            cube([10/2,5,height*3]);
        }
        cylinder(d=diameter+1,h=height);
    }
}

module clasp(claspAngle, holes){        
    rotate([0,0,claspAngle+90])
    translate([-10,-diameter/2+10,0])    
    difference(){
        hull(){
            cylinder(d=7,h=15);
            translate([4*holes,0,0])
            cylinder(d=7,h=15);
        }
        for(i=[0:5:holes*4]){
            translate([i,0,2])
            cylinder(d=3.75,h=13);
        }
        translate([-5,-1.5/2,2])
        cube([holes*6,1.5,13]);
    }
}

/*  text on ....
   This is a rework of version 3 of write.scad to use the new OpenSCAD internal text() primitive.
   All credit to Harlan Martin (harlan@sutlog.com) for his great effort on the original.
   Great thanks to t-paul (and the OpenSCAD dev team) on adding the new text() primitive.
*/


/*
The arguments to be provided for each function are explictly in the modules.

All modules take close to all the arguments to text() [Not all features are supported in all text_on_object() modules though -- try them out warnings will be given if it is not supported]

text() params:
t
size
spacing
font
direction -- ltr, ttb, btt or rtl
language
script
halign -- left, right or center
valign -- baseline, bottom, top or center

All modules also take the additional arguments:
extrusion_height = depth of the letter, i.e. how far it sits proud
rotate
center //center the text at the location it is being written (NOT that the object is centered)

ALL faux-objects that the text is applied to have center=true
TODO: object_center=true/false (already done for cylinder)

The above arguemnts can be seen in text_extrude() as all modules call that module evetually (often multiple times).

locn_vector -- Where the faux-object has been translated to. TODO: Rename object to translate_vector?

Additional arguments for text_on_cube():

Additional arguments for text_on_cylinder():

Additional arguments for text_on_circle():

Additional arguments for text_on_sphere():


*/

// These control the default values for text_extrude(), text_on_sphere(), text_on_cube(), text_on_cylinder(), text_on_circle()
// if the arguments are not included in the call to the module.

// Defaults
// Defaults for all modules
default_t="text_on";
default_size = 4; //TODO - Can we make this 10?? To match internal size? There is an underlying value in text() -- This masks that.
default_font = "Liberation Mono";
default_spacing = 1; //Spacing between characters. There is an underlying value in text() -- This masks that. We try and match it here.
default_rotate  = 0; // text rotation (clockwise)
default_center  = true; //Text-centering
default_scale = [1,1,1];
default_extrusion_height = 2; //mm letter extrusion height

//Defaults for Cube
default_cube_face        = "front";	 // default face (top,bottom,left,right,back,front)
default_sphere_rounded   = false;	 //default for rounded letters on text_on_sphere
default_cube_updown = 0; //mm up (-down) from center on face of cube
default_cube_rightleft = 0;		 //mm right(-left) from center on face of cube

//Defaults for Sphere
default_sphere_northsouth= 0;
default_sphere_eastwest  = 0;
default_sphere_spin      = 0; //TODO:Different to rotate? or up/down. Better name?

//Defaults for Cylinder (including circle as it is on top/bottom)
default_circle_middle    = 0;      //(mm toward middle of circle)
default_circle_ccw       = false;  //write on top or bottom in a ccw direction
default_circle_eastwest  = 0;
default_cylinder_face    = "side";
default_cylinder_updown  = 0;

//Internal values - don't play with these :)
//This is much more accurate than the PI constant internal to Openscad.
internal_pi=3.1415926535897932384626433832795028841971693993751058209;
internal_pi2=internal_pi*2;

//Internal values - You might want to play with these if you are using a proportional font
internal_space_fudge = 0.80; //Fudge for working out lengths (widths) of strings

debug = true;

//---- Helper Functions ----
//String width (length from left to right or RTL) in OpenSCAD units
//NOTE: These are innacurate because we don't know the real spacing of the chars and so have to approximate
//They work for monospaced (fixed-width) fonts well
function width_of_text_char( size, spacing ) = (size * internal_space_fudge * spacing);
function width_of_text_string_num_length(length, size, spacing) = ( width_of_text_char( size, spacing ) * (length));
function width_of_text_string( t, size, spacing ) = ( width_of_text_string_num_length(len(t), size, spacing) );

function cylinder_center_adjusted_top( height, center )    = (center==true) ? height/2 : height ;
function cylinder_center_adjusted_bottom( height, center ) = (center==true) ? height/2 : 0 ;


//Angle that measures width of letters on perimeter of a circle (and sphere and cylinder)
function rotation_for_character(size, spacing, r, rotate = 0)
 = ( width_of_text_char( size, spacing ) /(internal_pi2*r))*360*(1-abs(rotate)/90);


//Rotate 1/2 width of text if centering	
//One less -- if we have a single char we are already centred..
function rotation_for_center_text_string( t, size, spacing,r,rotate,center)
	= (center) ? (width_of_text_string_num_length( len(t)-1, size, spacing )/2/(internal_pi2*r)*360) : 0 ;

//Rotate according to rotate and if centred text also 1/2 width of text
function rotation_for_center_text_string_and_rotate( t, size, spacing,r,rotate,center)
	= ((center) ? (width_of_text_string( t, size, spacing )/2/(internal_pi2*r)*360) : 1) * (1-abs(rotate)/90);


//---- Text on Object Functions ----
//Text on the top or side of a cylinder.
//Supports writing on normal and slanty cylinders
//cylinder(h,r,center)
//cylinder(h,r1,r2,center)
module text_on_cylinder(t=default_t,
                        //Object-specific                        
                        locn_vec = [0,0,0],
                        r,r1,r2,h,
                        face             = default_cylinder_face,
                        updown           = default_cylinder_updown,
                        rotate           = default_rotate,
                        eastwest         = default_circle_eastwest,
                        middle           = default_circle_middle,
                        ccw              = default_circle_ccw,
                        cylinder_center  = false, //if the cylinder object we are writing on is center==true
                        //TODO: add rounded
                        
                        //All objects
                        extrusion_height = default_extrusion_height,
                        center           = default_center,
                        //All objects -- arguments as for text()
                        font             = undef,
                        size             = default_size,
                        direction        = undef,
                        halign           = undef,
                        valign           = undef,
                        language         = undef,
                        script           = undef,
                        spacing          = default_spacing
){
//    echo (str("text_on_cylinder:There are " ,len(t) ," letters in t" , t));
//    echo (str("text_on_cylinder:","h" , h));
//    echo (str("text_on_cylinder:","r=" , r));
//    echo (str("text_on_cylinder:","r1=" , r1));
//    echo (str("text_on_cylinder:","r2=" , r2));

    if((halign!=undef) || (halign!=undef))
    {
        echo (str("text_on_cylinder:","WARNING " , "halign and valign are NOT supported."));
    }

	rtl_sign = (direction=="rtl") ? -1 : 1;
	if ((face=="top")||(face=="bottom") ){
		//Work on a circle
		locn_offset_vec = (face=="top" ) ? [0,0,cylinder_center_adjusted_top(h,cylinder_center)] : [0,0,cylinder_center_adjusted_bottom(h,cylinder_center)] ;
		rotation_angle = (face=="top" ) ? 0 : 180 ;
		int_radius =  (r==undef) ? ((face=="top" ) ? r2 : r1 ) : r;  //Use the top/bottom radius for slanty-cylinders
			rotate(rotation_angle,[1,0,0])
			text_on_circle(t,locn_vec+locn_offset_vec,r=int_radius-size,
				font=font,size=size,
				spacing=spacing,direction=direction,language=language,script=script,halign=halign,valign=valign,
				extrusion_height=extrusion_height,
				rotate=rotate,
				eastwest=eastwest,middle=middle,ccw=ccw);
	}else{
		if((middle!=undef) && (middle!=default_circle_middle))
		{
			//TODO: Which others?
			//TODO: Which side things aren't supported on the circle
			echo (str("text_on_cylinder:","WARNING " , "middle NOT supported for the SIDE of a cylinder."));
		}
		//Work on the side
		locn_offset_vec =  (cylinder_center==true) ? [0,0,0] : [0,0,h/2]; 
		rotate(-rtl_sign * rotation_for_center_text_string_and_rotate(t, size, spacing,r,rotate,center), [0,0,1])
		translate(locn_vec+locn_offset_vec)
		__internal_text_on_cylinder_side(t,locn_vec,r=r,h=h,r1=r1,r2=r2,
			cylinder_center=cylinder_center,
			center=center,
			font=font,size=size,
			spacing=spacing,direction=direction,language=language,script=script,halign=halign,valign=valign,
			extrusion_height=extrusion_height,
			rotate=rotate,face=face,updown=updown,
			eastwest=eastwest);
	}
}

//circle(r)
module text_on_circle(t=default_t,
                      //Object-specific
                      locn_vec = [0,0,0],
                      r,
                      eastwest = default_circle_eastwest,
                      middle = default_circle_middle,
                      ccw = default_circle_ccw,

                      //All objects                      
                      extrusion_height = default_extrusion_height,
                      rotate = default_rotate,
                      center = default_center,
                      
                      //All objects -- arguments as for text()
                      font             = undef,
                      size             = default_size,
                      direction        = undef,
                      halign           = undef,
                      valign           = undef,
                      language         = undef,
                      script           = undef,
                      spacing          = default_spacing
){
//    echo (str("text_on_circle:","There are " ,len(t) ," letters in t" , t));
//    echo (str("text_on_circle:","rotate=" , rotate));
//    echo (str("text_on_circle:","eastwest=" , eastwest));

    if((halign!=undef) || (halign!=undef))
    {
        echo (str("text_on_circle:","WARNING " , "halign and valign are NOT supported."));
    }

	ccw_sign = (ccw==true) ? 1 : -1;
	rtl_sign = (direction=="rtl") ? -1 : 1;
    ttb_btt_inaction = (direction=="ttb" || direction=="btt") ? 0 : 1;
	rotate_z_outer =  -rotate + ccw_sign*eastwest;
	rotate_z_inner = -rtl_sign * ccw_sign * ttb_btt_inaction * rotation_for_center_text_string( t, size, spacing, r-middle, rotate, center);
	rotate( rotate_z_outer, [0,0,1] )
	rotate( rotate_z_inner, [0,0,1] )
	translate(locn_vec)
	for (l=[0:len(t)-1]){
		//TTB/BTT means no per letter rotation
		rotate_z_inner2 = -ccw_sign * 90 + ttb_btt_inaction*rtl_sign*ccw_sign*l*rotation_for_character(size, spacing, r-middle, rotate=0);   //Bottom out=-270+r
		//TTB means we go toward center, BTT means away
		vert_x_offset = (direction=="ttb" || direction=="btt") ?  (l * size * ((direction=="btt") ? -1 : 1)) :  0;
		rotate( rotate_z_inner2, [0,0,1] )
		translate([r - middle - vert_x_offset,0,0])
		rotate(-ccw_sign*270,[0,0,1])  // flip text (botom out = -270)
		text_extrude(t[l],center=true,
			font=font,size=size,
			rotate=undef,
			spacing=spacing,
			direction=undef, //We don't pass direction ( misaligns inside text() ). TODO: Investigate why
			language=language,script=script,halign=halign,valign=valign,
			extrusion_height=extrusion_height );
	}
}

//Only expected to be called from another function. No defaults as expected to be done in parent.
//NOTE: This is hacked. Requires more mathematics than I feel like to do properly today....
//TODO: Refactor the two operations - side of normal and slanty
//No default checks in this funciton -- done in parent
module __internal_text_on_cylinder_side(t=default_t,
                      //Object-specific
                      locn_vec = [0,0,0],
                      r,r1,r2,h,
                      cylinder_center,
                      
                      //All objects
                      extrusion_height = default_extrusion_height,
                      center           = undef,
                      rotate           = default_rotate,
                      
                      //All objects -- arguments as for text()
                      font             = undef,
                      size             = default_size,
                      direction        = undef,
                      halign           = undef, //Overridden
                      valign           = undef,
                      language         = undef,
                      script           = undef,
                      spacing          = default_spacing
)
{
//    echo (str("__internal_text_on_cylinder_side:There are " ,len(t) ," letters in t" , t));
//    echo (str("__internal_text_on_cylinder_side:","h=" , h));
//    echo (str("__internal_text_on_cylinder_side:","r=" , r));
//    echo (str("__internal_text_on_cylinder_side:","r1=" , r1));
//    echo (str("__internal_text_on_cylinder_side:","r2=" , r2));
//    echo (str("__internal_text_on_cylinder_side:","direction=" , direction));
    
    if((halign!=undef) || (halign!=undef))
    {
        echo (str("text_on_cylinder:","WARNING " , "halign and valign are NOT supported."));
    }

    wid = width_of_text_char( size, spacing ); //TODO: refactor this out?

    function calc_radius_at_height_offset(r1,r2,h_total,h_offset) = ( r1 + ((r2-r1) * (h_total-h_offset)/h_total) );
    
  	//Has to factor in up/downedness
    //Starts at middle height then height displacement is reduced under rotation and by the slope of the uneven radii
    function calc_height_offset_at_length(r1,r2,h,length,rotate, updown) = ( h/2 - updown + length * rotate/90 * cos( atan( (r2-r1)/h ) )  );

    function calc_radius_at_length(r1,r2,h,length,rotate,updown) = ( calc_radius_at_height_offset(r1,r2,h,calc_height_offset_at_length(r1,r2,h,length,rotate,updown)));
    
    if(r==undef)
    {
        //Slanty-cylinder (truncated cone) warnings
        if((direction=="btt") || (direction=="ttb"))
        {
            //TODO: After the issues are resolved refactoring should give this pretty easily
            echo (str("text_on_cylinder:","WARNING" , " - Slanty-cylinders definitely don't directions TTB or BTT on sides yet. Setting direction to ltr."));    
        }
        if(center==true)
        {
            echo (str("text_on_cylinder:","WARNING" , " - Slanty-cylinders don't support centering yet. Setting center to false. You can adjust updown and eastwest and achieve most of what you are after...."));    
        }
    }

    r1  = (r1!=undef) ? r1 : r;
    r2  = (r2!=undef) ? r2 : r;
    //NOTE: r is not used after here. We operate on generalised slanty cone (r1 and r2)
    
  	//TODO: Look at changing this to extrusion_height_center
	//and renaming the other as text_center
	rr1 = (center) ? r1-extrusion_height/2 : r1;
	rr2 = (center) ? r2-extrusion_height/2 : r2;
	
    ccenter  = (r!=undef) ? center : false; //We don't do (text) centering for the slanty cones/helical paths (yet? ever?). Needs to do quite a few offset calcs.
    ddirection   = ((r==undef) && ((direction=="ttb")||(direction=="btt"))) ? "ltr" : direction; //We don't do ttb or btt directions on slanty
    rtl_sign = (ddirection=="rtl") ? -1 : 1;

        //This code takes care of slanty cylinders and "normal" cylinders
        translate([0,0,updown])
        rotate(eastwest,[0,0,1])
        for (l=[0:len(t)-1]){
            //TODO: TTB and BTT need to have a different concept of path/length than this for RTL/LTR
   	        //width_of_... is half a char too long -- add 0.5 (counting from zero)
            length_to_center_of_char = width_of_text_string_num_length(l+0.5,size,spacing);
            radius_here = calc_radius_at_length(rr1,rr2,h, length_to_center_of_char, rotate, updown);
            //Rotating into position and tangentially to surface -- Don't rotate per character for ttb/btt
            //-90 is to get centering at origin
		    rotate_z_inner  = -90 + rtl_sign * rotation_for_character(size, spacing, ( radius_here ), rotate) * ((ddirection=="ttb" || ddirection=="btt") ?  0 : l);
	        rotate(rotate_z_inner,[0,0,1])
			{
	        //Positioning - based on (somewhat innacurate) string length
		    //Offset per character to go up/down the side in ttb/btt -- TTB down, BTT up
		    vert_z_char_offset = (ddirection=="ttb" || ddirection=="btt") ?  (l * size * ((ddirection=="ttb") ? -1 : 1 )) :  0 ;
		    //Only if RTL/LTR and if center -- center the text (starts off in a more visually appealing location)
		    vert_z_half_text_offset_tmp = (len(t)-1)/2 * (rotate/90*wid);
		    vert_z_half_text_offset =  ((ddirection=="ttb" || ddirection=="btt") || (ccenter==false)) ? 0 : vert_z_half_text_offset_tmp;
            translate([ radius_here , 0, vert_z_char_offset - l * ((rotate)/90*wid) + vert_z_half_text_offset])

	        //Flip to tangent on the sloping side (without respecting rotation impact on the tangent -- rotate seems a little off. TODO: Investigate).
	        rotate( atan( (rr2-rr1)/h ) , [0,1,0])
	        //Flip onto face of "normal" cylinder
	        rotate(90,[1,0,0])
	        rotate(90,[0,1,0])

    	    //Modify the offset of the baselined text to center
            translate([0,(ccenter) ? -size/2 : 0,0])
	        
	        text_extrude(t[l],
	            center=false,
	            rotate=rotate,
	            font=font,size=size,
	            spacing=spacing,
	            direction=undef, //We don't pass direction ( misaligns inside text() ). TODO: Investigate why
	            language=language,script=script,
	            halign="center", //This can be relaxed eventually
                valign="baseline", //Need this to keep all letters on the same line (could also support top -- otherw will make
	            extrusion_height=extrusion_height
	            );
			}
        }
}

//sphere(r)
//NB: Iterates through characters/glyphs and presents them individually (but supports actions across the entire string still)
//supports all features of text() except: halign and valign
module text_on_sphere(t=default_t,
                      //Object-specific
                      locn_vec = [0,0,0],
                      r,
                      eastwest         = default_sphere_eastwest,
                      northsouth       = default_sphere_northsouth,
                      rotate           = default_rotate,
                      spin             = default_sphere_spin,
                      rounded          = default_sphere_rounded,
                      //All objects
                      extrusion_height = default_extrusion_height,
                      center           = default_center, //center = false doesn't really even make sense to do (IMHO)
                      scale  = default_scale,
                      //All objects -- arguments as for text()
                      font             = undef,
                      size             = default_size,
                      direction        = undef,
                      halign           = undef, //Not supported - only here to enable a warning
                      valign           = undef, //Not supported - only here to enable a warning
                      language         = undef,
                      script           = undef,
                      spacing          = default_spacing
){
    //echo ("text_on_sphere:There are " ,len(t) ," letters in t" , t);

    if((halign!=undef) || (halign!=undef))
    {
        echo (str("text_on_sphere:","WARNING " , "halign and valign are NOT supported (functionality used in centering)."));
    }

    //TODO: refactor this?
	rtl_sign = (direction=="rtl") ? -1 : 1;
	
	//TODO: Look at changing this to extrusion_height_center
	//and renaming the other as text_center
	//If we are centered - we sink the radius by half the
	//extrusion height to draw "just below the surface"
	rr = (center) ? r-extrusion_height/2 : r ;
	
	rotate(eastwest,[0,0,1])
	rotate(-northsouth,[1,0,0])
	rotate(spin,[0,1,0])
	{
	//This tries to center the text (for RTL text).
    ttb_btt_inaction = (direction=="ttb" || direction=="btt") ? 0 : 1;
	rotate( -rtl_sign * ttb_btt_inaction * rotation_for_center_text_string(t, size, spacing, rr, rotate, center), [0,0,1])
	{
	    translate(locn_vec)
		if ( rounded == false ){
			__internal_text_on_sphere_helper(t=t,r=rr,
	    		rotate=rotate,
	    		center=center,
	    		scale=scale,
	            font=font,size=size,
                spacing=spacing,
                direction=direction,
                language=language,script=script,halign=halign,valign=valign,
                extrusion_height=extrusion_height
			);
		}else{
		    //If rounding then clip the text inside an inner sphere and outer sphere
			intersection()
			{
			__internal_text_on_sphere_helper(t=t,r=rr,
        		rotate=rotate,
        		center=center,
        		scale=scale,
                font=font,size=size,
                spacing=spacing,
                direction=direction,
                language=language,script=script,halign=halign,valign=valign,
                extrusion_height=extrusion_height*2 //Make it proud to clip it off.
		    );

            //Shell - bounding inner and outer
			difference()
			{   //rounded outside
				sphere(rr+extrusion_height);
				// rounded inside for indented text
			    sphere( rr  );
			}

		    }
		}
		}
	}
}

//internal function -- don't call directly
//No default checks in this funciton -- done in parent
module __internal_text_on_sphere_helper(t=default_t,
                      //Object-specific
                      r,
                      //All objects
                      extrusion_height = default_extrusion_height,
                      center           = default_center,
                      scale  = default_scale,
                      //All objects -- arguments as for text()
                      font             = undef,
                      size             = default_size,
                      direction        = undef,
                      //halign           = undef,
                      //valign           = undef,
                      language         = undef,
                      script           = undef,
                      spacing          = default_spacing
)
{
    rtl_sign = (direction=="rtl") ? -1 : 1;
    ttb_btt_inaction = (direction=="ttb" || direction=="btt") ? 0 : 1;
    ttb_btt_action   = (direction=="ttb" || direction=="btt") ? 1 : 0;
    
    for (l=[0:len(t)-1]){
	    rotate_z_inner   = -90 + rtl_sign * ttb_btt_inaction * l * rotation_for_character(size, spacing, r, 0);
	    
        rotate( rotate_z_inner, [0,0,1] )
		{
        translate_sign   = (direction=="ttb" || direction=="btt") ? ((direction=="btt") ? 1 : -1)  : 0 ;
        //translate_effect = (direction=="ttb" || direction=="btt") ? 1  :  0 ;
        //Translate letter to be located on the sphere in up/down direction when we are doing TTB and BTT
	    translate(r * [cos(0 + ttb_btt_action * rotation_for_character(size, spacing, r, rotate) * l ), 0, translate_sign * ttb_btt_action * sin(0 +  rotation_for_character(size, spacing, r, rotate) * l ) ])
        //Rotate letter to be tangential to the new part of the sphere when we are doing TTB and BTT
	    rotate(-90 * translate_sign * (0 + ttb_btt_action * rotation_for_character(size, spacing, r, rotate) * l )/90 , [0,1,0])
        //Flip character into position to be flush against sphere
	    rotate(90,[1,0,0])
	    rotate(90,[0,1,0])
	    
	    //Modify the offset of the baselined text to center
	    translate([0,(center) ? -size/2 : 0 ,0])
	    
	    text_extrude(t[l],
	        center=false,
	        rotate=rotate,
	        scale=scale,
	        font=font,
	        size=size,
            spacing=spacing,
            direction=undef, //We don't pass direction ( misaligns inside text() ). TODO: Investigate why
            language=language,script=script,
            halign="center", //This can be relaxed eventually
            valign="baseline", //Need this to keep all letters on the same line (could also support top -- otherw will make wonky letters)
            extrusion_height=extrusion_height );
		}
    }
}



//cube(size)
//cube([width,h,depth])
//NB: cube_size is used instead of size (the name size is used in the text module)
//NB: Passes through text as strings -- supports all features of text()
module text_on_cube(  t=default_t,
                      //Object-specific
                      cube_size, //number or 3-vector
                      face      = default_cube_face,
                      rightleft = default_cube_rightleft,
                      updown    = default_cube_updown,
                      //All objects
                      locn_vec = [0,0,0],
                      extrusion_height = default_extrusion_height,
                      center = undef,
                      rotate = default_rotate,
                      scale  = default_scale,
                      //All objects -- arguments as for text()
                      font             = undef,
                      size             = default_size,
                      direction        = undef,
                      halign           = undef,
                      valign           = undef,
                      language         = undef,
                      script           = undef,
                      spacing          = default_spacing
){
    //echo (str("text_on_cube:","There are " ,len(t) ," letters in t" , t));
    //echo (str("text_on_cube:","cube_size" , cube_size));
    
    if((halign!=undef) || (halign!=undef))
    {
        echo (str("text_on_cube:","WARNING " , "halign and valign are NOT supported."));
    }

    int_cube_size = (str(cube_size)[0] != "[") ? [cube_size,cube_size,cube_size] : cube_size;
    rotate_x = ( (face=="front") || (face=="back") || (face=="left") || (face=="right") ) ? 90
				: ((face=="bottom") ? 180 : 0) ; //Top is zero
	rotate_y = ( (face=="back") || (face=="left") || (face=="right") ) ? (face=="back") ? 180 : ((face=="left") ? -90 : 90) //Right is 90
				: 0 ; //Top, bottom, front are zero
	locn_vec_offset =
	        (face=="front") ?             [+rightleft,   -int_cube_size[1]/2, +updown]
	        :((face=="back")?             [+rightleft,   +int_cube_size[1]/2, +updown]
	            : ((face=="left")?         [-int_cube_size[0]/2, +rightleft,   +updown]
	                : ((face=="right")?    [+int_cube_size[0]/2, +rightleft,   +updown]
	                    : ((face=="top")?  [+rightleft,   +updown,             +int_cube_size[2]/2]
	                        :              [+rightleft,   -updown,             -int_cube_size[2]/2]
							)))); //bottom
							
		translate(locn_vec + locn_vec_offset)
		rotate(rotate_x,[1,0,0])
		rotate(rotate_y,[0,1,0])  // rotate around the y axis (z before rotation)
		text_extrude(t,
		    center=center,
		    rotate=rotate,
		    scale=scale,
		    font=font,
		    size=size,
		    spacing=spacing,
		    direction=direction, //Does this misalign inside text()? the individual character modules do.
		    language=language,
		    script=script,
		    halign=halign,
		    valign=valign,
		    extrusion_height=extrusion_height );
}

function default_if_undef(val, default_val) = (val!=undef) ? val : default_val ;

//Print a single character or a string at the desired extrusion height
//Passes on values to text() that are passed in
//TODO: Add x,y,z rotations get text facing the right way from the start)
module text_extrude( t=default_t,
                     extrusion_height = default_extrusion_height,
                     center = default_center, //Fudgy. YMMV. //TODO:center_extrusion, or extrusion offset??
                     rotate = default_rotate,
                     scale  = default_scale, //For scaling by different on axes (for widening etc)
                     //Following are test() params (in addition to t=)
                     font             = default_font,
                     size             = default_size,
                     direction        = undef,
                     halign           = undef,
                     valign           = undef,
                     language         = undef,
                     script           = undef,
                     spacing          = default_spacing
)
{
    //echo (str("text_extrude:","There are " ,len(t) ," letters in text" , t));
    //echo (str("text_extrude:","extrusion_height=" , extrusion_height));
    
    if(center==true)
    {
        if((halign!=undef) || (valign!=undef))
        {
            echo (str("text_extrude:","WARNING " , "When center is true, then halign and valign are NOT supported."));
        }
    }
    
    //As arguments are explicitly set as undef (from higher functions) as they come down (they don't get defaults in this function as they are set as something)
    //we need to check and replace any that we don't want to be undef
    t                 = default_if_undef(t,default_t);
    font              = default_if_undef(font,default_font);
    extrusion_height  = default_if_undef(extrusion_height,default_extrusion_height);
    center            = default_if_undef(center,default_center);
    rotate            = default_if_undef(rotate,default_rotate);
    spacing           = default_if_undef(spacing,default_spacing);
    size              = default_if_undef(size,default_size);
    
    halign            = (center) ? "center" : halign ;
    valign            = (center) ? "center" : valign ;
    extrusion_center  = (center) ? true : false ;
	
	scale( scale )
    rotate(rotate,[0,0,-1]) //TODO: Do we want to make this so that the entire vector can be set?
	{
	    linear_extrude(height=extrusion_height,convexity=10,center=extrusion_center)
        text(text=t, size = size,
            $fn = 40,
            font = font, direction = direction, spacing = spacing,
            halign = halign,
            valign = valign,
            language=language, script=script);
	}
}

