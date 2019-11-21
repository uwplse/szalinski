use <MCAD/boxes.scad>;
// preview[view:south, tilt:top]
/* [Print Settings ] */
// Layer 1 Height
layer1Height=.2;
// Other Layers (if different)
layerHeight=.2;
// Line 1 (Brand)
line_1_text="3dxtech PETg";
// Line 2 (Color / Type)
line_2_text="P.R.U.S.A. Orange";
// Line 3 (Nozzle / Temp / Bed Temp)
line_3_text=".4 / 265 / 80";

// Should the text be raised or inset from the Card
text_position=-1; //[1:Outset,-1:Inset]

// Layer Samples to Print
numLayers=4; // [4:1:8]
 

/* [Card Settings] */
// Width of the card
CardWidth = 90;
// Height of the card
CardHeight = 50;
// Depth/thickness of the Card
CardDepth=1.8; // [0.8:0.1:2.0]
// Radius of the rounded corners of the Card
cornerRadius = 3;
// Size of the Card hole
CardHole = 3; 
//Distance from edge of Card
HoleOffset = 1.6;



/* [Card Text Settings] */
// Left or right align the text on the Card
text_horizonal_alignment="right"; // [left:Left Aligned,right:Right Aligned]
// Spacing between the icon, lip or edge of Card and the text.
textPadding=2;
// Spacing between each line of text on the Card
line_spacing=2;


// Font style. See fonts.google.com for options.
line_1_style="Bold"; 
// Size of line 1 text, in mm.
line_1_size=7;
// Amount of inset or outset for line 1
line_1_depth=.4;


// Font style. See fonts.google.com for options.
line_2_style="Bold";
// Size of line 2 text, in mm. Zero to disable.
line_2_size=6;
// Amount of inset or outset for line 2
line_2_depth=.4;


// Font style. See fonts.google.com for options.
line_3_style="Bold";
// Size of line 3 text, in mm. Zero to disable.
line_3_size=6;
// Amount of inset or outset for line 3
line_3_depth=.4;

/* [Hidden] */
fudge = .1;
$fn=24;
textfn=12;
textvalign="center";
iconSpacing = 0;
textColor="black";
part="all";
lipWidth=0;
BoxSizeW=(CardWidth/(numLayers));
BoxSizeH=(CardHeight/3);
BoxZPos=-(BoxSizeH-HoleOffset);
echo (BoxSizeW=BoxSizeW,BoxSizeH=BoxSizeH,BoxZPos=BoxZPos);

difference() {   
    // the base of the Card
        roundedBox([CardWidth,CardHeight,CardDepth], cornerRadius, true);

    if (numLayers == 4) 
    {
       
    // Position of keyring hole, Lower left
         translate([-((CardWidth/2)-CardHole-HoleOffset), -(CardHeight/2)+CardHole+HoleOffset,-2]) 
            cylinder(r=CardHole,h=CardDepth+2, $fn=50 ); 

    // Layer Thickness Sample Boxes for 4 layers
         BoxSizeW=(CardWidth/5);
    // 1 Layer only
         translate([-(BoxSizeW)-(HoleOffset*4), BoxZPos,layer1Height])  
           roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
    // 2 Layers
         translate([-(HoleOffset*3), BoxZPos,(layer1Height+layerHeight)]) 
           roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
    // 3 Layers
         translate([BoxSizeW-(HoleOffset*2), BoxZPos,(layer1Height+(layerHeight)*2)]) 
           roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
    // 4 Layers
         translate([(BoxSizeW*2)-HoleOffset, BoxZPos,(layer1Height+(layerHeight*3))])
           roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );        
        } 
        
        
    if (numLayers == 5)
          {
    // Position of keyring hole, Upper left
       translate([-((CardWidth/2)-CardHole-HoleOffset), (CardHeight/2)-CardHole-HoleOffset,-2]) 
          cylinder(r=CardHole,h=CardDepth+2, $fn=50 );

    // Layer Thickness Sample Boxes for 5 layers
           BoxSizeW=(CardWidth/5);   
              cornerRadius=2;
    // 1 Layer only
         translate([-(BoxSizeW*2)+HoleOffset*2, BoxZPos,layer1Height]) 
           roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
    // 2 Layers
         translate([-(BoxSizeW)+HoleOffset, BoxZPos,(layer1Height+layerHeight)]) 
           roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
    // 3 Layers
         translate([0, BoxZPos,(layer1Height+(layerHeight)*2)]) 
           roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
    // 4 Layers
         translate([BoxSizeW-(HoleOffset), BoxZPos,(layer1Height+(layerHeight*3))])
           roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
    // 5 Layers 
         translate([(BoxSizeW*2)-(HoleOffset*2), BoxZPos,(layer1Height+(layerHeight*4))])
           roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
       }
        if (numLayers == 6)
          {
     // Position of keyring hole, upper left
       translate([-((CardWidth/2)-CardHole-HoleOffset), (CardHeight/2)-CardHole-HoleOffset,-2]) 
        cylinder(r=CardHole,h=CardDepth+2, $fn=50 );

    // Layer Thickness Sample Boxes for 6 layers
              BoxSizeW=(CardWidth/6);
              cornerRadius=1;
    // 1 Layer only - Left Most
       l1x=((CardWidth/2)-BoxSizeW/2-HoleOffset); echo (l1x=l1x);
         translate([-l1x, BoxZPos,layer1Height]) 
          roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
    // 2 Layers
       l2x=((CardWidth/2)-BoxSizeW*1.5-HoleOffset/2); echo (l2x=l2x);
         translate([-l2x, BoxZPos,(layer1Height+layerHeight)]) 
          roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
    // 3 Layers
       l3x=(BoxSizeW/2); echo (l3x=l3x);
         translate([-l3x, BoxZPos,(layer1Height+(layerHeight)*2)]) 
           roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
    // 4 Layers
         translate([l3x, BoxZPos,(layer1Height+(layerHeight*3))])
          roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
    // 5 Layers 
         translate([l2x, BoxZPos,(layer1Height+(layerHeight*4))])
          roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
    // 6 Layers 
         translate([l1x, BoxZPos,(layer1Height+(layerHeight*5))])
          roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
       }
        if (numLayers == 7)
          {
              
    // Position of keyring hole, upper left
       translate([-((CardWidth/2)-CardHole-HoleOffset), (CardHeight/2)-CardHole-HoleOffset,-2]) 
       cylinder(r=CardHole,h=CardDepth+2, $fn=50 );
    
    // Layer Thickness Sample Boxes for 7 layers
    BoxSizeW=(CardWidth/6.8);
    cornerRadius=1;
    // 1 Layer only
       l1x=((CardWidth/2)-BoxSizeW/2-HoleOffset); echo (l1x=l1x);
         translate([-l1x, BoxZPos,layer1Height]) 
           roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
    // 2 Layers
       l2x=((CardWidth/2)-BoxSizeW*1.5-HoleOffset/2); echo (l2x=l2x);
         translate([-l2x, BoxZPos,(layer1Height+layerHeight)]) 
           roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
    // 3 Layers
       l3x=((CardWidth/2)-BoxSizeW*2.5); echo (l3x=l3x);
         translate([-l3x, BoxZPos,(layer1Height+(layerHeight)*2)]) 
           roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
    // 4 Layers
         translate([0, BoxZPos,(layer1Height+(layerHeight*3))])
           roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
    // 5 Layers 
         translate([l3x, BoxZPos,(layer1Height+(layerHeight*4))])
           roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
    // 6 Layers 
         translate([l2x, BoxZPos,(layer1Height+(layerHeight*5))])
           roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
    // 7 Layers 
         translate([l1x, BoxZPos,(layer1Height+(layerHeight*6))])
           roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
       }
       if (numLayers == 8)
          {
          // Position of keyring hole, upper left
          translate([-((CardWidth/2)-CardHole-HoleOffset), (CardHeight/2)-CardHole-HoleOffset,-2]) 
        cylinder(r=CardHole,h=CardDepth+2, $fn=50 );
    // Layer Thickness Sample Boxes for 8 layers
    BoxSizeW=(CardWidth/8);
    cornerRadius=1;
    // 1 Layer only
       l1x=((CardWidth/2)-BoxSizeW/2-HoleOffset); echo (l1x=l1x);
         translate([-l1x, BoxZPos,layer1Height]) 
           roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
    // 2 Layers
       l2x=((CardWidth/2)-BoxSizeW*1.5-HoleOffset/2); echo (l2x=l2x);
         translate([-l2x, BoxZPos,(layer1Height+layerHeight)]) 
           roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
    // 3 Layers
       l3x=((CardWidth/2)-BoxSizeW*2.5); echo (l3x=l3x);
         translate([-l3x, BoxZPos,(layer1Height+(layerHeight)*2)]) 
           roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
    // 4 Layers
       l4x=((CardWidth/2)-BoxSizeW*3.5); echo (l4x=l4x);
         translate([-l4x, BoxZPos,(layer1Height+(layerHeight*3))])
           roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
    // 5 Layers 
         translate([l4x, BoxZPos,(layer1Height+(layerHeight*4))])
           roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
    // 6 Layers 
         translate([l3x, BoxZPos,(layer1Height+(layerHeight*5))])
           roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
    // 7 Layers 
         translate([l2x, BoxZPos,(layer1Height+(layerHeight*6))])
           roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
    // 8 Layers 
         translate([l1x, BoxZPos,(layer1Height+(layerHeight*7))])
           roundedBox([BoxSizeW,BoxSizeH,CardDepth],cornerRadius, true  );
       }
       
       render_text(0, true);
}
render_text(text_position, true);

module render_text(position, force)
{

    // render text

    //textHeight = line_1_size + line_2_size + (line_2_size > 0 ? line_spacing : 0) + line_3_size + (line_3_size > 0 ? line_spacing : 0) ;

    echo("Text box height: ", textHeight);
    textHeight = CardHeight-(textPadding+3) ;


    textOrigin = (text_horizonal_alignment=="right" ? CardWidth/2-textPadding : -(CardWidth/2) + iconSpacing + textPadding );
    
    echo ("Text Origin: ",textOrigin);
   

    // line 1
    line_1_y = textHeight/2-line_1_size/2;
    line_1_font = str(typeface,(line_1_style != "" ? str(":style=",line_1_style) : ""));
    echo("line_1_: ", line_1_y, " Font: ",line_1_font);
    {
        textDepth = (CardDepth*.75) + line_1_depth * position;
        echo("Line 1 Depth: ", textDepth);
        translate([textOrigin,line_1_y,(textDepth/2 - CardDepth/4)])
        color("DarkSlateGray")
            linear_extrude(height=textDepth, center=true)
                text($fn=textfn, line_1_text,font=line_1_font, valign=textvalign, halign=text_horizonal_alignment, size=line_1_size);
    }
    // line 2
    {
        line_2_y = line_1_y-line_1_size-line_spacing;
        line_2_font = str(typeface,(line_2_style != "" ? str(":style=",line_2_style) : ""));
        echo("line_2_: ", line_2_y, " Font: ",line_2_font);
        if (part == "line2" || part == "all" || force)
        {
            textDepth = (CardDepth*.75) + line_2_depth * position;
            echo("Line 2 Depth: ", textDepth);
            translate([textOrigin,line_2_y,(textDepth/2 - CardDepth/4)])
            color("DarkBlue")
                linear_extrude(height=textDepth, center=true)
                    text($fn=textfn, line_2_text,font=line_2_font, valign=textvalign, halign=text_horizonal_alignment, size=line_2_size);
        }
        // line 3
        {
            line_3_y = line_2_y-line_2_size-line_spacing;
            line_3_font = str(typeface,(line_3_style != "" ? str(":style=",line_3_style) : ""));
            echo("line_3_: ", line_3_y, " Font: ",line_3_font);
            if (part == "line3" || part == "all" || force)
            {
                textDepth = (CardDepth*.75) + line_3_depth * position;
                echo("Line 3 Depth: ", textDepth);
                translate([textOrigin,line_3_y,(textDepth/2 - CardDepth/4)])
                color("DarkRed")
                    linear_extrude(height=textDepth, center=true)
                        text($fn=textfn, line_3_text,font=line_3_font, valign=textvalign, halign=text_horizonal_alignment, size=line_3_size);
            }       
        }
    }
}







// Typeface to use. See fonts.google.com for options.
typeface = "Concert One"; //[ABeeZee,Abel,Abril Fatface,Aclonica,Acme,Actor,Adamina,Advent Pro,Aguafina Script,Akronim,Aladin,Aldrich,Alef,Alegreya,Alegreya SC,Alegreya Sans,Alegreya Sans SC,Alex Brush,Alfa Slab One,Alice,Alike,Alike Angular,Allan,Allerta,Allerta Stencil,Allura,Almendra,Almendra Display,Almendra SC,Amarante,Amaranth,Amatic SC,Amethysta,Amiri,Amita,Anaheim,Andada,Andika,Angkor,Annie Use Your Telescope,Anonymous Pro,Antic,Antic Didone,Antic Slab,Anton,Arapey,Arbutus,Arbutus Slab,Architects Daughter,Archivo Black,Archivo Narrow,Arimo,Arizonia,Armata,Artifika,Arvo,Arya,Asap,Asar,Asset,Astloch,Asul,Atomic Age,Aubrey,Audiowide,Autour One,Average,Average Sans,Averia Gruesa Libre,Averia Libre,Averia Sans Libre,Averia Serif Libre,Bad Script,Balthazar,Bangers,Basic,Battambang,Baumans,Bayon,Belgrano,Belleza,BenchNine,Bentham,Berkshire Swash,Bevan,Bigelow Rules,Bigshot One,Bilbo,Bilbo Swash Caps,Biryani,Bitter,Black Ops One,Bokor,Bonbon,Boogaloo,Bowlby One,Bowlby One SC,Brawler,Bree Serif,Bubblegum Sans,Bubbler One,Buda,Buenard,Butcherman,Butterfly Kids,Cabin,Cabin Condensed,Cabin Sketch,Caesar Dressing,Cagliostro,Calligraffitti,Cambay,Cambo,Candal,Cantarell,Cantata One,Cantora One,Capriola,Cardo,Carme,Carrois Gothic,Carrois Gothic SC,Carter One,Catamaran,Caudex,Caveat,Caveat Brush,Cedarville Cursive,Ceviche One,Changa One,Chango,Chau Philomene One,Chela One,Chelsea Market,Chenla,Cherry Cream Soda,Cherry Swash,Chewy,Chicle,Chivo,Chonburi,Cinzel,Cinzel Decorative,Clicker Script,Coda,Coda Caption,Codystar,Combo,Comfortaa,Coming Soon,Concert One,Condiment,Content,Contrail One,Convergence,Cookie,Copse,Corben,Courgette,Cousine,Coustard,Covered By Your Grace,Crafty Girls,Creepster,Crete Round,Crimson Text,Croissant One,Crushed,Cuprum,Cutive,Cutive Mono,Damion,Dancing Script,Dangrek,Dawning of a New Day,Days One,Dekko,Delius,Delius Swash Caps,Delius Unicase,Della Respira,Denk One,Devonshire,Dhurjati,Didact Gothic,Diplomata,Diplomata SC,Domine,Donegal One,Doppio One,Dorsa,Dosis,Dr Sugiyama,Droid Sans,Droid Sans Mono,Droid Serif,Duru Sans,Dynalight,EB Garamond,Eagle Lake,Eater,Economica,Eczar,Ek Mukta,Electrolize,Elsie,Elsie Swash Caps,Emblema One,Emilys Candy,Engagement,Englebert,Enriqueta,Erica One,Esteban,Euphoria Script,Ewert,Exo,Exo 2,Expletus Sans,Fanwood Text,Fascinate,Fascinate Inline,Faster One,Fasthand,Fauna One,Federant,Federo,Felipa,Fenix,Finger Paint,Fira Mono,Fira Sans,Fjalla One,Fjord One,Flamenco,Flavors,Fondamento,Fontdiner Swanky,Forum,Francois One,Freckle Face,Fredericka the Great,Fredoka One,Freehand,Fresca,Frijole,Fruktur,Fugaz One,GFS Didot,GFS Neohellenic,Gabriela,Gafata,Galdeano,Galindo,Gentium Basic,Gentium Book Basic,Geo,Geostar,Geostar Fill,Germania One,Gidugu,Gilda Display,Give You Glory,Glass Antiqua,Glegoo,Gloria Hallelujah,Goblin One,Gochi Hand,Gorditas,Goudy Bookletter 1911,Graduate,Grand Hotel,Gravitas One,Great Vibes,Griffy,Gruppo,Gudea,Gurajada,Habibi,Halant,Hammersmith One,Hanalei,Hanalei Fill,Handlee,Hanuman,Happy Monkey,Headland One,Henny Penny,Herr Von Muellerhoff,Hind,Hind Siliguri,Hind Vadodara,Holtwood One SC,Homemade Apple,Homenaje,IM Fell DW Pica,IM Fell DW Pica SC,IM Fell Double Pica,IM Fell Double Pica SC,IM Fell English,IM Fell English SC,IM Fell French Canon,IM Fell French Canon SC,IM Fell Great Primer,IM Fell Great Primer SC,Iceberg,Iceland,Imprima,Inconsolata,Inder,Indie Flower,Inika,Inknut Antiqua,Irish Grover,Istok Web,Italiana,Italianno,Itim,Jacques Francois,Jacques Francois Shadow,Jaldi,Jim Nightshade,Jockey One,Jolly Lodger,Josefin Sans,Josefin Slab,Joti One,Judson,Julee,Julius Sans One,Junge,Jura,Just Another Hand,Just Me Again Down Here,Kadwa,Kalam,Kameron,Kantumruy,Karla,Karma,Kaushan Script,Kavoon,Kdam Thmor,Keania One,Kelly Slab,Kenia,Khand,Khmer,Khula,Kite One,Knewave,Kotta One,Koulen,Kranky,Kreon,Kristi,Krona One,Kurale,La Belle Aurore,Laila,Lakki Reddy,Lancelot,Lateef,Lato,League Script,Leckerli One,Ledger,Lekton,Lemon,Libre Baskerville,Life Savers,Lilita One,Lily Script One,Limelight,Linden Hill,Lobster,Lobster Two,Londrina Outline,Londrina Shadow,Londrina Sketch,Londrina Solid,Lora,Love Ya Like A Sister,Loved by the King,Lovers Quarrel,Luckiest Guy,Lusitana,Lustria,Macondo,Macondo Swash Caps,Magra,Maiden Orange,Mako,Mallanna,Mandali,Marcellus,Marcellus SC,Marck Script,Margarine,Marko One,Marmelad,Martel,Martel Sans,Marvel,Mate,Mate SC,Maven Pro,McLaren,Meddon,MedievalSharp,Medula One,Megrim,Meie Script,Merienda,Merienda One,Merriweather,Merriweather Sans,Metal,Metal Mania,Metamorphous,Metrophobic,Michroma,Milonga,Miltonian,Miltonian Tattoo,Miniver,Miss Fajardose,Modak,Modern Antiqua,Molengo,Molle,Monda,Monofett,Monoton,Monsieur La Doulaise,Montaga,Montez,Montserrat,Montserrat Alternates,Montserrat Subrayada,Moul,Moulpali,Mountains of Christmas,Mouse Memoirs,Mr Bedfort,Mr Dafoe,Mr De Haviland,Mrs Saint Delafield,Mrs Sheppards,Muli,Mystery Quest,NTR,Neucha,Neuton,New Rocker,News Cycle,Niconne,Nixie One,Nobile,Nokora,Norican,Nosifer,Nothing You Could Do,Noticia Text,Noto Sans,Noto Serif,Nova Cut,Nova Flat,Nova Mono,Nova Oval,Nova Round,Nova Script,Nova Slim,Nova Square,Numans,Nunito,Odor Mean Chey,Offside,Old Standard TT,Oldenburg,Oleo Script,Oleo Script Swash Caps,Open Sans,Open Sans Condensed,Oranienbaum,Orbitron,Oregano,Orienta,Original Surfer,Oswald,Over the Rainbow,Overlock,Overlock SC,Ovo,Oxygen,Oxygen Mono,PT Mono,PT Sans,PT Sans Caption,PT Sans Narrow,PT Serif,PT Serif Caption,Pacifico,Palanquin,Palanquin Dark,Paprika,Parisienne,Passero One,Passion One,Pathway Gothic One,Patrick Hand,Patrick Hand SC,Patua One,Paytone One,Peddana,Peralta,Permanent Marker,Petit Formal Script,Petrona,Philosopher,Piedra,Pinyon Script,Pirata One,Plaster,Play,Playball,Playfair Display,Playfair Display SC,Podkova,Poiret One,Poller One,Poly,Pompiere,Pontano Sans,Poppins,Port Lligat Sans,Port Lligat Slab,Pragati Narrow,Prata,Preahvihear,Press Start 2P,Princess Sofia,Prociono,Prosto One,Puritan,Purple Purse,Quando,Quantico,Quattrocento,Quattrocento Sans,Questrial,Quicksand,Quintessential,Qwigley,Racing Sans One,Radley,Rajdhani,Raleway,Raleway Dots,Ramabhadra,Ramaraja,Rambla,Rammetto One,Ranchers,Rancho,Ranga,Rationale,Ravi Prakash,Redressed,Reenie Beanie,Revalia,Rhodium Libre,Ribeye,Ribeye Marrow,Righteous,Risque,Roboto,Roboto Condensed,Roboto Mono,Roboto Slab,Rochester,Rock Salt,Rokkitt,Romanesco,Ropa Sans,Rosario,Rosarivo,Rouge Script,Rozha One,Rubik,Rubik Mono One,Rubik One,Ruda,Rufina,Ruge Boogie,Ruluko,Rum Raisin,Ruslan Display,Russo One,Ruthie,Rye,Sacramento,Sahitya,Sail,Salsa,Sanchez,Sancreek,Sansita One,Sarala,Sarina,Sarpanch,Satisfy,Scada,Scheherazade,Schoolbell,Seaweed Script,Sevillana,Seymour One,Shadows Into Light,Shadows Into Light Two,Shanti,Share,Share Tech,Share Tech Mono,Shojumaru,Short Stack,Siemreap,Sigmar One,Signika,Signika Negative,Simonetta,Sintony,Sirin Stencil,Six Caps,Skranji,Slabo 13px,Slabo 27px,Slackey,Smokum,Smythe,Sniglet,Snippet,Snowburst One,Sofadi One,Sofia,Sonsie One,Sorts Mill Goudy,Source Code Pro,Source Sans Pro,Source Serif Pro,Special Elite,Spicy Rice,Spinnaker,Spirax,Squada One,Sree Krushnadevaraya,Stalemate,Stalinist One,Stardos Stencil,Stint Ultra Condensed,Stint Ultra Expanded,Stoke,Strait,Sue Ellen Francisco,Sumana,Sunshiney,Supermercado One,Sura,Suranna,Suravaram,Suwannaphum,Swanky and Moo Moo,Syncopate,Tangerine,Taprom,Tauri,Teko,Telex,Tenali Ramakrishna,Tenor Sans,Text Me One,The Girl Next Door,Tienne,Tillana,Timmana,Tinos,Titan One,Titillium Web,Trade Winds,Trocchi,Trochut,Trykker,Tulpen One,Ubuntu,Ubuntu Condensed,Ubuntu Mono,Ultra,Uncial Antiqua,Underdog,Unica One,UnifrakturCook,UnifrakturMaguntia,Unkempt,Unlock,Unna,VT323,Vampiro One,Varela,Varela Round,Vast Shadow,Vesper Libre,Vibur,Vidaloka,Viga,Voces,Volkhov,Vollkorn,Voltaire,Waiting for the Sunrise,Wallpoet,Walter Turncoat,Warnes,Wellfleet,Wendy One,Wire One,Work Sans,Yanone Kaffeesatz,Yantramanav,Yellowtail,Yeseva One,Yesteryear,Zeyada]