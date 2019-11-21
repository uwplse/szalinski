// This file is licensed under the following license:
// https://creativecommons.org/licenses/by-nc-nd/3.0/legalcode
// https://creativecommons.org/licenses/by-nc-nd/3.0/

// (c) 2018 Rainer Schlosshan


// preview[view:south west, tilt:top diagonal]


/* [General Settings] */
// The Diameter of your cable reel
ReelDiameter=40;
Height =ReelDiameter+1;
SizeX =  ReelDiameter+1;
// The width of your cable reel
ReelWidth=20;
SizeY= ReelWidth+1;

// Number of Columns
NumY = 4; // [1:15] 
// Number of Rows 
NumX = 1; // [1:15] 
// Compartment Type 
CompartmentType=12; // [0:Box,11:horizontal cylinder (X-Axis),12:horizontal cylinder (Y-Axis)]
// [0:Box,1:Cylinder,3:Triangle,4:RotatedRectangle,5:Pentagon5,6:Hexagon6,7:Heptagon7,8:Octagon8,9:Nonagon9,10:Decagon10,11:hoizontal cylinder (X-Axis),12:hoizontal cylinder (Y-Axis)]


//The offset in mm for the dispenser hole from the center
HoleCenterOffset=10;
MiddleCutoutVerticalOffset=HoleCenterOffset;

// the size of the dispenser hole
HoleSize=23; //[10:large,20:medium,23:small,30:tiny]
HoleSizeDivider =HoleSize ; 



/* [Text] */
// Put your text here
text="cable";
//Font to be used ( see https://fonts.google.com to choose from all of them )
font="exo"; //[<none>,Arial,ABeeZee,Abel,Abril Fatface,Aclonica,Acme,Actor,Adamina,Advent Pro,Aguafina Script,Akronim,Aladin,Aldrich,Alef,Alegreya,Alegreya Sans,Alegreya Sans SC,Alegreya SC,Alex Brush,Alfa Slab One,Alice,Alike,Alike Angular,Allan,Allerta,Allerta Stencil,Allura,Almendra,Almendra Display,Almendra SC,Amarante,Amaranth,Amatic SC,Amethysta,Amiri,Anaheim,Andada,Andika,Angkor,Annie Use Your Telescope,Anonymous Pro,Antic,Antic Didone,Antic Slab,Anton,Arapey,Arbutus,Arbutus Slab,Architects Daughter,Archivo Black,Archivo Narrow,Arimo,Arizonia,Armata,Artifika,Arvo,Asap,Asset,Astloch,Asul,Atomic Age,Aubrey,Audiowide,Autour One,Average,Average Sans,Averia Gruesa Libre,Averia Libre,Averia Sans Libre,Averia Serif Libre,Bad Script,Balthazar,Bangers,Basic,Battambang,Baumans,Bayon,Belgrano,Belleza,BenchNine,Bentham,Berkshire Swash,Bevan,Bigelow Rules,Bigshot One,Bilbo,Bilbo Swash Caps,Bitter,Black Ops One,Bokor,Bonbon,Boogaloo,Bowlby One,Bowlby One SC,Brawler,Bree Serif,Bubblegum Sans,Bubbler One,Buda,Buenard,Butcherman,Butterfly Kids,Cabin,Cabin Condensed,Cabin Sketch,Caesar Dressing,Cagliostro,Calligraffitti,Cambay,Cambo,Candal,Cantarell,Cantata One,Cantora One,Capriola,Cardo,Carme,Carrois Gothic,Carrois Gothic SC,Carter One,Caudex,Cedarville Cursive,Ceviche One,Changa One,Chango,Chau Philomene One,Chela One,Chelsea Market,Chenla,Cherry Cream Soda,Cherry Swash,Chewy,Chicle,Chivo,Cinzel,Cinzel Decorative,Clicker Script,Coda,Coda Caption,Codystar,Combo,Comfortaa,Coming Soon,Concert One,Condiment,Content,Contrail One,Convergence,Cookie,Copse,Corben,Courgette,Cousine,Coustard,Covered By Your Grace,Crafty Girls,Creepster,Crete Round,Crimson Text,Croissant One,Crushed,Cuprum,Cutive,Cutive Mono,Damion,Dancing Script,Dangrek,Dawning of a New Day,Days One,Dekko,Delius,Delius Swash Caps,Delius Unicase,Della Respira,Denk One,Devonshire,Dhurjati,Didact Gothic,Diplomata,Diplomata SC,Domine,Donegal One,Doppio One,Dorsa,Dosis,Dr Sugiyama,Droid Sans,Droid Sans Mono,Droid Serif,Duru Sans,Dynalight,Eagle Lake,Eater,EB Garamond,Economica,Ek Mukta,Electrolize,Elsie,Elsie Swash Caps,Emblema One,Emilys Candy,Engagement,Englebert,Enriqueta,Erica One,Esteban,Euphoria Script,Ewert,Exo,Exo 2,Expletus Sans,Fanwood Text,Fascinate,Fascinate Inline,Faster One,Fasthand,Fauna One,Federant,Federo,Felipa,Fenix,Finger Paint,Fira Mono,Fira Sans,Fjalla One,Fjord One,Flamenco,Flavors,Fondamento,Fontdiner Swanky,Forum,Francois One,Freckle Face,Fredericka the Great,Fredoka One,Freehand,Fresca,Frijole,Fruktur,Fugaz One,Gabriela,Gafata,Galdeano,Galindo,Gentium Basic,Gentium Book Basic,Geo,Geostar,Geostar Fill,Germania One,GFS Didot,GFS Neohellenic,Gidugu,Gilda Display,Give You Glory,Glass Antiqua,Glegoo,Gloria Hallelujah,Goblin One,Gochi Hand,Gorditas,Goudy Bookletter 1911,Graduate,Grand Hotel,Gravitas One,Great Vibes,Griffy,Gruppo,Gudea,Gurajada,Habibi,Halant,Hammersmith One,Hanalei,Hanalei Fill,Handlee,Hanuman,Happy Monkey,Headland One,Henny Penny,Herr Von Muellerhoff,Hind,Holtwood One SC,Homemade Apple,Homenaje,Iceberg,Iceland,IM Fell Double Pica,IM Fell Double Pica SC,IM Fell DW Pica,IM Fell DW Pica SC,IM Fell English,IM Fell English SC,IM Fell French Canon,IM Fell French Canon SC,IM Fell Great Primer,IM Fell Great Primer SC,Imprima,Inconsolata,Inder,Indie Flower,Inika,Irish Grover,Istok Web,Italiana,Italianno,Jacques Francois,Jacques Francois Shadow,Jim Nightshade,Jockey One,Jolly Lodger,Josefin Sans,Josefin Slab,Joti One,Judson,Julee,Julius Sans One,Junge,Jura,Just Another Hand,Just Me Again Down Here,Kalam,Kameron,Kantumruy,Karla,Karma,Kaushan Script,Kavoon,Kdam Thmor,Keania One,Kelly Slab,Kenia,Khand,Khmer,Khula,Kite One,Knewave,Kotta One,Koulen,Kranky,Kreon,Kristi,Krona One,La Belle Aurore,Laila,Lakki Reddy,Lancelot,Lateef,Lato,League Script,Leckerli One,Ledger,Lekton,Lemon,Liberation Sans,Libre Baskerville,Life Savers,Lilita One,Lily Script One,Limelight,Linden Hill,Lobster,Lobster Two,Londrina Outline,Londrina Shadow,Londrina Sketch,Londrina Solid,Lora,Love Ya Like A Sister,Loved by the King,Lovers Quarrel,Luckiest Guy,Lusitana,Lustria,Macondo,Macondo Swash Caps,Magra,Maiden Orange,Mako,Mallanna,Mandali,Marcellus,Marcellus SC,Marck Script,Margarine,Marko One,Marmelad,Martel Sans,Marvel,Mate,Mate SC,Maven Pro,McLaren,Meddon,MedievalSharp,Medula One,Megrim,Meie Script,Merienda,Merienda One,Merriweather,Merriweather Sans,Metal,Metal Mania,Metamorphous,Metrophobic,Michroma,Milonga,Miltonian,Miltonian Tattoo,Miniver,Miss Fajardose,Modak,Modern Antiqua,Molengo,Molle,Monda,Monofett,Monoton,Monsieur La Doulaise,Montaga,Montez,Montserrat,Montserrat Alternates,Montserrat Subrayada,Moul,Moulpali,Mountains of Christmas,Mouse Memoirs,Mr Bedfort,Mr Dafoe,Mr De Haviland,Mrs Saint Delafield,Mrs Sheppards,Muli,Mystery Quest,Neucha,Neuton,New Rocker,News Cycle,Niconne,Nixie One,Nobile,Nokora,Norican,Nosifer,Nothing You Could Do,Noticia Text,Noto Sans,Noto Serif,Nova Cut,Nova Flat,Nova Mono,Nova Oval,Nova Round,Nova Script,Nova Slim,Nova Square,NTR,Numans,Nunito,Odor Mean Chey,Offside,Old Standard TT,Oldenburg,Oleo Script,Oleo Script Swash Caps,Open Sans,Open Sans Condensed,Oranienbaum,Orbitron,Oregano,Orienta,Original Surfer,Oswald,Over the Rainbow,Overlock,Overlock SC,Ovo,Oxygen,Oxygen Mono,Pacifico,Paprika,Parisienne,Passero One,Passion One,Pathway Gothic One,Patrick Hand,Patrick Hand SC,Patua One,Paytone One,Peddana,Peralta,Permanent Marker,Petit Formal Script,Petrona,Philosopher,Piedra,Pinyon Script,Pirata One,Plaster,Play,Playball,Playfair Display,Playfair Display SC,Podkova,Poiret One,Poller One,Poly,Pompiere,Pontano Sans,Port Lligat Sans,Port Lligat Slab,Prata,Preahvihear,Press Start 2P,Princess Sofia,Prociono,Prosto One,PT Mono,PT Sans,PT Sans Caption,PT Sans Narrow,PT Serif,PT Serif Caption,Puritan,Purple Purse,Quando,Quantico,Quattrocento,Quattrocento Sans,Questrial,Quicksand,Quintessential,Qwigley,Racing Sans One,Radley,Rajdhani,Raleway,Raleway Dots,Ramabhadra,Ramaraja,Rambla,Rammetto One,Ranchers,Rancho,Ranga,Rationale,Ravi Prakash,Redressed,Reenie Beanie,Revalia,Ribeye,Ribeye Marrow,Righteous,Risque,Roboto,Roboto Condensed,Roboto Slab,Rochester,Rock Salt,Rokkitt,Romanesco,Ropa Sans,Rosario,Rosarivo,Rouge Script,Rozha One,Rubik Mono One,Rubik One,Ruda,Rufina,Ruge Boogie,Ruluko,Rum Raisin,Ruslan Display,Russo One,Ruthie,Rye,Sacramento,Sail,Salsa,Sanchez,Sancreek,Sansita One,Sarina,Sarpanch,Satisfy,Scada,Scheherazade,Schoolbell,Seaweed Script,Sevillana,Seymour One,Shadows Into Light,Shadows Into Light Two,Shanti,Share,Share Tech,Share Tech Mono,Shojumaru,Short Stack,Siemreap,Sigmar One,Signika,Signika Negative,Simonetta,Sintony,Sirin Stencil,Six Caps,Skranji,Slabo 13px,Slabo 27px,Slackey,Smokum,Smythe,Sniglet,Snippet,Snowburst One,Sofadi One,Sofia,Sonsie One,Sorts Mill Goudy,Source Code Pro,Source Sans Pro,Source Serif Pro,Special Elite,Spicy Rice,Spinnaker,Spirax,Squada One,Sree Krushnadevaraya,Stalemate,Stalinist One,Stardos Stencil,Stint Ultra Condensed,Stint Ultra Expanded,Stoke,Strait,Sue Ellen Francisco,Sunshiney,Supermercado One,Suranna,Suravaram,Suwannaphum,Swanky and Moo Moo,Syncopate,Tangerine,Taprom,Tauri,Teko,Telex,Tenali Ramakrishna,Tenor Sans,Text Me One,The Girl Next Door,Tienne,Timmana,Tinos,Titan One,Titillium Web,Trade Winds,Trocchi,Trochut,Trykker,Tulpen One,Ubuntu,Ubuntu Condensed,Ubuntu Mono,Ultra,Uncial Antiqua,Underdog,Unica One,UnifrakturCook,UnifrakturMaguntia,Unkempt,Unlock,Unna,Vampiro One,Varela,Varela Round,Vast Shadow,Vesper Libre,Vibur,Vidaloka,Viga,Voces,Volkhov,Vollkorn,Voltaire,VT323,Waiting for the Sunrise,Wallpoet,Walter Turncoat,Warnes,Wellfleet,Wendy One,Wire One,Yanone Kaffeesatz,Yellowtail,Yeseva One,Yesteryear,Zeyada]
FontSize=10; //[2,3,4,5,6,7,8,9,10,12,15,17,20,25,30,40,50]
Bold=false;
Italic=false;

//This parameter defines the thickness of the text. Negative values imprint text to the box, positive text will be added on top off the walls
FontThickness=-0.3; //[-5,-4,-3,-2,-1.5,-1.3,-1,-0.7,-0.5,-0.4,-0.3,-0.2,-0.1,0,0.1,0.2,0.3,0.4,0.5,0.7,1,1.3,1.5,2,3,4,5]
// Location of the text set all to none to disable text
X_Axis_Location=2; // [0:None,1:On 1 Side,2:On both Sides]
// Location of the text
Y_Axis_Location=0; // [0:None,1:On 1 Side,2:On both Sides]
// Location of the text on the lid
Lid_Location=0; // [0:None,1:Negative imprint on top of lid,2:Negative imprint inside of lid,3:both]

// Rotate the text by this angle 
TextRotation=0; // positive values=clockwise, negative values=counter clockwise

// Allignment should only be changed wen Rotation=0
HorizontalAllignment="left"; //[left,center,right]
VerticalAllignment="bottom"; //[top,center,bottom]

// Add an additional horizontal offset (mm)
TextHorizontalOffset=0;
TextVerticalOffset=0;


/* [Lid] */
// Which part(s) would you like to create?
parts = "both"; // [first:Box Only,second:lid only,both:box and lid]


// Select the type of lid you you like to create?
LidType= "Notched"; // ["None":No Lid,"SlideOver":SlideOver-lid that slides over outside walls of the box,"Notched":Notched-lid that slides over a "notch" w.o. incr. width/length]

// The inner height of your lid
LidHeight=4;
// The tolerance to add to the lid in order to fit
LidTolerance=0.3;
// The Thickness of the Lid walls
LidT =1.5; // [0,0.1,0.2,0.3,0.4,0.5,0.6,0.8,1,1.5,2,2.5,3,3.5,4,4.5,5,6,7,8,9,10,11,12,13,14,15]
// Do you want cutouts on the lid side walls for easier removal?
LidCutout = 0; //[0:No,1:On X-Axis,2:On Y-Axis,3:On Both Sides]

/* [Magnetic Lid] */
// Do you want to add Holes for Magnet closing mechanism for the lid?
LidMagnet = 0; //[0:No,1:Yes]
// Diameter of the optional Magnet holes
LidMagnetDia=6.1;
// Depth of the optional Magnet holes
LidMagnetDepth=1.1;

/* [Rounded Edges] */
// Radius in mm for rounding of outside edges? 0 disables rounding
OuterEdgesRadius=1; 
// Radius in mm for rounded edges in the compartments?  0 disables rounding
InnerEdgesRadius=1; 
// The number of segments a single circle is being rendered from. The higher this number is the better the quiality of especially bigger roundings will be, but increasing this will have a performance impact when creating /previewing your object
CircleSegments=75; 

/* [Advanced Settings] */
// Depth of an additional cutout over the full inner structure. (0=the compartments and outer Wall use the same height)
RecessInnerPart=15;
// The Thickness of the outer walls in mm
WallT =1.5; 
// The Thickness of the inner walls in mm(compartment separators)
SeparatorT =1.5; 
// The Thickness of the Bottom in mm
BottomT =1.5; 



// ignore variable values below
/* [Hidden] */
// Do you want a cutout on the top edges of the box?
TopCutout =0; // [0:None,1:Round On X Axis,2:Round On Y Axis,3:Round on X&Y Axis,7:Round Only 1 Outside on X Axis,8:Round Only 1 Outside on Y Axis,9:Round Only 1 Outside on X&Y Axis,4:Finger Slots All Sides,5:Finger Slots on Y Axis,6:Finger Slots on X Axis]
// Enable this parameter to place the fingercoutouts ony on the outside walls
FingerCutoutCount = 1; //[0:All,1:Only in outside walls,2:Only in one one outer wall]
// Do you want a cutout in the middle of the box per Row?
MiddleCutout =1; // [0:None,1:Round on X Axis,4:Round on Y Axis,2:Round Both outer sides,3:Diamond]
// Do you want a cutout on the bottom side of the box?
BottomCutout = 0; // [0:None,1:Round On X Axis,2:Round On Y Axis,3:Hole on bottom side of each compartment,4:4mmCylinderPositive,5:6mmCylinderPositive,6:8mmCylinderPositive,7:10mmCylinderPositive]
//* [Bottom Magnets] */
// The number of magnets added to each compartment
MagnetCount=0; //[0,1,2,4]
//The Diameter of the Magnets (Add some Tolerance!) 
MagnetDiameter=8.2; 
//The Height of the Magnets (Add some Tolerance!) (BottomT will also be increased by this value)
MagnetHeight=3; 
// Do you want a perforated Lid?
PerforatedLid=0;//[0:No,1:Yes]

// Quality Settings
$fa=360/CircleSegments;//360/$fa = Max Facets Number
$fs=0.2; //prefered facet length 


print_part();
module print_part() {
    /*if (parts == "first") {
		makebox();
	} else if (parts == "second") {
		lidcreator();
	} else if (parts == "both") {
		both();
	}*/
    part=(parts=="first"
        ?"box"
        :(parts=="second"
            ?"lid"
            :"both")
        );
    
    translate([0, 0, 0]) 
	RainersBoxCreator(
        _part=part
        ,_LidType=LidType
        ,_Height=Height
        ,_SizeY=SizeY
        ,_SizeX=SizeX
        ,_WallT=WallT+(LidMagnet?LidMagnetDia-InnerEdgesRadius:0)
        ,_BottomT=BottomT
        ,_SeparatorT=SeparatorT
        ,_NumX=NumX
        ,_NumY=NumY
        ,_TopCutout=TopCutout
        ,_MiddleCutout=MiddleCutout
        ,_MiddleCutoutVerticalOffset=MiddleCutoutVerticalOffset
        ,_BottomCutout=BottomCutout
        ,_HoleSizeDivider=HoleSizeDivider
        ,_CompartmentType=CompartmentType
        ,_InnerRadius=InnerEdgesRadius
        ,_OuterRadius=OuterEdgesRadius
        // Bottom Magnets for compartments
        ,_MagnetDiameter=MagnetDiameter
        ,_MagnetHeight=MagnetHeight
        // Generral Lid Parameters
        ,_MagnetCount=MagnetCount
        ,_LidT=LidT
        ,_LidHeight=LidHeight
        ,_LidTolerance=LidTolerance
        ,_LidMagnet=LidMagnet
        ,_LidMagnetDia=LidMagnetDia
        ,_LidMagnetDepth=LidMagnetDepth
        ,_LidMagnetAddDist=0
        ,_LidCutout=0
        ,_RecessDepth=RecessInnerPart
        ,_color="DeepSkyBlue"
        ,_Text=text
        ,_Font=font
        ,_FontSize=FontSize
        ,_StyleBold=Bold
        ,_StyleItalic=Italic
        ,_FontThickness=FontThickness
        ,_TextLocationX=X_Axis_Location
        ,_TextLocationY=Y_Axis_Location
        ,_TextLocationLid=Lid_Location
        ,_TextRotation=TextRotation
        ,_TextHAllign=HorizontalAllignment
        ,_TextVAllign=VerticalAllignment
        ,_TextHOffset=TextHorizontalOffset
        ,_TextVOffset=TextVerticalOffset
        //,_CompInc=CompInc

	);
}


/************************************************ Rainer's Modules below *********************************************/
// Version 5.1 2018-12-27
module RainersBoxCreator(
,_part="box" // box,lid
,_DebugMsg=""
,_LidType="Notched" //"SlideOver" (over the whole box) or "Notched"(with groove on top)
, _Height=30
,_SizeY=20
,_SizeX=40
,_WallT=1.5
,_BottomT=1.5
,_SeparatorT=1.5
,_NumX =2
,_NumY =3
,_TopCutout=0
,_MiddleCutout=0
,_MiddleCutoutVerticalOffset=0
,_BottomCutout=0
,_HoleSizeDivider=4
,_CompartmentType=0
,_InnerRadius=1
,_OuterRadius=1
// Bottom Magnets for compartments
,_MagnetDiameter=8.2
,_MagnetHeight=3
,_MagnetCount=1
// Generral Lid Parameters
,_LidT=1.5
,_LidTolerance=0.2
,_LidHeight=5
//specific to magnetic lids:
,_LidMagnet=0
,_LidMagnetDia=6.2
,_LidMagnetDepth=1.1
,_LidMagnetAddDist=0
,_color="yellow"
 ,_Text=""
 ,_Font=""
 ,_FontSize=15
 ,_FontThickness=0
 ,_StyleBold=false
 ,_StyleItalic=false
,_IgnoreValidityCheck=false
// Text Parameters
,_TextLocationX=2
,_TextLocationY=2
,_TextLocationLid=0
,_TextRotation=0
,_TextHAllign="centered"
,_TextVAllign="centered"
,_TextHOffset=0
,_TextVOffset=0
,_CompInc=0
,_CompInc=[
            [0,0,0,0,0,0,0,0,0,0]
            ,[0,0,0,0,0,0,0,0,0,0]
            ,[0,0,0,0,0,0,0,0,0,0]
            ,[0,0,0,0,0,0,0,0,0,0]
            ,[0,0,0,0,0,0,0,0,0,0]
            ,[0,0,0,0,0,0,0,0,0,0]
            ,[0,0,0,0,0,0,0,0,0,0]
            ,[0,0,0,0,0,0,0,0,0,0]
            ,[0,0,0,0,0,0,0,0,0,0]
            ,[0,0,0,0,0,0,0,0,0,0]
        ]
){
    echo(str("<h2>BoxMaker called for: ",_color,",",_part,"</h2>"));
    
    if(_DebugMsg!=""){echo(str("BoxMaker Debug: ",_DebugMsg));}
      
    // ==================== Parameter Validity Checks

    
    // ---------- WallT 
    //echo("_WallT,_LidT,_LidTolerance=",_WallT,_LidT,_LidTolerance);    
    _WallT2=(_LidType=="Notched"&&_WallT<(_LidT+_LidTolerance+0.6)&&((_part=="both")||(_part=="box")||(_part=="lid"))
   
             ? // WallT willbe increased to allow minimum size of notched top 
               _LidT+_LidTolerance+0.6
             : _WallT
    );
    if(_WallT2!=_WallT){
        echo(str("Automatically adjusted WallT from ",_WallT," to ",_WallT2));    
    }
    //echo("_WallT2 after validity check=",_WallT2);
    //If Bottom Magnets are used, increase BottomT by MagnetHeight
    _BottomT2=_BottomT+(_MagnetCount==0?0:_MagnetHeight);
   
     // ---------- Outer Radius 
    _SmallestBoxEdge = min(_SizeY+_WallT2,_SizeX+_WallT2,_Height+_BottomT2);
    _OuterRadius2=(
        _CompartmentType==0||_CompartmentType>1
        ?   // For A Box compartment the maxius Radius is the smallest side length
        min(_WallT2+_InnerRadius,_OuterRadius,_SmallestBoxEdge/2-.01)
        :	// Circle Compartments
        min((_WallT2+_InnerRadius/2),_OuterRadius)
    );
     if(_OuterRadius2<_OuterRadius)echo("<b><font color='orange'>Automatically adjusted OuterRadius from ",_OuterRadius," to ",_OuterRadius2);
   
    // ---------- Inner Radius 
    _InnerRadius2=min(_InnerRadius,min(_SizeX,_SizeY,_Height*2)/2-0.01);
    if(_InnerRadius2!=_InnerRadius)echo("<b><font color='orange'>Automatically adjusted InnerRadius from ",_InnerRadius," to ",_InnerRadius2);
    
    _BoxSizeX=2*_WallT2+(_NumX-1)*(_SizeX+_SeparatorT)+_SizeX;
    _BoxSizeY=2*_WallT2+(_NumY-1)*(_SizeY+_SeparatorT)+_SizeY;
    _BoxSizeZ=_BottomT2 +_Height;      

  
    // Prepare font style
    _FontStr=str(_Font,":style=",(_StyleBold?"Bold ":" "),(_StyleItalic?"Italic":""));
     
    
     //=========================== LidMaker
    if(_part=="lid"){
        MakeLid();
    }
    if(_part=="box"){
        translate([0, 0, 0]) 
        MakeBox();
    }
    if(_part=="both"){
        MakeBox();
        translate([
            _NumX * (_SizeX) + (_NumX-1)*_SeparatorT +2*_WallT2+10
            , 0
            , 0
        ]) 
        MakeLid();
    }
    
   module MakeBox(){
        RainersBoxCreator(
        ,_part="recursion box"
        ,_DebugMsg="box!"
        ,_Height=_Height
        ,_SizeY=_SizeY
        ,_SizeX=_SizeX
        ,_WallT=_WallT2
        ,_BottomT=_BottomT
        ,_SeparatorT=_SeparatorT
        ,_NumX=_NumX
        ,_NumY=_NumY
        ,_TopCutout=_TopCutout
        ,_MiddleCutout=_MiddleCutout
        ,_MiddleCutoutVerticalOffset=_MiddleCutoutVerticalOffset
        ,_BottomCutout=_BottomCutout
        ,_HoleSizeDivider=_HoleSizeDivider
        ,_CompartmentType=_CompartmentType
        ,_InnerRadius=_InnerRadius
        ,_OuterRadius=_OuterRadius
        ,_MagnetDiameter=_MagnetDiameter
        ,_MagnetHeight=_MagnetHeight
        ,_MagnetCount=_MagnetCount
        // Generral Lid Parameters
        ,_LidHeight=_LidHeight
        ,_LidType=_LidType
        ,_LidTolerance=_LidTolerance
        //specific to magnetic lids:
        ,_LidMagnet=_LidMagnet
        ,_LidMagnetDia=_LidMagnetDia
        ,_LidMagnetDepth=_LidMagnetDepth
        ,_LidMagnetAddDist=0
        ,_LidCutout=0
        ,_RecessDepth=_RecessDepth
        ,_color="DeepSkyBlue"
         ,_Text=_Text
        ,_Font=_Font
        ,_FontSize=_FontSize
        ,_StyleBold=_StyleBold
        ,_StyleItalic=_StyleItalic
        ,_FontThickness=FontThickness
        ,_TextLocationX=_TextLocationX
        ,_TextLocationY=_TextLocationY
        ,_TextLocationLid=_TextLocationLid
        ,_TextRotation=_TextRotation
        ,_IgnoreValidityCheck=false
        ,_TextHAllign=_TextHAllign
        ,_TextVAllign=_TextVAllign
        ,_TextHOffset=_TextHOffset
        ,_TextVOffset=_TextVOffset
        ,_CompInc=_CompInc
	);
   } 
   module MakeLid(){
        //_LidT=_WallT2;
        // Increase Lid thickness depending on magnet size 
        LidTAddHeight=(
            _LidMagnet==1
            ? (LidT < (_LidMagnetDepth+1)
            ?_LidMagnetDepth+1-LidT
            :0)
            :0
        );
	
        //Caclulate the innerSize of the lid & real box height
        //  LidSizeX = (_NumX-1)*_SeparatorT + _NumX*_SizeX  +2*_WallT2+_LidTolerance;
        //  LidSizeY = (_NumY-1)*_SeparatorT + _NumY*_SizeY  +2*_WallT2+_LidTolerance;
        LidSizeX=_NumX*SizeX+(_NumX-1)*SeparatorT+2*_WallT2;//-2*_LidT;
        LidSizeY=_NumY*SizeY+(_NumY-1)*SeparatorT+2*_WallT2;//-2*_LidT;
      
        RealBoxHeight=LidHeight*2 +_LidT+LidTAddHeight;
	
        // Calculate the "real" possible inner radius
        SmallerSize=min(_SizeX,_SizeY,_Height*2);
        InnerEdgesRadius2=min(_InnerRadius,SmallerSize/2-0.01);

        SmallestBoxEdge = min(_SizeY+_WallT2,_SizeX+_WallT2,_Height+_BottomT);
        OuterEdgesRadius2=(
            _CompartmentType==0||_CompartmentType>1
            ?   // For A Box compartment the maxius Radius is the smallest side length
            min(_WallT2+InnerEdgesRadius2,_OuterRadius,SmallestBoxEdge/2-.01)
            :   // Circle Compartments
            min(InnerEdgesRadius2/2,_OuterRadius)
        );
        /*echo("LidMaker _LidType=",_LidType);
        echo("LidMaker InnerEdgesRadius2=",InnerEdgesRadius2);
        echo("LidMaker OuterEdgesRadius2=",OuterEdgesRadius2); 
        echo("!!LidMaker _LidT=",_LidT); 
        echo("!!LidMaker _LidHeight=",_LidHeight);*/
        
        difference(){
            union(){
            if(_LidType=="Notched"){
            difference(){
            // Create the box 2x as high as required
                RainersBoxCreator(
                    _part="recursion notchedlid"
                    ,_LidType="NotchedLid"
                    ,_DebugMsg="Notched Lid!"
                    ,_Height=(_LidHeight+LidTAddHeight)*2
                    ,_SizeY=_NumY*SizeY+(_NumY-1)*SeparatorT+2*_WallT2-2*_LidT+_LidTolerance
                    ,_SizeX=_NumX*SizeX+(_NumX-1)*SeparatorT+2*_WallT2-2*_LidT+_LidTolerance
                    ,_WallT=_LidT-_LidTolerance/2
                    ,_BottomT=_LidT+LidTAddHeight//BottomT
                    ,_SeparatorT=_SeparatorT
                    ,_NumX=1,_NumY=1
                    ,_TopCutout=0
                    ,_MiddleCutout=0
                    ,_MiddleCutoutVerticalOffset=0
                    ,_BottomCutout=0
                    ,_HoleSizeDivider=_HoleSizeDivider
                    ,_CompartmentType=0
                    ,_InnerRadius=_OuterRadius2
                    ,_OuterRadius=_OuterRadius2
                    ,_MagnetDiameter=0
                    ,_MagnetHeight=0
                    ,_MagnetCount=0
                    ,_LidT=_LidT
                    ,_LidTolerance=_LidTolerance
                    ,_LidMagnet=_LidMagnet
                    ,_LidMagnetDia=_LidMagnetDia
                    ,_LidMagnetDepth=RealBoxHeight-_LidT+LidTAddHeight+_LidMagnetDepth
                    ,_LidMagnetAddDist=_LidT+_LidTolerance/2
                    ,_RecessDepth=0
                    ,_LidSHeight=0  // Height "slide" over portion of the lid
                    ,_LidST=0        // Thickness of the Slide over lid wall
                    ,_LidTolerance=_LidTolerance
                    ,_IgnoreValidityCheck=true // Ignore only the _WallT2 check!
                     ,_Text=_Text
                    ,_Font=_Font
                    ,_FontSize=_FontSize
                    ,_StyleBold=_StyleBold
                    ,_StyleItalic=_StyleItalic
                    ,_FontThickness=FontThickness
                    ,_TextLocationX=_TextLocationX
                    ,_TextLocationY=_TextLocationY
                    ,_TextLocationLid=_TextLocationLid
                    ,_TextRotation=_TextRotation
                    ,_TextHAllign=_TextHAllign
                    ,_TextVAllign=_TextVAllign    
                    ,_TextHOffset=_TextHOffset
                    ,_TextVOffset=_TextVOffset

                    ,colour="yellow"
                    );
                    
                    if(PerforatedLid==1)translate([LidT,LidT,-1])
                                    // createPattern(SizeX=LidSizeX,  SizeY=LidSizeY,HoleSize=4,Height=LidT+2, NumSides=6,Dist=1,Rotate=0);
                    createPattern(SizeX=_NumX*SizeX+(_NumX-1)*SeparatorT+2*_WallT2-2*_LidT+_LidTolerance
                                ,SizeY=_NumY*SizeY+(_NumY-1)*SeparatorT+2*_WallT2-2*_LidT+_LidTolerance
                                ,HoleSize=4,Height=LidT+2
                                ,NumSides=6,Dist=1,Rotate=0);
                    //
                    // Cut upper half of double size lid (to remove upper rounding)
                    translate([ 
                             -5,-5
                            ,_LidHeight+LidT+LidTAddHeight]) 
                    cube([LidSizeX+2*LidT+10,LidSizeY+2*LidT+10, RealBoxHeight*2+WallT]);
            
                    // Add optional round Cutouts to the finished lid
                        CutRX=(LidSizeX+2*LidT)/3;
                        CutRY=(LidSizeY+2*LidT)/3;
                    //[0:No,1:On X-Axis,2:On Y-Axis,3:On Both Sides]
                    if(LidCutout==2 || LidCutout==3){ 
                        translate([//(LidSizeX+1*LidT)/2
                                    (_NumX*SizeX+(_NumX-1)*SeparatorT+2*_WallT2)/2
                                    ,-1
                                    ,_LidT+LidTAddHeight+CutRX+ (LidHeight>CutRX?LidHeight-CutRX:0)+0.01
                                ])
                    
                        rotate([-90,0,0])cylinder(r=CutRX,h=LidSizeY+2*LidT+4);
                    }
                    if(LidCutout==1 || LidCutout==3){ 
                    
                        translate([-1
                                , (_NumY*SizeY+(_NumY-1)*SeparatorT+2*_WallT2)/2//(LidSizeY+2*LidT)/2
                                ,_LidT+LidTAddHeight+CutRY+ (LidHeight>CutRY?LidHeight-CutRY:0)+0.01])
                        rotate([0,90,0])cylinder(r=CutRY,h=LidSizeX+2*LidT+4);
                    }
                }
            }
            if(_LidType=="SlideOver"){
                //echo("------SlideOverLid:_WallT,_WallT2,_LidT=",_WallT,_WallT2,_LidT);
                // Create the box 2x as high as required
                difference(){
                    RainersBoxCreator(
                        _part="recursion SlideOverLid"
                        ,_LidType="SlideOverLid"
                        ,_DebugMsg="SlideOver Lid!"
                        ,_Height=_LidHeight*2
                        ,_SizeY=LidSizeY+_LidTolerance
                        ,_SizeX=LidSizeX+_LidTolerance
                        ,_WallT=_LidT
                        ,_BottomT=_LidT+LidTAddHeight//BottomT
                        ,_SeparatorT=_SeparatorT
                        ,_NumX=1,_NumY=1
                        ,_TopCutout=0
                        ,_MiddleCutout=0
                        ,_MiddleCutoutVerticalOffset=0
                        ,_BottomCutout=0
                        ,_HoleSizeDivider=_HoleSizeDivider
                        ,_CompartmentType=0
                        ,_InnerRadius=_OuterRadius2
                        ,_OuterRadius=_OuterRadius2
                        ,_MagnetDiameter=0
                        ,_MagnetHeight=0
                        ,_MagnetCount=0
                        ,_LidTolerance=_LidTolerance
                        ,_LidT=0
                        ,_LidMagnet=_LidMagnet
                        ,_LidMagnetDia=_LidMagnetDia
                        ,_LidMagnetDepth=RealBoxHeight-_LidT-LidTAddHeight+_LidMagnetDepth
                        ,_LidMagnetAddDist=_LidT+_LidTolerance/2
                        ,_RecessDepth=0
                        ,_LidSHeight=0  // Height "slide" over portion of the lid
                        ,_LidST=0        // Thickness of the Slide over lid wall
                        ,_LidTolerance=0
                        ,_Text=_Text
                        ,_Text=_Text
                        ,_Font=_Font
                        ,_FontSize=_FontSize
                        ,_StyleBold=_StyleBold
                        ,_StyleItalic=_StyleItalic
                        ,_FontThickness=FontThickness
                        ,_TextLocationX=_TextLocationX
                        ,_TextLocationY=_TextLocationY
                        ,_TextLocationLid=_TextLocationLid
                        ,_TextRotation=_TextRotation
                        ,_TextHAllign=_TextHAllign
                        ,_TextVAllign=_TextVAllign    
                        ,_TextHOffset=_TextHOffset
                        ,_TextVOffset=_TextVOffset

                        ,colour="yellow"
                        );
                    if(PerforatedLid==1)translate([LidT,LidT,-1])
                    createPattern(SizeX=LidSizeX,SizeY=LidSizeY,HoleSize=4,Height=LidT+2,NumSides=6,Dist=1,Rotate=0);
        
                    // Cut upper half of double size lid (to remove upper rounding)
                        translate([ 
                            -5,-5
                            , _LidHeight+_LidT+LidTAddHeight]) 
                        cube([LidSizeX+2*LidT+10,LidSizeY+2*LidT+10, RealBoxHeight*2+WallT]);
                
                    // Add optional round Cutouts to the finished lid
                    CutRX=(LidSizeX+2*LidT)/3;
                    CutRY=(LidSizeY+2*LidT)/3;
                        
                    if(LidCutout==2 || LidCutout==3){ 
                        translate([(LidSizeX+2*LidT)/2
                                    ,-1
                                    ,_LidT+LidTAddHeight+CutRX+ (LidHeight>CutRX?LidHeight-CutRX:0)+0.01
                                ])
                        rotate([-90,0,0])cylinder(r=CutRX,h=LidSizeY+2*_WallT2+_LidTolerance+2*LidT+4);
                    }
                   if(LidCutout==1 || LidCutout==3){ 
                       translate([-1
                                ,(LidSizeY+2*LidT)/2
                                ,_LidT+LidTAddHeight+CutRY+ (LidHeight>CutRY?LidHeight-CutRY:0)+0.01])
                       
                        rotate([0,90,0])cylinder(r=CutRY,h=LidSizeX+2*_WallT2+_LidTolerance+2*LidT+2);
                    }
                }//Difference
            }
        }//union
 
        }
    }
        
    if(search("recursion",_part)==[0, 1, 2, 3, 0, 5, 6, 7, 8]){
        echo(str("<h3>Boxmaker making ",_part," : X=",_SizeX,",Y=",_SizeY,",Z=",_Height,",_WallT=",_WallT,",_WallT2=",_WallT2,"</h3>"));
        // prepare text variables
        //HorizontalAllignment="left"; //[left,centered,right]
        //VerticalAllignment="centered"; //[top,centered,bottom]
        RealSizeX=(_NumX * _SizeX + (_NumX-1)*_SeparatorT + 2*_WallT2);
        RealSizeY=(_NumY * _SizeY + (_NumY-1)*_SeparatorT + 2*_WallT2);
        RealSizeZ=_Height+_BottomT2;
        posZ=(_TextVAllign=="top"
                        ?RealSizeZ-_OuterRadius2-1
                        : (_TextVAllign=="bottom"
                            ?_OuterRadius2+1
                            :(RealSizeZ)/2)   );
        color(_color) difference() {union(){
            //aeussere Box
            roundedCube([
              _NumX * _SizeX + (_NumX-1)*_SeparatorT + 2*_WallT2
             ,_NumY * _SizeY + (_NumY-1)*_SeparatorT + 2*_WallT2
             ,_Height+_BottomT2]
             ,  radius=_OuterRadius2, center=false);
           // =================================== Positive Text
           if(text !="" && _FontThickness>0 && _part=="recursion box"){
            if (_TextLocationX==1|| _TextLocationX==2){
                posX=RealSizeX;
                posY=(_TextHAllign=="left"
                        ? _OuterRadius2+1
                        : (_TextHAllign=="right"
                            ?RealSizeY-_OuterRadius2-1
                            :(RealSizeY)/2)   );
                translate([posX,posY+_TextHOffset,posZ+_TextVOffset])
                rotate([90,0-_TextRotation,90]) 
                    linear_extrude(height=_FontThickness) 
                    text(_Text,size=_FontSize, font=_FontStr, spacing=1, halign = _TextHAllign,valign = _TextVAllign); 
            }
            if (_TextLocationX==2 ){
                posX=0;
                posY=(_TextHAllign=="left"
                        ? RealSizeY-_OuterRadius2-1
                        : (_TextHAllign=="right"
                            ?_OuterRadius2+1
                            :(RealSizeY)/2)  );
                translate([posX,posY-_TextHOffset,posZ++_TextVOffset])
                rotate([90,0-_TextRotation,270]) 
                    linear_extrude(height=_FontThickness) 
                    text(_Text,size=_FontSize, font=_FontStr, spacing=1, halign = _TextHAllign,valign = _TextVAllign); 
            }
            if (_TextLocationY==1|| _TextLocationY==2){
                posX=(_TextHAllign=="left"
                        ? _OuterRadius2+1
                        : (_TextHAllign=="right"
                            ?RealSizeX-_OuterRadius2-1
                            :(RealSizeX)/2)   );
                posY=0;
                translate([posX+_TextHOffset,posY,posZ+_TextVOffset])
                rotate([90,0-_TextRotation,0]) 
                    linear_extrude(height=_FontThickness) 
                    text(_Text,size=_FontSize, font=_FontStr, spacing=1, halign = _TextHAllign,valign = _TextVAllign);
            }
            if (_TextLocationY==2){
                posX=(_TextHAllign=="left"
                        ? RealSizeX-_OuterRadius2-1
                        : (_TextHAllign=="right"
                            ?_OuterRadius2
                            :(RealSizeX)/2)   );
                posY=RealSizeY;
                translate([posX-_TextHOffset,posY,posZ+_TextVOffset])
                rotate([90,0-_TextRotation,180]) 
                    linear_extrude(height=_FontThickness) 
                    text(_Text,size=_FontSize, font=_FontStr, spacing=1, halign = _TextHAllign,valign = _TextVAllign);
            }
        }}//union positive box&text
            // Innere box / compartment 
            for (Row =[1:_NumY+1]) {
                for (Col =[1:_NumX]){
                    // calculate compartment position
                    _CompX=_WallT2 + (Col-1)*(_SizeX+_SeparatorT);
                    _CompY=_WallT2 + (Row-1)*(_SizeY+_SeparatorT);
                    if (_CompartmentType==0&&(Row<_NumY+1)){ // Box compartment
                       //echo(str("X",Col,"Y",Row, "=",_CompInc[Row-1][Col-1])); //X1Y1
                       translate([_CompX-0.01 
                        , _CompY-0.01 
                        , _BottomT2 -0.01])
                       roundedCube([
                            0.02+ _SizeX+   (_CompInc[Row-1][Col-1]==1|| _CompInc[Row-1][Col-1]==3?_SizeX+_SeparatorT:0)
                            ,0.02+ _SizeY+  (_CompInc[Row-1][Col-1]==2|| _CompInc[Row-1][Col-1]==3?_SizeY+_SeparatorT:0)
                        ,_Height*2]
                        ,radius=_InnerRadius2
                        ,center=false
                        );
                   }
                    if (_CompartmentType==1&&(Row<_NumY+1)){ // circle/cylinder compartment
                        translate([ _CompX + SizeX/2 
                        , _CompY + SizeY/2 
                        , _BottomT2])
                        scale([1,SizeY/SizeX,1]) 
                        rounded_cylinder(r=SizeX/2,h=_Height+_WallT2+_InnerRadius2,n=_InnerRadius2);
                    }        
                    if (_CompartmentType>=3&&_CompartmentType<=10&&(Row<_NumY+1)){ // multigon compartment
                         translate([ _CompX + SizeX/2 
                        , _CompY + SizeY/2 
                        , _BottomT2])
                        scale([1,SizeY/SizeX,1]) 
                        RoundedMultigon(_CompartmentType,_SizeX,(_InnerRadius2)
                        ,_Height+_WallT2);     
                        }           
                    if (_CompartmentType==11&&(Row<_NumY+1)){ // hoizontal cylinder X-Axis compartment
                        translate([_CompX-0.01 
                            , _CompY-0.01     
                            , _BottomT2])
                        rotatedCylinder([_SizeY,_SizeX,(_SizeY*_Height)*2]
                            ,r=_InnerRadius2);           
                     }           
                      if (_CompartmentType==12&&(Row<_NumY+1)){ // hoizontal cylinder Y Axis compartment         
                        translate([_CompX-0.01 
                            , _CompY-0.01 +_SizeY
                            , _BottomT2])
                        rotate([0,0,-90])
                        rotatedCylinder(
                          [_SizeX,_SizeY,(_SizeX*_Height)*2]
                          ,r=_InnerRadius2);           
                     }           
                     if(_MagnetCount==1&&Row<=NumY){
                        translate([_CompX-0.01 +_SizeX/2
                        , _CompY-0.01 +_SizeY/2
                        ,-0.01])
                        cylinder(h = (_MagnetHeight), r = _MagnetDiameter/2);
                     }
                     if(_MagnetCount==2&&Row<=NumY){
                        OffsetX=(_SizeX<_SizeY?0:_SizeX/4);
                        OffsetY=(_SizeX<_SizeY?SizeY/4:0);
                        translate([
                        _CompX+_SizeX/2- OffsetX
                        ,_CompY+_SizeY/2- OffsetY
                        ,-0.01])
                        cylinder(h = _MagnetHeight, r = _MagnetDiameter/2);
                        translate([
                        _CompX+_SizeX/2+ OffsetX
                        ,_CompY+_SizeY/2+ OffsetY
                        ,-0.01])
                        cylinder(h = _MagnetHeight, r = _MagnetDiameter/2);
                    }
                    if(_MagnetCount==4&&Row<=NumY){
                        OffsetX=_SizeX/4;
                        OffsetY=_SizeY/4;
                        
                        translate([
                        _CompX+_SizeX/2- OffsetX
                        ,_CompY+_SizeY/2- OffsetY
                        ,-0.01])
                        cylinder(h = (_MagnetHeight), r = _MagnetDiameter/2);
                        translate([
                        _CompX+_SizeX/2+ OffsetX
                        ,_CompY+_SizeY/2+ OffsetY
                        ,-0.01])
                        cylinder(h = (_MagnetHeight), r = _MagnetDiameter/2);
                        translate([
                        _CompX+_SizeX/2- OffsetX
                        ,_CompY+_SizeY/2+ OffsetY
                        ,-0.01])
                        cylinder(h = (_MagnetHeight), r = _MagnetDiameter/2);
                        translate([
                        _CompX+_SizeX/2+ OffsetX
                        ,_CompY+_SizeY/2- OffsetY
                        ,-0.01])
                        cylinder(h = (_MagnetHeight), r = _MagnetDiameter/2);
                    }
                }//end for (Col =[1:_NumX])
                            
                 // Aussparung an Oeffnungsseite         
                if ((_TopCutout==1)||(_TopCutout==3)){//1:RoundPerRow,3:RoundAllSides
                    CutoutCylDia = min(_SizeY,_Height*2)/_HoleSizeDivider;
                    translate([
                        -1 
                        ,((Row-1)*(_SizeY+_SeparatorT))+(_SizeY/2)+_WallT2
                        ,_Height+_BottomT2])
                    rotate ([0,90,0])
                    cylinder(h = (_SizeX)*(_NumX)+(_NumX-1)*_SeparatorT +2*_WallT2+2, r = CutoutCylDia);
                }
                if ((_TopCutout==2)||(_TopCutout==3)){ //2:RoundPerColumn,3:RoundAllSides
                    for (Col =[1:_NumX]){
                        CutoutCylDia = min(_SizeX,_Height*2)/_HoleSizeDivider;
                        translate([
                            ((Col-1)*(_SizeX+_SeparatorT))+_SizeX/2+_WallT2
                            ,-_WallT2
                            ,_Height+_BottomT2])
                        rotate ([-90,0,0])
                        cylinder(h = _NumY*(_SizeY +2*_WallT2)+2*_WallT2 , r = CutoutCylDia);
                    }
                }
                FingerSize=min(_SizeX,_SizeY)/_HoleSizeDivider;
                _FCLength=(HoleSizeDivider==2
                ?min(_SizeX,_SizeY)/2
                :min(_SizeX,_SizeY)*.6
                );
                _FCWidth=min(_SizeX,_SizeY)/_HoleSizeDivider;
                //TopCutOut[0:None,1:RoundPerRow,2:RoundPerColumn,3:RoundAllSides,4:FingerSlotsAllSides,5:FingerSlotsPerRow,6:FingerSlotsPerCol]
                if ((_TopCutout==4)||(_TopCutout==5)||(_TopCutout==6)){ //FingerSlots
                    // =========================================================================== Finger Slots for Rows
                    if((_TopCutout==4)||(_TopCutout==5)){
                        for (Col =[1:_NumX+1]){
                            if ( (Row!=_NumY+1 )&& //No Extra Row needed here....
                                    (
                                        ((FingerCutoutCount==1) && ( (Row == 1) || (Row==NumY+1))&&((Col==1)||(Col==NumX+1))) // Outside Row
                                        || ((FingerCutoutCount==1) && ( (Col == 1) || (Col==NumX+1))&&((Col==1)||(Col==NumX+1)))// Outside Row
                                        // First Row
                                        || ((FingerCutoutCount==2) && (Col == 1)) // First Col
                                        || FingerCutoutCount==0)
                                    ){
                                translate([
                                (Col-1)*(_SizeX+_SeparatorT)-_FCLength/2
                                + (Col>1?WallT-_SeparatorT/2:_SeparatorT/2) // Outer Cutorouts need to adjust due to WallThickness                                                 
                                ,(Row-1)*(_SizeY+_SeparatorT)+(_SizeY-_FCWidth)/2+_WallT2
                                ,-_BottomT2/2])
                                rotate ([0,0,0])
                                
                                cube([
                                _FCLength
                                + (Col==1||Col==_NumX+1?_WallT2-_SeparatorT:0) //First cutout need to be adjusted by WallT
                                ,_FCWidth
                                ,_Height+2*_BottomT2 ]);
                            }
                        }
                    }
                    if((_TopCutout==4)||(_TopCutout==6)){
                        //FingerSlots for each col (OK)
                        for (Col =[1:_NumX]){
                            if ( 
                                    ((FingerCutoutCount==1) && ( (Row == 1) || (Row==NumY+1))) // Outside Row
                                    || ((FingerCutoutCount==1) && ( (Col == 1) || (Col==NumX))&&Row==1) // Outside Row
                                    || ((FingerCutoutCount==2) && (Row == 1)) // First Col
                                    
                                    || FingerCutoutCount==0
                                    ){
                                
                                
                                FingerRow_SizeY=_SizeX/_HoleSizeDivider*1.55;
                                
                                translate([
                                (Col-1)*(_SizeX+_SeparatorT)+(_SizeX-_FCWidth)/2 +_WallT2
                                ,(Row-1)*(_SizeY+_SeparatorT)-_FCLength/2
                                + (Row>1?WallT-_SeparatorT/2:_SeparatorT/2) // Outer Cutouts need to adjust due to WallThickness                                   
                                ,-_BottomT2/2])
                                rotate ([0,0,0])
                                
                                cube([
                                (_FCWidth)
                                ,_FCLength   
                                + (Row==1||Row==_NumY+1?_WallT2-_SeparatorT:0) //First cutout need to be adjusted 
                                ,_Height+2*_BottomT2]);
                            }
                        }
                    }
                    
                }
                //7:OnlyOneOn RowSide,8,9: Both Sides
                if( (_TopCutout==7||_TopCutout==9)&&(Row==1)){ // Only One Round Cutout OnRowSide
                    //    CutoutCylDia = _SizeY/_HoleSizeDivider;
                    CutoutCylDia = min(_SizeY,_Height*2)/_HoleSizeDivider;
                    
                    translate([
                    -_SizeX/2
                    ,(((NumY-1)/2)*(_SizeY+_SeparatorT))+(_SizeY/2)+_WallT2
                    ,_Height+_BottomT2])
                    rotate ([0,90,0])
                    rounded_cylinder(h = (_SizeX), r = CutoutCylDia,n=11);        translate([
                    -_SizeX/2 +_WallT2+_NumX*SizeX+(_NumX-1)*_SeparatorT+_WallT2
                    ,(((NumY-1)/2)*(_SizeY+_SeparatorT))+(_SizeY/2)+_WallT2
                    ,_Height+_BottomT2])
                    rotate ([0,90,0])
                    rounded_cylinder(h = (_SizeX), r = CutoutCylDia,n=11);            
                    
                }
                //8:OnlyOneOn ColSide,8 ,9: Both Sides
                if( (_TopCutout==8||_TopCutout==9)&&(Row==1)){ // Only One Round Cutout OnRowSide
                    CutoutCylDia = min(_SizeX,_Height*2)/_HoleSizeDivider;
                    translate([
                    (((_NumX-1)/2)*(_SizeX+_SeparatorT))+(_SizeX/2)+_WallT2
                    ,(_NumY-1)*_SizeY+(_NumY-1)*_SeparatorT+(_SizeY/2)+_WallT2
                    
                    ,_Height+_BottomT2])
                    
                    rotate ([-90,0,0])
                    rounded_cylinder(h = (_SizeY), r = CutoutCylDia,n=11);
    
                    translate([
                    (((NumX-1)/2)*(_SizeX+_SeparatorT))+(_SizeX/2)+_WallT2
                    ,-_SizeY/2 +_WallT2                
                    ,_Height+_BottomT2])
                    rotate ([-90,0,0])
                    rounded_cylinder(h = (_SizeY), r = CutoutCylDia,n=11);
                }
                // Aussparung(en) in der Mitte Je Row
                // 1:Round on X Axis,4:Round on Y Axis
                if (_MiddleCutout==1&&Row<=_NumY){ // Round on X Axis
                    CutoutCylDia = min(_Height,_SizeY)/_HoleSizeDivider;
                    translate([
                    -_WallT2/2,
                    (Row-1)*(_SizeY+_SeparatorT)+(_SizeY/2)+_WallT2
                    ,_Height/2+_BottomT2+_MiddleCutoutVerticalOffset])
                    rotate ([0,90,0])
                    cylinder(h = _NumX*_SizeX+(_NumX-1)*SeparatorT+3*_WallT2, r = CutoutCylDia);
                }
                if (_MiddleCutout==4&&Row<=1){ // Round on Y Axis
                    for (Col =[1:_NumX]){
                        CutoutCylDia = min(_Height,_SizeX)/_HoleSizeDivider;
                        translate([
                        (Col-1)*(_SizeX+_SeparatorT)+(_SizeX/2)+_WallT2
                        ,-_WallT2/2
                        ,_Height/2+_BottomT2+_MiddleCutoutVerticalOffset])
                        rotate ([0,90,90])
                        cylinder(h = _NumY*_SizeY+(_NumY-1)*SeparatorT+3*_WallT2, r = CutoutCylDia);
                    }
                }
                if (_MiddleCutout==2 && Row==1){  // Beide Seiten OK
                    CutoutCylDia = min(_Height,_SizeY)/_HoleSizeDivider;
                    translate([-_WallT2/2
                    ,-1*CutoutCylDia/4
                    ,_Height/2+_BottomT2+_MiddleCutoutVerticalOffset])
                    rotate ([0,90,0])
                    cylinder(h = _NumX*_SizeX+(_NumX-1)*SeparatorT+3*_WallT2, r = CutoutCylDia);
                    translate([
                    -_WallT2/2
                    ,(NumY)*_SizeY +(NumY-1)*_SeparatorT+2*_WallT2+1*CutoutCylDia/4
                    ,_Height/2+_BottomT2+_MiddleCutoutVerticalOffset])
                    rotate ([0,90,0])
                    cylinder(h =_NumX*_SizeX+(_NumX-1)*SeparatorT+3*_WallT2, r = CutoutCylDia);
                }
                if (_MiddleCutout==3&&Row<=_NumY){ // Mitte Diamond
                        _CutoutCylDia = min(_SizeY*.95,_Height*.95)/(_HoleSizeDivider);
                        translate([
                            ((_NumX)*_SizeX+(_NumX-1)*_SeparatorT+1*_WallT2+2)/2 
                            ,(_SizeY/2)+_WallT2+(Row-1)*(_SizeY+_SeparatorT)
                            ,_Height/2+_WallT2+_MiddleCutoutVerticalOffset])
                        scale([1,max(_SizeY,_Height)/_Height,max(_SizeY,_Height)/_SizeY])
                        rotate ([45,0,0])
                        rotate ([0,90,0])
                        cube([_CutoutCylDia*1.4  
                             ,_CutoutCylDia*1.4
                             ,(_NumX)*_SizeX+(_NumX-1)*_SeparatorT+2*_WallT2+4]
                             ,center=true); 
                }
                // Aussparung an Unterseite 
                if (_BottomCutout==1&&Row<=NumY){ // 1:Row
                    CutoutCylDia = _SizeY/_HoleSizeDivider;
                    
                    translate([
                    -_WallT2/2
                    ,(Row-1)*(_SizeY+_SeparatorT)+(_SizeY/2)+_WallT2
                    ,0])
                    rotate ([0,90,0])
                    cylinder(h = (_NumX)*_SizeX+(_NumX-1)*SeparatorT+2*_WallT2+2, r = CutoutCylDia);
                    
                    //(_SizeX)*(_NumX+1)+_WallT2
                }
                if (_BottomCutout==2){ // 2:Column
                    for (Col =[1:_NumX]){
                        CutoutCylDia = _SizeX/_HoleSizeDivider;
                        translate([ 
                        (Col-1)*(_SizeX+_SeparatorT)+_SizeX/2 +_WallT2
                        ,-_WallT2/2
                        ,0])
                        rotate ([-90,0,0])
                        cylinder(h = _NumY*_SizeY+(_NumY-1)*SeparatorT+3*_WallT2, r = CutoutCylDia);
                        
                    }
                }
                if (_BottomCutout==3&&Row<=NumY){ //3:Hole on bottom
                    for (Col =[1:_NumX]){
                        HoleDiameter= (_SizeY<_SizeX)?_SizeY/_HoleSizeDivider:_SizeX/_HoleSizeDivider;
                        translate([
                        Col*_SizeX + (Col-1)*_SeparatorT -_SizeX/2+_WallT2
                        ,Row*_SizeY + (Row-1)*_SeparatorT -_SizeY/2+_WallT2
                        ,-_BottomT2/2])
                        rotate ([0,0,0])
                        cylinder(h = (_Height+2*_BottomT2), r = HoleDiameter);
                    }
                }
            } //End For (Row =[1:_NumY+1]) {
            if (_LidMagnet==1){
                // For a box with the groove for the notched list, the magnets have to move further to the inside
                _LidMagnetAddDist2=_LidMagnetAddDist
                   +(_LidType=="Notched"&&(_part=="recursion box"||_part== "recursion notchedlid")?_LidT:0);
            
                _BoxSizeX=2*_WallT2+(_NumX-1)*(_SizeX+_SeparatorT)+_SizeX;
                _BoxSizeY=2*_WallT2+(_NumY-1)*(_SizeY+_SeparatorT)+_SizeY;
                translate([
                _LidMagnetDia/2+1+_LidMagnetAddDist2
                ,_LidMagnetDia/2+1+_LidMagnetAddDist2
                ,_Height+_BottomT2 -_LidMagnetDepth
                ])
                cylinder(r=_LidMagnetDia/2,h=_LidMagnetDepth+0.01);
                // LidMagnet 2v4
                translate([
                _BoxSizeX-(_LidMagnetDia/2)-1-_LidMagnetAddDist2
                ,_LidMagnetDia/2+1+_LidMagnetAddDist2
                ,_Height+_BottomT2 -_LidMagnetDepth])
                cylinder(r=_LidMagnetDia/2,h=_LidMagnetDepth+0.01);
                // LidMagnet 3v4
                translate([
                _LidMagnetDia/2+1+_LidMagnetAddDist2
                ,_BoxSizeY-(_LidMagnetDia/2+1)-_LidMagnetAddDist2
                ,_Height+_BottomT2 -_LidMagnetDepth])
                cylinder(r=_LidMagnetDia/2,h=_LidMagnetDepth+0.01);
                // LidMagnet 4v4
                translate([
                _BoxSizeX-(_LidMagnetDia/2+1)-_LidMagnetAddDist2
                ,_BoxSizeY-(_LidMagnetDia/2+1)-_LidMagnetAddDist2
                ,_Height+_BottomT2 -_LidMagnetDepth])
                cylinder(r=_LidMagnetDia/2,h=_LidMagnetDepth+0.01);
            }
            //DEBUGView
            if(false)
                translate([-1,-1,-1])
                #cube([_BoxSizeY/2,_BoxSizeX+3,_BoxSizeZ+3]);
            // Cutout the inner top side of the complete box
            if ( _RecessDepth<_Height&& _RecessDepth>0){
                translate([_WallT2 //-0.01
                        , _WallT2 //-0.01
                        , _BottomT2 +(_Height-_RecessDepth)])
                        
                roundedRect([
                    _NumX*_SizeX+(_NumX-1)*_SeparatorT-0.02
                    ,_NumY*_SizeY+(_NumY-1)*_SeparatorT-0.02
                    ,_RecessDepth+_OuterRadius2+0.01]
                    ,radius=_OuterRadius2
                );
            }
            //============================== Slide Over (grooveed) Lid
            //_LidSHeight=4 // Height "slide" over portion of the lid
            //_LidST=1 // Thickness of the Slide over lid wall
    
            if(_LidType=="Notched"){ // The modification to the actual Box
                _LidST=LidT;//(_WallT2-_LidT);//-_LidTolerance/2;
                _LidSHeight=_LidHeight;
                difference(){
                    // The Outside Box of the Notched Lid Stencil
                    translate([-0.01-(_FontThickness>0?_FontThickness:0),-0.01-(_FontThickness>0?_FontThickness:0),_BottomT2+_Height-_LidSHeight+_LidTolerance])
                    roundedRect([
                        _NumX*_SizeX+(_NumX-1)*_SeparatorT+2*_WallT2+0.02+(_FontThickness>0?2*_FontThickness:0)
                        ,_NumY*_SizeY+(_NumY-1)*_SeparatorT+2*_WallT2+0.02+(_FontThickness>0?2*_FontThickness:0)
                        ,_LidSHeight*2]
                        ,radius=_OuterRadius2
                    );
                    // Cut the inside of the lid stencil
                    translate([_LidST,_LidST,_BottomT2+_Height-_LidSHeight+_LidTolerance])
                    roundedRect([
                         _NumX*_SizeX+(_NumX-1)*_SeparatorT+2*_WallT2-2*_LidST
                        ,_NumY*_SizeY+(_NumY-1)*_SeparatorT+2*_WallT2-2*_LidST
                        ,_LidSHeight*2]
                        ,radius=_OuterRadius2
                    );
                }
            }
            if(_LidType=="NotchedLid"){ // The modification to the actual lid
                _LidST=LidT;//(_WallT2-_LidT);//-_LidTolerance/2;
                _LidSHeight=_LidHeight;
                // The Outside Box of the Notched Lid Stencil
                translate([_LidST-_LidTolerance/2
                        ,_LidST-_LidTolerance/2
                        ,_BottomT2])
                roundedCube([
                    _NumX*_SizeX+(_NumX-1)*_SeparatorT+2*_WallT2-2*_LidST+_LidTolerance
                    ,_NumY*_SizeY+(_NumY-1)*_SeparatorT+2*_WallT2-2*_LidST+_LidTolerance
                    ,_Height*2]
                    ,radius=_OuterRadius2
                    ,center=false
                );
                
            }
            if(text !=""  && _part=="recursion SlideOverLid"||(_part=="recursion notchedlid")){
                if (_TextLocationLid==1|| _TextLocationLid==3){// Text Imprint to top of the lid 
                    //posX=RealSizeX/2;
                    //posY=RealSizeY/2;
                    posX=(_TextHAllign=="left"
                            ? _OuterRadius2+1
                            : (_TextHAllign=="right"
                                ?RealSizeX-_OuterRadius2-1
                                :(RealSizeX)/2)   );
                    posY=(_TextVAllign=="top"
                            ? _OuterRadius2+1
                            : (_TextVAllign=="bottom"
                                ?RealSizeY-_OuterRadius2-1
                                :(RealSizeY)/2)   );
                    
                    translate([posX+_TextHOffset,posY+_TextVOffset,abs(_FontThickness)-0.01])
                    rotate([180,0,0-_TextRotation]) 
                        linear_extrude(height=abs(_FontThickness)) 
                        text(_Text,size=_FontSize, font=_FontStr, spacing=1, halign = _TextHAllign,valign = _TextVAllign); 
                }
                if (_TextLocationLid==2|| _TextLocationLid==3){// Text Imprint to inner lid side
                    //posX=RealSizeX/2;
                    //posY=RealSizeY/2;
                    posX=(_TextHAllign=="left"
                            ? _OuterRadius2+1
                            : (_TextHAllign=="right"
                                ?RealSizeX-max(_OuterRadius2,_WallT2)-1
                                :(RealSizeX)/2)   );
                    posY=(_TextVAllign=="bottom"
                            ? max(_OuterRadius2,_WallT2)+1
                            : (_TextVAllign=="top"
                                ?RealSizeY-max(_OuterRadius2,_WallT2)-1
                                :(RealSizeY)/2)   );
                    
                    translate([posX+_TextHOffset,posY+_TextVOffset,_BottomT2-abs(_FontThickness)+0.01])
                    rotate([0,0,0-_TextRotation]) 
                        linear_extrude(height=abs(abs(_FontThickness))) 
                        text(_Text,size=_FontSize, font=_FontStr, spacing=1, halign = _TextHAllign,valign = _TextVAllign); 
                }
            }
            // =================================== Negative Text

            if(text !="" &&_FontThickness<0 && _part=="recursion box"){ 
                if (_TextLocationX==1|| _TextLocationX==2){
                    posX=RealSizeX+_FontThickness+0.01;
                    posY=(_TextHAllign=="left"
                            ? _OuterRadius2+1
                            : (_TextHAllign=="right"
                                ?RealSizeY-_OuterRadius2-1
                                :(RealSizeY)/2)   );
                    translate([posX,posY+_TextHOffset,posZ+_TextVOffset])
                    rotate([90,0-_TextRotation,90]) 
                        linear_extrude(height=-_FontThickness) 
                        text(_Text,size=_FontSize, font=_FontStr, spacing=1, halign = _TextHAllign,valign = _TextVAllign); 
                }
                
                if (_TextLocationX==2 ){
                    posX=0-_FontThickness-.01;
                    posY=(_TextHAllign=="left"
                            ? RealSizeY-_OuterRadius2-1
                            : (_TextHAllign=="right"
                                ?_OuterRadius2+1
                                :(RealSizeY)/2)  );
                   translate([posX,posY-_TextHOffset,posZ+_TextVOffset])
                   rotate([90,0-_TextRotation,270]) 
                        linear_extrude(height=-_FontThickness) 
                        text(_Text,size=_FontSize, font=_FontStr, spacing=1, halign = _TextHAllign,valign = _TextVAllign); 
                }
                if (_TextLocationY==1|| _TextLocationY==2){
                    posX=(_TextHAllign=="left"
                            ? _OuterRadius2+1
                            : (_TextHAllign=="right"
                                ?RealSizeX-_OuterRadius2-1
                                :(RealSizeX)/2)   );
                    posY=0-_FontThickness-.01;
                    translate([posX+_TextHOffset,posY,posZ+_TextVOffset])
                    rotate([90,0-_TextRotation,0]) 
                        linear_extrude(height=-_FontThickness) 
                        text(_Text,size=_FontSize, font=_FontStr, spacing=1, halign = _TextHAllign,valign = _TextVAllign);
                }
                if (_TextLocationY==2){
                    posX=(_TextHAllign=="left"
                            ? RealSizeX-_OuterRadius2-1
                            : (_TextHAllign=="right"
                                ?_OuterRadius2
                                :(RealSizeX)/2)   );
                    posY=RealSizeY+_FontThickness+.01;
                    translate([posX-_TextHOffset,posY,posZ+_TextVOffset])
                    rotate([90,0-_TextRotation,180]) 
                        linear_extrude(height=-_FontThickness) 
                        text(_Text,size=_FontSize, font=_FontStr, spacing=1, halign = _TextHAllign,valign = _TextVAllign);
                }
            }
        } // End of main difference
        color(_color)
        
        
        union(){
            if (_LidMagnet==1){ // Positive Magnet Support Cylinder
                // For a box with the groove for the notched list, the magnets supports have to move further to the inside
                _LidMagnetAddDist3=(_LidType=="Notched"&&(_part=="recursion box"||_part== "recursion notchedlid")?_LidT:0);
            
                _BoxSizeX=2*_WallT2+(_NumX-1)*(_SizeX+_SeparatorT)+_SizeX;
                _BoxSizeY=2*_WallT2+(_NumY-1)*(_SizeY+_SeparatorT)+_SizeY;
                // LidMagnet 1v4
                translate([
                _LidMagnetDia/2+1+_LidMagnetAddDist3
                ,_LidMagnetDia/2+1+_LidMagnetAddDist3
                ,_BottomT2])
                edgeCylinder(r=_LidMagnetDia/2,h=_Height-_LidMagnetDepth,rotate=0);
                // LidMagnet 2v4
                translate([
                _BoxSizeX-(_LidMagnetDia/2+1)-_LidMagnetAddDist3
                ,_LidMagnetDia/2+1+_LidMagnetAddDist3
                ,_BottomT2])
                edgeCylinder(r=_LidMagnetDia/2,h=_Height-_LidMagnetDepth,rotate=90);
                // LidMagnet 3v4
                translate([
                _LidMagnetDia/2+1+_LidMagnetAddDist3
                ,_BoxSizeY-(_LidMagnetDia/2+1)-_LidMagnetAddDist3
                ,_BottomT2])
                edgeCylinder(r=_LidMagnetDia/2,h=_Height-_LidMagnetDepth,rotate=270);
                // LidMagnet 4v4
                translate([
                _BoxSizeX-(_LidMagnetDia/2+1)-_LidMagnetAddDist3
                ,_BoxSizeY-(_LidMagnetDia/2+1)-_LidMagnetAddDist3
                ,_BottomT2])
                edgeCylinder(r=_LidMagnetDia/2,h=_Height-_LidMagnetDepth,rotate=180);
            }
            //4:4mmCylinderPositive,5:6mmCylinderPositive,6:8mmCylinderPositive,7:10mmCylinderPositive
            if (_BottomCutout>=4 && _BottomCutout<=7 ){ //3:Hole on bottom
                _CalR=(_BottomCutout==4?2.5:0)
                +(_BottomCutout==5?3:0)
                +(_BottomCutout==6?4:0)
                +(_BottomCutout==7?5:0);
                for (Row=[1:_NumY]){
                    for (Col =[1:_NumX]){
                        translate([
                        Col*_SizeX + (Col-1)*_SeparatorT -_SizeX/2+_WallT2
                        ,Row*_SizeY + (Row-1)*_SeparatorT -_SizeY/2+_WallT2
                        ,0])
                        rotate ([0,0,0])
                        rounded_cylinder(h = (_Height+_BottomT2), r = _CalR);
                    }
                }
            }
        }
    }//end of if part=recursion
}

module roundedCube(size = [20, 30, 15], center = false, radius = 1) {
	
	tpos = (center == false)
	?[radius, radius, radius] 
	:[
	radius - (size[0] / 2),
	radius - (size[1] / 2),
	radius - (size[2] / 2)
	];

	translate(v = tpos)
	minkowski() {
		cube(size = [
		size[0] - (radius * 2),
		size[1] - (radius * 2),
		size[2] - (radius * 2)
		]);
		sphere(r = radius);
	}
}

// r[adius], h[eight], [rou]n[d]
// Example: rounded_cylinder(r=10,h=30,n=11,$fn=60);
module rounded_cylinder(r=5,h=10,n=11) {
	rotate_extrude(convexity=1) {
		_roundR=min(n,r/2-0.01); // If radius of rounding is  too big, limit it automatically
		offset(r=_roundR) offset(delta=-_roundR) square([r,h]);
		square([_roundR,h]);
	}
}

// RoundedMultigon
// Example: RoundedMultigon(5,20,0,20);
module RoundedMultigon(NumSides,CompartmentSize,radius,height)
{ 
	//Limit Radius to avoid size increase of extrudedHexagon
	EdgeLength=CompartmentSize;
	rad = max(0.01,min(EdgeLength/2,radius)); //Limit Radius to avoid size increase of Body

	hull()  
	{
		for (S=[1:NumSides])
		{
			rotate([0,0,(360/NumSides)*(S-1)])
			translate([EdgeLength/2-rad,0,0])
			cylinder(r=rad,h=height); 
		}
	}
} 
// Create a fill pattern to perfectly match the specified size
// This can create problems inopenscad when internal buffers run full :(
module createPattern(SizeX=100,SizeY=100,HoleSize=5,Height=10,NumSides=20,Dist=1,Rotate=0){
	//Calculate needed addistional Distance value to make the pattern fit
	NumX=floor(SizeX/(HoleSize+Dist));
	NumY=floor(SizeY/(HoleSize+Dist));
	DistX=(SizeX-(NumX*HoleSize+(NumX+0.5)*Dist))/NumX;
	DistY=(SizeY-(NumY*HoleSize+(NumY+0.5)*Dist))/NumY;
	for (x=[1:NumX]){
		for (y=[1:NumY]){
			translate([
			(x-1)*(HoleSize+Dist+DistX)+HoleSize/2 +Dist
			,(y-1)*(HoleSize+Dist+DistY)+HoleSize/2+Dist
			,0
			])
			rotate([0,0,Rotate])
			cylinder(r=HoleSize/2,Height,$fn=NumSides);
		}
	}
}
//edgeCylinder(r=_LidMagnetDia/2,h=_Height-_LidMagnetDepth,rotate=0);
module edgeCylinder(r=3,h=20,rotate=0){
	rotate([0,0,90+rotate])
	union(){
		translate([-r,0,0])
		cube([r*2,r,h]);
		rotate([0,0,90])
		translate([-r,0,0])
		cube([r*2,r,h]);
		cylinder(r=r
		,h=h
		,center=false);
	}
}
//roundedRect (rounding only on sides, not bottom&top
//roundedRect([20,40,30],radius=2,center=true,$fn=75);
module roundedRect(size, radius)
{
    x = size[0];
    y = size[1];
    z = size[2];
    linear_extrude(height=z)
    hull()
    {
        translate([radius, radius, 0])
        circle(r=radius);
    
        translate([x-radius,radius, 0])
        circle(r=radius);
        
        translate([x-radius,y-radius, 0])
        circle(r=radius);
        
        translate([radius,y-radius, 0])
        circle(r=radius);
    }
}

// creates a lying cylinder
//like a battery tray for a batter of diameter=y,length=x, and a width of z
// example: rotatedCylinder([10,30,60],r=1,$fn=75);

module rotatedCylinder(size,r=0){
    translate([size[1],0,0])
    rotate([0,-90,0])
    translate([r,r,r])
    minkowski(){
        roundedRect([size[2]-2*r
        ,size[0]-2*r,size[1]-2*r], radius=(size[0]-2*r)/2);
        sphere(r=r);
    }
}

	