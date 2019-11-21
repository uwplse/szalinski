//Ornament-Customizable Lithopane by Mark G. Peeters 
//http://www.thingiverse.com/thing:189268
//version 1.0 has a 13mm hole for most tiny lights
//if you are using openSCAD then you are cool! You can get DAT files for local use using this tool
//http://customizer.makerbot.com/image_surface
// i used the nice code for adjusting layers from here:
//http://www.thingiverse.com/thing:74322

// preview[view:south, tilt:top]
//
//
/* [Image] */

// Load a SQUARE 150x150 image.(images will be stretched to fit) Simple photos work best. Don't forget to click the Invert Colors checkbox! *** ALSO IF YOU HAVE LETTERS IN YOUR IMAGE make sure to reverse the image before uploading so the letters are not backwards. ***
image_file = "image-surface.dat"; // [image_surface:150x150]

/* [Adjustments] */

//NOTE: ALL units are in millimeters (mm)
diameter = 70;// [50:100]

// What layer height will you slice this at?  The thinner the better!
layer_height = 0.05;

// The lower the layer height, the more layers you can use.
number_of_layers = 30; // [5:42]

//Thickness of sphere (2mm is fine) outer wall
shellthick = 2; //[1:4]

//Text to write on  the back
text_to_write = "Christmas";

//additional text to write on the back. Note: for some reason numbers (e.g. "2017" by themselves don't seem to show up in the preview so I add spaces around them.
text_to_write2 = "  2017  ";

//Text font
font = "Cookie"; //[Abril Fatface,Aclonica,Acme,Advent Pro,Akronim,Aladin,Alegreya,Alegreya Sans,Alegreya SC,Alex Brush,Alfa Slab One,Alice,Amaranth,Architects Daughter,Archivo Black,Archivo Narrow,Arimo,Arvo,Asap,Astloch,Asul,Averia Libre,Averia Serif Libre,Bangers,Basic,Belgrano,Berkshire Swash,Bigshot One,Bilbo Swash Caps,Black Ops One,Bonbon,Bowlby One SC,Brawler,Bubblegum Sans,Butterfly Kids,Cabin Condensed,Caesar Dressing,Cagliostro,Calligraffitti,Capriola,Carter One,Changa One,Chango,Chelsea Market,Cherry Cream Soda,Chewy,Chicle,Chivo,Clicker Script,Coming Soon,Concert One,Condiment,Cookie,Courgette,Covered By Your Grace,Crimson Text,Dancing Script,DejaVu Sans,DejaVu Serif,Dhurjati,Doppio One,Dosis,Droid Sans,Eagle Lake,Electrolize,Emilys Candy,Encode Sans,Encode Sans Compressed,Euphoria Script,Exo,Exo 2,Faster One,Federo,Finger Paint,Fjord One,Fontdiner Swanky,Freckle Face,Fruktur,Gabriela,Geo,Germania One,Give You Glory,Gloria Hallelujah,Goudy Bookletter 1911,Graduate,Grand Hotel,Great Vibes,Griffy,Hanalei Fill,Happy Monkey,Henny Penny,Hind,IM Fell English SC,Indie Flower,Irish Grover,Italianno,Jacques Francois Shadow,Jolly Lodger,Josefin Slab,Joti One,Judson,Just Another Hand,Kalam,Kameron,Karma,Kavoon,Knewave,Kranky,Kristi,Laila,Lakki Reddy,Lancelot,Lato,Leckerli One,Ledger,Lekton,Lemon One,Liberation Sans,Libre Caslon Text,Life Savers,Lilita One,Lily Script One,Limelight,Lobster,Lobster Two,Londrina Outline,Londrina Shadow,Londrina Solid,Lora,Love Ya Like A Sister,Loved by the King,Lovers Quarrel,Luckiest Guy,Lusitana,Macondo,Macondo Swash Caps,Mako,Marck Script,Margarine,Marko One,Maven Pro,McLaren,MedievalSharp,Merienda One,Merriweather,Mervale Script,Metal Mania,Metrophobic,Milonga,Miltonian Tattoo,Miss Fajardose,Molle,Montez,Montserrat,Mr De Haviland,Mystery Quest,Neucha,New Rocker,Niconne,Nosifer,Nothing You Could Do,Noto Sans Oriya,Noto Serif,Nova Square,Nunito,Old Standard TT,Oleo Script,Oleo Script Swash Caps,Orbitron,Oregano,Orienta,Original Surfer,Oswald,Over the Rainbow,Overlock,Oxygen,Pacifico,Paprika,Parisienne,Patrick Hand SC,Paytone One,Peralta,Permanent Marker,Piedra,Pirata One,Play,Playball,Poetsen One,Poppins,Press Start 2P,Princess Sofia,PT Mono,Qwigley,Racing Sans One,Raleway,Rancho,Ranga,Ribeye,Roboto,Roboto Condensed,Roboto Slab,Rochester,Rock Salt,Rubik One,Sail,Salsa,Sansita One,Sarina,Satisfy,Schoolbell,Seaweed Script,Sevillana,Shadows Into Light,Shadows Into Light Two,Share,Six Caps,Skranji,Source Sans Pro,Spicy Rice,Stardos Stencil,Stoke,Syncopate,Teko,Terminal Dosis,The Girl Next Door,Tillana,Timmana,Titillium Web,Ubuntu,Ultra,Underdog,UnifrakturCook,UnifrakturMaguntia,Vampiro One,Vidaloka,Viga,Voces,Volkhov,Vollkorn,Voltaire,Waiting for the Sunrise,Wallpoet,Wellfleet,Wendy One,Yellowtail,Yesteryear,Zeyada]

// Hidden parameter
module stopCustomizer(){}
/* [Hidden] */

// base (white) will always be 2 layers thick
min_layer_height = layer_height*2;
height = layer_height*number_of_layers;
maxheight = height+min_layer_height;
font_size_1 = get_font_size(text_to_write, diameter/3);
font_size_2 = get_font_size(text_to_write2, diameter/3);

difference() {
union() {  //union 1

// trim surface to circle & scale to hieght
  difference() { //diff 1
  translate([0, 0, min_layer_height]) scale([(diameter/150),(diameter/150),height]) surface(file=image_file, center=true, convexity=5); //litosurface
  union() {  //union tube and bottom to trim surface
  translate([0,0,-(maxheight)]) linear_extrude(height=maxheight) circle(diameter, center=true);//cutting bottom off surface
  difference() {  //diff make tube
                translate([0, 0, -7]) cylinder(maxheight+15,r= diameter); //outside
                translate([0, 0, -9]) cylinder(maxheight+18,r= (diameter/2)); //inside
               } //end diff make tube
            } //end union tube and bottom to trim surface
               } //end diff 1
// the surface is now trimmed 

//make frame wall shell thickness
difference() {  //diff make frame tube
                 cylinder(maxheight,r= (diameter/2)+shellthick); //outside
                 cylinder(maxheight+1,r= (diameter/2.02)); //inside
                } //end diff make frame tube
//end make frame wall

//make half sphere back half   sphere(2, $fn=100)
translate([0, 0, maxheight])  difference() {     //diff make sphere back
             sphere((diameter/2)+shellthick, $fn=100); //outside shell
            sphere((diameter/2)); //inside cutout
             translate([0, 0, -(diameter)]) cylinder(diameter,r= (diameter/2)+5);//trim bottom half 
              // make hole shape for holiday light string style bulb
             rotate ([-70,0,0]) translate([0, -5, 0])  union() {  //complete hole
             translate([0, 0, 0]) cylinder(60,r= 6.5);//light hole
             hull() {
             translate([-15, 2, 0]) cylinder(60,r= 2.5);//sideways hole left
             translate([0, -5, 0])  cylinder(60,r= 2);//sideways slot left
                      }   
             hull() {
             translate([15, 2, 0]) cylinder(60,r= 2.5);//sideways hole right
             translate([0, -5, 0])  cylinder(60,r= 2);//sideways slot right
                      } 
                       }  //end complete hole
       }//end diff make sphere back

} //final union 1
render()
difference() {
linear_extrude(diameter)
translate([0,0,diameter/2+2])
 {

if (len(text_to_write) != 0) {
    translate([0,min(max(font_size_1/3,5),diameter/3),0])
    text(text_to_write, font=font, size=font_size_1,halign="center", valign="center");
    }
    
if (len(text_to_write2) != 0) {
   translate([0,max(min(-3/4*font_size_1 - 2,-12), -diameter/4),0])
    text(text_to_write2, font=font, size=font_size_2,halign="center", valign="center");
    }
}
if (layer_height <= 0.09)
    sphere(diameter/2 + shellthick);
else
    sphere(diameter/2 + shellthick*2 - layer_height);
}
}


function get_font_size(text, max_size) =
    min((diameter+5) / (len(text)+1), max_size);
