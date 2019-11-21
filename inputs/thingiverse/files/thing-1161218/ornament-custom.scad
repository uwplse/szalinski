/*
* Name: CustomOrnament.scad
* Author: Michael Kruger
* Brief:
* 
* This SCAD file can be used to generate a personalized ornament for your 
* Christmas tree and other decorations!
* 
* 5 Lines of text can be added to make this ornament your own. 
* The size, offset and font of each line can be chosen.
*
* This file can be used in the MakerBot Customizer
*
* Link on Thingiverse:  http://www.thingiverse.com/thing:1161218
* Open in Customizer: http://www.thingiverse.com/apps/customizer/run?thing_id=1161218
*
* Uses an STL file remixed from the ornament:
* http://www.thingiverse.com/thing:587628 
* Created by:
* http://www.thingiverse.com/TTB_Studios/about
*
* License: MIT License
*
* Copyright (c) 2015 Michael Kruger, Krugaroo
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
* 
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/
/*
 V1.0 First Version
*/

// preview[view:south, tilt:side]


line1_Text = "Your";
line1_Font="Rock Salt"; //[Abril Fatface,Aclonica,Acme,Advent Pro,Akronim,Aladin,Alegreya,Alegreya Sans,Alegreya SC,Alex Brush,Alfa Slab One,Alice,Amaranth,Architects Daughter,Archivo Black,Archivo Narrow,Arimo,Arvo,Asap,Astloch,Asul,Averia Libre,Averia Serif Libre,Bangers,Basic,Belgrano,Berkshire Swash,Bigshot One,Bilbo Swash Caps,Black Ops One,Bonbon,Bowlby One SC,Brawler,Bubblegum Sans,Butterfly Kids,Cabin Condensed,Caesar Dressing,Cagliostro,Calligraffitti,Capriola,Carter One,Changa One,Chango,Chelsea Market,Cherry Cream Soda,Chewy,Chicle,Chivo,Clicker Script,Coming Soon,Concert One,Condiment,Cookie,Courgette,Covered By Your Grace,Crimson Text,Dancing Script,DejaVu Sans,DejaVu Serif,Dhurjati,Doppio One,Dosis,Droid Sans,Eagle Lake,Electrolize,Emilys Candy,Encode Sans,Encode Sans Compressed,Euphoria Script,Exo,Exo 2,Faster One,Federo,Finger Paint,Fjord One,Fontdiner Swanky,Freckle Face,Fruktur,Gabriela,Geo,Germania One,Give You Glory,Gloria Hallelujah,Goudy Bookletter 1911,Graduate,Grand Hotel,Great Vibes,Griffy,Hanalei Fill,Happy Monkey,Henny Penny,Hind,IM Fell English SC,Indie Flower,Irish Grover,Italianno,Jacques Francois Shadow,Jolly Lodger,Josefin Slab,Joti One,Judson,Just Another Hand,Kalam,Kameron,Karma,Kavoon,Knewave,Kranky,Kristi,Laila,Lakki Reddy,Lancelot,Lato,Leckerli One,Ledger,Lekton,Lemon One,Liberation Sans,Libre Caslon Text,Life Savers,Lilita One,Lily Script One,Limelight,Lobster,Lobster Two,Londrina Outline,Londrina Shadow,Londrina Solid,Lora,Love Ya Like A Sister,Loved by the King,Lovers Quarrel,Luckiest Guy,Lusitana,Macondo,Macondo Swash Caps,Mako,Marck Script,Margarine,Marko One,Maven Pro,McLaren,MedievalSharp,Merienda One,Merriweather,Mervale Script,Metal Mania,Metrophobic,Milonga,Miltonian Tattoo,Miss Fajardose,Molle,Montez,Montserrat,Mr De Haviland,Mystery Quest,Neucha,New Rocker,Niconne,Nosifer,Nothing You Could Do,Noto Sans Oriya,Noto Serif,Nova Square,Nunito,Old Standard TT,Oleo Script,Oleo Script Swash Caps,Orbitron,Oregano,Orienta,Original Surfer,Oswald,Over the Rainbow,Overlock,Oxygen,Pacifico,Paprika,Parisienne,Patrick Hand SC,Paytone One,Peralta,Permanent Marker,Piedra,Pirata One,Play,Playball,Poetsen One,Poppins,Press Start 2P,Princess Sofia,PT Mono,Qwigley,Racing Sans One,Raleway,Rancho,Ranga,Ribeye,Roboto,Roboto Condensed,Roboto Slab,Rochester,Rock Salt,Rubik One,Sail,Salsa,Sansita One,Sarina,Satisfy,Schoolbell,Seaweed Script,Sevillana,Shadows Into Light,Shadows Into Light Two,Share,Six Caps,Skranji,Source Sans Pro,Spicy Rice,Stardos Stencil,Stoke,Syncopate,Teko,Terminal Dosis,The Girl Next Door,Tillana,Timmana,Titillium Web,Ubuntu,Ultra,Underdog,UnifrakturCook,UnifrakturMaguntia,Vampiro One,Vidaloka,Viga,Voces,Volkhov,Vollkorn,Voltaire,Waiting for the Sunrise,Wallpoet,Wellfleet,Wendy One,Yellowtail,Yesteryear,Zeyada]
line1_fontSize = 5; // [2:10]
line1_verticalSpacing = 4; //[2:10]

line2_Text = "Name";
line2_Font="Rock Salt"; //[Abril Fatface,Aclonica,Acme,Advent Pro,Akronim,Aladin,Alegreya,Alegreya Sans,Alegreya SC,Alex Brush,Alfa Slab One,Alice,Amaranth,Architects Daughter,Archivo Black,Archivo Narrow,Arimo,Arvo,Asap,Astloch,Asul,Averia Libre,Averia Serif Libre,Bangers,Basic,Belgrano,Berkshire Swash,Bigshot One,Bilbo Swash Caps,Black Ops One,Bonbon,Bowlby One SC,Brawler,Bubblegum Sans,Butterfly Kids,Cabin Condensed,Caesar Dressing,Cagliostro,Calligraffitti,Capriola,Carter One,Changa One,Chango,Chelsea Market,Cherry Cream Soda,Chewy,Chicle,Chivo,Clicker Script,Coming Soon,Concert One,Condiment,Cookie,Courgette,Covered By Your Grace,Crimson Text,Dancing Script,DejaVu Sans,DejaVu Serif,Dhurjati,Doppio One,Dosis,Droid Sans,Eagle Lake,Electrolize,Emilys Candy,Encode Sans,Encode Sans Compressed,Euphoria Script,Exo,Exo 2,Faster One,Federo,Finger Paint,Fjord One,Fontdiner Swanky,Freckle Face,Fruktur,Gabriela,Geo,Germania One,Give You Glory,Gloria Hallelujah,Goudy Bookletter 1911,Graduate,Grand Hotel,Great Vibes,Griffy,Hanalei Fill,Happy Monkey,Henny Penny,Hind,IM Fell English SC,Indie Flower,Irish Grover,Italianno,Jacques Francois Shadow,Jolly Lodger,Josefin Slab,Joti One,Judson,Just Another Hand,Kalam,Kameron,Karma,Kavoon,Knewave,Kranky,Kristi,Laila,Lakki Reddy,Lancelot,Lato,Leckerli One,Ledger,Lekton,Lemon One,Liberation Sans,Libre Caslon Text,Life Savers,Lilita One,Lily Script One,Limelight,Lobster,Lobster Two,Londrina Outline,Londrina Shadow,Londrina Solid,Lora,Love Ya Like A Sister,Loved by the King,Lovers Quarrel,Luckiest Guy,Lusitana,Macondo,Macondo Swash Caps,Mako,Marck Script,Margarine,Marko One,Maven Pro,McLaren,MedievalSharp,Merienda One,Merriweather,Mervale Script,Metal Mania,Metrophobic,Milonga,Miltonian Tattoo,Miss Fajardose,Molle,Montez,Montserrat,Mr De Haviland,Mystery Quest,Neucha,New Rocker,Niconne,Nosifer,Nothing You Could Do,Noto Sans Oriya,Noto Serif,Nova Square,Nunito,Old Standard TT,Oleo Script,Oleo Script Swash Caps,Orbitron,Oregano,Orienta,Original Surfer,Oswald,Over the Rainbow,Overlock,Oxygen,Pacifico,Paprika,Parisienne,Patrick Hand SC,Paytone One,Peralta,Permanent Marker,Piedra,Pirata One,Play,Playball,Poetsen One,Poppins,Press Start 2P,Princess Sofia,PT Mono,Qwigley,Racing Sans One,Raleway,Rancho,Ranga,Ribeye,Roboto,Roboto Condensed,Roboto Slab,Rochester,Rock Salt,Rubik One,Sail,Salsa,Sansita One,Sarina,Satisfy,Schoolbell,Seaweed Script,Sevillana,Shadows Into Light,Shadows Into Light Two,Share,Six Caps,Skranji,Source Sans Pro,Spicy Rice,Stardos Stencil,Stoke,Syncopate,Teko,Terminal Dosis,The Girl Next Door,Tillana,Timmana,Titillium Web,Ubuntu,Ultra,Underdog,UnifrakturCook,UnifrakturMaguntia,Vampiro One,Vidaloka,Viga,Voces,Volkhov,Vollkorn,Voltaire,Waiting for the Sunrise,Wallpoet,Wellfleet,Wendy One,Yellowtail,Yesteryear,Zeyada]
line2_fontSize = 5; // [2:10]
line2_verticalSpacing = 7; //[2:10]

line3_Text = "Here";
line3_Font="Rock Salt"; //[Abril Fatface,Aclonica,Acme,Advent Pro,Akronim,Aladin,Alegreya,Alegreya Sans,Alegreya SC,Alex Brush,Alfa Slab One,Alice,Amaranth,Architects Daughter,Archivo Black,Archivo Narrow,Arimo,Arvo,Asap,Astloch,Asul,Averia Libre,Averia Serif Libre,Bangers,Basic,Belgrano,Berkshire Swash,Bigshot One,Bilbo Swash Caps,Black Ops One,Bonbon,Bowlby One SC,Brawler,Bubblegum Sans,Butterfly Kids,Cabin Condensed,Caesar Dressing,Cagliostro,Calligraffitti,Capriola,Carter One,Changa One,Chango,Chelsea Market,Cherry Cream Soda,Chewy,Chicle,Chivo,Clicker Script,Coming Soon,Concert One,Condiment,Cookie,Courgette,Covered By Your Grace,Crimson Text,Dancing Script,DejaVu Sans,DejaVu Serif,Dhurjati,Doppio One,Dosis,Droid Sans,Eagle Lake,Electrolize,Emilys Candy,Encode Sans,Encode Sans Compressed,Euphoria Script,Exo,Exo 2,Faster One,Federo,Finger Paint,Fjord One,Fontdiner Swanky,Freckle Face,Fruktur,Gabriela,Geo,Germania One,Give You Glory,Gloria Hallelujah,Goudy Bookletter 1911,Graduate,Grand Hotel,Great Vibes,Griffy,Hanalei Fill,Happy Monkey,Henny Penny,Hind,IM Fell English SC,Indie Flower,Irish Grover,Italianno,Jacques Francois Shadow,Jolly Lodger,Josefin Slab,Joti One,Judson,Just Another Hand,Kalam,Kameron,Karma,Kavoon,Knewave,Kranky,Kristi,Laila,Lakki Reddy,Lancelot,Lato,Leckerli One,Ledger,Lekton,Lemon One,Liberation Sans,Libre Caslon Text,Life Savers,Lilita One,Lily Script One,Limelight,Lobster,Lobster Two,Londrina Outline,Londrina Shadow,Londrina Solid,Lora,Love Ya Like A Sister,Loved by the King,Lovers Quarrel,Luckiest Guy,Lusitana,Macondo,Macondo Swash Caps,Mako,Marck Script,Margarine,Marko One,Maven Pro,McLaren,MedievalSharp,Merienda One,Merriweather,Mervale Script,Metal Mania,Metrophobic,Milonga,Miltonian Tattoo,Miss Fajardose,Molle,Montez,Montserrat,Mr De Haviland,Mystery Quest,Neucha,New Rocker,Niconne,Nosifer,Nothing You Could Do,Noto Sans Oriya,Noto Serif,Nova Square,Nunito,Old Standard TT,Oleo Script,Oleo Script Swash Caps,Orbitron,Oregano,Orienta,Original Surfer,Oswald,Over the Rainbow,Overlock,Oxygen,Pacifico,Paprika,Parisienne,Patrick Hand SC,Paytone One,Peralta,Permanent Marker,Piedra,Pirata One,Play,Playball,Poetsen One,Poppins,Press Start 2P,Princess Sofia,PT Mono,Qwigley,Racing Sans One,Raleway,Rancho,Ranga,Ribeye,Roboto,Roboto Condensed,Roboto Slab,Rochester,Rock Salt,Rubik One,Sail,Salsa,Sansita One,Sarina,Satisfy,Schoolbell,Seaweed Script,Sevillana,Shadows Into Light,Shadows Into Light Two,Share,Six Caps,Skranji,Source Sans Pro,Spicy Rice,Stardos Stencil,Stoke,Syncopate,Teko,Terminal Dosis,The Girl Next Door,Tillana,Timmana,Titillium Web,Ubuntu,Ultra,Underdog,UnifrakturCook,UnifrakturMaguntia,Vampiro One,Vidaloka,Viga,Voces,Volkhov,Vollkorn,Voltaire,Waiting for the Sunrise,Wallpoet,Wellfleet,Wendy One,Yellowtail,Yesteryear,Zeyada]
line3_fontSize = 5; // [2:10]
line3_verticalSpacing = 7; //[2:10]

line4_Text = "Happy";
line4_Font="Rock Salt"; //[Abril Fatface,Aclonica,Acme,Advent Pro,Akronim,Aladin,Alegreya,Alegreya Sans,Alegreya SC,Alex Brush,Alfa Slab One,Alice,Amaranth,Architects Daughter,Archivo Black,Archivo Narrow,Arimo,Arvo,Asap,Astloch,Asul,Averia Libre,Averia Serif Libre,Bangers,Basic,Belgrano,Berkshire Swash,Bigshot One,Bilbo Swash Caps,Black Ops One,Bonbon,Bowlby One SC,Brawler,Bubblegum Sans,Butterfly Kids,Cabin Condensed,Caesar Dressing,Cagliostro,Calligraffitti,Capriola,Carter One,Changa One,Chango,Chelsea Market,Cherry Cream Soda,Chewy,Chicle,Chivo,Clicker Script,Coming Soon,Concert One,Condiment,Cookie,Courgette,Covered By Your Grace,Crimson Text,Dancing Script,DejaVu Sans,DejaVu Serif,Dhurjati,Doppio One,Dosis,Droid Sans,Eagle Lake,Electrolize,Emilys Candy,Encode Sans,Encode Sans Compressed,Euphoria Script,Exo,Exo 2,Faster One,Federo,Finger Paint,Fjord One,Fontdiner Swanky,Freckle Face,Fruktur,Gabriela,Geo,Germania One,Give You Glory,Gloria Hallelujah,Goudy Bookletter 1911,Graduate,Grand Hotel,Great Vibes,Griffy,Hanalei Fill,Happy Monkey,Henny Penny,Hind,IM Fell English SC,Indie Flower,Irish Grover,Italianno,Jacques Francois Shadow,Jolly Lodger,Josefin Slab,Joti One,Judson,Just Another Hand,Kalam,Kameron,Karma,Kavoon,Knewave,Kranky,Kristi,Laila,Lakki Reddy,Lancelot,Lato,Leckerli One,Ledger,Lekton,Lemon One,Liberation Sans,Libre Caslon Text,Life Savers,Lilita One,Lily Script One,Limelight,Lobster,Lobster Two,Londrina Outline,Londrina Shadow,Londrina Solid,Lora,Love Ya Like A Sister,Loved by the King,Lovers Quarrel,Luckiest Guy,Lusitana,Macondo,Macondo Swash Caps,Mako,Marck Script,Margarine,Marko One,Maven Pro,McLaren,MedievalSharp,Merienda One,Merriweather,Mervale Script,Metal Mania,Metrophobic,Milonga,Miltonian Tattoo,Miss Fajardose,Molle,Montez,Montserrat,Mr De Haviland,Mystery Quest,Neucha,New Rocker,Niconne,Nosifer,Nothing You Could Do,Noto Sans Oriya,Noto Serif,Nova Square,Nunito,Old Standard TT,Oleo Script,Oleo Script Swash Caps,Orbitron,Oregano,Orienta,Original Surfer,Oswald,Over the Rainbow,Overlock,Oxygen,Pacifico,Paprika,Parisienne,Patrick Hand SC,Paytone One,Peralta,Permanent Marker,Piedra,Pirata One,Play,Playball,Poetsen One,Poppins,Press Start 2P,Princess Sofia,PT Mono,Qwigley,Racing Sans One,Raleway,Rancho,Ranga,Ribeye,Roboto,Roboto Condensed,Roboto Slab,Rochester,Rock Salt,Rubik One,Sail,Salsa,Sansita One,Sarina,Satisfy,Schoolbell,Seaweed Script,Sevillana,Shadows Into Light,Shadows Into Light Two,Share,Six Caps,Skranji,Source Sans Pro,Spicy Rice,Stardos Stencil,Stoke,Syncopate,Teko,Terminal Dosis,The Girl Next Door,Tillana,Timmana,Titillium Web,Ubuntu,Ultra,Underdog,UnifrakturCook,UnifrakturMaguntia,Vampiro One,Vidaloka,Viga,Voces,Volkhov,Vollkorn,Voltaire,Waiting for the Sunrise,Wallpoet,Wellfleet,Wendy One,Yellowtail,Yesteryear,Zeyada]
line4_fontSize = 6; // [2:10]
line4_verticalSpacing = 10; //[2:10]

line5_Text = "Holidays!";
line5_Font="Rock Salt"; //[Abril Fatface,Aclonica,Acme,Advent Pro,Akronim,Aladin,Alegreya,Alegreya Sans,Alegreya SC,Alex Brush,Alfa Slab One,Alice,Amaranth,Architects Daughter,Archivo Black,Archivo Narrow,Arimo,Arvo,Asap,Astloch,Asul,Averia Libre,Averia Serif Libre,Bangers,Basic,Belgrano,Berkshire Swash,Bigshot One,Bilbo Swash Caps,Black Ops One,Bonbon,Bowlby One SC,Brawler,Bubblegum Sans,Butterfly Kids,Cabin Condensed,Caesar Dressing,Cagliostro,Calligraffitti,Capriola,Carter One,Changa One,Chango,Chelsea Market,Cherry Cream Soda,Chewy,Chicle,Chivo,Clicker Script,Coming Soon,Concert One,Condiment,Cookie,Courgette,Covered By Your Grace,Crimson Text,Dancing Script,DejaVu Sans,DejaVu Serif,Dhurjati,Doppio One,Dosis,Droid Sans,Eagle Lake,Electrolize,Emilys Candy,Encode Sans,Encode Sans Compressed,Euphoria Script,Exo,Exo 2,Faster One,Federo,Finger Paint,Fjord One,Fontdiner Swanky,Freckle Face,Fruktur,Gabriela,Geo,Germania One,Give You Glory,Gloria Hallelujah,Goudy Bookletter 1911,Graduate,Grand Hotel,Great Vibes,Griffy,Hanalei Fill,Happy Monkey,Henny Penny,Hind,IM Fell English SC,Indie Flower,Irish Grover,Italianno,Jacques Francois Shadow,Jolly Lodger,Josefin Slab,Joti One,Judson,Just Another Hand,Kalam,Kameron,Karma,Kavoon,Knewave,Kranky,Kristi,Laila,Lakki Reddy,Lancelot,Lato,Leckerli One,Ledger,Lekton,Lemon One,Liberation Sans,Libre Caslon Text,Life Savers,Lilita One,Lily Script One,Limelight,Lobster,Lobster Two,Londrina Outline,Londrina Shadow,Londrina Solid,Lora,Love Ya Like A Sister,Loved by the King,Lovers Quarrel,Luckiest Guy,Lusitana,Macondo,Macondo Swash Caps,Mako,Marck Script,Margarine,Marko One,Maven Pro,McLaren,MedievalSharp,Merienda One,Merriweather,Mervale Script,Metal Mania,Metrophobic,Milonga,Miltonian Tattoo,Miss Fajardose,Molle,Montez,Montserrat,Mr De Haviland,Mystery Quest,Neucha,New Rocker,Niconne,Nosifer,Nothing You Could Do,Noto Sans Oriya,Noto Serif,Nova Square,Nunito,Old Standard TT,Oleo Script,Oleo Script Swash Caps,Orbitron,Oregano,Orienta,Original Surfer,Oswald,Over the Rainbow,Overlock,Oxygen,Pacifico,Paprika,Parisienne,Patrick Hand SC,Paytone One,Peralta,Permanent Marker,Piedra,Pirata One,Play,Playball,Poetsen One,Poppins,Press Start 2P,Princess Sofia,PT Mono,Qwigley,Racing Sans One,Raleway,Rancho,Ranga,Ribeye,Roboto,Roboto Condensed,Roboto Slab,Rochester,Rock Salt,Rubik One,Sail,Salsa,Sansita One,Sarina,Satisfy,Schoolbell,Seaweed Script,Sevillana,Shadows Into Light,Shadows Into Light Two,Share,Six Caps,Skranji,Source Sans Pro,Spicy Rice,Stardos Stencil,Stoke,Syncopate,Teko,Terminal Dosis,The Girl Next Door,Tillana,Timmana,Titillium Web,Ubuntu,Ultra,Underdog,UnifrakturCook,UnifrakturMaguntia,Vampiro One,Vidaloka,Viga,Voces,Volkhov,Vollkorn,Voltaire,Waiting for the Sunrise,Wallpoet,Wellfleet,Wendy One,Yellowtail,Yesteryear,Zeyada]
line5_fontSize = 6; // [2:10]
line5_verticalSpacing = 8; //[2:10]


//ornament(1);

//string, font, size, vertical offset
texts = [
[str(line1_Text) , line1_Font, line1_fontSize, line1_verticalSpacing],
[str(line2_Text) , line2_Font, line2_fontSize, line2_verticalSpacing],
[str(line3_Text) , line3_Font, line3_fontSize, line3_verticalSpacing],
[str(line4_Text) , line4_Font, line4_fontSize, line4_verticalSpacing],
[str(line5_Text) , line5_Font, line5_fontSize, line5_verticalSpacing]
];

union()
{
ornament_custom();

translate([0, 12, 50]) {
  translate([0, 0, (texts[0][3])*-1])  t(texts[0][0], s=texts[0][2], font=texts[0][1]);
  translate([0, 0, (texts[0][3]+texts[1][3])*-1])  t(texts[1][0], s=texts[1][2], font=texts[1][1]);
  translate([0, 0, (texts[0][3]+texts[1][3]+texts[2][3])*-1])  t(texts[2][0], s=texts[2][2], font=texts[2][1]);
  translate([0, 0, (texts[0][3]+texts[1][3]+texts[2][3]+texts[3][3])*-1])  t(texts[3][0], s=texts[3][2], font=texts[3][1]);
  translate([0, 0, (texts[0][3]+texts[1][3]+texts[2][3]+texts[3][3]+texts[4][3])*-1])  t(texts[4][0], s=texts[4][2], font=texts[4][1]);
}

}

module t(t, s = 10, style = "", font = "Forte") {
  rotate([90, 0, 0])
    linear_extrude(height = 5)
      text(t, size = s, font = str(font, style), halign="center", $fn = 16);
}

module ornament_custom() {
    
    union()
    {    
        translate([0,30,30])
        difference()
        {
            sphere(r=40);
            translate([-40,-40,-40])
            cube([75,15,75]);
            translate([0,-18,0])
            rotate([90, 0, 0])
            cylinder(h = 12, r = 28);
        }
        
        translate([0,30,60])
        {
            cylinder(h = 15, r = 10);
        }
        
        translate([4,28,75])
        cube([4,4,7]);
        translate([-8,28,75])
        cube([4,4,7]);

        translate([0,32,80])
        rotate([90, 0, 0])
        difference()
        {
            cylinder(h = 4, r = 8);
            cylinder(h = 6, r = 4);
            translate([-10,-10,0])
            cube([20,10,5]);
        }
    
    }   
}