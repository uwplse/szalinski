use <MCAD/boxes.scad>;

/* http://worknotes.scripting.com/february2012/22612ByDw/listOfGoogleFonts */

// preview[view:south, tilt:top]

part = "all"; // [base:Base Only,line1:Line 1 Text,line2:Line 2 Text,line3:Line 3 Text,line4:Line 4 Text,lip:Lip Only,all:Entire Tag]

/* [Tag Settings] */

// Width of the tag
tagWidth = 75;
// Height of the tag
tagHeight = 45;
// Depth/thickness of the tag
tagDepth=2;
// Radius of the rounded corners of the tag
cornerRadius = 4;

// Typeface to use. See fonts.google.com for options.
typeface = "Concert One"; //[ABeeZee,Abel,Abril Fatface,Aclonica,Acme,Actor,Adamina,Advent Pro,Aguafina Script,Akronim,Aladin,Aldrich,Alef,Alegreya,Alegreya SC,Alegreya Sans,Alegreya Sans SC,Alex Brush,Alfa Slab One,Alice,Alike,Alike Angular,Allan,Allerta,Allerta Stencil,Allura,Almendra,Almendra Display,Almendra SC,Amarante,Amaranth,Amatic SC,Amethysta,Amiri,Amita,Anaheim,Andada,Andika,Angkor,Annie Use Your Telescope,Anonymous Pro,Antic,Antic Didone,Antic Slab,Anton,Arapey,Arbutus,Arbutus Slab,Architects Daughter,Archivo Black,Archivo Narrow,Arimo,Arizonia,Armata,Artifika,Arvo,Arya,Asap,Asar,Asset,Astloch,Asul,Atomic Age,Aubrey,Audiowide,Autour One,Average,Average Sans,Averia Gruesa Libre,Averia Libre,Averia Sans Libre,Averia Serif Libre,Bad Script,Balthazar,Bangers,Basic,Battambang,Baumans,Bayon,Belgrano,Belleza,BenchNine,Bentham,Berkshire Swash,Bevan,Bigelow Rules,Bigshot One,Bilbo,Bilbo Swash Caps,Biryani,Bitter,Black Ops One,Bokor,Bonbon,Boogaloo,Bowlby One,Bowlby One SC,Brawler,Bree Serif,Bubblegum Sans,Bubbler One,Buda,Buenard,Butcherman,Butterfly Kids,Cabin,Cabin Condensed,Cabin Sketch,Caesar Dressing,Cagliostro,Calligraffitti,Cambay,Cambo,Candal,Cantarell,Cantata One,Cantora One,Capriola,Cardo,Carme,Carrois Gothic,Carrois Gothic SC,Carter One,Catamaran,Caudex,Caveat,Caveat Brush,Cedarville Cursive,Ceviche One,Changa One,Chango,Chau Philomene One,Chela One,Chelsea Market,Chenla,Cherry Cream Soda,Cherry Swash,Chewy,Chicle,Chivo,Chonburi,Cinzel,Cinzel Decorative,Clicker Script,Coda,Coda Caption,Codystar,Combo,Comfortaa,Coming Soon,Concert One,Condiment,Content,Contrail One,Convergence,Cookie,Copse,Corben,Courgette,Cousine,Coustard,Covered By Your Grace,Crafty Girls,Creepster,Crete Round,Crimson Text,Croissant One,Crushed,Cuprum,Cutive,Cutive Mono,Damion,Dancing Script,Dangrek,Dawning of a New Day,Days One,Dekko,Delius,Delius Swash Caps,Delius Unicase,Della Respira,Denk One,Devonshire,Dhurjati,Didact Gothic,Diplomata,Diplomata SC,Domine,Donegal One,Doppio One,Dorsa,Dosis,Dr Sugiyama,Droid Sans,Droid Sans Mono,Droid Serif,Duru Sans,Dynalight,EB Garamond,Eagle Lake,Eater,Economica,Eczar,Ek Mukta,Electrolize,Elsie,Elsie Swash Caps,Emblema One,Emilys Candy,Engagement,Englebert,Enriqueta,Erica One,Esteban,Euphoria Script,Ewert,Exo,Exo 2,Expletus Sans,Fanwood Text,Fascinate,Fascinate Inline,Faster One,Fasthand,Fauna One,Federant,Federo,Felipa,Fenix,Finger Paint,Fira Mono,Fira Sans,Fjalla One,Fjord One,Flamenco,Flavors,Fondamento,Fontdiner Swanky,Forum,Francois One,Freckle Face,Fredericka the Great,Fredoka One,Freehand,Fresca,Frijole,Fruktur,Fugaz One,GFS Didot,GFS Neohellenic,Gabriela,Gafata,Galdeano,Galindo,Gentium Basic,Gentium Book Basic,Geo,Geostar,Geostar Fill,Germania One,Gidugu,Gilda Display,Give You Glory,Glass Antiqua,Glegoo,Gloria Hallelujah,Goblin One,Gochi Hand,Gorditas,Goudy Bookletter 1911,Graduate,Grand Hotel,Gravitas One,Great Vibes,Griffy,Gruppo,Gudea,Gurajada,Habibi,Halant,Hammersmith One,Hanalei,Hanalei Fill,Handlee,Hanuman,Happy Monkey,Headland One,Henny Penny,Herr Von Muellerhoff,Hind,Hind Siliguri,Hind Vadodara,Holtwood One SC,Homemade Apple,Homenaje,IM Fell DW Pica,IM Fell DW Pica SC,IM Fell Double Pica,IM Fell Double Pica SC,IM Fell English,IM Fell English SC,IM Fell French Canon,IM Fell French Canon SC,IM Fell Great Primer,IM Fell Great Primer SC,Iceberg,Iceland,Imprima,Inconsolata,Inder,Indie Flower,Inika,Inknut Antiqua,Irish Grover,Istok Web,Italiana,Italianno,Itim,Jacques Francois,Jacques Francois Shadow,Jaldi,Jim Nightshade,Jockey One,Jolly Lodger,Josefin Sans,Josefin Slab,Joti One,Judson,Julee,Julius Sans One,Junge,Jura,Just Another Hand,Just Me Again Down Here,Kadwa,Kalam,Kameron,Kantumruy,Karla,Karma,Kaushan Script,Kavoon,Kdam Thmor,Keania One,Kelly Slab,Kenia,Khand,Khmer,Khula,Kite One,Knewave,Kotta One,Koulen,Kranky,Kreon,Kristi,Krona One,Kurale,La Belle Aurore,Laila,Lakki Reddy,Lancelot,Lateef,Lato,League Script,Leckerli One,Ledger,Lekton,Lemon,Libre Baskerville,Life Savers,Lilita One,Lily Script One,Limelight,Linden Hill,Lobster,Lobster Two,Londrina Outline,Londrina Shadow,Londrina Sketch,Londrina Solid,Lora,Love Ya Like A Sister,Loved by the King,Lovers Quarrel,Luckiest Guy,Lusitana,Lustria,Macondo,Macondo Swash Caps,Magra,Maiden Orange,Mako,Mallanna,Mandali,Marcellus,Marcellus SC,Marck Script,Margarine,Marko One,Marmelad,Martel,Martel Sans,Marvel,Mate,Mate SC,Maven Pro,McLaren,Meddon,MedievalSharp,Medula One,Megrim,Meie Script,Merienda,Merienda One,Merriweather,Merriweather Sans,Metal,Metal Mania,Metamorphous,Metrophobic,Michroma,Milonga,Miltonian,Miltonian Tattoo,Miniver,Miss Fajardose,Modak,Modern Antiqua,Molengo,Molle,Monda,Monofett,Monoton,Monsieur La Doulaise,Montaga,Montez,Montserrat,Montserrat Alternates,Montserrat Subrayada,Moul,Moulpali,Mountains of Christmas,Mouse Memoirs,Mr Bedfort,Mr Dafoe,Mr De Haviland,Mrs Saint Delafield,Mrs Sheppards,Muli,Mystery Quest,NTR,Neucha,Neuton,New Rocker,News Cycle,Niconne,Nixie One,Nobile,Nokora,Norican,Nosifer,Nothing You Could Do,Noticia Text,Noto Sans,Noto Serif,Nova Cut,Nova Flat,Nova Mono,Nova Oval,Nova Round,Nova Script,Nova Slim,Nova Square,Numans,Nunito,Odor Mean Chey,Offside,Old Standard TT,Oldenburg,Oleo Script,Oleo Script Swash Caps,Open Sans,Open Sans Condensed,Oranienbaum,Orbitron,Oregano,Orienta,Original Surfer,Oswald,Over the Rainbow,Overlock,Overlock SC,Ovo,Oxygen,Oxygen Mono,PT Mono,PT Sans,PT Sans Caption,PT Sans Narrow,PT Serif,PT Serif Caption,Pacifico,Palanquin,Palanquin Dark,Paprika,Parisienne,Passero One,Passion One,Pathway Gothic One,Patrick Hand,Patrick Hand SC,Patua One,Paytone One,Peddana,Peralta,Permanent Marker,Petit Formal Script,Petrona,Philosopher,Piedra,Pinyon Script,Pirata One,Plaster,Play,Playball,Playfair Display,Playfair Display SC,Podkova,Poiret One,Poller One,Poly,Pompiere,Pontano Sans,Poppins,Port Lligat Sans,Port Lligat Slab,Pragati Narrow,Prata,Preahvihear,Press Start 2P,Princess Sofia,Prociono,Prosto One,Puritan,Purple Purse,Quando,Quantico,Quattrocento,Quattrocento Sans,Questrial,Quicksand,Quintessential,Qwigley,Racing Sans One,Radley,Rajdhani,Raleway,Raleway Dots,Ramabhadra,Ramaraja,Rambla,Rammetto One,Ranchers,Rancho,Ranga,Rationale,Ravi Prakash,Redressed,Reenie Beanie,Revalia,Rhodium Libre,Ribeye,Ribeye Marrow,Righteous,Risque,Roboto,Roboto Condensed,Roboto Mono,Roboto Slab,Rochester,Rock Salt,Rokkitt,Romanesco,Ropa Sans,Rosario,Rosarivo,Rouge Script,Rozha One,Rubik,Rubik Mono One,Rubik One,Ruda,Rufina,Ruge Boogie,Ruluko,Rum Raisin,Ruslan Display,Russo One,Ruthie,Rye,Sacramento,Sahitya,Sail,Salsa,Sanchez,Sancreek,Sansita One,Sarala,Sarina,Sarpanch,Satisfy,Scada,Scheherazade,Schoolbell,Seaweed Script,Sevillana,Seymour One,Shadows Into Light,Shadows Into Light Two,Shanti,Share,Share Tech,Share Tech Mono,Shojumaru,Short Stack,Siemreap,Sigmar One,Signika,Signika Negative,Simonetta,Sintony,Sirin Stencil,Six Caps,Skranji,Slabo 13px,Slabo 27px,Slackey,Smokum,Smythe,Sniglet,Snippet,Snowburst One,Sofadi One,Sofia,Sonsie One,Sorts Mill Goudy,Source Code Pro,Source Sans Pro,Source Serif Pro,Special Elite,Spicy Rice,Spinnaker,Spirax,Squada One,Sree Krushnadevaraya,Stalemate,Stalinist One,Stardos Stencil,Stint Ultra Condensed,Stint Ultra Expanded,Stoke,Strait,Sue Ellen Francisco,Sumana,Sunshiney,Supermercado One,Sura,Suranna,Suravaram,Suwannaphum,Swanky and Moo Moo,Syncopate,Tangerine,Taprom,Tauri,Teko,Telex,Tenali Ramakrishna,Tenor Sans,Text Me One,The Girl Next Door,Tienne,Tillana,Timmana,Tinos,Titan One,Titillium Web,Trade Winds,Trocchi,Trochut,Trykker,Tulpen One,Ubuntu,Ubuntu Condensed,Ubuntu Mono,Ultra,Uncial Antiqua,Underdog,Unica One,UnifrakturCook,UnifrakturMaguntia,Unkempt,Unlock,Unna,VT323,Vampiro One,Varela,Varela Round,Vast Shadow,Vesper Libre,Vibur,Vidaloka,Viga,Voces,Volkhov,Vollkorn,Voltaire,Waiting for the Sunrise,Wallpoet,Walter Turncoat,Warnes,Wellfleet,Wendy One,Wire One,Work Sans,Yanone Kaffeesatz,Yantramanav,Yellowtail,Yeseva One,Yesteryear,Zeyada]

// The position of the tag hole -- within the tag or sticking out from it
tagHolePosition = 0; // [0:Inside Lip,1:Outside Lip]
// Width of the tag hole
tagHoleWidth = 15; 
// Height of the tag hole
tagHoleHeight = 4;

// Include a lip around the outside of the tag
useLip = true;
// How wide should the lip be?
lipWidth=3;
// How thick should the lip be? Zero to disable
lipDepth = 1;

/* [Tag Text] */
// Left or right align the text on the tag
text_horizonal_alignment="right"; // [left:Left Aligned,right:Right Aligned]

// Should the text be raised or inset from the tag
text_position=1; //[1:Outset,0:Flat,-1:Inset]

// Spacing between the icon, lip or edge of tag and the text.
textPadding=2;
// Spacing between each line of text on the tag
line_spacing=4;

// Text of line 1
line_1_text="Boaty McBoatface";
// Font style. See fonts.google.com for options.
line_1_style="Bold"; 
// Size of line 1 text, in mm.
line_1_size=6;
// Amount of inset or outset for line 1
line_1_depth=.5;

// Text of line 2
line_2_text="Atlantic Ocean";
// Font style. See fonts.google.com for options.
line_2_style="";
// Size of line 2 text, in mm. Zero to disable.
line_2_size=4.5;
// Amount of inset or outset for line 2
line_2_depth=.3;

// Text of line 3
line_3_text="bmcbf@atlanticocean.org";
// Font style. See fonts.google.com for options.
line_3_style="";
// Size of line 3 text, in mm. Zero to disable.
line_3_size=3;
// Amount of inset or outset for line 3
line_3_depth=.3;

// Text of line 4
line_4_text="(555) 555-1212";
// Font style. See fonts.google.com for options.
line_4_style = "";
// Size of line 4 text, in mm. Zero to disable.
line_4_size=4.5;
// Amount of inset or outset for line 4
line_4_depth=.3;


/* [Hidden] */
fudge = .1;
$fn=24;
textfn=12;
textvalign="center";
iconSpacing = 0;
textColor="black";

// render each of the parts

if (part == "base" || part == "all" || 
    (part == "line2" && line_2_size == 0) ||
    (part == "line3" && line_3_size == 0) ||
    (part == "line4" && line_4_size == 0))
{
    color("Khaki")
    difference() {
        render_tag();
        if (tagHolePosition == 0) // inside the tag
        {
            translate([-(tagWidth/2) + lipWidth + tagHoleHeight, 0, 0])
            roundedBox([tagHoleHeight, tagHoleWidth, 50], tagHoleHeight/2, sidesonly=true);
        }
        
        if (tagHolePosition == 1) // outside the tag
        {
            translate([-(tagWidth/2) - lipWidth - tagHoleHeight/2, 0, 0])
            roundedBox([tagHoleHeight, tagHoleWidth, 50], tagHoleHeight/2, sidesonly=true);
        }
        render_text(0, true);
    }
}

if (part == "lip" || part == "all")
{
    color("DarkCyan")
    render_lip();
}

if (part == "line1" || part == "line2" || part == "line3" || part == "line4" ||part == "all")
{
    render_text(text_position, false);
}

module render_text(position, force)
{

    // render text

    textHeight = line_1_size + line_2_size + (line_2_size > 0 ? line_spacing : 0) + line_3_size + (line_3_size > 0 ? line_spacing : 0) + line_4_size + (line_4_size > 0 ? line_spacing : 0);

    echo("Text box height: ", textHeight);


    textOrigin = (text_horizonal_alignment=="right" ? tagWidth/2-lipWidth-textPadding : -(tagWidth/2) + iconSpacing + textPadding + lipWidth + (tagHolePosition == 0 ? tagHoleHeight * 2 : 0));

    // line 1
    line_1_y = textHeight/2-line_1_size/2;
    line_1_font = str(typeface,(line_1_style != "" ? str(":style=",line_1_style) : ""));
    echo("line_1_: ", line_1_y, " Font: ",line_1_font);
    if (part == "line1" || part == "all" || force)
    {
        textDepth = (tagDepth *.75) + line_1_depth * position;
        echo("Line 1 Depth: ", textDepth);
        translate([textOrigin,line_1_y,(textDepth/2 - tagDepth/4)])
        color("DarkSlateGray")
            linear_extrude(height=textDepth, center=true)
                text($fn=textfn, line_1_text,font=line_1_font, valign=textvalign, halign=text_horizonal_alignment, size=line_1_size);
    }
    // line 2
    if (line_2_size > 0)
    {
        line_2_y = line_1_y-line_1_size-line_spacing;
        line_2_font = str(typeface,(line_2_style != "" ? str(":style=",line_2_style) : ""));
        echo("line_2_: ", line_2_y, " Font: ",line_2_font);
        if (part == "line2" || part == "all" || force)
        {
            textDepth = (tagDepth *.75) + line_2_depth * position;
            echo("Line 2 Depth: ", textDepth);
            translate([textOrigin,line_2_y,(textDepth/2 - tagDepth/4)])
            color("DarkBlue")
                linear_extrude(height=textDepth, center=true)
                    text($fn=textfn, line_2_text,font=line_2_font, valign=textvalign, halign=text_horizonal_alignment, size=line_2_size);
        }
        // line 3
        if (line_3_size > 0)
        {
            line_3_y = line_2_y-line_2_size-line_spacing;
            line_3_font = str(typeface,(line_3_style != "" ? str(":style=",line_3_style) : ""));
            echo("line_3_: ", line_3_y, " Font: ",line_3_font);
            if (part == "line3" || part == "all" || force)
            {
                textDepth = (tagDepth *.75) + line_3_depth * position;
                echo("Line 3 Depth: ", textDepth);
                translate([textOrigin,line_3_y,(textDepth/2 - tagDepth/4)])
                color("DarkRed")
                    linear_extrude(height=textDepth, center=true)
                        text($fn=textfn, line_3_text,font=line_3_font, valign=textvalign, halign=text_horizonal_alignment, size=line_3_size);
            }
            
            // line 4
            if (line_4_size > 0)
            {
                line_4_y = line_3_y-line_3_size-line_spacing;
                line_4_font = str(typeface,(line_4_style != "" ? str(":style=",line_4_style) : ""));
                echo("line_4_: ", line_4_y, " Font: ",line_4_font);
                if (part == "line4" || part == "all" || force)
                {
                    textDepth = (tagDepth *.75) + line_4_depth * position;
                    echo("Line 4 Depth: ", textDepth);
                    translate([textOrigin,line_4_y,(textDepth/2 - tagDepth/4)])
                        color("DarkGreen")
                            linear_extrude(height=textDepth, center=true)
                                text($fn=textfn, line_4_text,font=line_4_font, valign=textvalign, halign=text_horizonal_alignment, size=line_4_size);
                }
            }       
        }
    }
}
    

module render_tag()
{
    
    // the base of the tag
    if (useLip)
    {
        roundedBox([tagWidth-lipWidth*2,tagHeight-lipWidth*2,tagDepth], cornerRadius, true);
    } else {
        roundedBox([tagWidth,tagHeight,tagDepth], cornerRadius, true);
    }
    if (tagHolePosition == 1)
    {
        translate([-tagWidth/2, 0,0])
            roundedBox([tagHoleHeight*5, tagHoleWidth+tagHoleHeight*2, tagDepth], tagHoleHeight/2, true);
    }

}

module render_lip()
{
    if (useLip)
    {
        difference() {
            translate([0,0,lipDepth/2]) {
                difference() {
                    roundedBox([tagWidth,tagHeight,lipDepth+tagDepth], cornerRadius, true);
                    roundedBox([tagWidth-lipWidth*2,tagHeight-lipWidth*2,lipDepth+tagDepth+fudge], cornerRadius, true);
                }
            }
            if (tagHolePosition == 1)
                {
                    translate([-tagWidth/2, 0,0])
                        roundedBox([tagHoleHeight*5, tagHoleWidth+tagHoleHeight*2, tagDepth], tagHoleHeight/2, true);
            }
        }
    }
}
