// Customizable Stencils v 1.1
// http://www.thingiverse.com/thing:1488794
// Hacked by
// by infinigrove Squirrel Master 2016 (http://www.thingiverse.com/infinigrove)
//
// v1.0 Initial release
// v1.1 Fix issue with customizer and numbers
//      Moved Stencil friendly fonts to the top for customizer

Stencil_Text = "MC";

Stencil_Font="Stardos Stencil"; //[Allerta Stencil,Black Ops One,Sirin Stencil,Stardos Stencil,Wallpoet,Abril Fatface,Aclonica,Acme,Advent Pro,Akronim,Aladin,Alegreya,Alegreya Sans,Alegreya SC,Alex Brush,Alfa Slab One,Alice,Amaranth,Architects Daughter,Archivo Black,Archivo Narrow,Arimo,Arvo,Asap,Astloch,Asul,Averia Libre,Averia Serif Libre,Bangers,Basic,Belgrano,Berkshire Swash,Bigshot One,Bilbo Swash Caps,Bonbon,Bowlby One SC,Brawler,Bubblegum Sans,Butterfly Kids,Cabin Condensed,Caesar Dressing,Cagliostro,Calligraffitti,Capriola,Carter One,Changa One,Chango,Chelsea Market,Cherry Cream Soda,Chewy,Chicle,Chivo,Clicker Script,Coming Soon,Concert One,Condiment,Cookie,Courgette,Covered By Your Grace,Crimson Text,Dancing Script,DejaVu Sans,DejaVu Serif,Dhurjati,Doppio One,Dosis,Droid Sans,Eagle Lake,Electrolize,Emilys Candy,Encode Sans,Encode Sans Compressed,Euphoria Script,Exo,Exo 2,Faster One,Federo,Finger Paint,Fjord One,Fontdiner Swanky,Freckle Face,Fruktur,Gabriela,Geo,Germania One,Give You Glory,Gloria Hallelujah,Goudy Bookletter 1911,Graduate,Grand Hotel,Great Vibes,Griffy,Hanalei Fill,Happy Monkey,Henny Penny,Hind,IM Fell English SC,Indie Flower,Irish Grover,Italianno,Jacques Francois Shadow,Jolly Lodger,Josefin Slab,Joti One,Judson,Just Another Hand,Kalam,Kameron,Karma,Kavoon,Knewave,Kranky,Kristi,Laila,Lakki Reddy,Lancelot,Lato,Leckerli One,Ledger,Lekton,Lemon One,Liberation Sans,Libre Caslon Text,Life Savers,Lilita One,Lily Script One,Limelight,Lobster,Lobster Two,Londrina Outline,Londrina Shadow,Londrina Solid,Lora,Love Ya Like A Sister,Loved by the King,Lovers Quarrel,Luckiest Guy,Lusitana,Macondo,Macondo Swash Caps,Mako,Marck Script,Margarine,Marko One,Maven Pro,McLaren,MedievalSharp,Merienda One,Merriweather,Mervale Script,Metal Mania,Metrophobic,Milonga,Miltonian Tattoo,Miss Fajardose,Molle,Montez,Montserrat,Mr De Haviland,Mystery Quest,Neucha,New Rocker,Niconne,Nosifer,Nothing You Could Do,Noto Sans Oriya,Noto Serif,Nova Square,Nunito,Old Standard TT,Oleo Script,Oleo Script Swash Caps,Orbitron,Oregano,Orienta,Original Surfer,Oswald,Over the Rainbow,Overlock,Oxygen,Pacifico,Paprika,Parisienne,Patrick Hand SC,Paytone One,Peralta,Permanent Marker,Piedra,Pirata One,Play,Playball,Poetsen One,Poppins,Press Start 2P,Princess Sofia,PT Mono,Qwigley,Racing Sans One,Raleway,Rancho,Ranga,Ribeye,Roboto,Roboto Condensed,Roboto Slab,Rochester,Rock Salt,Rubik One,Sail,Salsa,Sansita One,Sarina,Satisfy,Schoolbell,Seaweed Script,Sevillana,Shadows Into Light,Shadows Into Light Two,Share,Six Caps,Skranji,Source Sans Pro,Spicy Rice,Stoke,Syncopate,Teko,Terminal Dosis,The Girl Next Door,Tillana,Timmana,Titillium Web,Ubuntu,Ultra,Underdog,UnifrakturCook,UnifrakturMaguntia,Vampiro One,Vidaloka,Viga,Voces,Volkhov,Vollkorn,Voltaire,Waiting for the Sunrise,Wellfleet,Wendy One,Yellowtail,Yesteryear,Zeyada]

Font_Style="Bold"; //[Regular, Bold, Italic]

//Height of characters [mm]
Font_Size=80;  //[5:200]

Letter_Spacing = 1; //[-1:0.5:5]

Boarder_Top=10;  //[0:90]

Boarder_Bottom=10;  //[0:90]

Boarder_Left=10;  //[0:90]

Boarder_Right=15;  //[-150:150]

Stencil_Depth=.6;  //[.2:0.2:3]

Stencil_Detail=100;  //[5:200]

/* [Hidden] */

letterspacingtext = 1.0+Letter_Spacing/10;

StencilWidth=((Font_Size)*(len(str(Stencil_Text)))+Boarder_Left+Boarder_Right);

StencilHeight=Font_Size+Letter_Spacing+Boarder_Top+Boarder_Bottom;

fontstylestencil = str(Stencil_Font,":",Font_Style);

difference (){
    // create stencil plate
    color("yellow")cube([StencilWidth,StencilHeight,Stencil_Depth]); 
    
    // Remove Characters
    translate([Letter_Spacing+Boarder_Left,Font_Size+Letter_Spacing+Boarder_Bottom,-.5]){
    color("red")linear_extrude(Stencil_Depth+1,$fn=Stencil_Detail) text(str(Stencil_Text), Font_Size, font = fontstylestencil, valign = "top", halign = "left", spacing = letterspacingtext);
}
}