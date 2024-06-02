const List<Map<String, String>> mushrooms = [
  {
    'name': 'Pieczarka',
    'image': 'assets/grzyby/pieczarka.jpg',
    'description': '''
Nazwa naukowa: Agaricus bisporus
Rodzina: Pieczarkowate (Agaricaceae)
Występowanie: Występuje na całym świecie, najczęściej na łąkach, pastwiskach, skrajach lasów.
Opis: Kapelusz białawy, gładki, kulisty lub płaski. Blaszki różowe, potem brązowiejące. Trzon cylindryczny, biały.
Zastosowanie: Jeden z najpopularniejszych grzybów jadalnych, wykorzystywany w kuchni na różne sposoby, surowy w sałatkach, smażony, duszony, pieczony.
      '''
  },
  {
    'name': 'Borowik',
    'image': 'assets/grzyby/borowik.jpeg',
    'description': '''
Nazwa naukowa: Boletus edulis
Rodzina: Borowikowate (Boletaceae)
Występowanie: Lasy liściaste i iglaste, zwłaszcza w okolicach dębów, buków, świerków. Spotykany od lata do jesieni.
Opis: Kapelusz brązowy, półkulisty, gładki. Rurki białe, potem żółtawe. Trzon gruby, białawy, z siateczką na górze.
Zastosowanie: Wyśmienity grzyb jadalny, używany w zupach, sosach, suszony, marynowany.
      '''
  },
  {
    'name': 'Rydz',
    'image': 'assets/grzyby/rydz.jpeg',
    'description': '''
Nazwa naukowa: Lactarius deliciosus
Rodzina: Gołąbkowate (Russulaceae)
Występowanie: Lasy iglaste, zwłaszcza pod sosnami. Pojawia się od lata do jesieni.
Opis: Kapelusz pomarańczowy, lejkowaty, z koncentrycznymi strefami. Blaszki gęste, pomarańczowe. Trzon krótki, pomarańczowy z jamkami.
Zastosowanie: Bardzo smaczny grzyb jadalny, często smażony lub marynowany.
      '''
  },
  {
    'name': 'Gołąbek',
    'image': 'assets/grzyby/golabek.jpeg',
    'description': '''
Nazwa naukowa: Russula
Rodzina: Gołąbkowate (Russulaceae)
Występowanie: Różne siedliska, lasy liściaste i iglaste, od wiosny do jesieni.
Opis: Kapelusz różnokolorowy, gładki, mięsisty. Blaszki białe lub kremowe. Trzon biały, kruchy.
Zastosowanie: W zależności od gatunku może być jadalny lub niejadalny. Jadalne gatunki są smaczne i używane w wielu potrawach.
      '''
  },
  {
    'name': 'Maślak',
    'image': 'assets/grzyby/maslak.jpeg',
    'description': '''
Nazwa naukowa: Suillus
Rodzina: Maślakowate (Suillaceae)
Występowanie: Lasy iglaste, głównie pod sosnami. Od lata do jesieni.
Opis: Kapelusz śliski, żółtobrązowy. Rurki żółte, łatwo oddzielające się od kapelusza. Trzon żółty z pierścieniem.
Zastosowanie: Popularny grzyb jadalny, stosowany w kuchni do zup, sosów, marynat.
      '''
  },
  {
    'name': 'Kurka',
    'image': 'assets/grzyby/kurka.jpg',
    'description': '''
Nazwa naukowa: Cantharellus cibarius
Rodzina: Pieprznikowate (Cantharellaceae)
Występowanie: Lasy liściaste i iglaste, często w mchach. Spotykany od lata do jesieni.
Opis: Kapelusz żółty, lejkowaty, z fałdami zamiast blaszek. Trzon krótki, zwarty.
Zastosowanie: Smaczny grzyb jadalny, ceniony w kuchni, smażony, duszony, marynowany.
      '''
  },
  {
    'name': 'Koźlarz',
    'image': 'assets/grzyby/kozlarz.jpg',
    'description': '''
Nazwa naukowa: Leccinum
Rodzina: Borowikowate (Boletaceae)
Występowanie: Lasy liściaste i mieszane, głównie pod brzozami i osikami. Spotykany od wiosny do jesieni.
Opis: Kapelusz brązowy lub czerwony, rurki białe lub szare. Trzon wysoki, pokryty łuseczkami.
Zastosowanie: Jadalny grzyb, wykorzystywany w kuchni na różne sposoby.
      '''
  },
  {
    'name': 'Podgrzybek',
    'image': 'assets/grzyby/podgrzybek.jpg',
    'description': '''
Nazwa naukowa: Xerocomus
Rodzina: Borowikowate (Boletaceae)
Występowanie: Lasy iglaste i mieszane, często w borach sosnowych. Spotykany od lata do jesieni.
Opis: Kapelusz brązowy, aksamitny, rurki żółte. Trzon żółtawy, smukły.
Zastosowanie: Bardzo smaczny grzyb jadalny, suszony, marynowany, używany do zup i sosów.
      '''
  },
  {
    'name': 'Czubajka kania',
    'image': 'assets/grzyby/kania.jpg',
    'description': '''
Nazwa naukowa: Macrolepiota procera
Rodzina: Pieczarkowate (Agaricaceae)
Występowanie: Lasy liściaste, iglaste, polany, łąki. Spotykana od lata do jesieni.
Opis: Kapelusz duży, brązowawy z łuskami. Trzon wysoki, smukły z ruchomym pierścieniem.
Zastosowanie: Ceniony grzyb jadalny, szczególnie smaczny smażony jak kotlet.
      '''
  },
  {
    'name': 'Opieńka miodowa',
    'image': 'assets/grzyby/opienka.jpg',
    'description': '''
Nazwa naukowa: Armillaria mellea
Rodzina: Physalacriaceae
Występowanie: Lasy liściaste i iglaste, na pniach drzew. Spotykana od lata do jesieni.
Opis: Kapelusz żółtobrązowy, pokryty drobnymi łuskami. Trzon ciemniejszy, włóknisty.
Zastosowanie: Jadalny po obróbce cieplnej, używany do duszenia, marynowania.
      '''
  },
  {
    'name': 'Gąska zielonka',
    'image': 'assets/grzyby/gaska_zielonka.jpg',
    'description': '''
Nazwa naukowa: Tricholoma equestre
Rodzina: Gąskowate (Tricholomataceae)
Występowanie: Lasy iglaste, piaszczyste gleby. Spotykana od lata do jesieni.
Opis: Kapelusz zielonkawy, blaszkowaty. Trzon żółtawy, mięsisty.
Zastosowanie: Smaczny grzyb jadalny, stosowany w kuchni na różne sposoby.
      '''
  },
  {
    'name': 'Sarniak dachówkowaty',
    'image': 'assets/grzyby/sarniak.jpg',
    'description': '''
Nazwa naukowa: Sarcodon imbricatus
Rodzina: Kolcownicowate (Bankeraceae)
Występowanie: Lasy iglaste, głównie pod sosnami. Spotykany od lata do jesieni.
Opis: Kapelusz brązowawy, pokryty łuskami, kolczasty od spodu. Trzon gruby, brązowy.
Zastosowanie: Jadalny, ale mało znany grzyb, stosowany do duszenia.
      '''
  },
  {
    'name': 'Mleczaj rydz',
    'image': 'assets/grzyby/mleczaj_rydz.jpg',
    'description': '''
Nazwa naukowa: Lactarius deliciosus
Rodzina: Gołąbkowate (Russulaceae)
Występowanie: Lasy iglaste, zwłaszcza pod sosnami. Spotykany od lata do jesieni.
Opis: Kapelusz pomarańczowy, lejkowaty, z koncentrycznymi strefami. Blaszki gęste, pomarańczowe.
Zastosowanie: Bardzo smaczny grzyb jadalny, często smażony lub marynowany.
      '''
  },
  {
    'name': 'Muchomor',
    'image': 'assets/grzyby/muchomor_czerwony.jpg',
    'description': '''
Nazwa naukowa: Amanita muscaria
Rodzina: Muchomorowate (Amanitaceae)
Występowanie: Lasy liściaste i iglaste, szczególnie pod brzozami i sosnami. Spotykany od lata do jesieni.
Opis: Kapelusz czerwony z białymi kropkami. Trzon biały, z pierścieniem.
Zastosowanie: Trujący, nie należy go spożywać.
      '''
  },
  {
    'name': 'Muchomor sromotnikowy',
    'image': 'assets/grzyby/muchomor_sromotnikowy.jpg',
    'description': '''
Nazwa naukowa: Amanita phalloides
Rodzina: Muchomorowate (Amanitaceae)
Występowanie: Lasy liściaste, szczególnie pod dębami i bukami. Spotykany od lata do jesieni.
Opis: Kapelusz zielonkawy, gładki. Trzon biały z bulwiastą podstawą.
Zastosowanie: Silnie trujący, śmiertelnie niebezpieczny.
      '''
  },
  {
    'name': 'Wilgotnica',
    'image': 'assets/grzyby/Wilgotnica.jpg',
    'description': '''
Nazwa naukowa: Hygrocybe
Rodzina: Wilgotnicowate (Hygrophoraceae)
Występowanie: Lasy liściaste i iglaste, łąki, pastwiska, szczególnie na wilgotnych glebach. Spotykana od lata do jesieni.
Opis: Kapelusz różnokolorowy, zwykle czerwony, pomarańczowy lub żółty, lepki i błyszczący, często z bruzdami na brzegu. Blaszki grube, szeroko rozstawione, w kolorze kapelusza. Trzon smukły, gładki, czasem lepki.
Zastosowanie: Różne gatunki wilgotnic mogą być jadalne, niejadalne lub lekko trujące. Zastosowanie w kuchni zależy od konkretnego gatunku, jednak wiele z nich nie jest powszechnie zbieranych.
  '''
  },
  {
    'name': 'Purchawka chropowata',
    'image': 'assets/grzyby/purchawka.jpg',
    'description': '''
Nazwa naukowa: Lycoperdon perlatum
Rodzina: Purchawkowate (Lycoperdaceae)
Występowanie: Lasy liściaste i iglaste, polany, łąki. Spotykana od wiosny do jesieni.
Opis: Owocnik kulisty, pokryty kolcami. Po dojrzeniu tworzy otwór na szczycie.
Zastosowanie: Młode owocniki są jadalne po obraniu.
      '''
  },
  {
    'name': 'Prawdziwek',
    'image': 'assets/grzyby/prawdziwek.jpg',
    'description': '''
Nazwa naukowa: Boletus edulis
Rodzina: Borowikowate (Boletaceae)
Występowanie: Lasy liściaste i iglaste, szczególnie pod dębami, bukami, świerkami. Spotykany od lata do jesieni.
Opis: Kapelusz brązowy, półkulisty, gładki. Rurki białe, potem żółtawe. Trzon gruby, białawy z siateczką.
Zastosowanie: Wyśmienity grzyb jadalny, suszony, marynowany, używany do zup i sosów.
      '''
  },
  {
    'name': 'Czubajka czerwieniejąca',
    'image': 'assets/grzyby/czubajka_czerwieniejaca.jpg',
    'description': '''
Nazwa naukowa: Chlorophyllum rhacodes
Rodzina: Pieczarkowate (Agaricaceae)
Występowanie: Lasy liściaste i iglaste, parki, ogrody. Spotykana od lata do jesieni.
Opis: Kapelusz brązowawy, pokryty łuskami. Trzon wysoki z ruchomym pierścieniem, po uszkodzeniu czerwienieje.
Zastosowanie: Jadalny po obróbce cieplnej, szczególnie smaczny smażony.
      '''
  },
  {
    'name': 'Smardz jadalny',
    'image': 'assets/grzyby/smardz.jpg',
    'description': '''
Nazwa naukowa: Morchella esculenta
Rodzina: Smardzowate (Morchellaceae)
Występowanie: Lasy liściaste, szczególnie pod topolami, wiązami. Spotykany wiosną.
Opis: Owocnik kulisty, o nieregularnych komorach. Trzon krótki, białawy.
Zastosowanie: Wyśmienity grzyb jadalny, stosowany w kuchni na różne sposoby.
      '''
  },
  {
    'name': 'Trufla letnia',
    'image': 'assets/grzyby/trufla.jpg',
    'description': '''
Nazwa naukowa: Tuber aestivum
Rodzina: Truflowate (Tuberaceae)
Występowanie: Lasy liściaste, szczególnie pod dębami, bukami, leszczynami. Spotykana od lata do jesieni.
Opis: Owocnik podziemny, kulisty, czarnobrązowy, z chropowatą powierzchnią.
Zastosowanie: Bardzo ceniona w kuchni, stosowana do aromatyzowania potraw.
      '''
  },
  {
    'name': 'Mleczaj chrząstka',
    'image': 'assets/grzyby/mleczaj_chrzastka.jpg',
    'description': '''
Nazwa naukowa: Lactarius vellereus
Rodzina: Gołąbkowate (Russulaceae)
Występowanie: Lasy liściaste i mieszane. Spotykany od lata do jesieni.
Opis: Kapelusz biały, lejkowaty, z gęstymi blaszkami. Trzon krótki, masywny.
Zastosowanie: Jadalny, ale o ostrym smaku, wymaga obróbki cieplnej.
      '''
  },
  {
    'name': 'Mleczaj biel',
    'image': 'assets/grzyby/mleczaj_biel.jpg',
    'description': '''
Nazwa naukowa: Lactarius piperatus
Rodzina: Gołąbkowate (Russulaceae)
Występowanie: Lasy liściaste i mieszane. Spotykany od lata do jesieni.
Opis: Kapelusz biały, gładki, z gęstymi blaszkami. Trzon krótki, masywny.
Zastosowanie: Jadalny, ale bardzo piekący w smaku, wymaga obróbki cieplnej.
      '''
  },
  {
    'name': 'Maślak zwyczajny',
    'image': 'assets/grzyby/maslak_zwyczajny.jpg',
    'description': '''
Nazwa naukowa: Suillus luteus
Rodzina: Maślakowate (Suillaceae)
Występowanie: Lasy iglaste, szczególnie pod sosnami. Spotykany od lata do jesieni.
Opis: Kapelusz śliski, żółtobrązowy, rurki żółte. Trzon żółty z pierścieniem.
Zastosowanie: Popularny grzyb jadalny, stosowany w kuchni do zup, sosów, marynat.
      '''
  },
  {
    'name': 'Gąska siarkowa',
    'image': 'assets/grzyby/gaska_siarkowa.jpg',
    'description': '''
Nazwa naukowa: Tricholoma sulphureum
Rodzina: Gąskowate (Tricholomataceae)
Występowanie: Lasy liściaste i iglaste. Spotykana od lata do jesieni.
Opis: Kapelusz siarkowożółty, gładki. Blaszki i trzon żółte, intensywnie pachnące.
Zastosowanie: Trujący, nie należy go spożywać.
      '''
  },
  {
    'name': 'Gąska niekształtna',
    'image': 'assets/grzyby/gaska_nieksztaltna.jpg',
    'description': '''
Nazwa naukowa: Tricholoma portentosum
Rodzina: Gąskowate (Tricholomataceae)
Występowanie: Lasy iglaste, szczególnie pod sosnami. Spotykana od późnej jesieni do zimy.
Opis: Kapelusz szarobrązowy, z promienistymi pręgami. Blaszki białe, trzon białawy.
Zastosowanie: Jadalny, smaczny grzyb, używany w kuchni na różne sposoby.
      '''
  },
  {
    'name': 'Łuszczak zmienny',
    'image': 'assets/grzyby/luszczak_zmienny.jpg',
    'description': '''
Nazwa naukowa: Kuehneromyces mutabilis
Rodzina: Omphalotaceae
Występowanie: Lasy liściaste, na pniakach i martwym drewnie. Spotykany od wiosny do jesieni.
Opis: Kapelusz zmienny, od żółtobrązowego do czerwonobrązowego. Blaszki i trzon jaśniejsze.
Zastosowanie: Jadalny po obróbce cieplnej, stosowany do duszenia i marynowania.
      '''
  },
  {
    'name': 'Łuskwiak nastroszony',
    'image': 'assets/grzyby/luskwiak_nastroszony.jpg',
    'description': '''
Nazwa naukowa: Pholiota squarrosa
Rodzina: Hymenogastraceae
Występowanie: Lasy liściaste, na pniakach i martwym drewnie. Spotykany od lata do jesieni.
Opis: Kapelusz żółtobrązowy, pokryty łuskami. Blaszki żółtawe, trzon z pierścieniem.
Zastosowanie: Młode owocniki są jadalne, ale o ostrym smaku.
      '''
  },
  {
    'name': 'Pieniążek szorstki',
    'image': 'assets/grzyby/pieniazek_szorstki.jpg',
    'description': '''
Nazwa naukowa: Gymnopus dryophilus
Rodzina: Omphalotaceae
Występowanie: Lasy liściaste i iglaste. Spotykany od wiosny do jesieni.
Opis: Kapelusz żółtobrązowy, gładki. Blaszki białe, trzon smukły, brązowawy.
Zastosowanie: Jadalny, ale mało ceniony, stosowany do duszenia.
      '''
  },
  {
    'name': 'Twardzioszek przydrożny',
    'image': 'assets/grzyby/twardzioszek_przydrozny.jpg',
    'description': '''
Nazwa naukowa: Marasmius oreades
Rodzina: Omphalotaceae
Występowanie: Łąki, pastwiska, przydroża. Spotykany od wiosny do jesieni.
Opis: Kapelusz jasnobrązowy, gładki. Blaszki szeroko rozstawione, trzon smukły.
Zastosowanie: Smaczny grzyb jadalny, szczególnie ceniony w kuchni francuskiej.
      '''
  },
  {
    'name': 'Zasłonak rudawy',
    'image': 'assets/grzyby/zaslonak_rudawy.jpg',
    'description': '''
Nazwa naukowa: Cortinarius orellanus
Rodzina: Zasłonakowate (Cortinariaceae)
Występowanie: Lasy liściaste, szczególnie pod dębami i bukami. Spotykany od lata do jesieni.
Opis: Kapelusz rdzawobrązowy, gładki. Blaszki jasnobrązowe, trzon jaśniejszy.
Zastosowanie: Silnie trujący, śmiertelnie niebezpieczny.
      '''
  },
  {
    'name': 'Maślanka wiązkowa',
    'image': 'assets/grzyby/maslanka_wiazowa.jpg',
    'description': '''
Nazwa naukowa: Hypholoma fasciculare
Rodzina: Strophariaceae
Występowanie: Lasy liściaste i iglaste, na martwym drewnie. Spotykana od wiosny do jesieni.
Opis: Kapelusz żółtawy, blaszkowaty. Blaszki zielonkawe, trzon żółtawy.
Zastosowanie: Trująca, nie należy jej spożywać.
      '''
  },
];
