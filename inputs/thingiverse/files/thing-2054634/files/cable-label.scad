//Thanks to wstein and his customizable multiline tag and keychain
//https://www.thingiverse.com/thing:739573
// from where I got the list of fonts


// preview[view:south, tilt:top]

/* [Shape] */
//should be a bit bigger than the actual diameter of your cable (maybe by 1mm)
cable_diameter=6.5;

//the bit between the hooks
main_body_length=15;//[3:150]

//the minimum value for this is twice the cable diameter
main_body_width=13;//[3:150]
//of the body and hooks. This needs to bend around the cable so better to keep this relatively thin (I use 1mm).
thickness=1;//[0.4:0.1:2.5]


/* [Text] */
text="A";
text_thickness=2;
text_size=10;
text_font="Acme"; //[Abril Fatface,Aclonica,Acme,Advent Pro,Akronim,Aladin,Alegreya,Alegreya Sans,Alegreya SC,Alex Brush,Alfa Slab One,Alice,Amaranth,Architects Daughter,Archivo Black,Archivo Narrow,Arimo,Arvo,Asap,Astloch,Asul,Averia Libre,Averia Serif Libre,Bangers,Basic,Belgrano,Berkshire Swash,Bigshot One,Bilbo Swash Caps,Black Ops One,Bonbon,Bowlby One SC,Brawler,Bubblegum Sans,Butterfly Kids,Cabin Condensed,Caesar Dressing,Cagliostro,Calligraffitti,Capriola,Carter One,Changa One,Chango,Chelsea Market,Cherry Cream Soda,Chewy,Chicle,Chivo,Clicker Script,Coming Soon,Concert One,Condiment,Cookie,Courgette,Covered By Your Grace,Crimson Text,Dancing Script,DejaVu Sans,DejaVu Serif,Dhurjati,Doppio One,Dosis,Droid Sans,Eagle Lake,Electrolize,Emilys Candy,Encode Sans,Encode Sans Compressed,Euphoria Script,Exo,Exo 2,Faster One,Federo,Finger Paint,Fjord One,Fontdiner Swanky,Freckle Face,Fruktur,Gabriela,Geo,Germania One,Give You Glory,Gloria Hallelujah,Goudy Bookletter 1911,Graduate,Grand Hotel,Great Vibes,Griffy,Hanalei Fill,Happy Monkey,Henny Penny,Hind,IM Fell English SC,Indie Flower,Irish Grover,Italianno,Jacques Francois Shadow,Jolly Lodger,Josefin Slab,Joti One,Judson,Just Another Hand,Kalam,Kameron,Karma,Kavoon,Knewave,Kranky,Kristi,Laila,Lakki Reddy,Lancelot,Lato,Leckerli One,Ledger,Lekton,Lemon One,Liberation Sans,Libre Caslon Text,Life Savers,Lilita One,Lily Script One,Limelight,Lobster,Lobster Two,Londrina Outline,Londrina Shadow,Londrina Solid,Lora,Love Ya Like A Sister,Loved by the King,Lovers Quarrel,Luckiest Guy,Lusitana,Macondo,Macondo Swash Caps,Mako,Marck Script,Margarine,Marko One,Maven Pro,McLaren,MedievalSharp,Merienda One,Merriweather,Mervale Script,Metal Mania,Metrophobic,Milonga,Miltonian Tattoo,Miss Fajardose,Molle,Montez,Montserrat,Mr De Haviland,Mystery Quest,Neucha,New Rocker,Niconne,Nosifer,Nothing You Could Do,Noto Sans Oriya,Noto Serif,Nova Square,Nunito,Old Standard TT,Oleo Script,Oleo Script Swash Caps,Orbitron,Oregano,Orienta,Original Surfer,Oswald,Over the Rainbow,Overlock,Oxygen,Pacifico,Paprika,Parisienne,Patrick Hand SC,Paytone One,Peralta,Permanent Marker,Piedra,Pirata One,Play,Playball,Poetsen One,Poppins,Press Start 2P,Princess Sofia,PT Mono,Qwigley,Racing Sans One,Raleway,Rancho,Ranga,Ribeye,Roboto,Roboto Condensed,Roboto Slab,Rochester,Rock Salt,Rubik One,Sail,Salsa,Sansita One,Sarina,Satisfy,Schoolbell,Seaweed Script,Sevillana,Shadows Into Light,Shadows Into Light Two,Share,Six Caps,Skranji,Source Sans Pro,Spicy Rice,Stardos Stencil,Stoke,Syncopate,Teko,Terminal Dosis,The Girl Next Door,Tillana,Timmana,Titillium Web,Ubuntu,Ultra,Underdog,UnifrakturCook,UnifrakturMaguntia,Vampiro One,Vidaloka,Viga,Voces,Volkhov,Vollkorn,Voltaire,Waiting for the Sunrise,Wallpoet,Wellfleet,Wendy One,Yellowtail,Yesteryear,Zeyada]

rotate_text="perpendicular";//[perpendicular,parallel]

/* [Hidden] */
$fn=100;
main_body_width_use=max([cable_diameter*2,main_body_width]);
//main body

union()
{
    cube([main_body_width_use,main_body_length,thickness],center=true);
     
    //hook 1
    translate([0,main_body_length/2, 0,])
        hook(cable_diameter,thickness);
    //hook 2
        rotate(180)
            translate([0,main_body_length/2, 0,]) 
                hook(cable_diameter,thickness);
 
    if(rotate_text=="parallel")
    {    linear_extrude(height= text_thickness) 
            rotate(270)
                translate([0,0,thickness/2]) 
                    text(str(text), font = text_font, size = text_size, halign = "center",valign = "center");
    }
    else
    {    linear_extrude(height= text_thickness) 
               translate([0,0,thickness/2]) 
                    text(str(text), font = text_font, size = text_size, halign = "center",valign = "center");
    }

}
module slot(diameter, thickness){

    union()
    {   cylinder(thickness, d=diameter, center=true);
        translate([0,-diameter,0])
            cylinder(thickness, d=diameter, center=true);
        translate([0,-diameter/2,0]) 
            cube ([diameter,diameter,thickness],center=true);
        translate ([-diameter,-diameter*11/8,0])  
            cube ([diameter*2,diameter/4,thickness],center=true);
        translate([-diameter/4,-diameter,0])
            cube([diameter/2,diameter,thickness],center=true);
    }
      
}
module hook(diameter,thickness)
{
     difference(){
       union()
        {
           translate([0,diameter*3/4,0]) 
                cube([diameter*2,diameter*3/2,thickness],center=true);
           translate([0,diameter*3/2,0]) 
                cylinder(thickness, d=diameter*2, center=true);
        }
        translate([0,diameter*3/2,0]) slot(diameter, thickness*2);
    }
        
}
