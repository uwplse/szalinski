// Customizable Motorcycle License Plate Cover/Frame
// Thanks to wstein for the font list

top_text = "Only";
bot_text = "You";
font = "Liberation Sans";  //[Abril Fatface,Aclonica,Acme,Advent Pro,Akronim,Aladin,Alegreya,Alegreya Sans,Alegreya SC,Alex Brush,Alfa Slab One,Alice,Amaranth,Architects Daughter,Archivo Black,Archivo Narrow,Arimo,Arvo,Asap,Astloch,Asul,Averia Libre,Averia Serif Libre,Bangers,Basic,Belgrano,Berkshire Swash,Bigshot One,Bilbo Swash Caps,Black Ops One,Bonbon,Bowlby One SC,Brawler,Bubblegum Sans,Butterfly Kids,Cabin Condensed,Caesar Dressing,Cagliostro,Calligraffitti,Capriola,Carter One,Changa One,Chango,Chelsea Market,Cherry Cream Soda,Chewy,Chicle,Chivo,Clicker Script,Coming Soon,Concert One,Condiment,Cookie,Courgette,Covered By Your Grace,Crimson Text,Dancing Script,DejaVu Sans,DejaVu Serif,Dhurjati,Doppio One,Dosis,Droid Sans,Eagle Lake,Electrolize,Emilys Candy,Encode Sans,Encode Sans Compressed,Euphoria Script,Exo,Exo 2,Faster One,Federo,Finger Paint,Fjord One,Fontdiner Swanky,Freckle Face,Fruktur,Gabriela,Geo,Germania One,Give You Glory,Gloria Hallelujah,Goudy Bookletter 1911,Graduate,Grand Hotel,Great Vibes,Griffy,Hanalei Fill,Happy Monkey,Henny Penny,Hind,IM Fell English SC,Indie Flower,Irish Grover,Italianno,Jacques Francois Shadow,Jolly Lodger,Josefin Slab,Joti One,Judson,Just Another Hand,Kalam,Kameron,Karma,Kavoon,Knewave,Kranky,Kristi,Laila,Lakki Reddy,Lancelot,Lato,Leckerli One,Ledger,Lekton,Lemon One,Liberation Sans,Libre Caslon Text,Life Savers,Lilita One,Lily Script One,Limelight,Lobster,Lobster Two,Londrina Outline,Londrina Shadow,Londrina Solid,Lora,Love Ya Like A Sister,Loved by the King,Lovers Quarrel,Luckiest Guy,Lusitana,Macondo,Macondo Swash Caps,Mako,Marck Script,Margarine,Marko One,Maven Pro,McLaren,MedievalSharp,Merienda One,Merriweather,Mervale Script,Metal Mania,Metrophobic,Milonga,Miltonian Tattoo,Miss Fajardose,Molle,Montez,Montserrat,Mr De Haviland,Mystery Quest,Neucha,New Rocker,Niconne,Nosifer,Nothing You Could Do,Noto Sans Oriya,Noto Serif,Nova Square,Nunito,Old Standard TT,Oleo Script,Oleo Script Swash Caps,Orbitron,Oregano,Orienta,Original Surfer,Oswald,Over the Rainbow,Overlock,Oxygen,Pacifico,Paprika,Parisienne,Patrick Hand SC,Paytone One,Peralta,Permanent Marker,Piedra,Pirata One,Play,Playball,Poetsen One,Poppins,Press Start 2P,Princess Sofia,PT Mono,Qwigley,Racing Sans One,Raleway,Rancho,Ranga,Ribeye,Roboto,Roboto Condensed,Roboto Slab,Rochester,Rock Salt,Rubik One,Sail,Salsa,Sansita One,Sarina,Satisfy,Schoolbell,Seaweed Script,Sevillana,Shadows Into Light,Shadows Into Light Two,Share,Six Caps,Skranji,Source Sans Pro,Spicy Rice,Stardos Stencil,Stoke,Syncopate,Teko,Terminal Dosis,The Girl Next Door,Tillana,Timmana,Titillium Web,Ubuntu,Ultra,Underdog,UnifrakturCook,UnifrakturMaguntia,Vampiro One,Vidaloka,Viga,Voces,Volkhov,Vollkorn,Voltaire,Waiting for the Sunrise,Wallpoet,Wellfleet,Wendy One,Yellowtail,Yesteryear,Zeyada]
font_size = 20;
text_offset = 5;

heart_height = 15;


translate([0,0,heart_height/2]) 
{
    difference() { 
        union() 
        {
            // middle
            cube([150,30,heart_height],true);
  
            // top
            translate([-40,20,0]) cube([70,10,heart_height],true);
            translate([40,20,0]) cube([70,10,heart_height],true);
            translate([-40,30,0]) cube([50,10,heart_height],true);
            translate([40,30,0]) cube([50,10,heart_height],true);
            translate([-40,40,0]) cube([30,10,heart_height],true);
            translate([40,40,0]) cube([30,10,heart_height],true);

            // bottom  
            translate([0,-20,0]) cube([130,10,heart_height],true);
            translate([0,-30,0]) cube([110,10,heart_height],true);
            translate([0,-40,0]) cube([90,10,heart_height],true);
            translate([0,-50,0]) cube([70,10,heart_height],true);
            translate([0,-60,0]) cube([50,10,heart_height],true);
            translate([0,-70,0]) cube([30,10,heart_height],true);
            translate([0,-80,0]) cube([10,10,heart_height],true); 
        }
        translate([0,-text_offset,0]) {
            translate([0,0,heart_height/2]) linear_extrude(height = heart_height, center = true) text(top_text, halign = "center", valign = "center", size = font_size, font = font);
            translate([0,-15 - (font_size/2),heart_height/2]) linear_extrude(height = heart_height, center = true) text(bot_text, halign = "center", valign = "center", size = font_size, font = font);
        }
    }
}