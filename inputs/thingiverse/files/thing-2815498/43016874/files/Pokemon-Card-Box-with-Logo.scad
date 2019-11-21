cardWidth=63.5;
cardHeight=88.5;
cardThickness=0.34;

cardPerBox=250;
cardBlockLength=cardThickness*cardPerBox;

spaceAroundCard=0.25;
spaceAroundLid=0.5;

wallthickness=0.96;

fingerCutout=30;

// 1 for base box, 0 for lid, 2 for Logo only
boxOrLidOrLogo=0;

// logo filename
logoFile=""; //No Logo

/*
logoFile="pokemon-unbroken-bonds-set-symbol-150x150.dxf"; //Unbroken Bonds	2019
logoFile="detective-pikachu-set-symbol-150x147.dxf"; //Detective Pikachu	2019
logoFile="pokemon-team-up-set-symbol-150x150.dxf"; //Team Up	2019
logoFile="sm-lost-thunder-set-symbol-145x150.dxf"; //Lost Thunder	2018
logoFile="dragon-majesty-pokemon-set-symbol-150x150.dxf"; //Dragon Majesty	2018
logoFile="sun-and-moon-celestial-storm-pokemon-set-symbol-150x150.dxf"; //Celestial Storm	2018
logoFile="sun-and-moon-forbidden-light-pokemon-set-symbol-150x150.dxf"; //Forbidden Light	2018
logoFile="sun-and-moon-ultra-prism-pokemon-set-symbol-1-150x150.dxf"; //Ultra Prism	2018
logoFile="sun-and-moon-crimson-invasion-pokemon-set-symbol-150x150.dxf"; //Crimson Invasion	2017
logoFile="shining-legends-pokemon-set-symbol-150x150.dxf"; //Shining Legends	2017
logoFile="sun-and-moon-burning-shadows-set-symbol-150x150.dxf"; //Burning Shadows	2017
logoFile="sun-and-moon-guardians-rising-pokemon-set-symbol-150x150.dxf"; //Guardians Rising	2017
logoFile="sun-and-moon-pokemon-set-symbol-150x150.dxf"; //Sun & Moon	2017
logoFile="xy-promos-pokemon-set-symbol-150x136.dxf"; //Sun & Moon Promos	2016
logoFile="xy-evolutions-pokemon-set-symbol-150x150.dxf"; //Evolutions	2016
logoFile="xy-steam-siege-pokemon-set-symbol-150x150.dxf"; //Steam Siege	2016
logoFile="xy-fates-collide-pokemon-set-symbol-150x150.dxf"; //Fates Collide	2016
logoFile="generations-pokemon-set-symbol-150x150.dxf"; //Generations	2016
logoFile="xy-BREAKpoint-pokemon-set-symbol-150x150.dxf"; //BREAKpoint	2016
logoFile="xy-BREAKthrough-pokemon-set-symbol-150x150.dxf"; //BREAKthrough	2015
logoFile="xy-ancient-origins-pokemon-set-symbol-150x150.dxf"; //Ancient Origins	2015
logoFile="xy-roaring-skies-pokemon-set-symbol-150x150.dxf"; //Roaring Skies	2015
logoFile="xy-double-crisis-pokemon-set-symbol.png-150x150.dxf"; //Double Crisis	2015
logoFile="xy-primal-clash-pokemon-set-symbol-150x150.dxf"; //Primal Clash	2015
logoFile="xy-phantom-forces-pokemon-set-symbol-150x150.dxf"; //Phantom Forces	2014
logoFile="xy-furious-fists-pokemon-set-symbol-150x150.dxf"; //Furious Fists	2014
logoFile="xy-flashfire-pokemon-set-symbol-150x150.dxf"; //Flashfire	2014
logoFile="xy-pokemon-set-symbol-150x150.dxf"; //XY	2014
logoFile="xy-kalos-starter-pokemon-set-symbol-150x150.dxf"; //Kalos Starter Set	2013
logoFile="xy-promos-pokemon-set-symbol-150x136.dxf"; //XY - Promos	2013
logoFile="black-and-white-legendary-treasures-pokemon-set-symbol-150x150.dxf"; //Legendary Treasures	2013
logoFile="black-and-white-plasma-blast-pokemon-set-symbol-150x150.dxf"; //Plasma Blast	2013
logoFile="black-and-white-plasma-freeze-pokemon-set-symbol-150x150.dxf"; //Plasma Freeze	2013
logoFile="black-and-white-plasma-storm-pokemon-set-symbol-150x150.dxf"; //Plasma Storm	2013
logoFile="black-and-white-boundaries-crossed-pokemon-set-symbol-150x150.dxf"; //Boundaries Crossed	2012
logoFile="black-and-white-dragon-vault-pokemon-set-symbol-150x150.dxf"; //Dragon Vault	2012
logoFile="black-and-white-dragons-exalted-pokemon-set-symbol-150x150.dxf"; //Dragons Exalted	2012
logoFile="black-and-white-dark-explorers-pokemon-set-symbol-150x150.dxf"; //Dark Explorers	2012
logoFile="black-and-white-next-destinies-pokemon-set-symbol-150x150.dxf"; //Next Destinies	2012
logoFile="black-and-white-noble-victories-pokemon-set-symbol-150x150.dxf"; //Noble Victories	2011
logoFile="black-and-white-emerging-powers-pokemon-set-symbol-150x150.dxf"; //Emerging Powers	2011
logoFile="black-and-white-pokemon-set-symbol-150x150.dxf"; //Black and White Base Set	2011
logoFile="call-of-legends-pokemon-set-symbol-150x150.dxf"; //Call of Legends	2011
logoFile="heartgold-and-soulsilver-triumphant-pokemon-set-symbol-150x150.dxf"; //Triumphant	2010
logoFile="heartgold-and-soulsilver-undaunted-pokemon-set-symbol-150x150.dxf"; //Undaunted	2010
logoFile="heartgold-and-soulsilver-unleashed-pokemon-set-symbol-150x150.dxf"; //Unleashed	2010
logoFile="heartGold-and-soulSilver-pokemon-set-symbol-150x150.dxf"; //HeartGold and SoulSilver	2010
logoFile="heartgold-soulsilver-promos-pokemon-set-symbol-150x136.dxf"; //HeartGold and SoulSilver Promos	2010
logoFile="arceus-pokemon-set-symbol-150x150.dxf"; //Arceus	2009
logoFile="supreme-victors-pokemon-set-symbol-150x150.dxf"; //Supreme Victors	2009
logoFile="rising-rivals-pokemon-set-symbol-150x150.dxf"; //Rising Rivals	2009
logoFile="pokemon-pop-series-9-set-symbol-150x92.dxf"; //POP Series 9	2009
logoFile="platinum-base-set-pokemon-set-symbol-150x150.dxf"; //Platinum Base Set	2009
logoFile="pokemon-pop-series-8-set-symbol-150x91.dxf"; //POP Series 8	2008 - 2009
logoFile="stormfront-pokemon-set-symbol-150x150.dxf"; //Stormfront	2008
logoFile="legends-awakened-pokemon-set-symbol-150x150.dxf"; //Legends Awakened	2008
logoFile="majestic-dawn-pokemon-set-symbol-150x150.dxf"; //Majestic Dawn	2008
logoFile="pokemon-pop-series-7-set-symbol-150x95.dxf"; //POP Series 7	2008
logoFile="great-encounters-pokemon-set-symbol-150x150.dxf"; //Great Encounters	2008	
logoFile="secret-wonders-pokemon-set-symbol-150x150.dxf"; //Secret Wonders	2007
logoFile="pokemon-pop-series-6-set-symbol-150x91.dxf"; //POP Series 6	2007 - 2008
logoFile="mysterious-treasures-pokemon-set-symbol-150x150.dxf"; //Mysterious Treasures	2007
logoFile="diamond-and-pearl-pokemon-set-symbol-150x150.dxf"; //Diamond & Pearl	2007
logoFile="diamond-pearl-promos-pokemon-set-symbol-150x136.dxf"; //Diamond & Pearl Promos	2007
logoFile="pokemon-pop-series-5-set-symbol-150x97.dxf"; //POP Series 5	2007
logoFile="ex-power-keepers-pokemon-set-symbol-150x150.dxf"; //Power Keepers	2007
logoFile="ex-dragon-frontiers-pokemon-set-symbol-150x150.dxf"; //Dragon Frontiers	2006
logoFile="ex-crystal-guardians-pokemon-set-symbol-150x150.dxf"; //Crystal Guardians	2006
logoFile="pokemon-pop-series-4-set-symbol-150x92.dxf"; //POP Series 4	2006 - 2007
logoFile="ex-holon-phantoms-pokemon-set-symbol-150x150.dxf"; //Holon Phantoms	2006
logoFile="pokemon-pop-series-3-set-symbol-150x94.dxf"; //POP Series 3	2006
logoFile="ex-trainer-kit-2-minun-pokemon-set-symbol-115x150.dxf"; //EX Trainer Kit 2	2006
logoFile="ex-legend-maker-pokemon-set-symbol-150x150.dxf"; //Legend Maker	2006
logoFile="ex-delta-species-pokemon-set-symbol-150x150.dxf"; //Delta Species	2005
logoFile="ex-unseen-forces-pokemon-set-symbol-150x150.dxf"; //Unseen Forces	2005
logoFile="pokemon-pop-series-2-set-symbol-150x94.dxf"; //POP Series 2	2005 - 2006
logoFile="ex-emerald-pokemon-set-symbol-150x150.dxf"; //Emerald	2005
logoFile="ex-deoxys-pokemon-set-symbol-150x150.dxf"; //Deoxys	2005
logoFile="ex-team-rocket-returns-pokemon-set-symbol.dxf"; //Team Rocket Returns	2004
logoFile="pokemon-pop-series-1-set-symbol-150x100.dxf"; //POP Series 1	2004 - 2005
logoFile="ex-fire-red-and-leaf-green-pokemon-set-symbol.dxf"; //Fire Red and Leaf Green	2004
logoFile="ex-hidden-legends-pokemon-set-symbol.dxf"; //Hidden Legends	2004
logoFile="pokemon-ex-trainer-kit-latias-set-symbol-150x101.dxf"; //EX Trainer Kit	2004
logoFile="ex-team-magma-vs-team-aqua-pokemon-set-symbol.dxf"; //Team Magma vs Team Aqua	2004
logoFile="ex-dragon-pokemon-set-symbol.dxf"; //Dragon	2003
logoFile="ex-sandstorm-pokemon-set-symbol.dxf"; //Sandstorm	2003
logoFile="ex-ruby-and-sapphire-pokemon-set-symbol.dxf"; //Ruby and Sapphire	2003
logoFile="skyridge-pokemon-set-symbol.dxf"; //Skyridge	2003
logoFile="pokemon-nintendo-black-star-promos-set-symbol-150x136.dxf"; //Nintendo Black Star Promos	2003 - 2006
logoFile="aquapolis-pokemon-set-symbol.dxf"; //Aquapolis	2003
logoFile="expedition-base-set-pokemon-set-symbol.dxf"; //Expedition	2002
logoFile="legendary-collection-pokemon-set-symbol.dxf"; //Legendary Collection	2002
logoFile="neo-destiny-pokemon-set-symbol.dxf"; //Neo Destiny	2002
logoFile="neo-revelation-pokemon-set-symbol-150x97.dxf"; //Neo Revelation	2001
logoFile="pokemon-southern-islands-set-symbol-150x118.dxf"; //Southern Islands	2001
logoFile="neo-discovery-pokemon-set-symbol.dxf"; //Neo Discovery	2001
logoFile="neo-genesis-pokemon-set-symbol.dxf"; //Neo Genesis	2000
logoFile="gym-challenge-pokemon-set-symbol-150x92.dxf"; //Gym Challenge	2000
logoFile="gym-heroes-pokemon-set-symbol-150x91.dxf"; //Gym Heroes	2000
logoFile="team-rocket-pokemon-set-symbol.dxf"; //Team Rocket	2000
logoFile="base-set-2-pokemon-set-symbol.dxf"; //Base Set 2	2000
logoFile="fossil-pokemon-set-symbol.dxf"; //Fossil	1999
logoFile="pokemon-wizards-black-star-promos-set-symbol-150x136.dxf"; //Wizards Black Star Promos	1999 - 2003
logoFile="jungle-pokemon-set-symbol.dxf"; //Jungle	1999
logoFile=".dxf"; //Base Set	1999
logoFile="mcdonalds-pokemon-2018-set-symbol-150x140.dxf"; //McDonald’s 2018	2018
logoFile="mcdonalds-pokemon-2017-set-symbol-150x150.dxf"; //McDonald’s 2017	2017
logoFile="mcdonalds-pokemon-2016-set-symbol-150x140.dxf"; //McDonald’s 2016	2016
logoFile="mcdonalds-pokemon-2015-set-symbol-148x150.dxf"; //McDonald’s 2015	2015
logoFile="mcdonalds-pokemon-2014-set-symbol-150x148.dxf"; //McDonald’s 2014	2014
logoFile="mcdonalds-pokemon-2013-set-symbol.dxf"; //McDonald’s 2013	2013
logoFile="mcdonalds-pokemon-2012-set-symbol-150x150.dxf"; //McDonald’s 2012	2012
logoFile="mcdonalds-pokemon-2011-set-symbol-150x130.dxf"; //McDonald’s 2011	2011
*/


if (boxOrLidOrLogo==0) {
   mainLid();
}
if (boxOrLidOrLogo==1) {
   mainBox();
}
if (boxOrLidOrLogo==2) {
   Logo();
}

module mainBox () {
    difference() {
        Box();
        translate([
            (cardWidth+(spaceAroundCard*2)+(wallthickness*2))/2,
            cardBlockLength+(spaceAroundCard*2)+(wallthickness*3),
            cardHeight+spaceAroundCard+wallthickness
            ]){
            rotate(a=[90,0,0]){
                cylinder(h=(cardBlockLength+(spaceAroundCard*2)+(wallthickness*4)),d=fingerCutout);
            }
        }
    }
}


module Box () {
    difference() {
        cube([
        cardWidth+(spaceAroundCard*2)+(wallthickness*2),
        cardBlockLength+(spaceAroundCard*2)+(wallthickness*2),
        cardHeight+spaceAroundCard+wallthickness
        ]);
        translate([wallthickness,wallthickness,wallthickness]) {
            cube([
            cardWidth+(spaceAroundCard*2),
            cardBlockLength+(spaceAroundCard*2),
            cardHeight+spaceAroundCard+wallthickness
            ]);
        }
    }
}

module mainLid () {
    difference() {
        LidBox();
        translate([
            -spaceAroundLid,
            (cardBlockLength+(spaceAroundCard*2)+(wallthickness*4)+(spaceAroundLid*2))/2,
            cardHeight+spaceAroundCard+(wallthickness*2)+(spaceAroundLid)
            ]){
            rotate(a=[0,90,0]){
                cylinder(h=cardWidth+(spaceAroundCard*2)+(wallthickness*4)+(spaceAroundLid*4),d=fingerCutout);
            }
        }
        if (logoFile) Logo();
    }
}


module LidBox () {
    difference() {
        cube([
        cardWidth+(spaceAroundCard*2)+(wallthickness*4)+(spaceAroundLid*2),
        cardBlockLength+(spaceAroundCard*2)+(wallthickness*4)+(spaceAroundLid*2),
        cardHeight+spaceAroundCard+(wallthickness*2)+(spaceAroundLid)
        ]);
        translate([wallthickness,wallthickness,wallthickness]) {
            cube([
            cardWidth+(spaceAroundCard*2)+(wallthickness*2)+(spaceAroundLid*2),
            cardBlockLength+(spaceAroundCard*2)+(wallthickness*2)+(spaceAroundLid*2),
            cardHeight+spaceAroundCard+(wallthickness*2)+(spaceAroundLid)
            ]);
        }
    }
}

module Logo () {
        
    boxwidth=cardWidth+(spaceAroundCard*2)+(wallthickness*4)+(spaceAroundLid*2);
    translate([((boxwidth/2)/2)+(boxwidth/2),wallthickness/2,boxwidth/1.5]) {
        rotate(a=[90,180,0]){
            resize([boxwidth/2,boxwidth/2,wallthickness/2]) {
                linear_extrude(height = 4) import(logoFile);
            }
        }
    }
     
    
    
}
