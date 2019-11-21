lettering = "Basil";
// font
style = "Pacifico"; //[Abril Fatface,Aclonica,Acme,Advent Pro,Akronim,Aladin,Alegreya,Alegreya Sans,Alegreya SC,Alex Brush,Alfa Slab One,Alice,Amaranth,Architects Daughter,Archivo Black,Archivo Narrow,Arimo,Arvo,Asap,Astloch,Asul,Averia Libre,Averia Serif Libre,Bangers,Basic,Belgrano,Berkshire Swash,Bigshot One,Bilbo Swash Caps,Black Ops One,Bonbon,Bowlby One SC,Brawler,Bubblegum Sans,Butterfly Kids,Cabin Condensed,Caesar Dressing,Cagliostro,Calligraffitti,Capriola,Carter One,Changa One,Chango,Chelsea Market,Cherry Cream Soda,Chewy,Chicle,Chivo,Clicker Script,Coming Soon,Concert One,Condiment,Cookie,Courgette,Covered By Your Grace,Crimson Text,Dancing Script,DejaVu Sans,DejaVu Serif,Dhurjati,Doppio One,Dosis,Droid Sans,Eagle Lake,Electrolize,Emilys Candy,Encode Sans,Encode Sans Compressed,Euphoria Script,Exo,Exo 2,Faster One,Federo,Finger Paint,Fjord One,Fontdiner Swanky,Freckle Face,Fruktur,Gabriela,Geo,Germania One,Give You Glory,Gloria Hallelujah,Goudy Bookletter 1911,Graduate,Grand Hotel,Great Vibes,Griffy,Hanalei Fill,Happy Monkey,Henny Penny,Hind,IM Fell English SC,Indie Flower,Irish Grover,Italianno,Jacques Francois Shadow,Jolly Lodger,Josefin Slab,Joti One,Judson,Just Another Hand,Kalam,Kameron,Karma,Kavoon,Knewave,Kranky,Kristi,Laila,Lakki Reddy,Lancelot,Lato,Leckerli One,Ledger,Lekton,Lemon One,Liberation Sans,Libre Caslon Text,Life Savers,Lilita One,Lily Script One,Limelight,Lobster,Lobster Two,Londrina Outline,Londrina Shadow,Londrina Solid,Lora,Love Ya Like A Sister,Loved by the King,Lovers Quarrel,Luckiest Guy,Lusitana,Macondo,Macondo Swash Caps,Mako,Marck Script,Margarine,Marko One,Maven Pro,McLaren,MedievalSharp,Merienda One,Merriweather,Mervale Script,Metal Mania,Metrophobic,Milonga,Miltonian Tattoo,Miss Fajardose,Molle,Montez,Montserrat,Mr De Haviland,Mystery Quest,Neucha,New Rocker,Niconne,Nosifer,Nothing You Could Do,Noto Sans Oriya,Noto Serif,Nova Square,Nunito,Old Standard TT,Oleo Script,Oleo Script Swash Caps,Orbitron,Oregano,Orienta,Original Surfer,Oswald,Over the Rainbow,Overlock,Oxygen,Pacifico,Paprika,Parisienne,Patrick Hand SC,Paytone One,Peralta,Permanent Marker,Piedra,Pirata One,Play,Playball,Poetsen One,Poppins,Press Start 2P,Princess Sofia,PT Mono,Qwigley,Racing Sans One,Raleway,Rancho,Ranga,Ribeye,Roboto,Roboto Condensed,Roboto Slab,Rochester,Rock Salt,Rubik One,Sail,Salsa,Sansita One,Sarina,Satisfy,Schoolbell,Seaweed Script,Sevillana,Shadows Into Light,Shadows Into Light Two,Share,Six Caps,Skranji,Source Sans Pro,Spicy Rice,Stardos Stencil,Stoke,Syncopate,Teko,Terminal Dosis,The Girl Next Door,Tillana,Timmana,Titillium Web,Ubuntu,Ultra,Underdog,UnifrakturCook,UnifrakturMaguntia,Vampiro One,Vidaloka,Viga,Voces,Volkhov,Vollkorn,Voltaire,Waiting for the Sunrise,Wallpoet,Wellfleet,Wendy One,Yellowtail,Yesteryear,Zeyada]
labelStyle = "Indent"; //[Cutout,OnTop,Indent]
oneOrTwoSticks = "One"; //[One, Two]

textSpacing = 1; //[1:10]
textSize = 12; //[1:30]
textNudgeX = -10; //[-100:100]
textNudgeY = -2; //[-100:100]
textHeight = 2; //[1:10]



labelWidth = 44; //[1:200]
labelHeight = 20; //[1:50]
labelDepth = 2; //[1:10]
//only used for indent style; no sense to make this more than Label Depth; value =
indentDepth = 1;
// good idea to make this a multiple of nozzle size
indentEdgeWidth = 1.05;
stickWidth = 10; //[1:50]
stickLength = 50; //[1:200]


module label1() {
    difference() {
        cube ([labelWidth, labelHeight, labelDepth], center=true);
        translate([textNudgeX/10,textNudgeY/10,-(labelDepth+1)/2])
        linear_extrude(height=textHeight)
        text (lettering,  size=textSize, font = style, halign = "center", valign = "center", spacing = textSpacing);
    };
}

module label2() {
        cube ([labelWidth, labelHeight, labelDepth], center=true);
        translate([textNudgeX/10,textNudgeY/10,(labelDepth)/2])
        linear_extrude(height=textHeight)
        text (lettering,  size=textSize, font = style, halign = "center", valign = "center", spacing = textSpacing);
}

module label3() {
    difference() {
        cube ([labelWidth, labelHeight, labelDepth], center=true);
        translate([0,0,2*labelDepth/2+labelDepth/2-indentDepth])
        cube ([labelWidth-indentEdgeWidth, labelHeight-indentEdgeWidth, 2*labelDepth], center=true);
    }
        translate([textNudgeX/10,textNudgeY/10,(labelDepth)/2-indentDepth])
        linear_extrude(height=textHeight)
        text (lettering,  size=textSize, font = style, halign = "center", valign = "center", spacing = textSpacing);
}

module stick() {
    translate([0,-stickLength/2-labelHeight/2,0])
    difference() {
        cube([stickWidth,stickLength,labelDepth],center=true);
        translate([stickWidth/2,-stickLength/2,0])
        rotate([0,0,45])
        cube([stickWidth,stickWidth,labelDepth+1],center=true);
        translate([-stickWidth/2,-stickLength/2,0])
        rotate([0,0,45])
        cube([stickWidth,stickWidth,labelDepth+1],center=true);
    }
}

if (labelStyle == "Cutout") {
    label1();
} else if (labelStyle == "OnTop") {
    label2();
} else {
    label3();
}
    
if (oneOrTwoSticks == "One") {
    stick();
} else {
    translate([labelWidth/2-stickWidth/2,0,0])
    stick();
    translate([-(labelWidth/2-stickWidth/2),0,0])
    stick();
}