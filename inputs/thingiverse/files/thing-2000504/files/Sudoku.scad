// What size should a tile be?
tilesize = 12; // [8:50]

// How thick is the wall?
wallsize = 2; // [1:10]

// How thick is a tile?
tilethick = 2; // [1:10]

// Which part should you look at?
part = "lt"; // [lt:Large Tiles,st:Small Tiles,b:Board]

font_name="Lobster"; //[Abril Fatface,Aclonica,Acme,Advent Pro,Akronim,Aladin,Alegreya,Alegreya Sans,Alegreya SC,Alex Brush,Alfa Slab One,Alice,Amaranth,Architects Daughter,Archivo Black,Archivo Narrow,Arimo,Arvo,Asap,Astloch,Asul,Averia Libre,Averia Serif Libre,Bangers,Basic,Belgrano,Berkshire Swash,Bigshot One,Bilbo Swash Caps,Black Ops One,Bonbon,Bowlby One SC,Brawler,Bubblegum Sans,Butterfly Kids,Cabin Condensed,Caesar Dressing,Cagliostro,Calligraffitti,Capriola,Carter One,Changa One,Chango,Chelsea Market,Cherry Cream Soda,Chewy,Chicle,Chivo,Clicker Script,Coming Soon,Concert One,Condiment,Cookie,Courgette,Covered By Your Grace,Crimson Text,Dancing Script,DejaVu Sans,DejaVu Serif,Dhurjati,Doppio One,Dosis,Droid Sans,Eagle Lake,Electrolize,Emilys Candy,Encode Sans,Encode Sans Compressed,Euphoria Script,Exo,Exo 2,Faster One,Federo,Finger Paint,Fjord One,Fontdiner Swanky,Freckle Face,Fruktur,Gabriela,Geo,Germania One,Give You Glory,Gloria Hallelujah,Goudy Bookletter 1911,Graduate,Grand Hotel,Great Vibes,Griffy,Hanalei Fill,Happy Monkey,Henny Penny,Hind,IM Fell English SC,Indie Flower,Irish Grover,Italianno,Jacques Francois Shadow,Jolly Lodger,Josefin Slab,Joti One,Judson,Just Another Hand,Kalam,Kameron,Karma,Kavoon,Knewave,Kranky,Kristi,Laila,Lakki Reddy,Lancelot,Lato,Leckerli One,Ledger,Lekton,Lemon One,Liberation Sans,Libre Caslon Text,Life Savers,Lilita One,Lily Script One,Limelight,Lobster,Lobster Two,Londrina Outline,Londrina Shadow,Londrina Solid,Lora,Love Ya Like A Sister,Loved by the King,Lovers Quarrel,Luckiest Guy,Lusitana,Macondo,Macondo Swash Caps,Mako,Marck Script,Margarine,Marko One,Maven Pro,McLaren,MedievalSharp,Merienda One,Merriweather,Mervale Script,Metal Mania,Metrophobic,Milonga,Miltonian Tattoo,Miss Fajardose,Molle,Montez,Montserrat,Mr De Haviland,Mystery Quest,Neucha,New Rocker,Niconne,Nosifer,Nothing You Could Do,Noto Sans Oriya,Noto Serif,Nova Square,Nunito,Old Standard TT,Oleo Script,Oleo Script Swash Caps,Orbitron,Oregano,Orienta,Original Surfer,Oswald,Over the Rainbow,Overlock,Oxygen,Pacifico,Paprika,Parisienne,Patrick Hand SC,Paytone One,Peralta,Permanent Marker,Piedra,Pirata One,Play,Playball,Poetsen One,Poppins,Press Start 2P,Princess Sofia,PT Mono,Qwigley,Racing Sans One,Raleway,Rancho,Ranga,Ribeye,Roboto,Roboto Condensed,Roboto Slab,Rochester,Rock Salt,Rubik One,Sail,Salsa,Sansita One,Sarina,Satisfy,Schoolbell,Seaweed Script,Sevillana,Shadows Into Light,Shadows Into Light Two,Share,Six Caps,Skranji,Source Sans Pro,Spicy Rice,Stardos Stencil,Stoke,Syncopate,Teko,Terminal Dosis,The Girl Next Door,Tillana,Timmana,Titillium Web,Ubuntu,Ultra,Underdog,UnifrakturCook,UnifrakturMaguntia,Vampiro One,Vidaloka,Viga,Voces,Volkhov,Vollkorn,Voltaire,Waiting for the Sunrise,Wallpoet,Wellfleet,Wendy One,Yellowtail,Yesteryear,Zeyada]

// Does the text cut in to a tile or stand out?
textorientation = "cut"; // [cut:Cut Into,stand:Stand Out]

print_part();

module print_part(){
    if (part == "lt"){
        tileset1();
    }else if (part == "st"){
        tileset2();
    }else if (part == "b"){
        board();
    }else{
        tileset1();
    }
}

module tileset1(){
    for (x = [1:1:9]){
        translate([tilesize*x-tilesize*5,0,0])
        tile(x,tilesize);
    }
}

module tileset2(){
    for (x = [1:1:9]){
        translate([tilesize/2*x-tilesize/2*5,0,0])
        tile(x,tilesize/2);
    }
}

module tile(num=1,tilesize=10){
    difference(){
        translate([0,0,tilethick/2])
        cube([tilesize-1,tilesize-1,tilethick],center=true);
        if (textorientation == "cut"){
            translate([0,0,tilethick/2])
            linear_extrude(tilethick)
            text(text=str(num), font=font_name, size=tilesize-3, halign="center",valign="center");
        }
        for(r=[0:90:359]){
            rotate(r)
            translate([tilesize/2-0.5,0,0])
            rotate([0,45,0])
            cube([tilethick/2,tilesize,tilethick/2],center=true);
        }
    }
    if (textorientation == "stand"){
        translate([0,0,tilethick/2])
        linear_extrude(tilethick)
        text(text=str(num), font=font_name, size=tilesize-3, halign="center",valign="center");
    }
}

module board(){
    for (outerx=[-1:1:1], outery = [-1:1:1]){
        translate([outerx*(tilesize*3+wallsize*4), outery*(tilesize*3+wallsize*4), 0]){
            for (innerx=[-1:1:1],innery=[-1:1:1]){
                translate([innerx*(tilesize+wallsize),innery*(tilesize+wallsize),0])
                boardtile();
            }
            for (innerx = [-1.5:1:1.5]){
                translate([innerx*(tilesize+wallsize),0,tilethick])
                cube([wallsize, (tilesize*3+wallsize*4),tilethick*2],center=true);
            }
            for (innery = [-1.5:1:1.5]){
                translate([0,innery*(tilesize+wallsize),tilethick])
                cube([(tilesize*3+wallsize*4),wallsize,tilethick*2],center=true);
            }
        }
    }
    for (x = [-1,1]){
        translate([x*(tilesize/2+tilesize+wallsize*2),0,tilethick*1.5])
        cube([wallsize, 3*(tilesize*3+wallsize*4),tilethick*3],center=true);
    }
    for (y = [-1,1]){
        translate([0,y*(tilesize/2+tilesize+wallsize*2),tilethick*1.5])
        cube([3*(tilesize*3+wallsize*4),wallsize,tilethick*3],center=true);
    }
}

module boardtile(){
    polyhedron(
        points = [
            [-tilesize/2-0.5,tilesize/2+0.5,tilethick/2], // 0
            [tilesize/2+0.5,tilesize/2+0.5,tilethick/2], // 1
            [-tilesize/2+2.5,tilesize/2-2.5,tilethick], // 2
            [tilesize/2-2.5,tilesize/2-2.5,tilethick], // 3
            [-tilesize/2+2.5,-tilesize/2+2.5,tilethick], // 4
            [tilesize/2-2.5,-tilesize/2+2.5,tilethick], // 5
            [-tilesize/2-0.5,-tilesize/2-0.5,tilethick/2], // 6
            [tilesize/2+0.5,-tilesize/2-0.5,tilethick/2], // 7
            [-tilesize/2-0.5,tilesize/2+0.5,0], // 8
            [tilesize/2+0.5,tilesize/2+0.5,0], // 9
            [-tilesize/2-0.5,-tilesize/2-0.5,0], // 10
            [tilesize/2+0.5,-tilesize/2-0.5,0], // 11
        ], faces = [
            [0,1,3,2],[1,7,5,3],[7,6,4,5],[6,0,2,4],
            [2,3,5,4],[9,8,10,11],
            [1,9,11,7],[7,11,10,6],[0,6,10,8],[1,0,8,9]
        ]);
}