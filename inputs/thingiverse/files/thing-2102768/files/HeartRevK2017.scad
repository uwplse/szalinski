// Heart box
// Adrian Kennard (RevK) 2017 @theRealRevK
// Rework of http://www.thingiverse.com/thing:44579 from scratch

// Print the heart (args are monogram letters on top)

/* [Main Options] */

// letters on top
word1="";
word2="";

heart(word1,word2);

// Text on top
// Font for text on top of heart
font="Helvetica";   //[ABeeZee,Abel,Abril Fatface,Aclonica,Acme,Actor,Adamina,Advent Pro,Aguafina Script,Akronim,Aladin,Aldrich,Alef,Alegreya,Alegreya Sans,Alegreya Sans SC,Alegreya SC,Alex Brush,Alfa Slab One,Alice,Alike,Alike Angular,Allan,Allerta,Allerta Stencil,Allura,Almendra,Almendra Display,Almendra SC,Amarante,Amaranth,Amatic SC,Amethysta,Amiri,Anaheim,Andada,Andika,Angkor,Annie Use Your Telescope,Anonymous Pro,Antic,Antic Didone,Antic Slab,Anton,Arapey,Arbutus,Arbutus Slab,Architects Daughter,Archivo Black,Archivo Narrow,Arimo,Arizonia,Armata,Artifika,Arvo,Asap,Asset,Astloch,Asul,Atomic Age,Aubrey,Audiowide,Autour One,Average,Average Sans,Averia Gruesa Libre,Averia Libre,Averia Sans Libre,Averia Serif Libre,Bad Script,Balthazar,Bangers,Basic,Battambang,Baumans,Bayon,Belgrano,Belleza,BenchNine,Bentham,Berkshire Swash,Bevan,Bigelow Rules,Bigshot One,Bilbo,Bilbo Swash Caps,Bitter,Black Ops One,Bokor,Bonbon,Boogaloo,Bowlby One,Bowlby One SC,Brawler,Bree Serif,Bubblegum Sans,Bubbler One,Buda,Buenard,Butcherman,Butterfly Kids,Cabin,Cabin Condensed,Cabin Sketch,Caesar Dressing,Cagliostro,Calligraffitti,Cambay,Cambo,Candal,Cantarell,Cantata One,Cantora One,Capriola,Cardo,Carme,Carrois Gothic,Carrois Gothic SC,Carter One,Caudex,Cedarville Cursive,Ceviche One,Changa One,Chango,Chau Philomene One,Chela One,Chelsea Market,Chenla,Cherry Cream Soda,Cherry Swash,Chewy,Chicle,Chivo,Cinzel,Cinzel Decorative,Clicker Script,Coda,Coda Caption,Codystar,Combo,Comfortaa,Coming Soon,Concert One,Condiment,Content,Contrail One,Convergence,Cookie,Copse,Corben,Courgette,Cousine,Coustard,Covered By Your Grace,Crafty Girls,Creepster,Crete Round,Crimson Text,Croissant One,Crushed,Cuprum,Cutive,Cutive Mono,Damion,Dancing Script,Dangrek,Dawning of a New Day,Days One,Dekko,Delius,Delius Swash Caps,Delius Unicase,Della Respira,Denk One,Devonshire,Dhurjati,Didact Gothic,Diplomata,Diplomata SC,Domine,Donegal One,Doppio One,Dorsa,Dosis,Dr Sugiyama,Droid Sans,Droid Sans Mono,Droid Serif,Duru Sans,Dynalight,Eagle Lake,Eater,EB Garamond,Economica,Ek Mukta,Electrolize,Elsie,Elsie Swash Caps,Emblema One,Emilys Candy,Engagement,Englebert,Enriqueta,Erica One,Esteban,Euphoria Script,Ewert,Exo,Exo 2,Expletus Sans,Fanwood Text,Fascinate,Fascinate Inline,Faster One,Fasthand,Fauna One,Federant,Federo,Felipa,Fenix,Finger Paint,Fira Mono,Fira Sans,Fjalla One,Fjord One,Flamenco,Flavors,Fondamento,Fontdiner Swanky,Forum,Francois One,Freckle Face,Fredericka the Great,Fredoka One,Freehand,Fresca,Frijole,Fruktur,Fugaz One,Gabriela,Gafata,Galdeano,Galindo,Gentium Basic,Gentium Book Basic,Geo,Geostar,Geostar Fill,Germania One,GFS Didot,GFS Neohellenic,Gidugu,Gilda Display,Give You Glory,Glass Antiqua,Glegoo,Gloria Hallelujah,Goblin One,Gochi Hand,Gorditas,Goudy Bookletter 1911,Graduate,Grand Hotel,Gravitas One,Great Vibes,Griffy,Gruppo,Gudea,Gurajada,Habibi,Halant,Hammersmith One,Hanalei,Hanalei Fill,Handlee,Hanuman,Happy Monkey,Headland One,Henny Penny,Herr Von Muellerhoff,Hind,Holtwood One SC,Homemade Apple,Homenaje,Iceberg,Iceland,IM Fell Double Pica,IM Fell Double Pica SC,IM Fell DW Pica,IM Fell DW Pica SC,IM Fell English,IM Fell English SC,IM Fell French Canon,IM Fell French Canon SC,IM Fell Great Primer,IM Fell Great Primer SC,Imprima,Inconsolata,Inder,Indie Flower,Inika,Irish Grover,Istok Web,Italiana,Italianno,Jacques Francois,Jacques Francois Shadow,Jim Nightshade,Jockey One,Jolly Lodger,Josefin Sans,Josefin Slab,Joti One,Judson,Julee,Julius Sans One,Junge,Jura,Just Another Hand,Just Me Again Down Here,Kalam,Kameron,Kantumruy,Karla,Karma,Kaushan Script,Kavoon,Kdam Thmor,Keania One,Kelly Slab,Kenia,Khand,Khmer,Khula,Kite One,Knewave,Kotta One,Koulen,Kranky,Kreon,Kristi,Krona One,La Belle Aurore,Laila,Lakki Reddy,Lancelot,Lateef,Lato,League Script,Leckerli One,Ledger,Lekton,Lemon,Liberation Sans,Libre Baskerville,Life Savers,Lilita One,Lily Script One,Limelight,Linden Hill,Lobster,Lobster Two,Londrina Outline,Londrina Shadow,Londrina Sketch,Londrina Solid,Lora,Love Ya Like A Sister,Loved by the King,Lovers Quarrel,Luckiest Guy,Lusitana,Lustria,Macondo,Macondo Swash Caps,Magra,Maiden Orange,Mako,Mallanna,Mandali,Marcellus,Marcellus SC,Marck Script,Margarine,Marko One,Marmelad,Martel Sans,Marvel,Mate,Mate SC,Maven Pro,McLaren,Meddon,MedievalSharp,Medula One,Megrim,Meie Script,Merienda,Merienda One,Merriweather,Merriweather Sans,Metal,Metal Mania,Metamorphous,Metrophobic,Michroma,Milonga,Miltonian,Miltonian Tattoo,Miniver,Miss Fajardose,Modak,Modern Antiqua,Molengo,Molle,Monda,Monofett,Monoton,Monsieur La Doulaise,Montaga,Montez,Montserrat,Montserrat Alternates,Montserrat Subrayada,Moul,Moulpali,Mountains of Christmas,Mouse Memoirs,Mr Bedfort,Mr Dafoe,Mr De Haviland,Mrs Saint Delafield,Mrs Sheppards,Muli,Mystery Quest,Neucha,Neuton,New Rocker,News Cycle,Niconne,Nixie One,Nobile,Nokora,Norican,Nosifer,Nothing You Could Do,Noticia Text,Noto Sans,Noto Serif,Nova Cut,Nova Flat,Nova Mono,Nova Oval,Nova Round,Nova Script,Nova Slim,Nova Square,NTR,Numans,Nunito,Odor Mean Chey,Offside,Old Standard TT,Oldenburg,Oleo Script,Oleo Script Swash Caps,Open Sans,Open Sans Condensed,Oranienbaum,Orbitron,Oregano,Orienta,Original Surfer,Oswald,Over the Rainbow,Overlock,Overlock SC,Ovo,Oxygen,Oxygen Mono,Pacifico,Paprika,Parisienne,Passero One,Passion One,Pathway Gothic One,Patrick Hand,Patrick Hand SC,Patua One,Paytone One,Peddana,Peralta,Permanent Marker,Petit Formal Script,Petrona,Philosopher,Piedra,Pinyon Script,Pirata One,Plaster,Play,Playball,Playfair Display,Playfair Display SC,Podkova,Poiret One,Poller One,Poly,Pompiere,Pontano Sans,Port Lligat Sans,Port Lligat Slab,Prata,Preahvihear,Press Start 2P,Princess Sofia,Prociono,Prosto One,PT Mono,PT Sans,PT Sans Caption,PT Sans Narrow,PT Serif,PT Serif Caption,Puritan,Purple Purse,Quando,Quantico,Quattrocento,Quattrocento Sans,Questrial,Quicksand,Quintessential,Qwigley,Racing Sans One,Radley,Rajdhani,Raleway,Raleway Dots,Ramabhadra,Ramaraja,Rambla,Rammetto One,Ranchers,Rancho,Ranga,Rationale,Ravi Prakash,Redressed,Reenie Beanie,Revalia,Ribeye,Ribeye Marrow,Righteous,Risque,Roboto,Roboto Condensed,Roboto Slab,Rochester,Rock Salt,Rokkitt,Romanesco,Ropa Sans,Rosario,Rosarivo,Rouge Script,Rozha One,Rubik Mono One,Rubik One,Ruda,Rufina,Ruge Boogie,Ruluko,Rum Raisin,Ruslan Display,Russo One,Ruthie,Rye,Sacramento,Sail,Salsa,Sanchez,Sancreek,Sansita One,Sarina,Sarpanch,Satisfy,Scada,Scheherazade,Schoolbell,Seaweed Script,Sevillana,Seymour One,Shadows Into Light,Shadows Into Light Two,Shanti,Share,Share Tech,Share Tech Mono,Shojumaru,Short Stack,Siemreap,Sigmar One,Signika,Signika Negative,Simonetta,Sintony,Sirin Stencil,Six Caps,Skranji,Slabo 13px,Slabo 27px,Slackey,Smokum,Smythe,Sniglet,Snippet,Snowburst One,Sofadi One,Sofia,Sonsie One,Sorts Mill Goudy,Source Code Pro,Source Sans Pro,Source Serif Pro,Special Elite,Spicy Rice,Spinnaker,Spirax,Squada One,Sree Krushnadevaraya,Stalemate,Stalinist One,Stardos Stencil,Stint Ultra Condensed,Stint Ultra Expanded,Stoke,Strait,Sue Ellen Francisco,Sunshiney,Supermercado One,Suranna,Suravaram,Suwannaphum,Swanky and Moo Moo,Syncopate,Tangerine,Taprom,Tauri,Teko,Telex,Tenali Ramakrishna,Tenor Sans,Text Me One,The Girl Next Door,Tienne,Timmana,Tinos,Titan One,Titillium Web,Trade Winds,Trocchi,Trochut,Trykker,Tulpen One,Ubuntu,Ubuntu Condensed,Ubuntu Mono,Ultra,Uncial Antiqua,Underdog,Unica One,UnifrakturCook,UnifrakturMaguntia,Unkempt,Unlock,Unna,Vampiro One,Varela,Varela Round,Vast Shadow,Vesper Libre,Vibur,Vidaloka,Viga,Voces,Volkhov,Vollkorn,Voltaire,VT323,Waiting for the Sunrise,Wallpoet,Walter Turncoat,Warnes,Wellfleet,Wendy One,Wire One,Yanone Kaffeesatz,Yellowtail,Yeseva One,Yesteryear,Zeyada]

// for longer text make this smaller, for single initials, 12 is good
fontheight=12;      
// How high the embossed text is
fontthickness=1;   

/* [Print related constants] */
// Print related constants
// Print tolerance for moving parts, ie gap between moving edges
T=0.4;   //[0.1,0.2:0.2 TAZ6,0.3,0.4:0.4 Makerbot,0.5,0.6]
// Extra gap in centre, increase this for makerbot
G=0.0;  //[0:0 none TAZ6,0.1,0.2:0.2 Makerbot,0.3:0.4 Wider]    
// Overhang slope angle for main join rivet
S=30;       
// extrude width - used as a "small gap"
Q=0.6;      

/* [Main constants] */
// Main constants
// Width of heart when folded as losenge
W=40;       
// Length of heart when folded as losenge
L=80;       
// Height of heart (before embossed mongram)
H=20;       
// Wall thickness
wall=Q*2;   

/* [Quality controls] */
// Quality controls
$fs=1;
$fa=5;

/* [Additional values you probably don't need to touch] */
// Additional values you probably don't need to touch
// extra tolerance on join rivet to avoid sticking
joint=0.3;      
// join cylinder radius
joinr=H/5; 


/* [Hinge controls] */
// Hinge height
hingeh=H/5+T;   
// Spacing of hinges - some shapes of heart this won't work
hingew=W/3-T;   

/* [Nub] */
// Nub in centre is cylinder d1/d2/h
nubd1=1;      
nubd2=2;
nubh=2.5;
// Additional width to make nub stronger (degrees, keep small)
nubw=8;         

/* [Derived values] */
// Derived values
// Angle of cut
A=atan2(W,L-W); 
// nub radius
nubr=H/2-nubd2/2-T/2-Q;  
nuba=360*((nubd1*(T/nubh)+nubd2*(1-T/nubh))+T)/(6.28*nubr)/2;
// center of top curve
x=sin(A)*(W/2)-T/4; 
// Y position of hinge
hy=H+hingeh/4+T*sqrt(2)/2+wall; 

// Test functions - useful for confirming print works without printing whole things

module opentop()
{ // view with no top
    difference()
    {
        heart();
        translate([-L,-L,H-wall-0.1])cube(L*2);
    }
}

module testflap()
{ // Make section to print to test the flap/hinge
    intersection()
    {
        heart();
        translate([-x-W/2,H/2,0])cube([x+W/2,W,max(hingeh,wall)]);
    }
}

module testjoin()
{   // Make section to print to test the main joint
    difference()
    {
        intersection()
        {
            heart();
            cube([H,H,2*(H-wall-T-nubd2/2-0.1)],center=true);
        }
        translate([-L/2,H,0])rotate([45,0,0])cube([L,H,H*2]);
    }
}

// Main construction functions

module solid(w=0,h=0,right=0)
{ // The solid model of a side, with width and height offsets
    difference()
    {
        hull()
        {
            translate([0,(W-L)/2,0])sphere(d=W-w*2);
            translate([0,(L-W)/2,0])sphere(d=W-w*2);
        }
        translate([-L,-L,H/2-h])cube(L*2);
        translate([-L,-L,-L*2-H/2+h])cube(L*2);
        rotate([0,0,-A])translate([-T/2-w,-L,-H/2-T])cube([L,L*2,H+T*2]); // Cut for two sides
    }
}

module nubshape(w=0)
{ // The actual nub itself, a simple cylinder with back support in to the base
    hull()
    { // avoid any zero width edges between these two parts
        translate([0,0,-wall-w])cylinder(d=nubd2+w,h=wall+w,$fn=50);
        cylinder(d1=nubd2+w,d2=nubd1+w,h=nubh,$fn=50);
    }
}

module nub(right=0,w=0)
{ // The nub stretched (rotated) but nuba
  // ideally this would use a rotate_extrude with limit angle rather than a hull - next version of openscad supports this
    rotate([0,90,0])
    {
        hull()
        {
            rotate([0,0,135+(right?-nuba:nuba)])translate([nubr,0,0])nubshape(w=w);
            rotate([0,0,135+(right?-nuba-nubw/2:nuba+nubw/2)])translate([nubr,0,0])nubshape(w=w);
        }
        hull()
        {
            rotate([0,0,135+(right?-nuba-nubw/2:nuba+nubw/2)])translate([nubr,0,0])nubshape(w=w);
            rotate([0,0,135+(right?-nuba-nubw:nuba+nubw)])translate([nubr,0,0])nubshape(w=w);

        }
    }
}

module nubtrack(right=0,w=0)
{
    difference()
    {
        rotate([0,90,0])rotate_extrude($fn=100)translate([nubr,0,0])projection()rotate([90,0,0])nubshape(w=w);
        rotate([0,90,0])rotate([0,0,(right?180:0)+135+(right?nuba:-nuba)])translate([-H/2,0,-H/2])cube([H,H,H]);
    }
    mirror([1,0,0])
    {
        nub(1-right,w=w);
        rotate([180,0,0])nub(1-right,w=w);
    }
}

module side(right=0,text="")
{ // Create one of the sides
    difference()
    {
        rotate([0,0,A])solid(right=right);    // The solid shape of the side
        union()
        { // Remove the inside
            rotate([0,0,A])difference()
            {
                hull()      // The inside, created using two offset for champhered top/bottom for support
                {
                    solid(wall*2,wall,right=right);
                    solid(wall,wall*2,right=right);
                }
                // Other parts added to interior as not removed from solid
                rotate([0,0,-A])
                {
                    // Support for the cut at the top for bridging
                    hull()
                    {
                        translate([-L,T/sqrt(2)+wall,H/2-wall])cube([L*2,Q*4,Q]);
                        translate([-L,T/sqrt(2)+wall+Q*2,H/2-wall-Q*2])cube([L*2,Q*2,Q]);
                    }
                    hull()
                    {
                        translate([-L,-T/sqrt(2)-Q*2+wall-Q*2,H/2-wall-Q])cube([L*2,Q*4,Q]);
                        translate([-L,-T/sqrt(2)-Q*2+wall-Q,H/2-wall-Q*2])cube([L*2,Q*2,Q]);
                    }
                   // Inside for nub track for extra support
                    translate([-wall-T/2,0,0])nubtrack(right,w=T*sqrt(2)+Q*3);
                }
            }
        }
        // Other parts removed from main shape
        // The main slice separating the flap
        translate([0,H/2,0])rotate([45,0,0])cube([W*2,T,H*sqrt(2)+T*2],center=true);
        // Space for nub if it goes to far
        intersection()
        {
            translate([-wall*2-T/2,H-nubd2*sqrt(2),-H/2])rotate([45,0,0])cube([wall*2+T,nubd2,H*sqrt(2)+T*2]);
            translate([-T/2,0,0])nub(right,w=2*T*sqrt(2));
        }
        // Thin edges of central join as that is where is sticks
        translate([-T/2-(wall-Q)/sqrt(2)-T,H,-H/2])rotate([45,0,0])rotate([0,0,45])translate([0,-wall,wall*sqrt(2)])cube([wall,wall,(H-wall*2)*sqrt(2)]);
        // Nub track
        translate([-T/2,0,0])nubtrack(right=right,w=T*sqrt(2));
        // Hinge holes in flap
        translate([-x,hy,0])for(m=[0:1])mirror([m,0,0])
        {
            translate([-hingew/2-T*2-hingeh-T*sqrt(T),0,hingeh/2-H/2])rotate([0,90,0])cylinder(h=hingeh*3/2+T+T*sqrt(2),d=hingeh,$fn=50);
            translate([-hingew/2-hingeh/2-2*T*sqrt(2),0,hingeh/2-H/2])rotate([0,90,0])cylinder(h=hingeh/2+2*sqrt(2)*T,d=hingeh+T*2,$fn=50);
            hull()
            {
                translate([-hingew/2-hingeh/2-2*T*sqrt(2),hingeh/2-T,-H/2-T])cube([hingeh/2+2*sqrt(2)*T,T,wall+T*2]);
                translate([-hingew/2-hingeh/2-2*T*sqrt(2),H-hy+T,-H/2-T])rotate([45,0,0])cube([hingeh/2+2*sqrt(2)*T,T,sqrt(2)*wall+T*2]);
            }
        }
        // Join
        if(right)translate([-wall-T,0,0])rotate([0,90,0])cylinder(r=joinr+T+joint,h=wall+T,$fn=100);
    }
    // Other parts added to main shape
    // Clasp to help align the flap
    difference()
    {
        hull()
        {
            translate([-T/2-wall*2-T,(nubr+nubd2/2+Q+T/2+T)/sqrt(2),-H/2])cube([wall+T*2,H/3,wall]);
            translate([-T/2-wall*2-T,(nubr+nubd2/2+Q+T/2+T)/sqrt(2)+H,-H/2+H])cube([wall+T*2,H/3,wall]);
        }
        translate([-T/2-wall-T,H-T/sqrt(2),-H/2])rotate([45,0,0])cube([wall+T*2,H*2,H*2]);
        translate([-T/2-wall*2-T*2,H,-H/2])rotate([45,0,0])translate([0,H/4,0])cube([wall+T*3,H*2,H*2]);
    }
    // Hinge
    translate([-x,hy,0])for(m=[0:1])mirror([m,0,0])
    {
        difference()
        {
            union()
            {
               translate([-hingew/2-hingeh/2-T*sqrt(2)-hingeh/2-T*sqrt(2),0,hingeh/2-H/2])hull()
               {
                   rotate([0,90,0])cylinder(h=hingeh/2,d=hingeh,$fn=50);
                   translate([-1,-hingeh/2,-hingeh/2])cube([hingeh/2+1,hingeh,hingeh/2]);
               }
               translate([-hingew/2,0,hingeh/2-H/2])hull()
               {
                   rotate([0,90,0])cylinder(h=hingeh/2,d=hingeh,$fn=50);
                   translate([0,-hingeh/2,-hingeh/2])cube([hingeh/2+1,hingeh,hingeh/2]);
               }
            }
            translate([-hingew/2-hingeh/2-T*sqrt(2)-hingeh/2-T*sqrt(2),0,hingeh/2-H/2])rotate([0,90,0])cylinder(h=hingeh/2,r2=hingeh/2,r1=0,$fn=50);
            translate([-hingew/2,0,hingeh/2-H/2])rotate([0,90,0])cylinder(h=hingeh/2,r1=hingeh/2,r2=0,$fn=50);
        }
        translate([-hingew/2-sqrt(2)*T,0,hingeh/2-H/2])rotate([0,90,0])cylinder(h=hingeh/2,r1=hingeh/2,r2=0,$fn=50);
        translate([-hingew/2-sqrt(2)*T-hingeh,0,hingeh/2-H/2])rotate([0,90,0])cylinder(h=hingeh/2,r2=hingeh/2,r1=0,$fn=50);
        hull()
        {
            translate([-hingew/2-hingeh/2-T*sqrt(2),0,hingeh/2-H/2])rotate([0,90,0])cylinder(h=hingeh/2,d=hingeh,$fn=50);
            translate([-hingew/2-hingeh/2-T*sqrt(2),-hingeh*2,-H/2])cube([hingeh/2,T,wall]);
        }
    }
    // Join
   if(!right)
    {
        difference()
        {
            r2=min(sqrt(H/2*H)/2,nubr-nubd2/2-Q*3/2-T*sqrt(2)/2)-T;
            rotate([0,90,0])
            {
                translate([0,0,-T])cylinder(r=joinr,h=wall+T*3+G);
                translate([0,0,G])cylinder(r=joinr,h=wall+T,$fn=100);
                translate([0,0,wall+T*3/2+G])cylinder(r=r2,r2=r2-wall,h=wall*2);
                translate([0,0,-T/2])cylinder(r1=min(r2+min(wall,G),nubr-nubd2/2-T/2),r2=r2,h=G);
                translate([0,0,-wall*2-T/2])cylinder(r2=r2,r=r2-wall,h=wall);
            }
            translate([-T/2+G,-joinr*2,-joinr])rotate([0,90-S,0])cube([H,H,H]);
            translate([-T/2+G,-joinr*2,-H-joinr])cube([H,H,H]);
            h=tan(S)*(wall+2*T);
            x=sqrt(joinr*joinr-(joinr-h)*(joinr-h));
            for(m=[0:1])mirror([0,m,0])translate([wall+T*3/2+G,x,-(H/2-T)/2+h])rotate([S-90,0,0])cube([H,H,H]);
        }
    }
    // Text
    if(text!="")translate([-(x+sqrt(W/2*W/2-H/2*H/2))/2,W/4,H/2-T])mirror([right,0,0])minkowski()
    {
        cylinder(r1=fontthickness/2,r2=0,h=fontthickness,$fn=4);
        linear_extrude(height=T)text(text,font=font,size=fontheight,halign="center",valign="baseline");
    }
    // Nub
    translate([-T/2,0,0])nub(right);
}

module heart(l="",r="")
{
    translate([0,0,H/2])
    {
        translate([-G/2,0,0])side(0,l);
        translate([G/2,0,0])mirror([1,0,0])side(1,r);
    }
    
}
