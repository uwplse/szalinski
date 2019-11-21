//Personalized and Parameterized Gift Tags
//By Brad Wagner (c) 2012
//Creative Commons License, yada yada.

//I made these for my new printer for Christmas giving/showing off. Damn I'm good. :P

//Print these with a 2 solid layers top and bottom and one perimeter for best results.

/*[Text]*/
tag_name="Ruby";

tag_width = 55; //[25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,105,110,115,120,125,130,135,140,145,150,155,160,165,170]

tag_height = 30; //[5,10,15,20,25,30,35,40,45,50]

text_centering_height = 10; 

text_centering_left_to_right = 15; 

What_font="Yesteryear"; //[Abril Fatface,Aclonica,Acme,Advent Pro,Akronim,Aladin,Alegreya,Alegreya Sans,Alegreya SC,Alex Brush,Alfa Slab One,Alice,Amaranth,Architects Daughter,Archivo Black,Archivo Narrow,Arimo,Arvo,Asap,Astloch,Asul,Averia Libre,Averia Serif Libre,Bangers,Basic,Belgrano,Berkshire Swash,Bigshot One,Bilbo Swash Caps,Black Ops One,Bonbon,Bowlby One SC,Brawler,Bubblegum Sans,Butterfly Kids,Cabin Condensed,Caesar Dressing,Cagliostro,Calligraffitti,Capriola,Carter One,Changa One,Chango,Chelsea Market,Cherry Cream Soda,Chewy,Chicle,Chivo,Clicker Script,Coming Soon,Concert One,Condiment,Cookie,Courgette,Covered By Your Grace,Crimson Text,Dancing Script,DejaVu Sans,DejaVu Serif,Dhurjati,Doppio One,Dosis,Droid Sans,Eagle Lake,Electrolize,Emilys Candy,Encode Sans,Encode Sans Compressed,Euphoria Script,Exo,Exo 2,Faster One,Federo,Finger Paint,Fjord One,Fontdiner Swanky,Freckle Face,Fruktur,Gabriela,Geo,Germania One,Give You Glory,Gloria Hallelujah,Goudy Bookletter 1911,Graduate,Grand Hotel,Great Vibes,Griffy,Hanalei Fill,Happy Monkey,Henny Penny,Hind,IM Fell English SC,Indie Flower,Irish Grover,Italianno,Jacques Francois Shadow,Jolly Lodger,Josefin Slab,Joti One,Judson,Just Another Hand,Kalam,Kameron,Karma,Kavoon,Knewave,Kranky,Kristi,Laila,Lakki Reddy,Lancelot,Lato,Leckerli One,Ledger,Lekton,Lemon One,Liberation Sans,Libre Caslon Text,Life Savers,Lilita One,Lily Script One,Limelight,Lobster,Lobster Two,Londrina Outline,Londrina Shadow,Londrina Solid,Lora,Love Ya Like A Sister,Loved by the King,Lovers Quarrel,Luckiest Guy,Lusitana,Macondo,Macondo Swash Caps,Mako,Marck Script,Margarine,Marko One,Maven Pro,McLaren,MedievalSharp,Merienda One,Merriweather,Mervale Script,Metal Mania,Metrophobic,Milonga,Miltonian Tattoo,Miss Fajardose,Molle,Montez,Montserrat,Mr De Haviland,Mystery Quest,Neucha,New Rocker,Niconne,Nosifer,Nothing You Could Do,Noto Sans Oriya,Noto Serif,Nova Square,Nunito,Old Standard TT,Oleo Script,Oleo Script Swash Caps,Orbitron,Oregano,Orienta,Original Surfer,Oswald,Over the Rainbow,Overlock,Oxygen,Pacifico,Paprika,Parisienne,Patrick Hand SC,Paytone One,Peralta,Permanent Marker,Piedra,Pirata One,Play,Playball,Poetsen One,Poppins,Press Start 2P,Princess Sofia,PT Mono,Qwigley,Racing Sans One,Raleway,Rancho,Ranga,Ribeye,Roboto,Roboto Condensed,Roboto Slab,Rochester,Rock Salt,Rubik One,Sail,Salsa,Sansita One,Sarina,Satisfy,Schoolbell,Seaweed Script,Sevillana,Shadows Into Light,Shadows Into Light Two,Share,Six Caps,Skranji,Source Sans Pro,Spicy Rice,Stardos Stencil,Stoke,Syncopate,Teko,Terminal Dosis,The Girl Next Door,Tillana,Timmana,Titillium Web,Ubuntu,Ultra,Underdog,UnifrakturCook,UnifrakturMaguntia,Vampiro One,Vidaloka,Viga,Voces,Volkhov,Vollkorn,Voltaire,Waiting for the Sunrise,Wallpoet,Wellfleet,Wendy One,Yellowtail,Yesteryear,Zeyada]

font_size = 12; //[5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]

// Hidden parameter
module stopCustomizer(){}

depth = 2;
letter_height = .75;
$fn=30;

//Let x be the length of one of three tag sides
x = (tag_height*sqrt(2)) / (2 + sqrt(2));

module tagName()
{
    linear_extrude(height = 3)
    text(tag_name, size = font_size, font = What_font);
}

difference() {
	tag(tag_width, tag_height, depth + letter_height);
	translate([2,2,depth]) tag(tag_width-4, tag_height-4, depth);
	translate([x/2, tag_height/2, 0]) cylinder(depth+letter_height, x/6, x/6);
}

difference() {
	translate([x/2, tag_height/2, 0]) cylinder(depth+letter_height, x/6+1, x/6+1);
#	translate([x/2, tag_height/2, 0]) cylinder(depth+letter_height, x/6, x/6);
}

module tag(w, h, d) {

	p_x = (h*sqrt(2)) / (2 + sqrt(2));

	difference() {
		cube([w, h, d]);

		translate([-p_x/2, h/2, 0]) rotate([0,0,45]) cube([50,50,d]);
		translate([-p_x/2, h/2, 0]) rotate([0,0,225]) cube([50,50,d]);
	}

}
translate([text_centering_left_to_right, text_centering_height,0]) tagName();