/*    This file is licensed under the following license:
    https://creativecommons.org/licenses/by-nc-nd/3.0/legalcode
    https://creativecommons.org/licenses/by-nc-nd/3.0/
    (c) 2018 Rainer Schlosshan
*/


    
// preview[view:south west, tilt:top diagonal]

/* [General Settings] */
// The Height of each compartment
Height = 15;
// The Size of the X Axis of each compartment (Column Axis)
SizeX =  35;
// The Size of the Y Axis for each compartment (Row Axis)
SizeY= 35;

// Number of Rows 
NumX = 3; // [1:15] 
// Number of Columns
NumY = 2; // [1:15] 
// Stackable bottom. Lid Height and tolerance will apply to the bottom of the box 
StackableBottom=0; // [0:no,1:yes] 

/* [Bottom Magnets] */
// The number of magnets added to each compartment
MagnetCount=1; //[0,1,2,4]
//The Diameter of the Magnets (Add some Tolerance!) 
MagnetDiameter=8.2; 
//The Height of the Magnets (Add some Tolerance!) (BottomT will also be increased by this value)
MagnetHeight=3.2; 
// Use this option if you want to fully enclose the magnets into the body. This will require to stop the print at the right moment to insert the bottom Magnets
EncloseBottomMagnet=0; // [0:No,1:Yes]
/* [Lid] */
// Which part(s) would you like to create?
parts = "first"; // [first:Box Only,second:lid only,both:box and lid]


// Select the type of lid you you like to create?
LidType= "SlideOver"; // ["None":No Lid,"SlideOver":SlideOver-lid that slides over outside walls of the box,"Notched":Notched-lid that slides over a "notch" w.o. incr. width/length,"Stackable":Stackable- Make the box fit another rounded box]

LidHeight=3.1;
// The tolerance to add to the lid in order to fit
LidTolerance=0.15       ;
// The Thickness of the Lid walls
LidT =1.5; 
// [0,0.1,0.2,0.3,0.4,0.5,0.6,0.8,1,1.5,2,2.5,3,3.5,4,4.5,5,6,7,8,9,10,11,12,13,14,15]
// Do you want cutouts on the lid side walls for easier removal?
LidCutout = 3   ; //[0:No,1:On X-Axis,2:On Y-Axis,3:On Both Sides]
// Do you want a perforated Lid?
PerforatedLid=0;//[0:No,1:Yes]

/* [Magnetic Lid] */
// Do you want to add Holes for Magnet closing mechanism for the lid? (if you want to avoid the magnets holes to interfer with the compartments, increate Advances=>WallT
LidMagnet = 0; //[0:No,1:Yes]
// Diameter of the optional Magnet holes
LidMagnetDia=6.1;
// Depth of the optional Magnet holes
LidMagnetDepth=1.1;

/* [Text Location & Orientation] */
//This parameter defines the thickness of the text. Negative values imprint text to the box, positive text will be added on top off the walls
FontThickness=-0.3; //[-5,-4,-3,-2,-1.5,-1.3,-1,-0.7,-0.5,-0.4,-0.3,-0.2,-0.1,0,0.1,0.2,0.3,0.4,0.5,0.7,1,1.3,1.5,2,3,4,5]
// Location of the text set all to none to disable text
X_Axis_Location=2; // [0:None,1:On 1 Side,2:On both Sides]
// Location of the text
Y_Axis_Location=2; // [0:None,1:On 1 Side,2:On both Sides]
// Location of the text on the lid
Lid_Location=1; // [0:None,1:Negative imprint on top of lid X-Axis,2:Negative imprint inside of lid X-Axis,3:both on X-Axis,4:Negative imprint on top of lid Y-Axis,5:Negative imprint inside of lid Y-Axis,6:both on Y-Axis]

// Rotate the text by this angle 
TextRotation=0; // positive values=clockwise, negative values=counter clockwise

// Allignment should only be changed wen Rotation=0
HorizontalAllignment="left"; //[left,center,right]
VerticalAllignment="center"; //[top,center,bottom]
/* [Text Line 1] */
// Put your text here
text="Facio Ergo Sum";
//Font to be used ( see https://fonts.google.com to choose from all of them )
font="exo"; //[<none>,abeezee,abel,abhayalibre,abrilfatface,abyssinicasil,acme,actor,adamina,adobeblank,adventpro,aguafinascript,akronim,aksarabaligalang,aladin,aldrich,alef,alefhebrew,alegreya,alegreyasans,alegreyasanssc,alegreyasc,aleo,alexbrush,alfaslabone,alice,alike,alikeangular,allan,allerta,allertastencil,allura,almendra,almendradisplay,almendrasc,amarante,amaranth,amaticasc,amaticsc,amethysta,amiko,amiri,amita,amstelvaralpha,anaheim,andada,andadasc,andika,angkor,annieuseyourtelescope,anonymouspro,antic,anticdidone,anticslab,anton,antonio,arapey,arbutus,arbutusslab,architectsdaughter,archivo,archivoblack,archivonarrow,archivovfbeta,arefruqaa,arimamadurai,arizonia,armata,arsenal,artifika,arvo,arya,asap,asapcondensed,asapvfbeta,asar,asset,assistant,astloch,asul,athiti,atma,atomicage,aubrey,audiowide,autourone,average,averagesans,averiagruesalibre,averialibre,averiasanslibre,averiaseriflibre,b612,b612mono,badscript,bahiana,baijamjuree,baloo,baloobhai,baloobhaijaan,baloobhaina,baloochettan,balooda,baloopaaji,balootamma,balootammudu,baloothambi,balthazar,bangers,barlow,barlowcondensed,barlowsemicondensed,barrio,basic,battambang,baumans,bayon,belgrano,bellefair,belleza,benchnine,bentham,berkshireswash,bevan,bhavuka,bigelowrules,bigshotone,bilbo,bilboswashcaps,biorhyme,biorhymeexpanded,biryani,bitter,blackandwhitepicture,blackhansans,blackopsone,bokor,bonbon,boogaloo,bowlbyone,bowlbyonesc,brawler,breeserif,brunoace,brunoacesc,bubblegumsans,bubblerone,buda,buenard,bungee,bungeehairline,bungeeinline,bungeeoutline,bungeeshade,butcherman,butchermancaps,butterflykids,cabin,cabincondensed,cabinsketch,cabinvfbeta,caesardressing,cagliostro,cairo,cambay,cambo,candal,cantarell,cantataone,cantoraone,capriola,cardo,carme,carroisgothic,carroisgothicsc,carterone,catamaran,caudex,caveat,caveatbrush,cedarvillecursive,cevicheone,chakrapetch,changa,changaone,chango,charm,charmonman,chathura,chauphilomeneone,chelaone,chelseamarket,chenla,cherryswash,chicle,chivo,chonburi,cinzel,cinzeldecorative,clickerscript,coda,codacaption,codystar,coiny,combo,comfortaa,concertone,condiment,conf.d,content,contrailone,convergence,cookie,copse,corben,cormorant,cormorantgaramond,cormorantinfant,cormorantsc,cormorantunicase,cormorantupright,courgette,coustard,coveredbyyourgrace,creepster,creteround,crimsontext,croissantone,cuprum,cutefont,cutive,cutivemono,damion,dancingscript,dangrek,dawningofanewday,daysone,decovaralpha,dekko,delius,deliusswashcaps,deliusunicase,dellarespira,denkone,devonshire,dhurjati,dhyana,didactgothic,digitalnumbers,diplomata,diplomatasc,dohyeon,dokdo,domine,donegalone,doppioone,dorsa,dosis,drsugiyama,durusans,dynalight,eaglelake,eastseadokdo,eater,eatercaps,ebgaramond,economica,eczar,ekmukta,electrolize,elmessiri,elsie,elsieswashcaps,emblemaone,emilyscandy,encodesans,encodesanscondensed,encodesansexpanded,encodesanssemicondensed,encodesanssemiexpanded,engagement,englebert,enriqueta,ericaone,esteban,euphoriascript,ewert,exo,exo2,expletussans,fahkwang,fanwoodtext,farsan,fascinate,fascinateinline,fasterone,fasthand,faunaone,faustina,faustinavfbeta,federant,federo,felipa,fenix,fingerpaint,firamono,firasans,firasanscondensed,firasansextracondensed,fjallaone,fjordone,flamenco,flavors,fondamento,fonts.conf,forum,francoisone,frankruhllibre,freckleface,frederickathegreat,fredokaone,freehand,fresca,frijole,fruktur,fugazone,gabriela,gaegu,gafata,galada,galdeano,galindo,gamjaflower,gemunulibre,gentiumbasic,gentiumbookbasic,geo,geostar,geostarfill,germaniaone,gfsdidot,gfsneohellenic,gidugu,gildadisplay,giveyouglory,glassantiqua,glegoo,gloriahallelujah,goblinone,gochihand,gorditas,gothica1,goudybookletter1911,graduate,grandhotel,gravitasone,greatvibes,griffy,gruppo,gudea,gugi,gurajada,habibi,halant,hammersmithone,hanalei,hanaleifill,handlee,hanna,hannari,hanuman,happymonkey,harmattan,headlandone,heebo,hennypenny,hermeneusone,herrvonmuellerhoff,himelody,hind,hindcolombo,hindguntur,hindjalandhar,hindkochi,hindmadurai,hindmysuru,hindsiliguri,hindvadodara,holtwoodonesc,homenaje,ibmplexmono,ibmplexsans,ibmplexsanscondensed,ibmplexserif,iceberg,iceland,imfelldoublepica,imfelldoublepicasc,imfelldwpica,imfelldwpicasc,imfellenglish,imfellenglishsc,imfellfrenchcanon,imfellfrenchcanonsc,imfellgreatprimer,imfellgreatprimersc,imprima,inconsolata,inder,indieflower,inika,inknutantiqua,istokweb,italiana,italianno,itim,jacquesfrancois,jacquesfrancoisshadow,jaldi,jejugothic,jejuhallasan,jejumyeongjo,jimnightshade,jockeyone,jollylodger,jomhuria,jomolhari,josefinsans,josefinsansstdlight,josefinslab,jotione,jua,judson,julee,juliussansone,junge,jura,justmeagaindownhere,k2d,kadwa,kalam,kameron,kanit,kantumruy,karla,karlatamilinclined,karlatamilupright,karma,katibeh,kaushanscript,kavivanar,kavoon,kdamthmor,keaniaone,kellyslab,kenia,khand,khmer,khula,khyay,kiranghaerang,kiteone,knewave,kodchasan,koho,kokoro,kopubbatang,kottaone,koulen,kreon,kristi,kronaone,krub,kumarone,kurale,labelleaurore,laila,lakkireddy,lalezar,lancelot,laomuangdon,laomuangkhong,laosanspro,lateef,lato,leaguescript,leckerlione,ledger,lekton,lemon,lemonada,lemonadavfbeta,Liberation-2.00.1,librebarcode128,librebarcode128text,librebarcode39,librebarcode39extended,librebarcode39extendedtext,librebarcode39text,librebaskerville,librecaslontext,librefranklin,lifesavers,lilitaone,lilyscriptone,limelight,lindenhill,lobster,lobstertwo,lohitbengali,lohitdevanagari,lohittamil,londrinaoutline,londrinashadow,londrinasketch,londrinasolid,lora,lovedbytheking,loversquarrel,loveyalikeasister,lusitana,lustria,macondo,macondoswashcaps,mada,magra,maitree,majormonodisplay,mako,mali,mallanna,mandali,manuale,marcellus,marcellussc,marckscript,margarine,markazitext,markazitextvfbeta,markoone,marmelad,martel,martelsans,marvel,mate,matesc,mavenpro,mavenprovfbeta,mclaren,meddon,medievalsharp,medulaone,meerainimai,megrim,meiescript,mergeone,merienda,meriendaone,merriweather,merriweathersans,mervalescript,metal,metalmania,metamorphous,metrophobic,miama,michroma,milonga,miltonian,miltoniantattoo,mina,miniver,miriamlibre,mirza,missfajardose,misssaintdelafield,mitr,modak,modernantiqua,mogra,molengo,molle,monda,monofett,monoton,monsieurladoulaise,montaga,montserrat,montserratalternates,montserratsubrayada,moul,moulpali,mousememoirs,mplus1p,mrbedford,mrbedfort,mrdafoe,mrdehaviland,mrssaintdelafield,mrssheppards,mukta,muktamahee,muktamalar,muktavaani,muli,myanmarsanspro,mysteryquest,nanumbrushscript,nanumgothic,nanumgothiccoding,nanummyeongjo,nanumpenscript,nats,neucha,neuton,newrocker,newscycle,nicomoji,niconne,nikukyu,niramit,nixieone,nobile,norican,nosifer,nosifercaps,notable,nothingyoucoulddo,noticiatext,notosans,notosanstamil,notoserif,novacut,novaflat,novamono,novaoval,novaround,novascript,novaslim,novasquare,ntr,numans,nunito,nunitosans,odormeanchey,offside,oflsortsmillgoudytt,oldenburg,oldstandardtt,oleoscript,oleoscriptswashcaps,oranienbaum,orbitron,oregano,orienta,originalsurfer,oswald,overlock,overlocksc,overpass,overpassmono,overtherainbow,ovo,oxygen,oxygenmono,pacifico,padauk,palanquin,palanquindark,pangolin,paprika,parisienne,passeroone,passionone,pathwaygothicone,patrickhand,patrickhandsc,pattaya,patuaone,pavanam,paytoneone,pecita,peddana,peralta,petitformalscript,petrona,phetsarath,philosopher,piedra,pinyonscript,pirataone,plaster,play,playball,playfairdisplay,playfairdisplaysc,podkova,podkovavfbeta,poetsenone,poiretone,pollerone,poly,pompiere,ponnala,pontanosans,poorstory,poppins,portersansblock,portlligatsans,portlligatslab,postnobillscolombo,postnobillsjaffna,pragatinarrow,prata,preahvihear,pressstart2p,pridi,princesssofia,prociono,prompt,prostoone,prozalibre,ptmono,ptsans,ptsanscaption,ptsansnarrow,ptserif,ptserifcaption,puritan,purplepurse,quando,quantico,quattrocento,quattrocentosans,questrial,quicksand,quintessential,qwigley,racingsansone,radley,rajdhani,rakkas,raleway,ralewaydots,ramabhadra,ramaraja,rambla,rammettoone,ranchers,ranga,rasa,rationale,raviprakash,redacted,redactedscript,reemkufi,reeniebeanie,revalia,rhodiumlibre,ribeye,ribeyemarrow,righteous,risque,rokkitt,rokkittvfbeta,romanesco,ropasans,rosario,rosarivo,rougescript,roundedmplus1c,rozhaone,rubik,rubikmonoone,rubikone,ruda,rufina,rugeboogie,ruluko,rumraisin,ruslandisplay,russoone,ruthie,rye,sacramento,sahitya,sail,saira,sairacondensed,sairaextracondensed,sairasemicondensed,salsa,sanchez,sancreek,sansation,sansita,sansitaone,sarabun,sarala,sarina,sarpanch,sawarabigothic,sawarabimincho,scada,scheherazade,scopeone,seaweedscript,secularone,sedan,sedansc,sedgwickave,sedgwickavedisplay,seoulhangang,seoulhangangcondensed,seoulnamsan,seoulnamsancondensed,seoulnamsanvertical,sevillana,seymourone,shadowsintolight,shadowsintolighttwo,shanti,share,sharetech,sharetechmono,shojumaru,shortstack,shrikhand,siamreap,siemreap,sigmarone,signika,signikanegative,simonetta,singleday,sintony,sirinstencil,sitara,sixcaps,skranji,slabo13px,slabo27px,smythe,sniglet,snippet,snowburstone,sofadione,sofia,songmyung,sonsieone,sortsmillgoudy,souliyo,sourcecodepro,sourcesanspro,sourceserifpro,spacemono,spectral,spectralsc,spicyrice,spinnaker,spirax,squadaone,sreekrushnadevaraya,sriracha,srisakdi,staatliches,stalemate,stalinistone,stalinone,stardosstencil,stintultracondensed,stintultraexpanded,stoke,strait,strong,stylish,sueellenfrancisco,suezone,sumana,sunflower,supermercadoone,sura,suranna,suravaram,suwannaphum,swankyandmoomoo,tajawal,tangerine,taprom,tauri,taviraj,teko,telex,tenaliramakrishna,tenorsans,terminaldosis,terminaldosislight,textmeone,thabit,tharlon,thasadith,thegirlnextdoor,tienne,tillana,timmana,titanone,titilliumweb,tradewinds,trirong,trocchi,trochut,trykker,tuffy,tulpenone,uncialantiqua,underdog,unicaone,unifrakturcook,unifrakturmaguntia,unlock,unna,vampiroone,varela,varelaround,varta,vastshadow,vesperlibre,vibur,vidaloka,viga,voces,volkhov,vollkorn,vollkornsc,voltaire,vt323,waitingforthesunrise,wallpoet,warnes,wellfleet,wendyone,wireone,worksans,yaldevicolombo,yanonekaffeesatz,yantramanav,yatraone,yeonsung,yesevaone,yesteryear,yinmar,yrsa,zcoolkuaile,zcoolqingkehuangyou,zcoolxiaowei,zeyada,zillaslab,zillaslabhighlight]
FontSize=7  ; //[2,3,4,5,6,7,8,9,10,12,15,17,20,25,30,40,50]
Bold=false;
Italic=false;



// Add an additional horizontal offset (mm)
TextHorizontalOffset=0;
TextVerticalOffset=0;

/* [Text Line 2] */
// Put your text here
text2="I Make Therefore I Am";
//Font to be used ( see https://fonts.google.com to choose from all of them )
font2="I Make Therefore I Am"; //[<none>,abeezee,abel,abhayalibre,abrilfatface,abyssinicasil,acme,actor,adamina,adobeblank,adventpro,aguafinascript,akronim,aksarabaligalang,aladin,aldrich,alef,alefhebrew,alegreya,alegreyasans,alegreyasanssc,alegreyasc,aleo,alexbrush,alfaslabone,alice,alike,alikeangular,allan,allerta,allertastencil,allura,almendra,almendradisplay,almendrasc,amarante,amaranth,amaticasc,amaticsc,amethysta,amiko,amiri,amita,amstelvaralpha,anaheim,andada,andadasc,andika,angkor,annieuseyourtelescope,anonymouspro,antic,anticdidone,anticslab,anton,antonio,arapey,arbutus,arbutusslab,architectsdaughter,archivo,archivoblack,archivonarrow,archivovfbeta,arefruqaa,arimamadurai,arizonia,armata,arsenal,artifika,arvo,arya,asap,asapcondensed,asapvfbeta,asar,asset,assistant,astloch,asul,athiti,atma,atomicage,aubrey,audiowide,autourone,average,averagesans,averiagruesalibre,averialibre,averiasanslibre,averiaseriflibre,b612,b612mono,badscript,bahiana,baijamjuree,baloo,baloobhai,baloobhaijaan,baloobhaina,baloochettan,balooda,baloopaaji,balootamma,balootammudu,baloothambi,balthazar,bangers,barlow,barlowcondensed,barlowsemicondensed,barrio,basic,battambang,baumans,bayon,belgrano,bellefair,belleza,benchnine,bentham,berkshireswash,bevan,bhavuka,bigelowrules,bigshotone,bilbo,bilboswashcaps,biorhyme,biorhymeexpanded,biryani,bitter,blackandwhitepicture,blackhansans,blackopsone,bokor,bonbon,boogaloo,bowlbyone,bowlbyonesc,brawler,breeserif,brunoace,brunoacesc,bubblegumsans,bubblerone,buda,buenard,bungee,bungeehairline,bungeeinline,bungeeoutline,bungeeshade,butcherman,butchermancaps,butterflykids,cabin,cabincondensed,cabinsketch,cabinvfbeta,caesardressing,cagliostro,cairo,cambay,cambo,candal,cantarell,cantataone,cantoraone,capriola,cardo,carme,carroisgothic,carroisgothicsc,carterone,catamaran,caudex,caveat,caveatbrush,cedarvillecursive,cevicheone,chakrapetch,changa,changaone,chango,charm,charmonman,chathura,chauphilomeneone,chelaone,chelseamarket,chenla,cherryswash,chicle,chivo,chonburi,cinzel,cinzeldecorative,clickerscript,coda,codacaption,codystar,coiny,combo,comfortaa,concertone,condiment,conf.d,content,contrailone,convergence,cookie,copse,corben,cormorant,cormorantgaramond,cormorantinfant,cormorantsc,cormorantunicase,cormorantupright,courgette,coustard,coveredbyyourgrace,creepster,creteround,crimsontext,croissantone,cuprum,cutefont,cutive,cutivemono,damion,dancingscript,dangrek,dawningofanewday,daysone,decovaralpha,dekko,delius,deliusswashcaps,deliusunicase,dellarespira,denkone,devonshire,dhurjati,dhyana,didactgothic,digitalnumbers,diplomata,diplomatasc,dohyeon,dokdo,domine,donegalone,doppioone,dorsa,dosis,drsugiyama,durusans,dynalight,eaglelake,eastseadokdo,eater,eatercaps,ebgaramond,economica,eczar,ekmukta,electrolize,elmessiri,elsie,elsieswashcaps,emblemaone,emilyscandy,encodesans,encodesanscondensed,encodesansexpanded,encodesanssemicondensed,encodesanssemiexpanded,engagement,englebert,enriqueta,ericaone,esteban,euphoriascript,ewert,exo,exo2,expletussans,fahkwang,fanwoodtext,farsan,fascinate,fascinateinline,fasterone,fasthand,faunaone,faustina,faustinavfbeta,federant,federo,felipa,fenix,fingerpaint,firamono,firasans,firasanscondensed,firasansextracondensed,fjallaone,fjordone,flamenco,flavors,fondamento,fonts.conf,forum,francoisone,frankruhllibre,freckleface,frederickathegreat,fredokaone,freehand,fresca,frijole,fruktur,fugazone,gabriela,gaegu,gafata,galada,galdeano,galindo,gamjaflower,gemunulibre,gentiumbasic,gentiumbookbasic,geo,geostar,geostarfill,germaniaone,gfsdidot,gfsneohellenic,gidugu,gildadisplay,giveyouglory,glassantiqua,glegoo,gloriahallelujah,goblinone,gochihand,gorditas,gothica1,goudybookletter1911,graduate,grandhotel,gravitasone,greatvibes,griffy,gruppo,gudea,gugi,gurajada,habibi,halant,hammersmithone,hanalei,hanaleifill,handlee,hanna,hannari,hanuman,happymonkey,harmattan,headlandone,heebo,hennypenny,hermeneusone,herrvonmuellerhoff,himelody,hind,hindcolombo,hindguntur,hindjalandhar,hindkochi,hindmadurai,hindmysuru,hindsiliguri,hindvadodara,holtwoodonesc,homenaje,ibmplexmono,ibmplexsans,ibmplexsanscondensed,ibmplexserif,iceberg,iceland,imfelldoublepica,imfelldoublepicasc,imfelldwpica,imfelldwpicasc,imfellenglish,imfellenglishsc,imfellfrenchcanon,imfellfrenchcanonsc,imfellgreatprimer,imfellgreatprimersc,imprima,inconsolata,inder,indieflower,inika,inknutantiqua,istokweb,italiana,italianno,itim,jacquesfrancois,jacquesfrancoisshadow,jaldi,jejugothic,jejuhallasan,jejumyeongjo,jimnightshade,jockeyone,jollylodger,jomhuria,jomolhari,josefinsans,josefinsansstdlight,josefinslab,jotione,jua,judson,julee,juliussansone,junge,jura,justmeagaindownhere,k2d,kadwa,kalam,kameron,kanit,kantumruy,karla,karlatamilinclined,karlatamilupright,karma,katibeh,kaushanscript,kavivanar,kavoon,kdamthmor,keaniaone,kellyslab,kenia,khand,khmer,khula,khyay,kiranghaerang,kiteone,knewave,kodchasan,koho,kokoro,kopubbatang,kottaone,koulen,kreon,kristi,kronaone,krub,kumarone,kurale,labelleaurore,laila,lakkireddy,lalezar,lancelot,laomuangdon,laomuangkhong,laosanspro,lateef,lato,leaguescript,leckerlione,ledger,lekton,lemon,lemonada,lemonadavfbeta,Liberation-2.00.1,librebarcode128,librebarcode128text,librebarcode39,librebarcode39extended,librebarcode39extendedtext,librebarcode39text,librebaskerville,librecaslontext,librefranklin,lifesavers,lilitaone,lilyscriptone,limelight,lindenhill,lobster,lobstertwo,lohitbengali,lohitdevanagari,lohittamil,londrinaoutline,londrinashadow,londrinasketch,londrinasolid,lora,lovedbytheking,loversquarrel,loveyalikeasister,lusitana,lustria,macondo,macondoswashcaps,mada,magra,maitree,majormonodisplay,mako,mali,mallanna,mandali,manuale,marcellus,marcellussc,marckscript,margarine,markazitext,markazitextvfbeta,markoone,marmelad,martel,martelsans,marvel,mate,matesc,mavenpro,mavenprovfbeta,mclaren,meddon,medievalsharp,medulaone,meerainimai,megrim,meiescript,mergeone,merienda,meriendaone,merriweather,merriweathersans,mervalescript,metal,metalmania,metamorphous,metrophobic,miama,michroma,milonga,miltonian,miltoniantattoo,mina,miniver,miriamlibre,mirza,missfajardose,misssaintdelafield,mitr,modak,modernantiqua,mogra,molengo,molle,monda,monofett,monoton,monsieurladoulaise,montaga,montserrat,montserratalternates,montserratsubrayada,moul,moulpali,mousememoirs,mplus1p,mrbedford,mrbedfort,mrdafoe,mrdehaviland,mrssaintdelafield,mrssheppards,mukta,muktamahee,muktamalar,muktavaani,muli,myanmarsanspro,mysteryquest,nanumbrushscript,nanumgothic,nanumgothiccoding,nanummyeongjo,nanumpenscript,nats,neucha,neuton,newrocker,newscycle,nicomoji,niconne,nikukyu,niramit,nixieone,nobile,norican,nosifer,nosifercaps,notable,nothingyoucoulddo,noticiatext,notosans,notosanstamil,notoserif,novacut,novaflat,novamono,novaoval,novaround,novascript,novaslim,novasquare,ntr,numans,nunito,nunitosans,odormeanchey,offside,oflsortsmillgoudytt,oldenburg,oldstandardtt,oleoscript,oleoscriptswashcaps,oranienbaum,orbitron,oregano,orienta,originalsurfer,oswald,overlock,overlocksc,overpass,overpassmono,overtherainbow,ovo,oxygen,oxygenmono,pacifico,padauk,palanquin,palanquindark,pangolin,paprika,parisienne,passeroone,passionone,pathwaygothicone,patrickhand,patrickhandsc,pattaya,patuaone,pavanam,paytoneone,pecita,peddana,peralta,petitformalscript,petrona,phetsarath,philosopher,piedra,pinyonscript,pirataone,plaster,play,playball,playfairdisplay,playfairdisplaysc,podkova,podkovavfbeta,poetsenone,poiretone,pollerone,poly,pompiere,ponnala,pontanosans,poorstory,poppins,portersansblock,portlligatsans,portlligatslab,postnobillscolombo,postnobillsjaffna,pragatinarrow,prata,preahvihear,pressstart2p,pridi,princesssofia,prociono,prompt,prostoone,prozalibre,ptmono,ptsans,ptsanscaption,ptsansnarrow,ptserif,ptserifcaption,puritan,purplepurse,quando,quantico,quattrocento,quattrocentosans,questrial,quicksand,quintessential,qwigley,racingsansone,radley,rajdhani,rakkas,raleway,ralewaydots,ramabhadra,ramaraja,rambla,rammettoone,ranchers,ranga,rasa,rationale,raviprakash,redacted,redactedscript,reemkufi,reeniebeanie,revalia,rhodiumlibre,ribeye,ribeyemarrow,righteous,risque,rokkitt,rokkittvfbeta,romanesco,ropasans,rosario,rosarivo,rougescript,roundedmplus1c,rozhaone,rubik,rubikmonoone,rubikone,ruda,rufina,rugeboogie,ruluko,rumraisin,ruslandisplay,russoone,ruthie,rye,sacramento,sahitya,sail,saira,sairacondensed,sairaextracondensed,sairasemicondensed,salsa,sanchez,sancreek,sansation,sansita,sansitaone,sarabun,sarala,sarina,sarpanch,sawarabigothic,sawarabimincho,scada,scheherazade,scopeone,seaweedscript,secularone,sedan,sedansc,sedgwickave,sedgwickavedisplay,seoulhangang,seoulhangangcondensed,seoulnamsan,seoulnamsancondensed,seoulnamsanvertical,sevillana,seymourone,shadowsintolight,shadowsintolighttwo,shanti,share,sharetech,sharetechmono,shojumaru,shortstack,shrikhand,siamreap,siemreap,sigmarone,signika,signikanegative,simonetta,singleday,sintony,sirinstencil,sitara,sixcaps,skranji,slabo13px,slabo27px,smythe,sniglet,snippet,snowburstone,sofadione,sofia,songmyung,sonsieone,sortsmillgoudy,souliyo,sourcecodepro,sourcesanspro,sourceserifpro,spacemono,spectral,spectralsc,spicyrice,spinnaker,spirax,squadaone,sreekrushnadevaraya,sriracha,srisakdi,staatliches,stalemate,stalinistone,stalinone,stardosstencil,stintultracondensed,stintultraexpanded,stoke,strait,strong,stylish,sueellenfrancisco,suezone,sumana,sunflower,supermercadoone,sura,suranna,suravaram,suwannaphum,swankyandmoomoo,tajawal,tangerine,taprom,tauri,taviraj,teko,telex,tenaliramakrishna,tenorsans,terminaldosis,terminaldosislight,textmeone,thabit,tharlon,thasadith,thegirlnextdoor,tienne,tillana,timmana,titanone,titilliumweb,tradewinds,trirong,trocchi,trochut,trykker,tuffy,tulpenone,uncialantiqua,underdog,unicaone,unifrakturcook,unifrakturmaguntia,unlock,unna,vampiroone,varela,varelaround,varta,vastshadow,vesperlibre,vibur,vidaloka,viga,voces,volkhov,vollkorn,vollkornsc,voltaire,vt323,waitingforthesunrise,wallpoet,warnes,wellfleet,wendyone,wireone,worksans,yaldevicolombo,yanonekaffeesatz,yantramanav,yatraone,yeonsung,yesevaone,yesteryear,yinmar,yrsa,zcoolkuaile,zcoolqingkehuangyou,zcoolxiaowei,zeyada,zillaslab,zillaslabhighlight]
FontSize2=4 ; //[2,3,4,5,6,7,8,9,10,12,15,17,20,25,30,40,50]
Bold2=false;
Italic2=false;

// Add an additional horizontal offset (mm)
Text2HorizontalOffset=0;
Text2VerticalOffset=0;

/* [Advanced] */
// The Thickness of the outer walls in mm
WallT =4.5  ; 
// The Thickness of the inner walls in mm(compartment separators)
SeparatorT =1; 

/* [Rounded Edges] */
// Radius in mm for rounding of outside edges? 0 disables rounding
OuterEdgesRadius=1; 
// Radius in mm for rounded edges in the compartments?  0 disables rounding
InnerEdgesRadius=8  ; 
// The number of segments a single circle is being rendered from. The higher this number is the better the quiality of especially bigger roundings will be, but increasing this will have a performance impact when creating /previewing your object
CircleSegments=76; 

// ======== ignore variable values below
/* [Hidden] */
// The Thickness of the Bottom in mm
BottomT =1.5; 
// Compartment Type 
CompartmentType=0; // [0:Box,1:Cylinder,3:Triangle,4:RotatedRectangle,5:Pentagon5,6:Hexagon6,7:Heptagon7,8:Octagon8,9:Nonagon9,10:Decagon10]

//* [Cutouts] */
// Do you want a cutout on the top edges of the box?
TopCutout =0; // [0:None,1:RoundPerRow,2:RoundPerColumn,3:RoundAllSides,7:OnlyOneOn RowSide,8:OnlyOneOn ColSide,9:OnlyOneOn BothSides,4:FingerSlotsAllSides,5:FingerSlotsPerRow,6:FingerSlotsPerCol]
// Enable this parameter to place the fingercoutouts ony on the outside walls
FingerCutoutCount = 1; //[0:All,1:Only in outside walls,2:Only once per col/row]
// Do you want a cutout in the middle of the box per Row?
MiddleCutout =0; // [0:None,1:Round Centered,2:Round Both Sides,3:Diamond]
// Do you want a cutout on the bottom side of the box?
BottomCutout = 0; // [0:None,1:Round per Row,2:Round per Column,3:Hole on bottom,4:4mmCylinderPositive,5:6mmCylinderPositive,6:8mmCylinderPositive,7:10mmCylinderPositive]
//Higher Number make smaller cutouts
HoleSizeDivider =3 ; // [2:7]

// Depth of an additional cutout over the full inner structure. (0=the compartments and outer Wall use the same height)
RecessInnerPart=0;

// Quality Settings
$fa=360/CircleSegments;//360/$fa = Max Facets Number
$fs=0.2; //prefered facet length 
/* [Increase Single Compartment Size In Row Y1] */
X1Y1=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X2Y1=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X3Y1=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X4Y1=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X5Y1=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X6Y1=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X7Y1=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X8Y1=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X9Y1=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X10Y1=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X11Y1=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X12Y1=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X13Y1=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X14Y1=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X15Y1=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
/* [Increase Single Compartment Size In Row Y2] */
X1Y2=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X2Y2=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X3Y2=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X4Y2=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X5Y2=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X6Y2=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X7Y2=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X8Y2=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X9Y2=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X10Y2=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X11Y2=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X12Y2=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X13Y2=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X14Y2=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X15Y2=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
/* [Increase Single Compartment Size In Row Y3] */
X1Y3=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X2Y3=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X3Y3=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X4Y3=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X5Y3=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X6Y3=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X7Y3=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X8Y3=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X9Y3=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X10Y3=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X11Y3=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X12Y3=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X13Y3=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X14Y3=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X15Y3=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
/* [Increase Single Compartment Size In Row Y4] */
X1Y4=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X2Y4=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X3Y4=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X4Y4=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X5Y4=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X6Y4=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X7Y4=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X8Y4=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X9Y4=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X10Y4=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X11Y4=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X12Y4=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X13Y4=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X14Y4=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X15Y4=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
/* [Increase Single Compartment Size In Row Y5] */
X1Y5=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X2Y5=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X3Y5=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X4Y5=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X5Y5=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X6Y5=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X7Y5=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X8Y5=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X9Y5=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X10Y5=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X11Y5=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X12Y5=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X13Y5=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X14Y5=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X15Y5=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
/* [Increase Single Compartment Size In Row Y6] */
X1Y6=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X2Y6=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X3Y6=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X4Y6=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X5Y6=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X6Y6=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X7Y6=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X8Y6=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X9Y6=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X10Y6=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X11Y6=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X12Y6=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X13Y6=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X14Y6=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X15Y6=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
/* [Increase Single Compartment Size In Row Y7] */
X1Y7=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X2Y7=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X3Y7=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X4Y7=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X5Y7=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X6Y7=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X7Y7=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X8Y7=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X9Y7=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X10Y7=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X11Y7=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X12Y7=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X13Y7=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X14Y7=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X15Y7=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
/* [Increase Single Compartment Size In Row Y8] */
X1Y8=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X2Y8=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X3Y8=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X4Y8=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X5Y8=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X6Y8=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X7Y8=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X8Y8=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X9Y8=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X10Y8=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X11Y8=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X12Y8=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X13Y8=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X14Y8=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X15Y8=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
/* [Increase Single Compartment Size In Row Y9] */
X1Y9=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X2Y9=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X3Y9=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X4Y9=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X5Y9=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X6Y9=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X7Y9=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X8Y9=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X9Y9=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X10Y9=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X11Y9=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X12Y9=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X13Y9=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X14Y9=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X15Y9=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
/* [Increase Single Compartment Size In Row Y10] */
X1Y10=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X2Y10=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X3Y10=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X4Y10=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X5Y10=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X6Y10=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X7Y10=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X8Y10=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X9Y10=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X10Y10=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X11Y10=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X12Y10=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X13Y10=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X14Y10=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X15Y10=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
/* [Increase Single Compartment Size In Row Y11] */
X1Y11=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X2Y11=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X3Y11=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X4Y11=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X5Y11=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X6Y11=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X7Y11=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X8Y11=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X9Y11=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X10Y11=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X11Y11=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X12Y11=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X13Y11=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X14Y11=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X15Y11=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
/* [Increase Single Compartment Size In Row Y12] */
X1Y12=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X2Y12=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X3Y12=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X4Y12=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X5Y12=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X6Y12=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X7Y12=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X8Y12=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X9Y12=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X10Y12=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X11Y12=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X12Y12=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X13Y12=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X14Y12=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X15Y12=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
/* [Increase Single Compartment Size In Row Y13] */
X1Y13=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X2Y13=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X3Y13=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X4Y13=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X5Y13=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X6Y13=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X7Y13=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X8Y13=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X9Y13=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X10Y13=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X11Y13=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X12Y13=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X13Y13=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X14Y13=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X15Y13=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
/* [Increase Single Compartment Size In Row Y14] */
X1Y14=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X2Y14=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X3Y14=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X4Y14=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X5Y14=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X6Y14=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X7Y14=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X8Y14=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X9Y14=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X10Y14=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X11Y14=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X12Y14=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X13Y14=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X14Y14=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X15Y14=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
/* [Increase Single Compartment Size In Row Y15] */
X1Y15=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X2Y15=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X3Y15=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X4Y15=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X5Y15=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X6Y15=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X7Y15=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X8Y15=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X9Y15=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X10Y15=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X11Y15=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X12Y15=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X13Y15=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X14Y15=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]
X15Y15=0; //[0:off,1:DoubleX,2:DoubleY,3:DoubleBoth]



// ignore variable values below
/* [Hidden] */

//CreateArrays for Compartment SIze Increase
CompInc=[
            [X1Y1,X2Y1,X3Y1,X4Y1,X5Y1,X6Y1,X7Y1,X8Y1,X9Y1,X10Y1,X11Y1,X12Y1,X13Y1,X14Y1,X15Y1]
            ,[X1Y2,X2Y2,X3Y2,X4Y2,X5Y2,X6Y2,X7Y2,X8Y2,X9Y2,X10Y2,X11Y2,X12Y2,X13Y2,X14Y2,X15Y2]
            ,[X1Y3,X2Y3,X3Y3,X4Y3,X5Y3,X6Y3,X7Y3,X8Y3,X9Y3,X10Y3,X11Y3,X12Y3,X13Y3,X14Y3,X15Y3]
            ,[X1Y4,X2Y4,X3Y4,X4Y4,X5Y4,X6Y4,X7Y4,X8Y4,X9Y4,X10Y4,X11Y4,X12Y4,X13Y4,X14Y4,X15Y4]
            ,[X1Y5,X2Y5,X3Y5,X4Y5,X5Y5,X6Y5,X7Y5,X8Y5,X9Y5,X10Y5,X11Y5,X12Y5,X13Y5,X14Y5,X15Y5]
            ,[X1Y6,X2Y6,X3Y6,X4Y6,X5Y6,X6Y6,X7Y6,X8Y6,X9Y6,X10Y6,X11Y6,X12Y6,X13Y6,X14Y6,X15Y6]
            ,[X1Y7,X2Y7,X3Y7,X4Y7,X5Y7,X6Y7,X7Y7,X8Y7,X9Y7,X10Y7,X11Y7,X12Y7,X13Y7,X14Y7,X15Y7]
            ,[X1Y8,X2Y8,X3Y8,X4Y8,X5Y8,X6Y8,X7Y8,X8Y8,X9Y8,X10Y8,X11Y8,X12Y8,X13Y8,X14Y8,X15Y8]
            ,[X1Y9,X2Y9,X3Y9,X4Y9,X5Y9,X6Y9,X7Y9,X8Y9,X9Y9,X10Y9,X11Y9,X12Y9,X13Y9,X14Y9,X15Y9]
            ,[X1Y10,X2Y10,X3Y10,X4Y10,X5Y10,X6Y10,X7Y10,X8Y10,X9Y10,X10Y10,X11Y10,X12Y10,X13Y10,X14Y10,X15Y10]
            ,[X1Y11,X2Y11,X3Y11,X4Y11,X5Y11,X6Y11,X7Y11,X8Y11,X9Y11,X10Y11,X11Y11,X12Y11,X13Y11,X14Y11,X15Y11]
            ,[X1Y12,X2Y12,X3Y12,X4Y12,X5Y12,X6Y12,X7Y12,X8Y12,X9Y12,X10Y12,X11Y12,X12Y12,X13Y12,X14Y12,X15Y12]
            ,[X1Y13,X2Y13,X3Y13,X4Y13,X5Y13,X6Y13,X7Y13,X8Y13,X9Y13,X10Y13,X11Y13,X12Y13,X13Y13,X14Y13,X15Y13]
            ,[X1Y14,X2Y14,X3Y14,X4Y14,X5Y14,X6Y14,X7Y14,X8Y14,X9Y14,X10Y14,X11Y14,X12Y14,X13Y14,X14Y14,X15Y14]
            ,[X1Y15,X2Y15,X3Y15,X4Y15,X5Y15,X6Y15,X7Y15,X8Y15,X9Y15,X10Y15,X11Y15,X12Y15,X13Y15,X14Y15,X15Y15]
        ];
/*echo("<h1> X1Y1 CompInc(0,0)=",CompInc[0][0]); //X1Y1
echo("<h1> X2Y2 CompInc(1,1)=",CompInc[1][1]); // X2Y2
echo("<h1> X3Y4 CompInc(3,2)=",CompInc[3][2]); // X4Y3*/


print_part();
module print_part() {

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
        ,_WallT=WallT
        ,_BottomT=BottomT
        ,_SeparatorT=SeparatorT
        ,_NumX=NumX
        ,_NumY=NumY
        ,_Stackable=StackableBottom
        ,_TopCutout=TopCutout
        ,_MiddleCutout=MiddleCutout
        ,_BottomCutout=BottomCutout
        ,_HoleSizeDivider=HoleSizeDivider
        ,_CompartmentType=CompartmentType
        ,_InnerRadius=InnerEdgesRadius
        ,_OuterRadius=OuterEdgesRadius
        // Bottom Magnets for compartments
        ,_MagnetCount=MagnetCount
        ,_MagnetDiameter=MagnetDiameter
        ,_MagnetHeight=MagnetHeight
        ,_EncloseBottomMagnet=EncloseBottomMagnet
        // Generral Lid Parameters
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
        
        ,_Text2=text2
        ,_Font2=font2
        ,_FontSize2=FontSize2
        ,_StyleBold2=Bold2
        ,_StyleItalic2=Italic2
        ,_Text2HOffset=Text2HorizontalOffset
        ,_Text2VOffset=Text2VerticalOffset

        ,_CompInc=CompInc

	);
}


/************************************************ Rainer's Modules below *********************************************/
// Version History
// 6.0 2019-01-08
// - changed the bottom thickness for the Stackable lid to be defined by BottomT parameter instead of LidT to avoid very thick lids where not needed.
// - implemented automatically adjustment of text position for a stackable box.
// - fixed a bug where the text horizontal offset for line1 did not get applied
// - fixed a bug where the FingerCutoutCount parameter was not working
// - fixed a bug where the MiddleCutoutVerticalOffset was not working
// 5.9 2019-01-07
// - fixed some bugs related to slideoverlid generation&magnet position
// 5.8 2019-01-06
// - new options for the Text location on the lid that allow the text to go along the X or Y axis. this allows to orientate the text on the lid better
// 5.7
// - Reimplemeted all text handling
// - a 2nd line of text is now possible
// - improved positioning and orientation of text
// - regrouped all text parameters
// - fixed SlideoverLid when used with higher outer Radius
    
// 5.5
// - new parameter EncloseBottomMagnet. If selected, the bottomM magnets will be fully enclosed in the body. This will require you to stop the print justat the right time and insert the magnets before continuing.
// 5.4
// - Adjusted LidMagnet Positions &WallT correction for rounded stackable boxes
module RainersBoxCreator(
,_part="box" // box,lid
,_DebugMsg=""
,_LidType="Notched" //"SlideOver" (over the whole box) or "Notched"(with groove on top)
,_Height=30
,_SizeY=20
,_SizeX=40
,_WallT=1.5
,_BottomT=1.5
,_SeparatorT=1.5
,_NumX =2
,_NumY =3
,_Stackable=false
,_TopCutout=0
,_FingerCutoutCount=0
,_MiddleCutout=0
,_MiddleCutoutVerticalOffset=0
,_BottomCutout=0
,_HoleSizeDivider=4
,_CompartmentType=0
,_InnerRadius=1
,_OuterRadius=1
,_RecessDepth=5
// Bottom Magnets for compartments
,_MagnetDiameter=8.2
,_MagnetHeight=3
,_MagnetCount=1
,_EncloseBottomMagnet=0
// Generral Lid Parameters
,_LidType="Notched" //"SlideOver" (over the whole box) or "Notched"(with groove on top)
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
,_Text2=""
,_Font2=""
,_FontSize2=15
,_StyleBold2=0
,_StyleItalic2=0
,_Text2HOffset=0
,_Text2VOffset=0



,_CompInc=0


){
    //echo("<H1>ToDo's left!");
    /* ToDo: 
    */
    echo(str("<h2>BoxMaker called for: ",_color,",",_part,"</h2>"));
    //echo(str("BoxMaker _RecessDepth=: ",_RecessDepth));
    
    
    if(_DebugMsg!=""){echo(str("BoxMaker Debug: ",_DebugMsg));}
      
    // ==================== Parameter Validity Checks
    // LidT defines the how much the outer edge will be removed to be able to slide into the upper part of a box, So WallT will be automatically increased if to small
    // ----------- _LidType2
    _LidType2=(_Stackable && ( _LidType !="Stackable" && _LidType !="None" ))
                ? "Stackable"
                : _LidType;
    if(_LidType2!=_LidType)echo("<b><font color='orange'>Automatically adjusted LidType from ",_LidType," to ",_LidType2);
    // LidT defines the how much the outer edge will be removed to be able to slide into the upper part of a box, So WallT will be automatically increased if to small
    
    // ----------- _Height2
    _Height2=(_LidType2 =="Stackable"&&_part=="recursion box")
                ? _Height+_LidHeight
                : _Height;
    if(_Height2!=_Height)echo("<b><font color='orange'>Automatically adjusted _Height from ",_Height," to ",_Height2);
    
    // ---------- WallT/LidT - increase for stackable with LidMagnets
    // When using LidMagnets for a stackable box, we want to assure that the outer walls are big enough to actually have space for them.
    _LidT2tmp=0+(_Stackable==true&&_LidMagnet==1
        ?max(_LidT,_LidMagnetDia+.6)
        :_LidT);
    if(_LidT2tmp!=_LidT){
        echo(str("<b><font color='orange'>Automatically adjusted LidT from ",_LidT," to ",_LidT2tmp));    
    }
    //echo("Debug: _LidT=",_LidT,",_LidT2tmp=",_LidT2tmp);
   _WallT2tmp=0+(_Stackable==true||_LidType=="Stackable"
        //?max(_LidT+0.6,_WallT)
        ?max(_LidT,_WallT)
        :_WallT)
        ;
    //if(_WallT2tmp!=_WallT)echo(str("<b><font color='orange'>(1) Automatically adjusted _WallT from ",_WallT," to ",_WallT2tmp," (Stackable=",_Stackable,",LidType=",_LidType,")"));    
    
    // Adjust WallThickness to make room for the magnets
    _WallT3tmp=0+
        (_LidMagnet==1
            ?max(
                _LidMagnetDia-_InnerRadius/3.14+1   
                ,_WallT2tmp)
            :_WallT2tmp)
        //+(_LidMagnet==1 && _LidType=="Notched" ?_WallT2tmp-_LidT2:0)
         ;
    //if(_WallT3tmp!=_WallT2tmp)echo(str("<b><font color='orange'>(2) Automatically adjusted _WallT from ",_WallT2tmp," to ",_WallT3tmp," (LidMagnet=",_LidMagnet,",LidMagnetDia=",_LidMagnetDia,",InnerEdgesRadius=",_InnerRadius,")"));    
    
    // ---------- WallT 
    //echo("_WallT,_LidT2,_LidTolerance=",_WallT,_LidT2,_LidTolerance);    
    /*_WallT2=(_LidType2=="Notched"&&_WallT<(_LidT2+_LidTolerance+0.6)&&((_part=="both")||(_part=="box")||(_part=="lid"))
   
             ? // WallT willbe increased to allow minimum size of notched top 
               _LidT2+_LidTolerance+0.6
             : _WallT
    );*/
    _WallT4tmp=(_LidType2=="Notched"&&_WallT3tmp<(_LidT2tmp+0.6)&&((_part=="both")||(_part=="box")||(_part=="lid"))
   
             ? // WallT willbe increased to allow minimum size of notched top 
              _LidT2tmp+0.6
             : _WallT3tmp
    );
    //if(_WallT2!=_WallT4tmp)echo(str("(3) Automatically adjusted WallT from ",_WallT4tmp," to ",_WallT2));    
    
    //echo("_WallT2 after validity check=",_WallT2);
    
    // ---------- BottomT
    
    //If Bottom Magnets are used, increase BottomT by MagnetHeight
    // removed: if this is a stackable box, increase BottomT by StackableHeight
    //_StackableHeight=_LidHeight-_LidTolerance;
    _StackableHeight=_LidHeight;//-_LidTolerance;
    
    _BottomT2=_BottomT
                +(_MagnetCount==0?0:_MagnetHeight)
                +(_Stackable?_StackableHeight:0); // size increase for stackable bottom
    
    // ---------- MagnetHeight
    _MagnetHeight2=_MagnetHeight
                +(_Stackable?_StackableHeight:0);
   
     // ---------- Outer Radius 
    _SmallestBoxEdge = min(_SizeY+_WallT4tmp,_SizeX+_WallT4tmp,_Height2+_BottomT2);
    _OuterRadius2tmp=(
        _CompartmentType==0||_CompartmentType>1
        ?   // For A Box compartment the maxius Radius is the smallest side length
        min(_WallT4tmp+_InnerRadius,_OuterRadius,_SmallestBoxEdge/2-.01)
        :	// Circle Compartments
        min((_WallT4tmp+_InnerRadius/2),_OuterRadius)
    );
     
    // ---------- Inner Radius 
    _InnerRadius2tmp=min(_InnerRadius,min(_SizeX,_SizeY,_Height2*2)/2-0.01);
    
    // Now set actual parameters to use depending on _IgnoreValidityCheck parameter
    _WallT2=(_IgnoreValidityCheck?_WallT:_WallT4tmp);
    _LidT2=_IgnoreValidityCheck?_LidT:_LidT2tmp;
    
    _BoxSizeX=2*_WallT2+(_NumX-1)*(_SizeX+_SeparatorT)+_SizeX;
    _BoxSizeY=2*_WallT2+(_NumY-1)*(_SizeY+_SeparatorT)+_SizeY;
    _BoxSizeZ=_Height2+_BottomT2;      
    _InnerRadius2=_IgnoreValidityCheck?_InnerRadius:_InnerRadius2tmp;
    _OuterRadius2=_IgnoreValidityCheck?_OuterRadius:_OuterRadius2tmp;
     
   if(_WallT2!=_WallT){
        echo(str("<b><font color='orange'>Automatically adjusted WallT from ",_WallT," to ",_WallT2));    
    }
      
   if(_InnerRadius2!=_InnerRadius)echo("<b><font color='orange'>Automatically adjusted InnerRadius from ",_InnerRadius," to ",_InnerRadius2);
   if(_OuterRadius2<_OuterRadius)echo("<b><font color='orange'>Automatically adjusted OuterRadius from ",_OuterRadius," to ",_OuterRadius2);
    
   // Prepare font style
    _FontStr=str(_Font,":style=",(_StyleBold?"Bold ":" "),(_StyleItalic?"Italic":""));
    _FontStr2=str(_Font2,":style=",(_StyleBold2?"Bold ":" "),(_StyleItalic2?"Italic":""));
   // prepare variables for the textbox
    TBx=_BoxSizeX- 2*_OuterRadius2 -2; // the X Size of the TextBox
    TBy=_BoxSizeY- 2*_OuterRadius2 -2; // the Y SIze of the TextBox
    TBz=_BoxSizeZ- 2
        -(_part=="recursion box"&&_Stackable?_LidHeight:0)
   ; // the height of the TextBox
    TBPosX=TBx/2+_OuterRadius2  +1;
    TBPosY=TBy/2+_OuterRadius2  +1;
    TBPosZ=TBz/2+1
        +(_part=="recursion box"&&_Stackable?_LidHeight:0);
            
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
            _NumX * (_SizeX) + (_NumX-1)*_SeparatorT +2*_WallT2+20
            , 0
            , 0
        ]) 
        MakeLid();
    }
    
   module MakeBox(){
        RainersBoxCreator(
        ,_part="recursion box"
        ,_DebugMsg="box!"
        ,_Height=_Height2
        ,_SizeY=_SizeY
        ,_SizeX=_SizeX
        ,_WallT=_WallT2
        ,_BottomT=_BottomT
        ,_SeparatorT=_SeparatorT
        ,_NumX=_NumX
        ,_NumY=_NumY
        ,_Stackable=_Stackable        
        ,_TopCutout=_TopCutout
        ,_FingerCutoutCount=_FingerCutoutCount
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
        ,_EncloseBottomMagnet=_EncloseBottomMagnet
        // Generral Lid Parameters
        ,_LidHeight=_LidHeight
        ,_LidType=_LidType2
        ,_LidT=_LidT2
        ,_LidTolerance=_LidTolerance
        //specific to magnetic lids:
        ,_LidMagnet=_LidMagnet
        ,_LidMagnetDia=_LidMagnetDia
        ,_LidMagnetDepth=_LidMagnetDepth //+(_LidType2=="Stackable"?_LidHeight:0)

        ,_LidMagnetAddDist=0
        ,_LidCutout=0
        ,_RecessDepth=_RecessDepth+ (_LidType2=="Stackable"?_LidHeight:0)
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
        
        ,_Text2=_Text2
        ,_Font2=_Font2
        ,_FontSize2=_FontSize2
        ,_StyleBold2=_StyleBold2
        ,_StyleItalic2=_StyleItalic2
        ,_Text2HOffset=_Text2HOffset
        ,_Text2VOffset=_Text2VOffset
        ,_CompInc=_CompInc
	);
   } 
   module MakeLid(){
        //_LidT2=_WallT2;
        // Increase Lid thickness depending on magnet size 
        LidTAddHeight=(
            _LidMagnet==1
            ? (_LidT2 < (_LidMagnetDepth+1)
            ?_LidMagnetDepth+1-LidT
            :0)
            :0
        );
	
        //Caclulate the innerSize of the lid & real box height
        //  LidSizeX = (_NumX-1)*_SeparatorT + _NumX*_SizeX  +2*_WallT2+_LidTolerance;
        //  LidSizeY = (_NumY-1)*_SeparatorT + _NumY*_SizeY  +2*_WallT2+_LidTolerance;
        LidSizeX=_NumX*_SizeX+(_NumX-1)*SeparatorT+2*_WallT2;//-2*_LidT2;
        LidSizeY=_NumY*_SizeY+(_NumY-1)*SeparatorT+2*_WallT2;//-2*_LidT2;
      
        RealBoxHeight=_LidHeight*2 +_LidT2+LidTAddHeight;
	
        // Calculate the "real" possible inner radius
        SmallerSize=min(_SizeX,_SizeY,_Height2*2);
        InnerEdgesRadius2=min(_InnerRadius,SmallerSize/2-0.01);

        SmallestBoxEdge = min(_SizeY+_WallT2,_SizeX+_WallT2,_Height2+_BottomT);
        OuterEdgesRadius2=(
            _CompartmentType==0||_CompartmentType>1
            ?   // For A Box compartment the maxius Radius is the smallest side length
            min(_WallT2+InnerEdgesRadius2,_OuterRadius,SmallestBoxEdge/2-.01)
            :   // Circle Compartments
            min(InnerEdgesRadius2/2,_OuterRadius)
        );
        /*echo("LidMaker _LidType2=",_LidType2);
        echo("LidMaker InnerEdgesRadius2=",InnerEdgesRadius2);
        echo("LidMaker OuterEdgesRadius2=",OuterEdgesRadius2); 
        echo("!!LidMaker _LidT2=",_LidT2); 
        echo("!!LidMaker _LidHeight=",_LidHeight);*/
        //echo("!!LidMaker LidTAddHeight=",LidTAddHeight,"_BottomT=",_BottomT,"_LidT2=",_LidT2 ); 
        
        if(_LidType2=="Stackable"){
            //echo ("making stackable Lid!");
            // Create the box 2x as high as required
                difference(){
                RainersBoxCreator(
                    _part="recursion stackabelid"
                    ,_DebugMsg="Stackable Lid!"
                    ,_Height=_LidHeight//(_LidHeight+LidTAddHeight) // Height of the part that slides into the box cutout
                    ,_SizeY=_NumY*SizeY+(_NumY-1)*SeparatorT//+2*_WallT2
                    ,_SizeX=_NumX*SizeX+(_NumX-1)*SeparatorT//+2*_WallT2//-2*_LidT2+_LidTolerance
                    ,_WallT=_WallT2//+_LidTolerance//_LidT2-_LidTolerance/2
                    //,_BottomT=max(_LidT2,0+(_LidMagnet?_LidMagnetDepth+1:0))//_LidT2+LidTAddHeight//BottomT
                    ,_BottomT=max(_BottomT,0+(_LidMagnet?_LidMagnetDepth+1:0))//_LidT2+LidTAddHeight//BottomT
                    ,_SeparatorT=_SeparatorT
                    ,_NumX=1,_NumY=1
                    ,_Stackable=false
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
                    ,_LidType="Stackable"
                    ,_LidT=_LidT2
                    ,_LidHeight=_LidHeight
                    ,_LidTolerance=_LidTolerance
                    ,_LidMagnet=_LidMagnet
                    ,_LidMagnetDia=_LidMagnetDia
                    ,_LidMagnetDepth=_LidMagnetDepth//+_LidHeight//RealBoxHeight-_LidT2+LidTAddHeight+_LidMagnetDepth
                    ,_LidMagnetAddDist=0//_LidT2+_LidTolerance/2
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
                    ,_Text2=_Text2
                    ,_Font2=_Font2
                    ,_FontSize2=_FontSize2
                    ,_StyleBold2=_StyleBold2
                    ,_StyleItalic2=_StyleItalic2
                    ,_Text2HOffset=_Text2HOffset
                    ,_Text2VOffset=_Text2VOffset
                    ,colour="green"
                    );
                translate([-0.01,-0.01
                    //        ,_LidHeight+max(_LidT2,_LidMagnetDepth+1)-_LidTolerance]) 
                            ,max(_BottomT,0+(_LidMagnet?_LidMagnetDepth+1:0))+_LidHeight])
                    cube([_NumX*SizeX+(_NumX-1)*SeparatorT+2*_WallT2+0.02
                        ,_NumY*SizeY+(_NumY-1)*SeparatorT+2*_WallT2+0.02
                        ,RealBoxHeight*2]);
                   
                }
        }
        if(_LidType2=="Notched"||_LidType2=="SlideOver"){
            difference(){
            union(){
            if(_LidType2=="Notched"){
            difference(){
            // Create the box 2x as high as required
                RainersBoxCreator(
                    //_part=_LidType2=="Notched"?"recursion notchedlid":"recursion stackabelid"
                    _part="recursion notchedlid"
                    ,_DebugMsg="Notched Lid!"
                    ,_Height=(_LidHeight+LidTAddHeight)*2//_LidTolerance
                    ,_SizeY=_NumY*SizeY+(_NumY-1)*SeparatorT+2*_WallT2-2*_LidT2+_LidTolerance
                    ,_SizeX=_NumX*SizeX+(_NumX-1)*SeparatorT+2*_WallT2-2*_LidT2+_LidTolerance
                    ,_WallT=_LidT2-_LidTolerance/2
                    ,_BottomT=_LidT2+LidTAddHeight//BottomT
                    ,_SeparatorT=_SeparatorT
                    ,_NumX=1,_NumY=1
                    ,_Stackable=_Stackable
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
                    ,_LidType="Notched"
                    ,_LidT=_LidT2
                    ,_LidTolerance=0//_LidTolerance
                    ,_LidMagnet=_LidMagnet
                    ,_LidMagnetDia=_LidMagnetDia
                    ,_LidMagnetDepth=RealBoxHeight-_LidT2+LidTAddHeight+_LidMagnetDepth
                    ,_LidMagnetAddDist=0
                    //,_LidMagnetAddDist=_LidT2+_LidTolerance/2
                    ,_RecessDepth=0
                    ,_LidSHeight=0  // Height "slide" over portion of the lid
                    ,_LidST=0        // Thickness of the Slide over lid wall
                    ,_LidTolerance=_LidTolerance
                    ,_IgnoreValidityCheck=true 
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
                    ,_Text2=_Text2
                    ,_Font2=_Font2
                    ,_FontSize2=_FontSize2
                    ,_StyleBold2=_StyleBold2
                    ,_StyleItalic2=_StyleItalic2
                    ,_Text2HOffset=_Text2HOffset
                    ,_Text2VOffset=_Text2VOffset

                    ,colour="yellow"
                    );
                    
                    if(PerforatedLid==1)translate([LidT,LidT,-1])
                                    // createPattern(SizeX=LidSizeX,  SizeY=LidSizeY,HoleSize=4,Height=LidT+2, NumSides=6,Dist=1,Rotate=0);
                    createPattern(SizeX=_NumX*SizeX+(_NumX-1)*SeparatorT+2*_WallT2-2*_LidT2+_LidTolerance
                                ,SizeY=_NumY*SizeY+(_NumY-1)*SeparatorT+2*_WallT2-2*_LidT2+_LidTolerance
                                ,HoleSize=4,Height=LidT+2
                                ,NumSides=6,Dist=1,Rotate=0);
                    //
                    // Cut upper half of double size lid (to remove upper rounding)
                    translate([ 
                             -5,-5
                            ,_LidHeight+_LidT2+LidTAddHeight]) 
                    cube([LidSizeX+2*_LidT2+10,LidSizeY+2*_LidT2+10, RealBoxHeight*2+_WallT2]);
            
                    // Add optional round Cutouts to the finished lid
                        CutRX=(LidSizeX+2*_LidT2)/3;
                        CutRY=(LidSizeY+2*_LidT2)/3;
                    //[0:No,1:On X-Axis,2:On Y-Axis,3:On Both Sides]
                    if(LidCutout==2 || LidCutout==3){ 
                        translate([//(LidSizeX+1*LidT)/2
                                    (_NumX*SizeX+(_NumX-1)*SeparatorT+2*_WallT2)/2
                                    ,-1
                                    ,_LidT2+LidTAddHeight+CutRX+ (LidHeight>CutRX?LidHeight-CutRX:0)+0.01
                                ])
                    
                        rotate([-90,0,0])cylinder(r=CutRX,h=LidSizeY+2*_LidT2+5);
                    }
                    if(LidCutout==1 || LidCutout==3){ 
                    
                        translate([-1
                                , (_NumY*SizeY+(_NumY-1)*SeparatorT+2*_WallT2)/2//(LidSizeY+2*LidT)/2
                                ,_LidT2+LidTAddHeight+CutRY+ (LidHeight>CutRY?LidHeight-CutRY:0)+0.01])
                        rotate([0,90,0])cylinder(r=CutRY,h=LidSizeX+2*_LidT2+5);
                    }
                }
            }
            if(_LidType2=="SlideOver"){
                //echo("------SlideOverLid:_WallT,_WallT2,_LidT2=",_WallT,_WallT2,_LidT2);
                // Create the box 2x as high as required
                difference(){
                    RainersBoxCreator(
                        _part="recursion SlideOverLid"
                        ,_DebugMsg="SlideOver Lid!"
                        ,_Height=_BoxSizeZ+_LidHeight*2
                        ,_SizeY=LidSizeY+_LidTolerance
                        ,_SizeX=LidSizeX+_LidTolerance
                        ,_Stackable=_Stackable
                        ,_WallT=_LidT2
                        ,_BottomT=(_LidMagnet==1
                                        ?max(_LidT,1+_LidMagnetDepth)
                                        :LidT)
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
                        ,_IgnoreValidityCheck=true 
                        ,_LidType="SlideOver"
                        ,_LidT=_LidT2//0
                        ,_LidMagnet=_LidMagnet
                        ,_LidMagnetDia=_LidMagnetDia
                        ,_LidMagnetDepth=_BoxSizeZ+_LidHeight*2 +_LidMagnetDepth
                                //_BoxSizeZ+_LidHeight*2//RealBoxHeight-_LidT2-LidTAddHeight+_LidMagnetDepth
                        ,_LidMagnetAddDist=0
                        ,_RecessDepth=0
                        ,_LidSHeight=0 
                        ,_LidST=0       
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
                        ,_Text2=_Text2
                        ,_Font2=_Font2
                        ,_FontSize2=_FontSize2
                        ,_StyleBold2=_StyleBold2
                        ,_StyleItalic2=_StyleItalic2
                        ,_Text2HOffset=_Text2HOffset
                        ,_Text2VOffset=_Text2VOffset

                        ,colour="yellow"
                        );
                    if(PerforatedLid==1)translate([LidT,LidT,-1])
                    createPattern(SizeX=LidSizeX,SizeY=LidSizeY,HoleSize=4,Height=LidT+2,NumSides=6,Dist=1,Rotate=0);
        
                    // Cut upper half of double size lid (to remove upper rounding)
                        translate([ 
                            -5,-5
                            , _LidHeight+_LidT2+LidTAddHeight]) 
                        cube([
                                LidSizeX+_LidTolerance+2*_LidT2+10
                                ,LidSizeY+_LidTolerance+2*_LidT2+10
                                , (_BoxSizeZ+_LidHeight+_LidMagnetDepth)*2]);
                
                    // Add optional round Cutouts to the finished lid
                    CutRX=(LidSizeX+2*LidT)/3;
                    CutRY=(LidSizeY+2*LidT)/3;
                        
                    if(LidCutout==2 || LidCutout==3){ 
                        translate([(LidSizeX+2*LidT)/2
                                    ,-1
                                    ,_LidT2+LidTAddHeight+CutRX+ (LidHeight>CutRX?LidHeight-CutRX:0)+0.01
                                ])
                        rotate([-90,0,0])cylinder(r=CutRX,h=LidSizeY+2*_WallT2+_LidTolerance+2*LidT+4);
                    }
                   if(LidCutout==1 || LidCutout==3){ 
                       translate([-1
                                ,(LidSizeY+2*LidT)/2
                                ,_LidT2+LidTAddHeight+CutRY+ (LidHeight>CutRY?LidHeight-CutRY:0)+0.01])
                       
                        rotate([0,90,0])cylinder(r=CutRY,h=LidSizeX+2*_WallT2+_LidTolerance+2*LidT+2);
                    }
                }//Difference
            }
        }//union
 
        }//diference
    } // if(_LidType2=="Notched"||_LidType2=="Stackable"||_LidType2=="SlideOver"){
       
    } // end of module MakeLid()
    
    //======================================================== make the actual part!
    if(search("recursion",_part)==[0, 1, 2, 3, 0, 5, 6, 7, 8]){ //found recursion
        //echo(str("<h3>Boxmaker making ",_part," : X=",_SizeX,",Y=",_SizeY,",Z=",_Height2,",_WallT=",_WallT,",_WallT2=",_WallT2,"</h3>"));
        // prepare text variables
        //HorizontalAllignment="left"; //[left,centered,right]
        //VerticalAllignment="centered"; //[top,centered,bottom]
        RealSizeX=(_NumX * _SizeX + (_NumX-1)*_SeparatorT + 2*_WallT2);
        RealSizeY=(_NumY * _SizeY + (_NumY-1)*_SeparatorT + 2*_WallT2);
        RealSizeZ=_Height2+_BottomT2;
        echo(str("<h3>Boxmaker Actual Dimensions for ",_part," : X=",RealSizeX,",Y=",RealSizeY,",Z=",RealSizeZ));
        //echo(str("Boxmaker Actual _RecessDepth=",_RecessDepth));
        //echo(str("Boxmaker _Stackable=",_Stackable,",_LidType2=",_LidType2));
        posZ=(_TextVAllign=="top"
                        ?RealSizeZ-_OuterRadius2-1
                        : (_TextVAllign=="bottom"
                            ?_OuterRadius2+1
                            :(RealSizeZ)/2)   );
        color(_color) difference() {union(){
            //aeussere Box
            // =============================== Modification to the bottom of a stackable box
            // Tolerance WILL be aplied her to X&Y
            // Tolerance will not be aplied here to z
            // the bottom X&Y will be reduced by LidT+LidTolerance
            
            if(_Stackable&&_part=="recursion box"){
                // add a stacking bottom
                _LidST=_LidT2+_LidTolerance;
                _LidSHeight=_LidHeight;
                difference(){
                    roundedRect([
                        RealSizeX
                        ,RealSizeY
                        ,RealSizeZ] 
                        ,  radius=_OuterRadius2, center=false);
                    difference(){
                        // The Outside Box of the stackable bottom Stencil
                        translate([-0.01-(_FontThickness>0?_FontThickness:0)
                                  ,-0.01-(_FontThickness>0?_FontThickness:0)
                                  ,-0.01])
                        roundedRect([ 
                            RealSizeX+0.02+(_FontThickness>0?2*_FontThickness:0)
                            ,RealSizeY+0.02+(_FontThickness>0?2*_FontThickness:0)
                            ,_LidHeight]
                            ,radius=_OuterRadius2
                        );
                        // Cut the inside of the stackable  bottom stencil
                       translate([_LidST
                                  ,_LidST
                                  ,-0.01])
                        roundedRect([
                             RealSizeX-2*_LidST
                            ,RealSizeY-2*_LidST
                            ,_LidHeight+5]
                            ,radius=_OuterRadius2
                        );
                    }
                }
                
            }else if (_part=="recursion stackabelid"){
                // only round the outside edges for a stackable box
                 //echo("debug: Part=recursion stackabelid, _BottomT2=",_BottomT2);
                 roundedRect([
                    //roundedCube([
                        RealSizeX
                        ,RealSizeY
                        ,RealSizeZ] 
                        ,  radius=_OuterRadius2, center=false);
                   
            }else if(_LidType2=="Stackable"){
                    // if lid is stackable, no rounding on top&bottom 
                    roundedRect([
                    RealSizeX
                    ,RealSizeY
                    ,RealSizeZ]
                    ,  radius=_OuterRadius2, center=false);
            }else{
                // normal box rounded on all edges
                roundedCube([
                RealSizeX
                ,RealSizeY
                ,RealSizeZ]
                ,  radius=_OuterRadius2, center=false);
             
           }
           // =================================== Positive Text
           if(text !="" && _FontThickness>0 && _part=="recursion box"){
              CreateBoxText();
           }
        }//union positive box&text
            // Innere box / compartment 
            // ================================ Inner Cutout for a stackable lid
            if(_part=="recursion stackabelid"){
                // tolerance WILL be applied here for x&y
                // tolerance will not be applied her for z
                //echo("Inner Cutout for a stackable lid. _LidT2=",_LidT2,",_LidTolerance=",_LidTolerance);
                _LidST=(_LidT2)+_LidTolerance;
                _LidSHeight=_LidHeight;
                difference(){
                    //translate([-0.01,-0.01,_BottomT2])
                    translate([-0.01,-0.01,max(_BottomT,0+(_LidMagnet?_LidMagnetDepth+1:0))])
                    
                    roundedRect([
                        RealSizeX+0.02
                        ,RealSizeY+0.02
                        ,RealSizeZ]
                        ,  radius=_OuterRadius2, center=false);
                    //inner part of the stackable lid stencil
                    translate([_LidST
                              ,_LidST
                    //          ,_LidT2])
                              ,max(_BottomT,0+(_LidMagnet?_LidMagnetDepth+1:0))])
                    roundedRect([
                        RealSizeX-2*_LidST
                        ,RealSizeY-2*_LidST
                        ,RealSizeZ] 
                        ,  radius=_OuterRadius2, center=false);
                }
            }else{ //normal box, create the required cutouts..
            for (Row =[1:_NumY+1]) {
                for (Col =[1:_NumX]){
                    // calculate compartment position
                    _CompX=_WallT2 + (Col-1)*(_SizeX+_SeparatorT);
                    _CompY=_WallT2 + (Row-1)*(_SizeY+_SeparatorT);
                    if (_CompartmentType==0&&(Row<_NumY+1)){ // Box compartment
                       //echo(str("X",Col,"Y",Row, "=",_CompInc[Row-1][Col-1])); //X1Y1
                       //echo("Creating box compartment cutout _BottomT2 -0.01 @Z=",_BottomT2 -0.01);
                       translate([_CompX-0.01 
                        , _CompY-0.01 
                        , _BottomT2 -0.01])
                       if((_part=="recursion notchedlid" ||_part=="recursion SlideOverLid") && _Stackable){
                          roundedRect([
                            0.02+ _SizeX+   (_CompInc[Row-1][Col-1]==1|| _CompInc[Row-1][Col-1]==3?_SizeX+_SeparatorT:0)
                            ,0.02+ _SizeY+  (_CompInc[Row-1][Col-1]==2|| _CompInc[Row-1][Col-1]==3?_SizeY+_SeparatorT:0)
                            ,_Height2*2]
                            ,radius=_InnerRadius2
                            ,center=false
                            );
                       }else{
                        roundedCube([
                            0.02+ _SizeX+   (_CompInc[Row-1][Col-1]==1|| _CompInc[Row-1][Col-1]==3?_SizeX+_SeparatorT:0)
                            ,0.02+ _SizeY+  (_CompInc[Row-1][Col-1]==2|| _CompInc[Row-1][Col-1]==3?_SizeY+_SeparatorT:0)
                            ,_Height2*2]
                            ,radius=_InnerRadius2
                            ,center=false
                            );
                       }
                   }
                    if (_CompartmentType==1&&(Row<_NumY+1)){ // circle/cylinder compartment
                        translate([ _CompX + SizeX/2 
                        , _CompY + SizeY/2 
                        , _BottomT2])
                        scale([1,SizeY/SizeX,1]) 
                        rounded_cylinder(r=SizeX/2,h=_Height2+_WallT2+_InnerRadius2,n=_InnerRadius2);
                    }        
                    if (_CompartmentType>=3&&_CompartmentType<=10&&(Row<_NumY+1)){ // multigon compartment
                         translate([ _CompX + _SizeX/2 
                        , _CompY + _SizeY/2 
                        , _BottomT2])
                        scale([1,_SizeY/_SizeX,1]) 
                        RoundedMultigon(_CompartmentType,_SizeX,(_InnerRadius2)
                        ,_Height2+_WallT2);     
                        }           
                    if (_CompartmentType==11&&(Row<_NumY+1)){ // hoizontal cylinder X-Axis compartment
                        translate([_CompX-0.01 
                            , _CompY-0.01     
                            , _BottomT2])
                        rotatedCylinder([_SizeY,_SizeX,(_SizeY*_Height2)*2]
                            ,r=_InnerRadius2);           
                     }           
                      if (_CompartmentType==12&&(Row<_NumY+1)){ // hoizontal cylinder Y Axis compartment         
                        translate([_CompX-0.01 
                            , _CompY-0.01 +_SizeY
                            , _BottomT2])
                        rotate([0,0,-90])
                        rotatedCylinder(
                          [_SizeX,_SizeY,(_SizeX*_Height2)*2]
                          ,r=_InnerRadius2);           
                     }           
                     if(_MagnetCount==1&&Row<=NumY){
                        translate([_CompX-0.01 +_SizeX/2
                        , _CompY-0.01 +_SizeY/2
                        ,( _EncloseBottomMagnet==1?0.75:-0.01)])
                        cylinder(h = (_MagnetHeight2), r = _MagnetDiameter/2);
                     }
                     if(_MagnetCount==2&&Row<=NumY){
                        OffsetX=(_SizeX<_SizeY?0:_SizeX/4);
                        OffsetY=(_SizeX<_SizeY?SizeY/4:0);
                        translate([
                        _CompX+_SizeX/2- OffsetX
                        ,_CompY+_SizeY/2- OffsetY
                        ,( _EncloseBottomMagnet==1?0.75:-0.01)])
                        cylinder(h = _MagnetHeight2, r = _MagnetDiameter/2);
                        translate([
                        _CompX+_SizeX/2+ OffsetX
                        ,_CompY+_SizeY/2+ OffsetY
                        ,( _EncloseBottomMagnet==1?0.75:-0.01)])
                        cylinder(h = _MagnetHeight2, r = _MagnetDiameter/2);
                    }
                    if(_MagnetCount==4&&Row<=NumY){
                        OffsetX=_SizeX/4;
                        OffsetY=_SizeY/4;
                        
                        translate([
                        _CompX+_SizeX/2- OffsetX
                        ,_CompY+_SizeY/2- OffsetY
                        ,( _EncloseBottomMagnet==1?0.75:-0.01)])
                        cylinder(h = (_MagnetHeight2), r = _MagnetDiameter/2);
                        translate([
                        _CompX+_SizeX/2+ OffsetX
                        ,_CompY+_SizeY/2+ OffsetY
                        ,( _EncloseBottomMagnet==1?0.75:-0.01)])
                        cylinder(h = (_MagnetHeight2), r = _MagnetDiameter/2);
                        translate([
                        _CompX+_SizeX/2- OffsetX
                        ,_CompY+_SizeY/2+ OffsetY
                        ,( _EncloseBottomMagnet==1?0.75:-0.01)])
                        cylinder(h = (_MagnetHeight2), r = _MagnetDiameter/2);
                        translate([
                        _CompX+_SizeX/2+ OffsetX
                        ,_CompY+_SizeY/2- OffsetY
                        ,( _EncloseBottomMagnet==1?0.75:-0.01)])
                        cylinder(h = (_MagnetHeight2), r = _MagnetDiameter/2);
                    }
                }//end for (Col =[1:_NumX])
                            
                 // Aussparung an Oeffnungsseite         
                if ((_TopCutout==1)||(_TopCutout==3)){//1:RoundPerRow,3:RoundAllSides
                    CutoutCylDia = min(_SizeY,_Height2*2)/_HoleSizeDivider;
                    translate([
                        -1 
                        ,((Row-1)*(_SizeY+_SeparatorT))+(_SizeY/2)+_WallT2
                        ,_Height2+_BottomT2])
                    rotate ([0,90,0])
                    cylinder(h = (_SizeX)*(_NumX)+(_NumX-1)*_SeparatorT +2*_WallT2+2, r = CutoutCylDia);
                }
                if ((_TopCutout==2)||(_TopCutout==3)){ //2:RoundPerColumn,3:RoundAllSides
                    for (Col =[1:_NumX]){
                        CutoutCylDia = min(_SizeX,_Height2*2)/_HoleSizeDivider;
                        translate([
                            ((Col-1)*(_SizeX+_SeparatorT))+_SizeX/2+_WallT2
                            ,-_WallT2
                            ,_Height2+_BottomT2])
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
                    // ====================================================== Finger Slots for Rows
                    if((_TopCutout==4)||(_TopCutout==5)){
                        //echo ("Debug: _FingerCutoutCount=",_FingerCutoutCount);
                        for (Col =[1:_NumX+1]){
                            if ( (Row!=_NumY+1 )&& //No Extra Row needed here....
                                    (
                                        ((_FingerCutoutCount==1) && ( (Row == 1) || (Row==NumY+1))&&((Col==1)||(Col==NumX+1))) // Outside Row
                                        || ((_FingerCutoutCount==1) && ( (Col == 1) || (Col==NumX+1))&&((Col==1)||(Col==NumX+1)))// Outside Row
                                        // First Row
                                        || ((_FingerCutoutCount==2) && (Col == 1)) // First Col
                                        || _FingerCutoutCount==0)
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
                                ,_Height2+2*_BottomT2 ]);
                            }
                        }
                    }
                    if((_TopCutout==4)||(_TopCutout==6)){
                        //FingerSlots for each col (OK)
                        for (Col =[1:_NumX]){
                            if ( 
                                    ((_FingerCutoutCount==1) && ( (Row == 1) || (Row==NumY+1))) // Outside Row
                                    || ((_FingerCutoutCount==1) && ( (Col == 1) || (Col==NumX))&&Row==1) // Outside Row
                                    || ((_FingerCutoutCount==2) && (Row == 1)) // First Col
                                    
                                    || _FingerCutoutCount==0
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
                                ,_Height2+2*_BottomT2]);
                            }
                        }
                    }
                    
                }
                //7:OnlyOneOn RowSide,8,9: Both Sides
                if( (_TopCutout==7||_TopCutout==9)&&(Row==1)){ // Only One Round Cutout OnRowSide
                    //    CutoutCylDia = _SizeY/_HoleSizeDivider;
                    CutoutCylDia = min(_SizeY,_Height2*2)/_HoleSizeDivider;
                    
                    translate([
                    -_SizeX/2
                    ,(((NumY-1)/2)*(_SizeY+_SeparatorT))+(_SizeY/2)+_WallT2
                    ,_Height2+_BottomT2])
                    rotate ([0,90,0])
                    rounded_cylinder(h = (_SizeX), r = CutoutCylDia,n=11);        translate([
                    -_SizeX/2 +_WallT2+_NumX*SizeX+(_NumX-1)*_SeparatorT+_WallT2
                    ,(((NumY-1)/2)*(_SizeY+_SeparatorT))+(_SizeY/2)+_WallT2
                    ,_Height2+_BottomT2])
                    rotate ([0,90,0])
                    rounded_cylinder(h = (_SizeX), r = CutoutCylDia,n=11);            
                    
                }
                //8:OnlyOneOn ColSide,8 ,9: Both Sides
                if( (_TopCutout==8||_TopCutout==9||_TopCutout==10)&&(Row==1)){ // Only One Round Cutout OnRowSide
                    CutoutCylDia = min(_SizeX,_Height2*2)/_HoleSizeDivider;
                    if(_TopCutout!=10){
                        translate([
                            (((_NumX-1)/2)*(_SizeX+_SeparatorT))+(_SizeX/2)+_WallT2
                            ,(_NumY-1)*_SizeY+(_NumY-1)*_SeparatorT+(_SizeY/2)+_WallT2
                    
                            ,_Height2+_BottomT2])
                    
                        rotate ([-90,0,0])
                        rounded_cylinder(h = (_SizeY), r = CutoutCylDia,n=11);
                    }
                    translate([
                    (((NumX-1)/2)*(_SizeX+_SeparatorT))+(_SizeX/2)+_WallT2
                    ,-_SizeY/2 +_WallT2                
                    ,_Height2+_BottomT2])
                    rotate ([-90,0,0])
                    rounded_cylinder(h = (_SizeY), r = CutoutCylDia,n=11);
                }
                // Aussparung(en) in der Mitte Je Row
                // 1:Round on X Axis,4:Round on Y Axis
                if (_MiddleCutout==1&&Row<=_NumY){ // Round on X Axis
                    //echo("Debug: ,_MiddleCutoutVerticalOffset=",_MiddleCutoutVerticalOffset);
                    
                    CutoutCylDia = min(_Height2,_SizeY)/_HoleSizeDivider;
                    translate([
                    -_WallT2/2,
                    (Row-1)*(_SizeY+_SeparatorT)+(_SizeY/2)+_WallT2
                    ,_Height2/2+_BottomT2+_MiddleCutoutVerticalOffset])
                    rotate ([0,90,0])
                    cylinder(h = _NumX*_SizeX+(_NumX-1)*SeparatorT+3*_WallT2, r = CutoutCylDia);
                }
                if (_MiddleCutout==4&&Row<=1){ // Round on Y Axis
                    for (Col =[1:_NumX]){
                        CutoutCylDia = min(_Height2,_SizeX)/_HoleSizeDivider;
                        translate([
                        (Col-1)*(_SizeX+_SeparatorT)+(_SizeX/2)+_WallT2
                        ,-_WallT2/2
                        ,_Height2/2+_BottomT2+_MiddleCutoutVerticalOffset])
                        rotate ([0,90,90])
                        cylinder(h = _NumY*_SizeY+(_NumY-1)*SeparatorT+3*_WallT2, r = CutoutCylDia);
                    }
                }
                if (_MiddleCutout==2 && Row==1){  // Beide Seiten OK
                    CutoutCylDia = min(_Height2,_SizeY)/_HoleSizeDivider;
                    translate([-_WallT2/2
                    ,-1*CutoutCylDia/4
                    ,_Height2/2+_BottomT2+_MiddleCutoutVerticalOffset])
                    rotate ([0,90,0])
                    cylinder(h = _NumX*_SizeX+(_NumX-1)*SeparatorT+3*_WallT2, r = CutoutCylDia);
                    translate([
                    -_WallT2/2
                    ,(NumY)*_SizeY +(NumY-1)*_SeparatorT+2*_WallT2+1*CutoutCylDia/4
                    ,_Height2/2+_BottomT2+_MiddleCutoutVerticalOffset])
                    rotate ([0,90,0])
                    cylinder(h =_NumX*_SizeX+(_NumX-1)*SeparatorT+3*_WallT2, r = CutoutCylDia);
                }
                if (_MiddleCutout==3&&Row<=_NumY){ // Mitte Diamond
                        _CutoutCylDia = min(_SizeY*.95,_Height2*.95)/(_HoleSizeDivider);
                        translate([
                            ((_NumX)*_SizeX+(_NumX-1)*_SeparatorT+1*_WallT2+2)/2 
                            ,(_SizeY/2)+_WallT2+(Row-1)*(_SizeY+_SeparatorT)
                            ,_Height2/2+_WallT2+_MiddleCutoutVerticalOffset])
                        scale([1,max(_SizeY,_Height2)/_Height2,max(_SizeY,_Height2)/_SizeY])
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
                if (_BottomCutout==3&&Row<=_NumY){ //3:Hole on bottom
                    //echo("BottomCutout,Row=",Row);
                    for (Col =[1:_NumX]){
                        HoleDiameter= (_SizeY<_SizeX)?_SizeY/_HoleSizeDivider:_SizeX/_HoleSizeDivider;
                        translate([
                        Col*_SizeX + (Col-1)*_SeparatorT -_SizeX/2+_WallT2
                        ,Row*_SizeY + (Row-1)*_SeparatorT -_SizeY/2+_WallT2
                        ,-_BottomT2/2])
                        rotate ([0,0,0])
                        cylinder(h = (_Height2+2*_BottomT2), r = HoleDiameter);
                    }
                }
            } //End For (Row =[1:_NumY+1]) {
        } // if(_part!="recursion stackabelid"){
            //============================================== Add LidMagnets to box and Lid
            if (_LidMagnet==1){
                // For a box with the groove for the notched lid, the magnets have to move further to the inside
                _LidMagnetAddDist2=_LidMagnetAddDist
                   +(_LidType2=="Notched"&&(_part=="recursion box"||_part== "recursion notchedlid")?_LidT2+0.6:0)
                   +(_LidType2=="SlideOver"&&_part=="recursion box"?0.6:0)
                   +(_LidType2=="SlideOver"&&_part=="recursion SlideOverLid"?_LidT2+_LidTolerance/2+0.6:0)
                   +(_LidType2=="Stackable"&&(_part=="recursion box"||_part== "recursion stackabelid")?0.6+_OuterRadius2/3.14:0);
                _LidMagnetAddDepth=0
                   +(_LidType2=="Stackable"&&_part== "recursion stackabelid"?_Height2:0)
                   ;
                _BoxSizeX=2*_WallT2+(_NumX-1)*(_SizeX+_SeparatorT)+_SizeX;
                _BoxSizeY=2*_WallT2+(_NumY-1)*(_SizeY+_SeparatorT)+_SizeY;
                _LidToleranceMagnetAdjZ=0
                    +(_part=="recursion stackabelid"?_LidTolerance:0);
                //echo(str("LidMagnet on top of box/lid. _Height2=",_Height2,", _BottomT2=",_BottomT2,",_LidT2=",_LidT2,", _LidMagnetDepth=",_LidMagnetDepth,",_LidToleranceMagnetAdjZ=",_LidToleranceMagnetAdjZ,",_LidTolerance=",_LidTolerance,",_LidMagnetAddDist=",_LidMagnetAddDist,",_LidMagnetAddDist2=",_LidMagnetAddDist2));
                //echo("addMagnets..Part=",_part,",Z=",_Height2+_BottomT2 -_LidToleranceMagnetAdjZ -_LidMagnetDepth -_LidMagnetAddDepth);
                //echo("addMagnets..Part=",_part,",Abstand zwischen Magneten=",(_LidMagnetDia/2+_LidMagnetAddDist2)-(_BoxSizeY-(_LidMagnetDia/2)-_LidMagnetAddDist2));
                translate([
                    _LidMagnetDia/2 +_LidMagnetAddDist2
                    ,_LidMagnetDia/2+_LidMagnetAddDist2
                    ,_Height2+_BottomT2 -_LidToleranceMagnetAdjZ -_LidMagnetDepth -_LidMagnetAddDepth
                    ])
                cylinder(r=_LidMagnetDia/2,h=_LidMagnetDepth+0.01+_LidMagnetAddDepth);
                // LidMagnet 2v4
                translate([
                    _BoxSizeX-(_LidMagnetDia/2)-_LidMagnetAddDist2
                    ,_LidMagnetDia/2+_LidMagnetAddDist2
                    ,_Height2+_BottomT2 -_LidToleranceMagnetAdjZ-_LidMagnetDepth -_LidMagnetAddDepth
                    ])
                cylinder(r=_LidMagnetDia/2,h=_LidMagnetDepth+0.01+_LidMagnetAddDepth);
                // LidMagnet 3v4
                translate([
                    _LidMagnetDia/2+_LidMagnetAddDist2
                    ,_BoxSizeY-(_LidMagnetDia/2)-_LidMagnetAddDist2
                    ,_Height2+_BottomT2 -_LidToleranceMagnetAdjZ-_LidMagnetDepth-_LidMagnetAddDepth
                    ])
                cylinder(r=_LidMagnetDia/2,h=_LidMagnetDepth+0.01+_LidMagnetAddDepth);
                // LidMagnet 4v4
                translate([
                    _BoxSizeX-(_LidMagnetDia/2)-_LidMagnetAddDist2
                    ,_BoxSizeY-(_LidMagnetDia/2)-_LidMagnetAddDist2
                    ,_Height2+_BottomT2 -_LidToleranceMagnetAdjZ-_LidMagnetDepth-_LidMagnetAddDepth
                    ])
                cylinder(r=_LidMagnetDia/2,h=_LidMagnetDepth+0.01+_LidMagnetAddDepth);
                // ==================================== Magnet on the bottom of a stackable box
                if(_Stackable){
                    //echo("Stackable bottom magnets. _LidMagnetDepth=",_LidMagnetDepth);
                    translate([
                    _LidMagnetDia/2+_LidMagnetAddDist2
                    ,_LidMagnetDia/2+_LidMagnetAddDist2-_LidMagnetAddDepth
                    ,-0.01
                    ])
                    cylinder(r=_LidMagnetDia/2,h=_LidMagnetDepth+0.01+_LidMagnetAddDepth+_LidHeight);
                    // LidMagnet 2v4
                    translate([
                    _BoxSizeX-(_LidMagnetDia/2)-_LidMagnetAddDist2
                    ,_LidMagnetDia/2+_LidMagnetAddDist2
                    ,-0.01])
                    cylinder(r=_LidMagnetDia/2,h=_LidMagnetDepth+0.01+_LidHeight);
                    // LidMagnet 3v4
                    translate([
                    _LidMagnetDia/2+_LidMagnetAddDist2
                    ,_BoxSizeY-(_LidMagnetDia/2)-_LidMagnetAddDist2
                    ,-0.01])
                    cylinder(r=_LidMagnetDia/2,h=_LidMagnetDepth+0.01+_LidHeight);
                    // LidMagnet 4v4
                    translate([
                    _BoxSizeX-(_LidMagnetDia/2)-_LidMagnetAddDist2
                    ,_BoxSizeY-(_LidMagnetDia/2)-_LidMagnetAddDist2
                    ,-0.01])
                    cylinder(r=_LidMagnetDia/2,h=_LidMagnetDepth+0.01+_LidHeight);
                    
                }
                //======  Cutout support Cylinder from stackable lid to avoid collision when closing lid
                if(_LidType=="Stackable" && _part=="recursion stackabelid"){
                    //echo("Debug: Removing Supportcyinder from stackable lid");
                    _SupportCylZPos=(_BottomT2>_LidMagnetDepth?_BottomT2:_LidMagnetDepth);
                    
                    _SupportCylActualHeight=_Height2+1;
                    // LidMagnet 1v4
                    translate([
                    _LidMagnetDia/2+_LidMagnetAddDist2
                    ,_LidMagnetDia/2+_LidMagnetAddDist2
                    ,_SupportCylZPos])
                    edgeCylinder(r=_LidMagnetDia/2+_LidTolerance
                                ,h=_SupportCylActualHeight
                                ,rotate=0);
                    // LidMagnet 2v4
                    translate([
                    _BoxSizeX-(_LidMagnetDia/2)-_LidMagnetAddDist2
                    ,_LidMagnetDia/2+_LidMagnetAddDist2
                    ,_SupportCylZPos])
                    edgeCylinder(r=_LidMagnetDia/2+_LidTolerance
                                ,h=_SupportCylActualHeight
                                ,rotate=90);
                    // LidMagnet 3v4
                    translate([
                    _LidMagnetDia/2+_LidMagnetAddDist2
                    ,_BoxSizeY-(_LidMagnetDia/2)-_LidMagnetAddDist2
                    ,_SupportCylZPos])
                    edgeCylinder(r=_LidMagnetDia/2+_LidTolerance
                                ,h=_SupportCylActualHeight
                                ,rotate=270);
                    // LidMagnet 4v4
                    translate([
                    _BoxSizeX-(_LidMagnetDia/2)-_LidMagnetAddDist2
                    ,_BoxSizeY-(_LidMagnetDia/2)-_LidMagnetAddDist2
                    ,_SupportCylZPos])
                    edgeCylinder(r=_LidMagnetDia/2+_LidTolerance
                                ,h=_SupportCylActualHeight
                                ,rotate=180);
                }
            }
            //DEBUGView
            if(false)
                translate([-1,-1,-1])
                cube([_SizeY/2+_WallT2,_SizeX+_WallT2,_BoxSizeZ+3]);
            // Cutout the inner top side of the complete box
            //echo("====================_RecessDepth=",_RecessDepth,",_Height2=",_Height2);
            if ( _RecessDepth<_Height2&& _RecessDepth>0){
                translate([_WallT2 //-0.01
                        , _WallT2 //-0.01
                        , _BottomT2 +(_Height2-_RecessDepth)])
                        
                roundedRect([
                    _NumX*_SizeX+(_NumX-1)*_SeparatorT//-0.02
                    ,_NumY*_SizeY+(_NumY-1)*_SeparatorT//-0.02
                    ,_RecessDepth+_OuterRadius2]//+0.01]
                    ,radius=_OuterRadius2//+0.01
                );
            }
            //============================== Slide Over (grooveed) Lid
            //_LidSHeight=4 // Height "slide" over portion of the lid
            //_LidST=1 // Thickness of the Slide over lid wall
            // ================================== Modification to the top of a stackable box
            // tolerance will not be applied here for x&y
            // tolerance WILL be applied here for z
            if(_LidType2=="Stackable"&&_part=="recursion box"){
                // echo("Modifying the box to be stackable on the top");
                //_LidST=LidT;//(_WallT2-_LidT2);//-_LidTolerance/2;
                _LidST=(_LidT2);
                _LidSHeight=_LidHeight;
                difference(){
                    // The Outside Box of the stackable Lid Stencil
                    // Cut the inside of the lid stencil
                    translate([_LidST
                                ,_LidST
                                ,_BottomT2+_Height2-_LidSHeight-_LidTolerance])
                    roundedRect([
                         _NumX*_SizeX+(_NumX-1)*_SeparatorT+2*_WallT2-2*_LidST
                        ,_NumY*_SizeY+(_NumY-1)*_SeparatorT+2*_WallT2-2*_LidST
                        ,_LidSHeight*2]
                        ,radius=_OuterRadius2
                    );
                }
            }
            // =========================== The modification to the actual BOX for a notched Lid
            if(_LidType2=="Notched"&&_part=="recursion box"){ 
                echo("==================== Modifying the box to be notched on the top");
                //echo(str("Notched Lid on box: _WallT2=",_WallT2,", _LidT2=",_LidT2));
                _LidST=(_WallT2-_LidT2);
                _LidSHeight=_LidHeight;
                 echo(str("Notched Lid on box: _LidST=",_LidST,", _LidSHeight=",_LidSHeight));
                
                difference(){
                    // The Outside Box of the Notched Lid Stencil
                    translate([-0.01-(_FontThickness>0?_FontThickness:0)
                              ,-0.01-(_FontThickness>0?_FontThickness:0)
                              ,_BottomT2+_Height2-_LidSHeight+_LidTolerance])
                    
                roundedRect([
                        _NumX*_SizeX+(_NumX-1)*_SeparatorT+2*_WallT2+0.02+(_FontThickness>0?2*_FontThickness:0)
                        ,_NumY*_SizeY+(_NumY-1)*_SeparatorT+2*_WallT2+0.02+(_FontThickness>0?2*_FontThickness:0)
                        ,_LidSHeight*2]
                        ,radius=_OuterRadius2
                    );
                    // Cut the inside of the lid stencil
                    translate([_WallT2-_LidST
                                ,_WallT2-_LidST
                                ,_BottomT2+_Height2-_LidSHeight+_LidTolerance])
                    roundedRect([
                         _NumX*_SizeX+(_NumX-1)*_SeparatorT+2*_LidST
                        ,_NumY*_SizeY+(_NumY-1)*_SeparatorT+2*_LidST
                        ,_LidSHeight*2]
                        ,radius=_OuterRadius2
                    );
                }
            }
            // =========================== The modification to the actual lid for a notched lid
            if(_LidType2=="Notched" && _part=="recursion notchedlid"){ 
                //echo("Notched Lid on Lid: _WallT2=",_WallT2,", _LidT2=",_LidT2);
                _LidST=(_LidT2)-_LidTolerance;
                _LidSHeight=_LidHeight;
                //echo("modifying lid for notched. _WallT2=",_WallT2,",_LidT2=",_LidT2,",_LidST=",_LidST);
                // The Outside Box of the Notched Lid Stencil
                translate([_LidST
                        ,_LidST
                        ,_BottomT2])
                roundedRect([
                    _NumX*_SizeX+(_NumX-1)*_SeparatorT+2*_WallT2-2*_LidST
                    ,_NumY*_SizeY+(_NumY-1)*_SeparatorT+2*_WallT2-2*_LidST
                    ,_Height2*2]
                    ,radius=_OuterRadius2
                    ,center=false
                );
                
            }
            // ============================= Text Imprint to top of the lid
            // [0:None,1:Negative imprint on top of lid X-Axis,2:Negative imprint inside of lid X-Axis,3:both on X-Axis,4:Negative imprint on top of lid Y-Axis,5:Negative imprint inside of lid Y-Axis,6:both on Y-Axis]
            if(text !=""  && (_part=="recursion SlideOverLid"||_part=="recursion notchedlid"||_part=="recursion stackabelid")){
                if (_TextLocationLid==1|| _TextLocationLid==3
                    ||_TextLocationLid==4||_TextLocationLid==6){// Text Imprint to top of the lid 
                    translate([TBPosX,TBPosY,0])  
                    rotate([180
                            ,0
                            ,0-_TextRotation
                                +(_TextLocationLid==4||_TextLocationLid==6?90:0) // y-Axis
                        ]) 
                        textWriter(
                            hAllign1=_TextHAllign,vAllign1=_TextVAllign,hOffset1=_TextHOffset,vOffset1=_TextVOffset
                            ,text1=_Text,font1=_FontStr,fontSize1=_FontSize
                            ,hOffset2=_Text2HOffset,vOffset2=_Text2VOffset,text2=_Text2
                            ,text2=_Text2,font2=_FontStr2,fontSize2=_FontSize2
                            ,fontThickness=-1*abs(_FontThickness)
                            ,TBwidth=0+(_TextLocationLid==4||_TextLocationLid==6?TBy:TBx) // y-Axis
                            ,TBheight=0+(_TextLocationLid==4||_TextLocationLid==6?TBx:TBy) // y-Axis
                            ,debug=false);
                }
                // ============================= Text Imprint to the inner side of the lid
                if (_TextLocationLid==2|| _TextLocationLid==3
                     ||_TextLocationLid==5||_TextLocationLid==6){// Text Imprint to top of the lid 
                   
                    //echo("_LidT2=",_LidT2,"_LidT=",_LidT,"_BottomT2=",_BottomT2,"_Height2=",_Height2,"_LidHeight=",_LidHeight,",LidType=",_LidType,",_LidTolerance=",_LidTolerance,",_LidMagnetDepth=",LidMagnetDepth);
                    _TBx=TBx
                                -(_LidMagnet>0&&_LidType!="Stackable"?2*_LidMagnetDia:0)
                                -(_LidType=="SlideOver"?2*_InnerRadius2:0)
                                -(_LidType=="Stackable"?2*_LidT2 +2*_LidTolerance:0);
                    _TBy=TBy
                                -(_LidMagnet>0&&_LidType!="Stackable"?2*_LidMagnetDia:0)
                                -(_LidType=="SlideOver"?2*_InnerRadius2:0)
                                -(_LidType=="Stackable"?2*_LidT2 +2*_LidTolerance:0);
                            
                    translate([_BoxSizeX/2,_BoxSizeY/2
                                ,0 //Z
                                    //+(_LidType=="Stackable"?_BottomT2+_Height2-_LidTolerance:0)//-_LidTolerance
                         // ,max(_BottomT,0+(_LidMagnet?_LidMagnetDepth+1:0))+_LidT2
                                    +(_LidType=="Stackable"
                                        ?max(_BottomT2+_LidHeight,
                                             (_LidMagnet?_LidMagnetDepth+1+_LidHeight:0))
                                             :0)
                                    +(_LidType=="SlideOver"?_BottomT+_InnerRadius2:0)//_LidT2+_InnerRadius2:0)
                                    +(_LidType=="Notched"?_BottomT2:0)//+_InnerRadius2
                                    ])  
                    rotate([0,0,0-_TextRotation
                          +(_TextLocationLid==5||_TextLocationLid==6?90:0) // y-Axis
                         ]) 
                        textWriter(
                            hAllign1=_TextHAllign,vAllign1=_TextVAllign,hOffset1=_TextHOffset,vOffset1=_TextVOffset
                            ,text1=_Text,font1=_FontStr,fontSize1=_FontSize
                            ,hOffset2=_Text2HOffset,vOffset2=_Text2VOffset,text2=_Text2
                            ,text2=_Text2,font2=_FontStr2,fontSize2=_FontSize2
                            ,fontThickness=-1*abs(_FontThickness)-(_LidType=="SlideOver"?_InnerRadius2:0)//+15
                            ,TBwidth=0+(_TextLocationLid==5||_TextLocationLid==6?_TBy:_TBx) // y-Axis
                            ,TBheight=0+(_TextLocationLid==5||_TextLocationLid==6?_TBx:_TBy) // y-Axis
                            ,debug=false);
                }
            }
            // =================================== Negative Text
            if(_FontThickness<0 && _part=="recursion box")CreateBoxText();
        } // End of main difference
        color(_color)
        
        
        union(){
            // ============================== Positive Magnet Support Cylinder
            if (_LidMagnet==1
                    && _part!="recursion stackabelid" // SupportCylinders are not required for a stackable lid!
            ){ 
                
                // For a box with the groove for the notched list, the magnets supports have to move further to the inside
                           
                _LidMagnetAddDist3=_LidMagnetAddDist
                   +(_LidType2=="Notched"&&(_part=="recursion box"||_part== "recursion notchedlid")?_LidT2+0.6:0)
                   +(_LidType2=="SlideOver"&&_part=="recursion box"?0.6:0)
                   +(_LidType2=="SlideOver"&&_part=="recursion SlideOverLid"?_LidT2+_LidTolerance/2+0.6:0)
                    +(_LidType2=="Stackable"&&(_part=="recursion box"||_part== "recursion stackabelid")?0.6+_OuterRadius2/3.14:0)
 
                ;
                _BoxSizeX=2*_WallT2+(_NumX-1)*(_SizeX+_SeparatorT)+_SizeX;
                _BoxSizeY=2*_WallT2+(_NumY-1)*(_SizeY+_SeparatorT)+_SizeY;
                
                _SupportCylZPos=(_BottomT2>_LidMagnetDepth?_BottomT2:_LidMagnetDepth);
                
                _SupportCylActualHeight=_Height2-_LidMagnetDepth                                    
                                -(_LidType2=="Stackable"&&_BottomT2<_LidMagnetDepth?_LidMagnetDepth-_BottomT2:0);
                // LidMagnet 1v4
                translate([
                _LidMagnetDia/2+_LidMagnetAddDist3
                ,_LidMagnetDia/2+_LidMagnetAddDist3
                ,_SupportCylZPos])
                edgeCylinder(r=_LidMagnetDia/2
                            ,h=_SupportCylActualHeight
                            ,rotate=0);
                // LidMagnet 2v4
                translate([
                _BoxSizeX-(_LidMagnetDia/2)-_LidMagnetAddDist3
                ,_LidMagnetDia/2+_LidMagnetAddDist3
                ,_SupportCylZPos])
                edgeCylinder(r=_LidMagnetDia/2
                            ,h=_SupportCylActualHeight
                            ,rotate=90);
                // LidMagnet 3v4
                translate([
                _LidMagnetDia/2+_LidMagnetAddDist3
                ,_BoxSizeY-(_LidMagnetDia/2)-_LidMagnetAddDist3
                ,_SupportCylZPos])
                edgeCylinder(r=_LidMagnetDia/2
                            ,h=_SupportCylActualHeight
                            ,rotate=270);
                // LidMagnet 4v4
                translate([
                _BoxSizeX-(_LidMagnetDia/2)-_LidMagnetAddDist3
                ,_BoxSizeY-(_LidMagnetDia/2)-_LidMagnetAddDist3
                ,_SupportCylZPos])
                edgeCylinder(r=_LidMagnetDia/2
                            ,h=_SupportCylActualHeight
                            ,rotate=180);
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
                        rounded_cylinder(h = (_Height2+_BottomT2), r = _CalR);
                    }
                }
            }
        }
    }//end of if part=recursion
    module CreateBoxText(){
        if(text !="" && _part=="recursion box"){
                               
                if (_TextLocationX==1|| _TextLocationX==2){
                    translate([_BoxSizeX,TBPosY,TBPosZ])  
                    rotate([90,0-_TextRotation,90]) 
                        textWriter(
                            hAllign1=_TextHAllign,vAllign1=_TextVAllign,hOffset1=_TextHOffset,vOffset1=_TextVOffset
                            ,text1=_Text,font1=_FontStr,fontSize1=_FontSize
                            ,hOffset2=_Text2HOffset,vOffset2=_Text2VOffset
                            ,text2=_Text2,font2=_FontStr2,fontSize2=_FontSize2
                            ,fontThickness=_FontThickness
                            ,TBwidth=TBy,TBheight=TBz
                            ,debug=false);
                }
                if (_TextLocationX==2 ){
                    translate([0,TBPosY,TBPosZ])  
                    rotate([90,0-_TextRotation,270]) 
                        textWriter(
                            hAllign1=_TextHAllign,vAllign1=_TextVAllign,hOffset1=_TextHOffset,vOffset1=_TextVOffset
                            ,text1=_Text,font1=_FontStr,fontSize1=_FontSize
                            ,hOffset2=_Text2HOffset,vOffset2=_Text2VOffset
                            ,text2=_Text2,font2=_FontStr2,fontSize2=_FontSize2
                            ,fontThickness=_FontThickness
                            ,TBwidth=TBy,TBheight=TBz
                            ,debug=false);
                        
                }
                if (_TextLocationY==1|| _TextLocationY==2){ 
                    translate([TBPosX,0,TBPosZ])  
                    rotate([90,0-_TextRotation,0]) 
                        textWriter(
                            hAllign1=_TextHAllign,vAllign1=_TextVAllign,hOffset1=_TextHOffset,vOffset1=_TextVOffset
                            ,text1=_Text,font1=_FontStr,fontSize1=_FontSize
                            ,hOffset2=_Text2HOffset,vOffset2=_Text2VOffset
                            ,text2=_Text2,font2=_FontStr2,fontSize2=_FontSize2
                            ,fontThickness=_FontThickness
                            ,TBwidth=TBx,TBheight=TBz
                            ,debug=false);
                }
                if (_TextLocationY==2){
                    translate([TBPosX,_BoxSizeY,TBPosZ])  
                    rotate([90,0-_TextRotation,180]) 
                        textWriter(
                            hAllign1=_TextHAllign,vAllign1=_TextVAllign,hOffset1=_TextHOffset,vOffset1=_TextVOffset
                            ,text1=_Text,font1=_FontStr,fontSize1=_FontSize
                            ,hOffset2=_Text2HOffset,vOffset2=_Text2VOffset
                            ,text2=_Text2,font2=_FontStr2,fontSize2=_FontSize2
                            ,fontThickness=_FontThickness
                            ,TBwidth=TBx,TBheight=TBz
                            ,debug=false);
                }
            }
        }
}

module textWriter(
    hAllign1="center",vAllign1="center"
    ,hOffset1=0,vOffset1=0,
    text1="text1",font1="",fontSize1=10
    ,hOffset2=0,vOffset2=0
    ,text2="",font2="",fontSize2=10
    ,fontThickness
     ,TBwidth=100,TBheight=50
    ,debug=false)
               
{
    //echo ("TextWriter hOffset1=",hOffset1,"vOffset1=",vOffset1);
    TBheight2=TBheight-2;
    TBwidth2=TBwidth-2;
    if(debug)translate([-TBwidth2/2,-TBheight2/2,0])cube([TBwidth2,TBheight2,1]);
    linespacing=1;
    height=fontSize1
        +(text2!=""?(fontSize2+linespacing):0);
    _yAllign=(vAllign1=="bottom"
                            ? - (TBheight2/2)+height/2
                            : (vAllign1=="top"
                                ?(TBheight2/2)-(height/2)
                                :0));
    _y1=_yAllign
            +(text2!=""
                ?height/2-fontSize1/2
                :0);
    //echo("_y1=",_y1);
    _y2=_yAllign
            +(text2!=""
                ?height/2-fontSize1-linespacing-fontSize2/2
                :0);
    posX=(hAllign1=="left"
                            ? -TBwidth2/2
                            : (hAllign1=="right"
                                ?TBwidth2/2
                                :0)   );
    translate([0,0,(fontThickness<0?fontThickness+0.01:0)])
    union(){
        translate([posX+hOffset1,_y1+vOffset1,0])
        linear_extrude(height=abs(fontThickness)) 
        text(text1,size=fontSize1, font=font1, spacing=1, halign = hAllign1,valign = "center"); 
        if(text2!=""){
            translate([posX+hOffset2,_y2+vOffset2,0])
            linear_extrude(height=abs(fontThickness)) 
            text(text2,size=fontSize2, font=font2, spacing=1, halign = hAllign1,valign = "center"); 
        }
    }
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
//edgeCylinder(r=_LidMagnetDia/2,h=_Height2-_LidMagnetDepth,rotate=0);
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
    r=(radius==0?0.01:radius);
    linear_extrude(height=z)
    hull()
    {
        translate([r, r, 0])
        circle(r=r);
    
        translate([x-r,r, 0])
        circle(r=r);
        
        translate([x-r,y-r, 0])
        circle(r=r);
        
        translate([r,y-r, 0])
        circle(r=r);
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

/*difference(){
    translate([0,0,0.1])
    Connector(dist=3,t=2,len=100);
    Connector(dist=3,t=2,len=102,tolerance=0.2);
}*/

//Create a interlocking connector or slot
// for positive connector add  via tolerance parameter in mm
// Dist = the side length of the center square
// t    = the additional depth for the triangle part
// tolerance = the tollerance to reduce from the connector (used when creting a positive connector) 
module Connector(dist=4,t=3,len=100,tolerance=0){
    linear_extrude(height=len)
    union(){
        halfConnector();
        mirror([1,0,0])halfConnector();
    }
    
    module halfConnector(){
        polygon(points=[
        [0,-dist/2+tolerance]
        ,[dist/2+tolerance,-dist/2+tolerance]
        ,[dist/2+t-tolerance,-dist/2-t+tolerance*2.5]
        ,[dist/2+t-tolerance,dist/2+t-tolerance*2.5]
        ,[dist/2+tolerance,dist/2-tolerance]
        ,[0,dist/2-tolerance]
        ]);
    }
    
}