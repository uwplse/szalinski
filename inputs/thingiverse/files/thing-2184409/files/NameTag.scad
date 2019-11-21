makeTag();

 /* [Base] */
     xSize = 50; // [10:100]
     ySize = 15; // [10:60]
     zSize = 2; // [1:0.2:6]
// 0 = No hole
     holeDia = 2; // [0:0.5:5]
// 0 = right angle
     cornerRad = 1.0; // [0:0.5:10.0] 
// Distance from edge to hole
     holeOffset = 1; // [0:0.5:10]  
// Color will not print
     baseColor = "yellow"; // [green, yellow, blue, red, silver, black]

/* [Rim]  */
// Add a rim?
    show_rim = "yes"; // [yes,no]
// Rim Thickness
    rimThickness = 1.0; // [0:0.2:5.0]

/* [Text] */
// Height of text over base
    textHeight = 1; // [0.2:0.2:6] 
// Size of text
    textSize = 9; // [1:0.5:25]
// Printed text
    myText = "Name"; 
// Color will not print
    text(t="OpenSCAD", font = "Symbol");
    textColor = "green"; // [green, yellow, blue, red, silver, black] 
// Pick your favorite font - check out Google fonts
    myFont="Liberation Mono"; //[Abril Fatface,Aclonica,Acme,Advent Pro,Akronim,Aladin,Alegreya,Alegreya Sans,Alegreya SC,Alex Brush,Alfa Slab One,Alice,Amaranth,Architects Daughter,Archivo Black,Archivo Narrow,Arimo,Arvo,Asap,Astloch,Asul,Averia Libre,Averia Serif Libre,Bangers,Basic,Belgrano,Berkshire Swash,Bigshot One,Bilbo Swash Caps,Black Ops One,Bonbon,Bowlby One SC,Brawler,Bubblegum Sans,Butterfly Kids,Cabin Condensed,Caesar Dressing,Cagliostro,Calligraffitti,Capriola,Carter One,Changa One,Chango,Chelsea Market,Cherry Cream Soda,Chewy,Chicle,Chivo,Clicker Script,Coming Soon,Concert One,Condiment,Cookie,Courgette,Covered By Your Grace,Crimson Text,Dancing Script,DejaVu Sans,DejaVu Serif,Dhurjati,Doppio One,Dosis,Droid Sans,Eagle Lake,Electrolize,Emilys Candy,Encode Sans,Encode Sans Compressed,Euphoria Script,Exo,Exo 2,Faster One,Federo,Finger Paint,Fjord One,Fontdiner Swanky,Freckle Face,Fruktur,Gabriela,Geo,Germania One,Give You Glory,Gloria Hallelujah,Goudy Bookletter 1911,Graduate,Grand Hotel,Great Vibes,Griffy,Hanalei Fill,Happy Monkey,Henny Penny,Hind,IM Fell English SC,Indie Flower,Irish Grover,Italianno,Jacques Francois Shadow,Jolly Lodger,Josefin Slab,Joti One,Judson,Just Another Hand,Kalam,Kameron,Karma,Kavoon,Knewave,Kranky,Kristi,Laila,Lakki Reddy,Lancelot,Lato,Leckerli One,Ledger,Lekton,Lemon One,Liberation Sans,Libre Caslon Text,Life Savers,Lilita One,Lily Script One,Limelight,Lobster,Lobster Two,Londrina Outline,Londrina Shadow,Londrina Solid,Lora,Love Ya Like A Sister,Loved by the King,Lovers Quarrel,Luckiest Guy,Lusitana,Macondo,Macondo Swash Caps,Mako,Marck Script,Margarine,Marko One,Maven Pro,McLaren,MedievalSharp,Merienda One,Merriweather,Mervale Script,Metal Mania,Metrophobic,Milonga,Miltonian Tattoo,Miss Fajardose,Molle,Montez,Montserrat,Mr De Haviland,Mystery Quest,Neucha,New Rocker,Niconne,Nosifer,Nothing You Could Do,Noto Sans Oriya,Noto Serif,Nova Square,Nunito,Old Standard TT,Oleo Script,Oleo Script Swash Caps,Orbitron,Oregano,Orienta,Original Surfer,Oswald,Over the Rainbow,Overlock,Oxygen,Pacifico,Paprika,Parisienne,Patrick Hand SC,Paytone One,Peralta,Permanent Marker,Piedra,Pirata One,Play,Playball,Poetsen One,Poppins,Press Start 2P,Princess Sofia,PT Mono,Qwigley,Racing Sans One,Raleway,Rancho,Ranga,Ribeye,Roboto,Roboto Condensed,Roboto Slab,Rochester,Rock Salt,Rubik One,Sail,Salsa,Sansita One,Sarina,Satisfy,Schoolbell,Seaweed Script,Sevillana,Shadows Into Light,Shadows Into Light Two,Share,Six Caps,Skranji,Source Sans Pro,Spicy Rice,Stardos Stencil,Stoke,Syncopate,Teko,Terminal Dosis,The Girl Next Door,Tillana,Timmana,Titillium Web,Ubuntu,Ultra,Underdog,UnifrakturCook,UnifrakturMaguntia,Vampiro One,Vidaloka,Viga,Voces,Volkhov,Vollkorn,Voltaire,Waiting for the Sunrise,Wallpoet,Wellfleet,Wendy One,Yellowtail,Yesteryear,Zeyada]
   
   
/* [Hidden] */
$fn = 48; //force full circle to be rendered using 48 fragments
holeRad = holeDia/2;
fudge = holeRad + holeOffset; //Distance from center of hole to edge
// Ruler is only shown in Customizer.
ruler_unit=10; //[10:cm, 25.4:inch]
// Convert input text to string
myTextStr=str(myText);

module holes() {
    // translate([-xSize/2, ysize/2, 0])
    // create a cylinder with 36 segments that is 2 times the thickness of the base
    translate([-(xSize/2)+ fudge, ySize/2-fudge, 0])
      color(baseColor) cylinder(r = holeRad, h = 2*zSize, , center = true);
    
    translate([xSize/2-fudge, ySize/2-fudge, 0])
      color(baseColor) cylinder(r = holeRad, h = 2*zSize, $fn = 48, center = true);

}
module base() {
     color(baseColor) translate ([0,0,0]) roundedBox ([xSize, ySize, zSize], radius = cornerRad, sidesonly = 1);
}

module rim() {
    difference(){
    color(baseColor) translate([0,0,-textHeight/2]) 
        roundedBox([xSize+rimThickness*2, ySize+rimThickness*2, (zSize+textHeight+.001)], radius = cornerRad, sidesonly = 1);
    
    color(baseColor) translate([0,0,-textHeight/2]) 
        roundedBox([xSize, ySize, zSize + textHeight*2], radius = cornerRad, sidesonly = 1);
    }
}

module textExtrude() {
  // the following four lines are all actually one command that ends with the ';'
    color(textColor)
    linear_extrude(height = textHeight)
    text(myText, halign = "center", valign = "center", size = textSize,
      font = myFont);
    if (show_rim=="yes"){
    rim();
    }

}

module makeTag(){
difference() {
        union(){
            base();
            translate([0, 0, zSize/2]) textExtrude();
        }
        holes();
    }
}



// Library: boxes.scad
// Version: 1.0
// Author: Marius Kintel
// Copyright: 2010
// License: BSD
// roundedBox([width, height, depth], float radius, bool sidesonly);
// EXAMPLE USAGE:
// roundedBox([20, 30, 40], 5, true);
// size is a vector [w, h, d]

module roundedBox(size, radius, sidesonly)
{
  rot = [ [0,0,0], [90,0,90], [90,90,0] ];
  if (sidesonly) {
    cube(size - [2*radius,0,0], true);
    cube(size - [0,2*radius,0], true);
    for (x = [radius-size[0]/2, -radius+size[0]/2],
           y = [radius-size[1]/2, -radius+size[1]/2]) {
      translate([x,y,0]) cylinder(r=radius, h=size[2], center=true);
    }
  }
  else {
    cube([size[0], size[1]-radius*2, size[2]-radius*2], center=true);
    cube([size[0]-radius*2, size[1], size[2]-radius*2], center=true);
    cube([size[0]-radius*2, size[1]-radius*2, size[2]], center=true);
    for (axis = [0:2]) {
      for (x = [radius-size[axis]/2, -radius+size[axis]/2],
             y = [radius-size[(axis+1)%3]/2, -radius+size[(axis+1)%3]/2]) {
        rotate(rot[axis])
          translate([x,y,0])
          cylinder(h=size[(axis+2)%3]-2*radius, r=radius, center=true);
      }
    }
    for (x = [radius-size[0]/2, -radius+size[0]/2],
           y = [radius-size[1]/2, -radius+size[1]/2],
           z = [radius-size[2]/2, -radius+size[2]/2]) {
      translate([x,y,z]) sphere(radius);
    }
  }
}
