//Customizable text
Text = "Enjoy!";
//Text size
Text_size = 20;
//Choose font
fontname="Pacifico"; //[Pacifico,ABeeZee,Abel,Abril Fatface,Aclonica,Acme,Aldrich,Alef,Alegreya,Alegreya Sans,Alegreya Sans SC,Alegreya SC,Alex Brush,Alfa Slab One,Alice,Alike,Alike Angular,Allan,Allerta,Allerta Stencil,Allura,Almendra,Almendra Display,Almendra SC,Amarante,Amaranth,Amatic SC,Amethysta,Amiri,Anaheim,Andada,Andika,Angkor,Annie Use Your Telescope,Anonymous Pro,Antic,Antic Didone,Antic Slab,Anton,Arapey,Arbutus,Arbutus Slab,Architects Daughter,Archivo Black,Archivo Narrow,Arimo,Arizonia,Armata,Artifika,Arvo,Asap,Asset,Astloch,Asul,Atomic Age,Aubrey,Audiowide,Autour One,Average,Average Sans,Averia Gruesa Libre,Averia Libre,Averia Sans Libre,Averia Serif Libre,Bad Script,Balthazar,Bangers,Basic,Battambang,Baumans,Bayon,Belgrano,Belleza,BenchNine,Bentham,Berkshire Swash,Bevan,Bigelow Rules,Bigshot One,Bilbo,Bilbo Swash Caps,Bitter,Black Ops One,Bokor,Bonbon,Boogaloo,Bowlby One,Bowlby One SC,Brawler,Bree Serif,Bubblegum Sans,Bubbler One,Buda,Buenard,Butcherman,Butterfly Kids,Cabin,Cabin Condensed,Cabin Sketch,Caesar Dressing,Cagliostro,Calligraffitti,Cambay,Cambo,Candal,Cantarell,Cantata One,Cantora One,Capriola,Cardo,Carme,Carrois Gothic,Carrois Gothic SC]

//sottrazione per fori
difference(){
    //Intero lunghezza piattina
    T = 140;
    //Piattina
    translate([-T/2,0,0])
    hull(){
        cylinder(h=5, d=30);
        translate([T,0,0])
        cylinder(h=5, d=30);
}
    //fori cilindrici
    translate([-76,0,0])
    cylinder(h=5, d=8);
    translate([76,0,0])
    cylinder(h=5, d=8);

    //scritta
    linear_extrude(height=5)
    text (Text, Text_size, halign="center", valign="center", font=fontname);
}
