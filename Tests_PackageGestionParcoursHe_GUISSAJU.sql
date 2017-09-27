/* *************************** TESTS FONCTION RECHERCHER *************************** */

-- Test E_AnscoNull

DECLARE
	tabResultats GestionParcoursHe.T_MeilleursResultats;
BEGIN
	tabResultats := GestionParcoursHe.Rechercher(NULL);
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

-- Résultat : ORA-20202: L'année scolaire passée en paramètre est obligatoire.

-----------------------------------------------------------------------------------------------------------------------

-- Test E_AnscoInvalid

DECLARE
	tabResultats GestionParcoursHe.T_MeilleursResultats;
BEGIN
	tabResultats := GestionParcoursHe.Rechercher('2016');
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

-- Résultat : ORA-20203: L'année scolaire passée en paramètre (2016) doit etre inferieure a l'année actuelle (2015).

-----------------------------------------------------------------------------------------------------------------------

-- Test E_TabOutVide

DECLARE
	tabResultats GestionParcoursHe.T_MeilleursResultats;
BEGIN
	tabResultats := GestionParcoursHe.Rechercher('2012');
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

-- Résultat : ORA-20204: Il n'y a pas de résultat pour l'année scolaire 2012.

-----------------------------------------------------------------------------------------------------------------------

-- Test sans paramètres, DEFAULT 2009

DECLARE
	tabResultats GestionParcoursHe.T_MeilleursResultats;
BEGIN
	tabResultats := GestionParcoursHe.Rechercher();
	DBMS_OUTPUT.PUT_LINE('Nombre de résultats : ' || tabResultats.COUNT);
	FOR i IN tabResultats.FIRST .. tabResultats.LAST LOOP
		DBMS_OUTPUT.PUT_LINE(tabResultats(i).Matricule || ' ' || tabResultats(i).Nom || ' ' || tabResultats(i).Prenom || ' ' || tabResultats(i).Annetud || ' ' || tabResultats(i).Formation || ' ' || tabResultats(i).Total);
	END LOOP;
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

/*
	Nombre de résultats : 39
	1900613ANGJAM Anglade Jamal 1 ECO-INF0 820
	1881018HINCON Hinton Conan 2 ECO-INF0 735
	1880310SHALEO Shattler Leonar 3 ECO-INF0 636
	2890824BOHIMA Bohbot Imane 1 PED-D_AESI 738
	2900523DIFIMA Difrancesco Imane 2 PED-D_AESI 812
	1851031DRANIK Dragon Niklas 3 PED-D_AESISA 675
	1851114MORERL Morales Erle 3 PED-D_AESISE 646
	1900616DOYSAM Doyon Sammy 3 PED-D_AESISO 660
	2910225HORIMA Horvath Imane 2 TECH-BCHI 730
	2880110DOBIMA Dobson Imane 3 TECH-BCHI 642
	1910223LITHAN Little Hannibal 2 TECH-BCON 720
	1880906MAXANT Maxwell Anthyme 3 TECH-BCON 629
	1900605CHAETO Chaput Etor 2 TECH-BELE 753
	1880204ORTMAI Ortega Maimoun 3 TECH-BELE 639
	1900104PIEJAN Pien Janneken 2 TECH-BGEN 726
	1880903BANNAZ Bannon Nazario 3 TECH-BGEN 620
	1911006GOSKOL Gosselin Kolin 1 TECH-BING 809
	1880317WISDEN Wiseman Denez 1 TECH-GRAI 819
	1881228SILPON Sills Pontien 2 TECH-GRAI 805
	1861218WALBER Wallace Bert 3 TECH-GRAI 585
	1841009THEKHO Theberge Khosrov 3 TECH-GRAI 585
	2880427DEMIMA Demirdjian Imane 1 TECH-IBIO 807
	2870414PREIMA Prevost Imane 1 TECH-ICHI 655
	1770814SCHFER Schinck Ferrero 2 TECH-ICHI 625
	1870707CRENIK Crete Nikolai 1 TECH-ICON 743
	1850216POUMEL Poudrier Melvin 1 TECH-IELE 678
	1870327PARJES Parr Jessi 1 TECH-IELM 805
	1820416ZACDAR Zacharie Darius 2 TECH-IELM 619
	2870619HAJMAD Hajjar Madonna 1 TECH-IGEO 686
	1851119VICSON Vicente Soni 2 TECH-IGEO 400
	1851117DECFAR Decelles Faride 1 TECH-IINF 785
	1900829BIGGAN Bigeault Ganix 2 TECH-INDU 801
	1890812BAHLAZ Bah Lazarus 3 TECH-INDU 716
	1910511SLIEGM Slight Egmund 1 TECH-INS0 883
	1890821NOUYOL Noury Yolan 1 TECH-MECM 765
	1841025SIDPON Sidhu Poncars 2 TECH-MECM 828
	2830205MAYIMA Mayo Imane 3 TECH-MECM 629
	1891107GALDAV Gale Davy 2 TECH-RESE 800
	1870601BLOJON Blondeau Jonathan 3 TECH-RESE 675
*/

-----------------------------------------------------------------------------------------------------------------------

-- Test fonctionnel

DECLARE
	tabResultats GestionParcoursHe.T_MeilleursResultats;
BEGIN
	tabResultats := GestionParcoursHe.Rechercher('2004');
	DBMS_OUTPUT.PUT_LINE('Nombre de résultats : ' || tabResultats.COUNT);
	FOR i IN tabResultats.FIRST .. tabResultats.LAST LOOP
		DBMS_OUTPUT.PUT_LINE(tabResultats(i).Matricule || ' ' || tabResultats(i).Nom || ' ' || tabResultats(i).Prenom || ' ' || tabResultats(i).Annetud || ' ' || tabResultats(i).Formation || ' ' || tabResultats(i).Total);
	END LOOP;
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

/*
	Nombre de résultats : 14
	1851116BOURAM Bourdua Ramzy 1 ECO-INF0 810
	1850803NEVMER Neves Merwane 2 ECO-INF0 872
	1841201TEORAO Teoli Raoulin 3 ECO-INF0 624
	1820808PACJOS Pachanos Josephe  1 TECH-GRAI 802
	1850310MALTIT Malka Titus 2 TECH-GRAI 804
	2830526LAPODE Lapierre Odelia 3 TECH-GRAI 570
	1840731SEBRUP Sebbag Ruperto 2 TECH-INDU 760
	1820715CHOTEO Cholette Teodoric 3 TECH-INDU 656
	1780131MCLGAR McLaughlin Garabed 1 TECH-INS0 907
	1840724BEGADR Begum Adriel 1 TECH-MECM 903
	1841002SARVAS Sarault Vassily 2 TECH-MECM 825
	1810309DEGDAR Deguire Dario 3 TECH-MECM 82
	1831125BLAJEN Blacksmith Jeng 2 TECH-RESE 830
	1830508RABROS Rabbitskin Ross 3 TECH-RESE 646
*/

/* *************************** TESTS PROCEDURE SUPPRIMER 1 *************************** */

-- Test fonctionnel

DECLARE
	tabEtudiantsSupprimes GestionParcoursHe.T_EtudiantsSupprimes;
BEGIN
	GestionParcoursHe.Supprimer(tabEtudiantsSupprimes);
	DBMS_OUTPUT.PUT_LINE('Nombre d''étudiants effacés : ' || tabEtudiantsSupprimes.COUNT);
	FOR i IN tabEtudiantsSupprimes.FIRST .. tabEtudiantsSupprimes.LAST LOOP
		DBMS_OUTPUT.PUT_LINE(tabEtudiantsSupprimes(i).Matricule || ' ' || tabEtudiantsSupprimes(i).Nom || ' ' || tabEtudiantsSupprimes(i).Prenom);
	END LOOP;
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

/*
	Nombre d''étudiants effacés : 648
	1710409PELNUR Peloquin Nuri
	1731228FAWMAV Fawaz Mavrick
	1740109HODHEL Hodgins Helias
	1740417BOICOM Boissy Come
	1750524LINRIN Linares Rino
	1750624SEVSAP Severe Saphir
	1751004BOIDOM Boilard Dom
	1760529GEOMAR Geoffrion Marwane
	1760612LADART Ladouceur Artus
	1760922PRUJAI Pruneau Jaimes
	1761104MCIMAR McInnis Marian
	1770304MONVAL Montpas Valmond
	1770311BRASAL Brazeau Salem
	1770827MILMEN Miljour Mendel
	1771119WELGEO Welsh Geoffroi
	1780118MAINAT Maiorano Naty
	1780217MAINAT Maillette Nathanel
	1780709GAUKEV Gaucher Kevin
	1780905DESHAR Desainde Harley
	1790119CHEPHO Chenel Phong
	1790201NEPKER Nepton Kerne
	1790426DOMDAM Dominguez Damien
	1790612DESMER Desjardins Meriadec
	1790921MARBAT Marchand Batisto
	1790928DEVHAR Devito Haroun
	1791001GARIRV Gardner Irvin
	1791012ISRKAI Israel Kailen
	1791217AQUMIL Aquino Milo
	1800505CLAYEN Clavet Yen
	1800512CHITHO Chiu Thony
	1800523PAXKAS Paxton Kasimir
	1800615TRAAKI Tranchemontagne Akilino
	1800703LAPBET Laplante Betelu
	1800709CHUPAO Chung Paolino
	1800811RAMGAS Ramos Gaspard
	1800813PAVJUS Pavao Justinien
	1800831CHITEO Chiovitti Teofilo
	1800914VESTEO Vescio Teofil
	1800918WEIELO Weistche eloi
	1801003MEEJER Meehan Jeronim 
	1801021IANLAU Iannuzzi Laurentch
	1801116COUTYM Coursol Tymote
	1801118LEPABR Lepore Abriel
	1801127LABMAT Labranche Matthew
	1801130SANHAS Sandoval Hasan
	1801216BRIPEL Brillant Pelaio
	1801220COLNUM Colby Numa
	1801227FELGER Felix Germinal
	1810103MEIYOR Meisels Yorick
	1810109CHETHO Chea Thomy
	1810115DESHAR Desalliers Haron
	1810303BILDON Bill Donan
	1810311BELJOR Belhumeur Jori
	1810312MATVIT Matteo Vito
	1810312RENALP Renda Alpha
	1810319DEBBER Debien Bernabe
	1810329DENMAR Denoncourt Marwen
	1810409DELGOR Delasablonniere Gorka
	1810410CHOTAO Cho Tao
	1810421MARVIT Martel Vitalis
	1810422CALREY Calderon Reyan
	1810422PACJOS Packwood Josian
	1810427MELMAR Meloche Marino
	1810429RAIHAS Rail Hasan
	1810505BRIPIL Brien Pilale
	1810507ST-CHI St-Arnaud Chirag
	1810509AMYMAM Amyot Mamoudou
	1810511CHESLO Chehade Sloan
	1810515DESPER Desantis Pere
	1810516CARMAX Carruthers Maximino
	1810522CHEIVO Chevrefils Ivo
	1810603SALOUS Saleh Ousmane
	1810614RANEUS Rana Eusebe
	1810629COLNEM Cole Nemo
	1810703CAYKEY Cayer Keyne
	1810710CECCAR Cecere Carmel
	1810719MECJER Mecteau Jeremi
	1810719RAYSOS Raymond Sostene
	1810815ST-CRI St-Andre Cristobal
	1810829DOLDOM Dolan Dominick
	1810906AINDON Ainsley Donal
	1810907DERHER Derouin Herold
	1810910LECCAR Lecuyer Carles
	1810927LETFAR Letourneau Faress
	1810927MESLOR Mestenapeo Lorenti
	1811014PASCES Passarelli Cesaru
	1811015DEMFER Demontigny Fernando
	1811019ESPLUI Esposito Luidgi
	1811027FREZAK Frenette Zakariya
	1811127COUAIM Couet Aimery
	1811203CHERAO Chene Raoul
	1811214PATKOS Patton Kosmos
	1811215WEIERO Weinstein Erol
	1811223FERYER Fernando Yeraz
	1811226BRUBAK Bruni Bakari
	1811231GALSOV Gallo Sovann
	1820119CROPAK Croxen Pakito
	1820126SCHHER Scherer Hermes
	1820130CELCOR Celestin Corey
	1820202LAFANT Lafond Anton
	1820208JORCOL Jordan Colomban
	1820216CORROM Corbo Romanus
	1820217SCAHER Scalabrini Hervey
	1820219PERMAR Perkins Maryan
	1820304KNAKEM Knafo Kemal
	1820305SANYAS Santana Yassine
	1820312KHAAPO Khalaf Apollo
	1820404DELGER Delbalso Geraldy
	1820425BLUZEN Bluteau Zenobe
	1820430CHAANO Chachai Anoir
	1820503PEPMAR Pepin Martik
	1820504DANERW Dantonio Erwan
	1820504PARJOS Parker Josselyn
	1820505DANMAX Dangelo Maxim
	1820513ADJHAR Adjei Haris
	1820523RODVAL Rodney Valens
	1820524DETHER Detonnancourt Hervey
	1820526ALECON Alexandre Constantin
	1820606FELGER Feldman Germano
	1820612PAUJUS Pauze Justinian
	1820617LEQYOR Lequin Yoram
	1820622PAYJOS Payne Jose
	1820629DESXAR Desmarteau Xarles
	1820717CHANAO Chalifoux Nao
	1820724CHAAPO Chahine Apolo
	1820726GENNOR Gendron Normann
	1820805DHIALO Dhillon Aloyse
	1820806LAUTOU Laurin Toufik
	1820918GERMAR Gervais Marcelino
	1820919ARNKOL Arnold Kolin
	1820924LANMOU Lanoie Mounir
	1820930MASPAT Masse Patricius
	1821001DESPER Desaulniers Peregrino
	1821007GAIEDV Gaignard Edvard
	1821007LAUYOU Laurie Yousef
	1821010FERGOR Ferland Gordan
	1821021LANSOU Lance Soulemane
	1821030CHAAPO Chagnon Apollo
	1821107NIQHEN Niquay Henrick
	1821123RODTUL Rodier Tullio
	1821203BOUPOM Bourgault Pompee
	1821205ST-CLI St-Aubin Clifford
	1821211MIGMON Migneault Monir
	1821224ROMCEL Romano Celio
	1830102MENMAR Menjivar Marlone
	1830105ARIKIL Arial Kiliann
	1830130MANOCT Manna Octave
	1830201JEUBAR Jeune Barry
	1830203AMIKEM Amireault Kemuel
	1830204MAARIT Maalouf Ritchie
	1830208LABMAT Labonville Mattew
	1830210FELGER Felx Gerry
	1830307CAPFAY Caplette Faycel
	1830309LEBCYR Leblond Cyrillus
	1830310PIEHEN Pierre Henrique
	1830313AMIKEM Amiri Kemil
	1830318BELJOR Belleau Joris
	1830319AINKEN Ainalik Kenzy
	1830329JOMCOL Jomphe Colbert
	1830403MAPFAT Mapachee Fatih
	1830405PERMAR Perras Marc-Alexandre
	1830406BROMIK Brouillard Mike
	1830408HANGAU Han Gautier
	1830422LEGELR Legrand Elric
	1830503DEBBER Debigare Bernardin
	1830505MONVAL Montour Valerius
	1830522SCUISR Scully Israel
	1830523DAOERW Dao Erwin
	1830525LANMOU Lanneville Mouad
	1830531HAYAQU Hayes Aquilain
	1830531SCOENR Scott Enrik
	1830603LENTER Lenoir Terrance
	1830611CORRAM Cormier Rambert
	1830612MCLGAR McLellan Garry
	1830619DESYOR Deslippe Yoran
	1830702DRANIK Draper Nikolas
	1830705FATSOV Fata Sovann
	1830705GHAADO Ghaleb Adolfino
	1830716CERCER Cere Ceres
	1830721CHAJAO Chalmers Jao
	1830729NEMKER Nemeth Kerian
	1830801DEPIDR Depont Idrissa
	1830807KERARR Kerouack Arran
	1830817LANNOU Langlois Nouri
	1830822PELNER Peluso Nerses
	1830831SHEENO Sheridan Enos
	1830904CHOTEO Choi Teobald
	1830905MARMAT Marmen Maties
	1830905VERLEO Verma Leoncio
	1830905VERTRO Verrier Trong
	1830908MEULAR Meunier Lars
	1830914SALOUS Salvas Ousmane
	1830922SHEFLO Sheehan Florimond
	1830926NOLHEL Nolet Helmut
	1830929MCLGER McLeod Gerald
	1830929NASCAS Nash Cassio
	1830930HARLOU Harnois Louis-Alexandre
	1831001ZIMDAN Zimmermann Danias
	1831002LAFANT Lafleur Antoine
	1831004MCKMAR McKay Marinus
	1831015REILOP Reich Lope
	1831017CROYEK Croteau Yekel
	1831029WHIBEN Whitebean Ben
	1831108MINTON Mineault Tonino
	1831108ST-AVI St-Cyr Aviv
	1831114FAYHOV Fayad Hovakim
	1831114LANMAU Lantagne Maudet
	1831124BELJER Belleville Jerome
	1831211HOWKIL Howarth Killian
	1831221ROGVAL Roger Valeran
	1831222GAMSEV Gamache Sevan
	1831228TRIZAI Tringle Zaid
	1831230CLAYAN Claveau Yannick
	1840103HAMEGU Hamade Egun
	1840105MENMAR Mendoza Marley
	1840110LECBER Leclerc Bertil
	1840111THUBEN Thurairajah Benedicto
	1840116WHILEN Whitehead Leno
	1840122ALATON Alain Tonny
	1840125LACANT Lacharite Antzo
	1840201DELHAR Deland Harouna
	1840206MILNAN Miles Nani
	1840216MCLGAR McLean Garen
	1840222GHAYVO Ghattas Yvonnic
	1840223RODVAL Rodriguez Valentinien
	1840227FREVIK Freedman Viktor
	1840309MCKLUR McKeown Lurenzu
	1840310HOWJUL Howell Juliann
	1840311KENAUR Kenney Aureo
	1840328WILDON Williamson Donald
	1840329SAUWAS Saunders Wasim
	1840408MCDMAR McDougall Marceles
	1840413KAUMAU Kausar Maurin
	1840414CARBAX Carignan Baxil
	1840416MALSET Mallozzi Seth
	1840420PALKOS Palladini Kosmos
	1840427PITHEN Pitre Henryk
	1840504BLAKEN Blanchette Kenzi
	1840505CHALEO Chaudhry Leo-Paul
	1840511ALATAN Alarcon Tangui
	1840511EDWHAR Edward Harris
	1840515DEFEDR Defrancesco edric
	1840519BEAGIR Beaumier Girald
	1840527HETMAR Hetu Marcos
	1840529XENELO Xenos eloy
	1840531TRAZOI Travers Zoig
	1840619LEMTUR Lemus Turio
	1840701MCNFER McNally Ferdinand
	1840713FAVNEV Favre Neven
	1840716NERKER Neron Keryan
	1840720MASPAT Massarelli Patricien
	1840722BEAGER Beaulieu Gerry
	1840722MALPET Maloney Petro
	1840723PANJUS Panneton Justino
	1840731LHEADO Lheureux Adolfino
	1840810LABMAT Labonne Mattalus
	1840828LARNOU Larcheveque Noubar
	1840901LESSER Lesieur Serge
	1840904MANOTT Mann Otto
	1840906KAUMAU Kauki Maurice
	1840913BOUPOM Bourgelas Pompeio
	1840923CHEISO Chevigny Isocrates
	1840927ARTKEL Arthur Kelil
	1841002GOUKAL Gourgues Kalil
	1841021LEMDAR Lemens Darren
	1841022BARANY Barker Anycet
	1841105CHALEO Chaumont Leopoldino
	1841109LANPRU Landreville Prudencio
	1841124LAUYOU Laurent Youness
	1841126BAZOZZ Bazile Ozzie
	1841127LEBCIR Lebrun Ciryl
	1841204LAWPAU Lawton Pau
	1841205MASOCT Mastrocola Octavius
	1841205SANYUS Santiago Yusuf
	1841210PAPDUS Papadakis Dustin
	1841216HENTER Henault Terrance
	1841217HARLAU Hart Lauri
	1841220HARLOU Harrisson Loup
	1841220SANGIS Sanschagrin Giselbert
	1850112LACMAT Lacasse Matys
	1850116COUTIM Courtemanche Time
	1850120PAPAOS Papineau Aostin
	1850212LHEADO Lherault Adolphe
	1850214GRAETI Grant etienne
	1850214NATBAS Nathan Basil
	1850215ARIKIL Arias Killian
	1850216CAMILY Campagna Ilyass
	1850216KAPYOU Kaplan Youcef
	1850216OSEAMI Osei Amine
	1850221CARCLY Carvalho Clyde
	1850228KHAAPO Khalife Apolo
	1850301CATRAY Cater Rayane
	1850304ALEGEN Alexander Genseric
	1850306TOOSUL Tooktoo Sulivan
	1850313RODVAL Rodrigue Valentine
	1850313WELTHO Welch Thor
	1850315WHABEN Whalen Benito
	1850325SANYAS Santamaria Yasser
	1850412LETFAR Lethiecq Farah
	1850412NASCES Nasser Cesariu
	1850415MILJAN Miller Janis
	1850418LAUSOU Lauziere Soufien
	1850418NANNAT Nantais Nathael
	1850423HAYAGU Hayeur Aguste
	1850501BEDALR Bedard Alrik
	1850506PETMIQ Petel Miquel
	1850522RENKEP Reny Kepa
	1850524BECALR Becotte Alric
	1850601TRAALI Tranquille Ali
	1850606JEATAR Jean Taron
	1850704MEQJOR Mequish Jordy
	1850704PETMAR Petitclerc Marick
	1850719CHITRO Chilton Trong
	1850726BARRAZ Barabe Razi
	1850728THOCON Thomas Cong
	1850808MARART Marciano Artan
	1850811MCAJUR McAllister Jurgen
	1850817SELSOP Sellathurai Sophian
	1850830MIRSIN Mirarchi Sinclare
	1850831LABMAT Labossiere Mattheo
	1850910LEHDOR Lehouillier Doris
	1850911OCOFER Oconnell Ferid
	1850915YOCZOL Yockell Zoltan
	1850917ROSALL Rossi Allen
	1851010ROBVAL Robles Valerius
	1851018MAREST Maranda Estebane
	1851018PAPDES Papatie Desiderius
	1851029JALLAU Jalbert Lauers
	1851103NASCES Nasrallah Cesare
	1851105HAIGAU Haines Gauvin
	1851110MASPAT Masri Patric
	1851124LEBCYR Lebeau Cyrano
	1851210MACPET Machabee Petronio
	1851212FARLIV Farina Livio
	1851222NICSAN Nickner Santi
	1860105VIOZEN Violette Zenodore
	1860118ZAMCOR Zamor Corneille
	1860120MARMAT Marois Matiss
	1860127MATMAT Mathurin Mat
	1860207SBELOR Sbeiti Lorne
	1860216BARAVY Bard Avy
	1860216MANNAT Manoukian Nataniel
	1860218CAMNAY Cameron Nayati
	1860302KANHOU Kandasamy Houssine
	1860303CHITXO Chin Txomin
	1860312BAXAZZ Baxter Azziz
	1860313MALMAT Malepart Matthias
	1860315MCCKAR McCabe Karmelo
	1860328BASARZ Bastille Arzhel
	1860328MAJMAT Major Mathys
	1860330LENTYR Leng Tyrone
	1860416MCAKAR McArthur Karan
	1860417GAUYOV Gaudreault Yovan
	1860419RICHON Richardson Honorus
	1860420MARMAT Marsan Matthys
	1860423MCMGER McMullen German
	1860425DELHAR Delaney Harrison
	1860427MANNAT Mansour Nathalien
	1860430MCCDOR McCallum Doran
	1860516MCWKER McWhirter Kerwan
	1860520VANROS Vanasse Rostan
	1860522SAYRUS Sayers Russ
	1860523LACART Lacroix Artin
	1860602IORKAL Iorio Kalil
	1860608SAMMUS Samson Mustapha
	1860609DILHAN Dilalla H?nsel
	1860715GALDAV Galarneau Davi
	1860718POLWIL Polisena Willy
	1860721HANGAU Handfield Gauvin
	1860730DELGAR Delva Garen
	1860803PARJOS Paris Josef
	1860803TALJUS Talarico Justus
	1860820ABECER Abellard Ceres
	1860831CALRAY Caluori Rayen
	1860902MCDMAR McDermott Marc-Alexandre
	1860903MARMAT Marotte Matmon
	1860910WALBER Wall Bernardo
	1860911VALWIS Valenzuela Wissam
	1860918LEGEMR Legresley Emrah
	1860919CANELY Cantara Elyesse
	1860929GAUVIV Gaul Viviano
	1861002LAUYOU Laurencelle Youcef
	1861003ATTANI Attar Anis
	1861013ROUTAL Roulier Taliane
	1861015OCOFER Oconnor Fergie
	1861024HAZAQU Hazen Aquilles
	1861102KATMAU Katz Maudez
	1861113GAUSEV Gaumond Severian
	1861128BRUJEK Bruneau Jekel
	1861129NASCES Nasr Cesaire
	1861210ALVVIN Alvarado Vinh
	1861214LABMAT Laboissonniere Matmon
	1861224JOBADL Jobidon Adler
	1861226FAUSEV Fauchon Sevan
	1861227KANHOU Kanapathipillai Houarn
	1861230BRISAL Brie Salah
	1870113BERBER Bernardi Bertrand
	1870127BELKUR Beloin Kurt
	1870127TRIARI Trinque Arie
	1870131BOUREM Bouthillette Remigio
	1870216PHIGIO Philippe Giordano
	1870219DOYSAM Doyer Sami
	1870223MADPAT Madden Patricien
	1870225DAMLEV Damphousse Levi
	1870304PAIEUS Paiva Eusebio
	1870307SAVSOS Savard Sostene
	1870310GANSAV Ganley Savinien
	1870316GASMAV Gascon Mavel
	1870318SHALEO Sharpe Leon
	1870324SINWIN Sincennes Winog
	1870403GHOADO Ghosn Adon
	1870411CARKEY Caruso Keyvan
	1870507SAGGAS Saget Gaspard
	1870530MAGOCT Maguire Octavien
	1870607GADLAU Gadbois Laureano
	1870618POLWIL Poliquin Willie
	1870712VALROS Vallieres Rosalio
	1870714FELGER Felteau Geronimo
	1870722WAUDER Waugh Derik
	1870726WOOKAL Woodard Kalil
	1870727MONVAL Monteiro Valentin
	1871031BANNAZ Banks Nazar
	1871105MOFMEL Moffatt Melwin
	1871111OSMAMI Osman Amiel
	1871117LAGDAT Lagueux Datev
	1871121BAILAZ Bain Lazaro
	1871122DIALUN Diallo Lunaire
	1871128LAVSAU Laviolette Saul
	1871130CORROM Corbett Roman
	1871202DIOKEN Dion Keny
	1871203FABERV Fabien Erven
	1871214NOVYUL Novak Yuli
	1871214POUMEL Poucachiche Meliton
	1871220VOLTAL Voltaire Taliane
	1871225GOOLEL Goodleaf Lelio
	1871228BALSEZ Ballabey Sezny
	1871229MARVIT Marien Vitalis
	1880102DAMDAV Dame Davie
	1880106IRVELI Irving Eliad
	1880128LAGFAT Lagrange Fatah
	1880130UNDAHM Underwood Ahmad
	1880212TAMJES Tam Jesus
	1880220TANDES Tanguay Desmond
	1880302FLOSAN Florent Santiago
	1880307BORTYM Bordage Tymote
	1880307CARAUX Carriere Auxence
	1880309BOUELM Bousquet Elmo
	1880309DALDAV Daly Dave
	1880310FIOBEN Fiorilli Benedict
	1880310ROWSAL Rowsell Salbator
	1880311VALWAS Valentini Wassim
	1880312TOUWAL Tousignant Waldi
	1880320APPWIL Appiah Willi
	1880324FAVMIV Favreau Mivek
	1880330FREZAK Freniere Zakarya
	1880408GHAATO Ghandour Atom
	1880409MASOCT Masson Octavien
	1880417SALDES Salah Desiderius
	1880419ROUSIL Rousselot Silvere
	1880424CAMNAY Camille Nayel
	1880503CARMAX Carmichael Maxance
	1880507METLOR Metcalfe Lorne
	1880512MALMAT Maldonado Matteu
	1880513BARANY Baril Anycet
	1880518DIMHEN Dimarco Hendrick
	1880520COTWIL Cote Wilhelm
	1880527JOHAEL John Aelig
	1880528PHAJAO Pharand Jaoued
	1880613TOUTUL Tougas Tullio
	1880622DOWTIM Dow Timothey
	1880624TORVAL Tortorici Valentinien
	1880703ELHMAN Elhachem Manua
	1880703VALYUS Valcourt Yusuf
	1880705POUILL Poulin Illan
	1880706CABILY Caballero Ilyas
	1880718DAMLAV Damours Lavrendios
	1880722HAPDRU Happyjack Druon
	1880726ROWSEL Rowan Sellam
	1880802ASPLOI Aspirot Loic
	1880809COMYUM Compere Yuma
	1880817BONJAM Bonhomme Jameson
	1880905LEIEDR Leifer Edris
	1880911BAZNAZ Bazinet Nazareno
	1880923FONRAM Fontaine Ramzy
	1881011BOUSAM Boulard Samire
	1881014GALALV Galipeau Alvine
	1881016BLAKEN Blake Kenneth
	1881016YOUWIL Youssef Wilfrid
	1881027FAUSAV Faubert Savie
	1881104SAIDUS Saini Dusan
	1881107GARNEV Garon Neven
	1881110ROZSAL Rozon Salvador
	1881112LAVSOU Lavictoire Soulemane
	1881208LAPPAU Laprise Paul-Antoine
	1881211PETPER Pettigrew Peregrino
	1881211YOUYUL Younes Yuli
	1881219VANOSS Vandelac Ossama
	1890109HAGGOU Hage Gourane
	1890109KNIKUM Knight Kumb
	1890112POTMEL Potvin Melih
	1890118RAPCES Raposo Ceslaw
	1890126GARMIV Garand Mivek
	1890129JEFPER Jeffrey Peru
	1890204BOYNEM Boyce Nemesio
	1890306CIRERN Circe Ernestus
	1890315DAWEDW Dawson Edward
	1890331PIPYAN Pipon Yanisse
	1890404HARLOU Harper Louison
	1890404LAFFAT Laframboise Fatah
	1890407KIDCON Kidd Consuelo
	1890417EINZEN Einish Zenodore
	1890418HAIGAU Haineault Gautier
	1890421WOOJOL Woodward Jolan
	1890515DESODR Desfosses Odran
	1890629KLEREN Klein Renier
	1890629MARSAT Martinez Saturnin
	1890713CORAYM Correia Ayman
	1890714YOUWIL Young Wilf
	1890726GIRKON Giraldeau Konstantino
	1890817HIVDAN Hivon Danel
	1890913BRAZEK Brassard Zeki
	1891005DOBROM Dobbs Romane
	1891007MOSSOL Moscato Solen
	1891021LORHEL Lorion Helmut
	1891024DOWTIM Downey Timour
	1891028LIPIAN Lippe Ianis
	1891117LORHEL Lord Helmes
	1891120ROSCEL Rosales Celestin
	1891211ANTAIM Antaya Aimeric
	1891215BOLROM Bolduc Romualdus
	1891222MAINAT Maille Nathanae
	1891223HOGHEL Hogue Helmut
	1900108ROBVAL Robinette Valerian
	1900110BOIDAM Boisselle Damen
	1900120VAZJOS Vaz Josephin
	1900127COLHAM Colombo Hamdi
	1900128BOBERM Bobbitt Ermin
	1900130BOIDOM Boire Domingos
	1900206PETPER Petrin Per
	1900212BOUOSM Bouvier Osmane
	1900302VONTEL Vong Telesforo
	1900320KIMCAN Kim Candido
	1900406DOUTYM Dougherty Tymothe
	1900408BIEGON Biello Gontrano
	1900426VOGJUL Voghel Jules
	1900502TOPVAL Topping Valeriano
	1900706DIPJON Dipalma Jonah
	1900708BOBEMM Bobbish Emmery
	1900713INNMAM Innocent Mamerto
	1900714TOBDAL Tobin Dalil
	1900715DORJEM Dormoy Jemil
	1900716RIBJAN Ribeiro Janos
	1900726BONHOM Bonnier Homere
	1900806BOCEDM Bock Edmond
	1900806PREGUI Preville Guilleme
	1900817GODCAL Godmer Caleb
	1900918MONWAL Monk Wally
	1900926ELBMAN Elbaz Manoel
	1901008DOUTIM Douillard Timo
	1901016FOROSM Forino Osmund
	1901125GRAFAI Gratton Faisal
	1901126SIMYON Simmons Yoni
	1901128DOUTIM Douyon Timothe
	1901204IREERI Ireland Erico
	1901215GLOREN Glover Renatus
	1910131DILHAN Dilillo Hansi
	1910207ANDGAM Andraos Gamal
	1910207FOROSM Forgues Osmond
	1910317HODHEL Hodgson Helio
	1910505EPSWIL Epstein Willie
	1910520BOUROM Boulos Romanos
	1910520TOUCEL Toutant Celian
	1910526BOYJAM Boyte Jamel
	1910604GOLCAL Gold Calvin
	1910623GOUJUL Goupil Jules
	1910628TORVAL Torossian Valeri
	1911101FLOSAN Flores Santoru
	1911101WOOKAL Wood Kalan
	1911114GORKOL Gorman Koldo
	1911129DORYAM Dorval Yamine
	1920502GONMAL Gonneville Malory
	2710607ARUIMA Arumugam Imane
	2720303HIDIMA Hidalgo Imane
	2730501GERIMA Gerinlajoie Imane
	2770523LABILD Labreche Ilda
	2771220LABILA Labrecque Ilanit
	2790405JOSIMA Joseph Imane
	2791123DESIMA Desautels Imane
	2791229DRUIMA Drummond Imane
	2810414CHAIMA Chayer Imane
	2810720SQUIMA Squires Imane
	2811023GALKAI Galasso Kaitlin
	2811116FEVIMA Fevrier Imane
	2820512MCKIMA McKenzie Imane
	2820521MALIMA Mallette Imane
	2820719GEMIMA Gemme Imane
	2820726CROIMA Cross Imane
	2820819FLYIMA Flynn Imane
	2821124MONIMA Monier Imane
	2830112FILIMA Filippone Imane
	2830114CORIMA Cornejo Imane
	2830120MILIMA Milot Imane
	2830308WEIIMA Weizineau Imane
	2830426LAPODE Laperriere Odelia
	2830801LESIMA Leslie Imane
	2831213DENIMA Deniger Imane
	2831222CHUIMA Church Imane
	2840104REMIMA Remy Imane
	2840121DASHAI Das Haiza
	2840310LAPODY Lapare Odyssee
	2840429NAVIMA Navarro Imane
	2840503MARIMA Marcelin Imane
	2840707ORLIMA Orlando Imane
	2840905COLIMA Colella Imane
	2841102MAPIMA Mapp Imane
	2841211PARIMA Parise Imane
	2850110MIRIMA Mirandette Imane
	2850307PARIMA Paradis Imane
	2850413DEOIMA Deom Imane
	2850414MARIMA Marleau Imane
	2850517LESIMA Lesperance Imane
	2850701BROIMA Brouard Imane
	2850715ATAIMA Atallah Imane
	2851127NATIMA Natachequan Imane
	2860402BEAIMA Beaunoyer Imane
	2860409MAKIMA Mak Imane
	2860419BOUIMA Bourdeau Imane
	2860516NADIMA Nadarajah Imane
	2860807HEAIMA Healey Imane
	2870103PALIMA Palumbo Imane
	2870401PROIMA Proulx Imane
	2870609PLAIMA Plante Imane
	2870824BOUIMA Boursier Imane
	2871012ROSIMA Rosenberg Imane
	2871110BALCAL Balthazar Calyssa
	2871224BALCAL Ballard Calypso
	2880105MONIMA Monfette Imane
	2880111SOWIMA Sow Imane
	2890112RIZIMA Rizk Imane
	2890226BATBAT Battisti Bathilda
	2890327MARIMA Marechal Imane
	2890825BIEIMA Bienaime Imane
	2891004GIRIMA Girardeau Imane
	2900131GOUIMA Gouin Imane
	2900502GODIMA Godon Imane
	2900825BONIMA Bondu Imane
	2910529MONIMA Monfils Imane
	2911119CONIMA Connors Imane
*/

-----------------------------------------------------------------------------------------------------------------------

-- Test exception E_TabOutVide (à exécuter après la 1ere fois)

DECLARE
	tabEtudiantsSupprimes GestionParcoursHe.T_EtudiantsSupprimes;
BEGIN
	GestionParcoursHe.Supprimer(tabEtudiantsSupprimes);
	DBMS_OUTPUT.PUT_LINE('Nombre d''étudiants effacés : ' || tabEtudiantsSupprimes.COUNT);
	FOR i IN tabEtudiantsSupprimes.FIRST .. tabEtudiantsSupprimes.LAST LOOP
		DBMS_OUTPUT.PUT_LINE(tabEtudiantsSupprimes(i).Matricule || ' ' || tabEtudiantsSupprimes(i).Nom || ' ' || tabEtudiantsSupprimes(i).Prenom);
	END LOOP;
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

-- Résultat : ORA-20210: Il n'y a aucun étudiant qui a fini son parcours scolaire.

/* *************************** TESTS PROCEDURE SUPPRIMER 2 *************************** */

-- Test Tableau IN vide

DECLARE
	tabMatriculeIn GestionParcoursHE.T_Matricules;
	tabEtudiantsSupprimes GestionParcoursHE.T_EtudiantsSupprimes;
	tabMatriculeOut GestionParcoursHE.T_Matricules;
	i NUMBER;
BEGIN
	GestionParcoursHE.Supprimer(tabMatriculeIn, tabEtudiantsSupprimes, tabMatriculeOut);
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

-- Résultat : ORA-20211: La collection de matricules passée en paramètre doit comporter des matricules.

-----------------------------------------------------------------------------------------------------------------------

-- Test fonctionnel (tuples supprimés et non-supprimés)

DECLARE
	tabMatriculeIn GestionParcoursHE.T_Matricules;
	tabEtudiantsSupprimes GestionParcoursHE.T_EtudiantsSupprimes;
	tabMatriculeOut GestionParcoursHE.T_Matricules;
	i NUMBER;
BEGIN  
	SELECT Matricule BULK COLLECT INTO tabMatriculeIn
	FROM Etudiants
	WHERE ROWNUM < 5;
	tabMatriculeIn(9) := '1234567GUIJUL';

	GestionParcoursHE.Supprimer(tabMatriculeIn, tabEtudiantsSupprimes, tabMatriculeOut);
	
	DBMS_OUTPUT.PUT_LINE('***** Etudiants à supprimer *****');
	i := tabMatriculeIn.FIRST;
	WHILE i IS NOT NULL LOOP
		DBMS_OUTPUT.PUT_LINE(tabMatriculeIn(i));
	i := tabMatriculeIn.NEXT(i);
	END LOOP;

	IF(tabEtudiantsSupprimes.COUNT > 0) THEN
		DBMS_OUTPUT.PUT_LINE('***** Etudiants supprimés *****');
		FOR i IN tabEtudiantsSupprimes.FIRST .. tabEtudiantsSupprimes.LAST LOOP
			DBMS_OUTPUT.PUT_LINE(tabEtudiantsSupprimes(i).Matricule || ' ' || tabEtudiantsSupprimes(i).Nom || ' ' || tabEtudiantsSupprimes(i).Prenom);
		END LOOP;
	END IF;

	IF(tabMatriculeOut.COUNT > 0) THEN
		DBMS_OUTPUT.PUT_LINE('***** Etudiants non supprimés *****');
		FOR i IN tabMatriculeOut.FIRST .. tabMatriculeOut.LAST LOOP
			DBMS_OUTPUT.PUT_LINE(tabMatriculeOut(i));
		END LOOP;
	END IF;
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

/*
	***** Etudiants à supprimer *****
	1871103PAUKES
	1871103TOBDEL
	1871113ELLKON
	1871115LERTAR
	1234567GUIJUL
	***** Etudiants supprimés *****
	1871103PAUKES Paulhus Kesi
	1871103TOBDEL Tobar Delane
	1871113ELLKON Ellyson Kong
	1871115LERTAR Leroux Tariq
	***** Etudiants non supprimés *****
	1234567GUIJUL
*/

-----------------------------------------------------------------------------------------------------------------------

-- Test fonctionnel (tuples supprimés)

DECLARE
	tabMatriculeIn GestionParcoursHe.T_Matricules;
	tabEtudiantsSupprimes GestionParcoursHe.T_EtudiantsSupprimes;
	tabMatriculeOut GestionParcoursHe.T_Matricules;
	i NUMBER;
BEGIN  
	tabMatriculeIn(1) := '1871116LALANT'; 
	tabMatriculeIn(3) := '1871118DERISR';
	tabMatriculeIn(5) := '1871120GAGEDV';
	tabMatriculeIn(7) := '1871119GARPAV';

	GestionParcoursHe.Supprimer(tabMatriculeIn, tabEtudiantsSupprimes, tabMatriculeOut);
	
	DBMS_OUTPUT.PUT_LINE('***** Etudiants à supprimer (' || tabMatriculeIn.COUNT || ') *****');
	i := tabMatriculeIn.FIRST;
	WHILE i IS NOT NULL LOOP
		DBMS_OUTPUT.PUT_LINE(tabMatriculeIn(i));
	i := tabMatriculeIn.NEXT(i);
	END LOOP;

	IF(tabEtudiantsSupprimes.COUNT > 0) THEN
		DBMS_OUTPUT.PUT_LINE('***** Etudiants supprimés (' || tabEtudiantsSupprimes.COUNT || ') *****');
		FOR i IN tabEtudiantsSupprimes.FIRST .. tabEtudiantsSupprimes.LAST LOOP
			DBMS_OUTPUT.PUT_LINE(tabEtudiantsSupprimes(i).Matricule || ' ' || tabEtudiantsSupprimes(i).Nom || ' ' || tabEtudiantsSupprimes(i).Prenom);
		END LOOP;
	END IF;

	IF(tabMatriculeOut.COUNT > 0) THEN
		DBMS_OUTPUT.PUT_LINE('***** Etudiants non supprimés (' || tabMatriculeOut.COUNT || ') *****');
		FOR i IN tabMatriculeOut.FIRST .. tabMatriculeOut.LAST LOOP
			DBMS_OUTPUT.PUT_LINE(tabMatriculeOut(i));
		END LOOP;
	END IF;
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

/*
	***** Etudiants à supprimer (4) *****
	1871116LALANT
	1871118DERISR
	1871120GAGEDV
	1871119GARPAV
	***** Etudiants supprimés (4) *****
	1871116LALANT Laliberte Antoine
	1871118DERISR Deragon Israel
	1871120GAGEDV Gagne Edvin
	1871119GARPAV Garneau Pavel
*/

-----------------------------------------------------------------------------------------------------------------------

-- Test fonctionnel (tuples non-supprimés)

DECLARE
	tabMatriculeIn GestionParcoursHe.T_Matricules;
	tabEtudiantsSupprimes GestionParcoursHe.T_EtudiantsSupprimes;
	tabMatriculeOut GestionParcoursHe.T_Matricules;
	i NUMBER;
BEGIN  
	tabMatriculeIn(1) := '1950205ABCDEF'; 
	tabMatriculeIn(3) := '123456POUKIL';
	tabMatriculeIn(5) := '321584GUIJUL';
	tabMatriculeIn(7) := '1921111GROHER';

	GestionParcoursHe.Supprimer(tabMatriculeIn, tabEtudiantsSupprimes, tabMatriculeOut);
	
	DBMS_OUTPUT.PUT_LINE('***** Etudiants à supprimer (' || tabMatriculeIn.COUNT || ') *****');
	i := tabMatriculeIn.FIRST;
	WHILE i IS NOT NULL LOOP
		DBMS_OUTPUT.PUT_LINE(tabMatriculeIn(i));
	i := tabMatriculeIn.NEXT(i);
	END LOOP;

	IF(tabEtudiantsSupprimes.COUNT > 0) THEN
		DBMS_OUTPUT.PUT_LINE('***** Etudiants supprimés (' || tabEtudiantsSupprimes.COUNT || ') *****');
		FOR i IN tabEtudiantsSupprimes.FIRST .. tabEtudiantsSupprimes.LAST LOOP
			DBMS_OUTPUT.PUT_LINE(tabEtudiantsSupprimes(i).Matricule || ' ' || tabEtudiantsSupprimes(i).Nom || ' ' || tabEtudiantsSupprimes(i).Prenom);
		END LOOP;
	END IF;

	IF(tabMatriculeOut.COUNT > 0) THEN
		DBMS_OUTPUT.PUT_LINE('***** Etudiants non supprimés (' || tabMatriculeOut.COUNT || ') *****');
		FOR i IN tabMatriculeOut.FIRST .. tabMatriculeOut.LAST LOOP
			DBMS_OUTPUT.PUT_LINE(tabMatriculeOut(i));
		END LOOP;
	END IF;
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

/*
	***** Etudiants à supprimer (4) *****
	1950205ABCDEF
	123456POUKIL
	321584GUIJUL
	1921111GROHER
	***** Etudiants non supprimés (4) *****
	1950205ABCDEF
	123456POUKIL
	321584GUIJUL
	1921111GROHER
*/

/* *************************** TESTS PROCEDURE AJOUTER 1 *************************** */

-- Test E_RefformdetNull

DECLARE
	tabGroupesInseres GestionParcoursHe.T_Groupes;
BEGIN
	GestionParcoursHe.Ajouter(NULL, 2, '2009', 5, 1, tabGroupesInseres);
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

-- Résultat : ORA-20220: La formation passée en paramètre est obligatoire.

-----------------------------------------------------------------------------------------------------------------------

-- Test E_AnnetudNull

DECLARE
	tabGroupesInseres GestionParcoursHe.T_Groupes;
BEGIN
	GestionParcoursHe.Ajouter('ECO-INF0', NULL, '2009', 5, 1, tabGroupesInseres);
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

-- Résultat : ORA-20221: L'année d'étude passée en paramètre est obligatoire.

-----------------------------------------------------------------------------------------------------------------------

-- Test E_AnscoNull

DECLARE
	tabGroupesInseres GestionParcoursHe.T_Groupes;
BEGIN
	GestionParcoursHe.Ajouter('ECO-INF0', 2, NULL, 5, 1, tabGroupesInseres);
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

-- Résultat : ORA-20222: L'année scolaire passée en paramètre est obligatoire.

-----------------------------------------------------------------------------------------------------------------------

-- Test E_NbreGroupeNull

DECLARE
	tabGroupesInseres GestionParcoursHe.T_Groupes;
BEGIN
	GestionParcoursHe.Ajouter('ECO-INF0', 2, '2009', NULL, 1, tabGroupesInseres);
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

-- Résultat : ORA-20223: Le nombre de groupe passé en paramètre est obligatoire.

-----------------------------------------------------------------------------------------------------------------------

-- Test E_PremierGroupeNull

DECLARE
	tabGroupesInseres GestionParcoursHe.T_Groupes;
BEGIN
	GestionParcoursHe.Ajouter('ECO-INF0', 2, '2009', 5, NULL, tabGroupesInseres);
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

-- Résultat : ORA-20224: Le numéro du 1er groupe passé en paramètre est obligatoire.

-----------------------------------------------------------------------------------------------------------------------

-- Test E_RefformdetInvalid

DECLARE
	tabGroupesInseres GestionParcoursHe.T_Groupes;
BEGIN
	GestionParcoursHe.Ajouter('Coucou', 2, '2009', 5, 1, tabGroupesInseres);
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

-- Résultat : ORA-20225: La formation Coucou n'est pas organisée a l'INPRES.

-----------------------------------------------------------------------------------------------------------------------

-- Test E_AnnetudInvalid

DECLARE
	tabGroupesInseres GestionParcoursHe.T_Groupes;
BEGIN
	GestionParcoursHe.Ajouter('ECO-INF0', 5, '2009', 5, 1, tabGroupesInseres);
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

-- Résultat : ORA-20226: L'année d'étude passée en paramètre (5) doit être plus petite ou égale au maximum d'années d'étude de la formation ECO-INF0 (3).

-----------------------------------------------------------------------------------------------------------------------

-- Test E_AnscoInvalid

DECLARE
	tabGroupesInseres GestionParcoursHe.T_Groupes;
BEGIN
	GestionParcoursHe.Ajouter('ECO-INF0', 2, '2016', 5, 1, tabGroupesInseres);
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

-- Résultat : ORA-20227: L'année scolaire passée en paramètre (2016) doit être inferieure a l'année actuelle (2015).

-----------------------------------------------------------------------------------------------------------------------

-- Test E_ContrainteRef 

DECLARE
	tabGroupesInseres GestionParcoursHe.T_Groupes;
BEGIN
	GestionParcoursHe.Ajouter('ECO-INF0', 2, '2011', 5, 1, tabGroupesInseres);
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

-- Résultat : ORA-20228: L'année d'étude 2 pour la formation ECO-INF0 de l'année scolaire 2011 n'existe pas.

-----------------------------------------------------------------------------------------------------------------------

-- Test DUP_VAL_ON_INDEX

DECLARE
	tabGroupesInseres GestionParcoursHe.T_Groupes;
BEGIN
	GestionParcoursHe.Ajouter('ECO-INF0', 2, '2009', 3, 1, tabGroupesInseres);
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

-- Résultat : ORA-20229: Le groupe que vous tentez d'inserer existe déjà pour l'année d'étude 2, de la formation ECO-INF0 de l'année scolaire 2009.

-----------------------------------------------------------------------------------------------------------------------

-- Test fonctionnel

/* On ajoute des formations se donnant à INPS et des années d'études pour l'année scolaire 2010 dans la table Organise */

INSERT INTO Organise (Refformdet, Annetud, Ansco, Refimplan) VALUES ('ECO-INF0', 1, '2010', 'INPS');
INSERT INTO Organise (Refformdet, Annetud, Ansco, Refimplan) VALUES ('ECO-INF0', 2, '2010', 'INPS');
INSERT INTO Organise (Refformdet, Annetud, Ansco, Refimplan) VALUES ('ECO-INF0', 3, '2010', 'INPS');
INSERT INTO Organise (Refformdet, Annetud, Ansco, Refimplan) VALUES ('TECH-GRAI', 1, '2010', 'INPS');
INSERT INTO Organise (Refformdet, Annetud, Ansco, Refimplan) VALUES ('TECH-GRAI', 2, '2010', 'INPS');
INSERT INTO Organise (Refformdet, Annetud, Ansco, Refimplan) VALUES ('TECH-GRAI', 3, '2010', 'INPS');
INSERT INTO Organise (Refformdet, Annetud, Ansco, Refimplan) VALUES ('TECH-MECM', 1, '2010', 'INPS');
INSERT INTO Organise (Refformdet, Annetud, Ansco, Refimplan) VALUES ('TECH-MECM', 2, '2010', 'INPS');
INSERT INTO Organise (Refformdet, Annetud, Ansco, Refimplan) VALUES ('TECH-MECM', 3, '2010', 'INPS');
INSERT INTO Organise (Refformdet, Annetud, Ansco, Refimplan) VALUES ('TECH-INDU', 2, '2010', 'INPS');
INSERT INTO Organise (Refformdet, Annetud, Ansco, Refimplan) VALUES ('TECH-INDU', 3, '2010', 'INPS');
INSERT INTO Organise (Refformdet, Annetud, Ansco, Refimplan) VALUES ('TECH-RESE', 2, '2010', 'INPS');
INSERT INTO Organise (Refformdet, Annetud, Ansco, Refimplan) VALUES ('TECH-RESE', 3, '2010', 'INPS');
INSERT INTO Organise (Refformdet, Annetud, Ansco, Refimplan) VALUES ('TECH-AER0', 1, '2010', 'INPS');
INSERT INTO Organise (Refformdet, Annetud, Ansco, Refimplan) VALUES ('TECH-INS0', 1, '2010', 'INPS');
COMMIT;

DECLARE
	tabGroupesInseres GestionParcoursHe.T_Groupes;
BEGIN
	GestionParcoursHe.Ajouter('ECO-INF0', 1, '2010', 5, 1, tabGroupesInseres);
	
	IF(tabGroupesInseres.COUNT > 0) THEN
		FOR i IN tabGroupesInseres.FIRST .. tabGroupesInseres.LAST LOOP
			DBMS_OUTPUT.PUT_LINE(tabGroupesInseres(i).Refgroupe || ' ' || tabGroupesInseres(i).Refformdet || ' ' || tabGroupesInseres(i).Annetud || ' ' || tabGroupesInseres(i).Ansco || ' ' || tabGroupesInseres(i).Refimplan);
		END LOOP;
	END IF;
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

/*
	2101 ECO-INF0 1 2010 INPS
	2102 ECO-INF0 1 2010 INPS
	2103 ECO-INF0 1 2010 INPS
	2104 ECO-INF0 1 2010 INPS
	2105 ECO-INF0 1 2010 INPS
*/

-----------------------------------------------------------------------------------------------------------------------

/* *************************** TESTS PROCEDURE AJOUTER 2 *************************** */

-- Test E_TabInVide

DECLARE
	tabGroupesIn GestionParcoursHe.T_Groupes;
	tabGroupesOut GestionParcoursHe.T_Groupes;
	tabGroupesErreurs GestionParcoursHe.T_GroupesErreurs;
BEGIN
	GestionParcoursHe.Ajouter(tabGroupesIn, tabGroupesOut, tabGroupesErreurs);
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

-- Résultat : ORA-20230: La collection de groupes passée en paramètre ne doit pas être vide.

-----------------------------------------------------------------------------------------------------------------------

-- Test fonctionnel (tuples ajoutés et tuples non-ajoutés)

DECLARE
	tabGroupesIn GestionParcoursHe.T_Groupes;
	tabGroupesOut GestionParcoursHe.T_Groupes;
	tabGroupesErreurs GestionParcoursHe.T_GroupesErreurs;
BEGIN
	tabGroupesIn(-1).Refgroupe := '2101';
	tabGroupesIn(-1).Refformdet := 'ECO-INF0';
	tabGroupesIn(-1).Annetud := 1;
	tabGroupesIn(-1).Ansco := '2009';
	tabGroupesIn(-1).Refimplan := 'INPS';
	tabGroupesIn(2).Refgroupe := '2106';
	tabGroupesIn(2).Refformdet := 'ECO-INF0';
	tabGroupesIn(2).Annetud := 1;
	tabGroupesIn(2).Ansco := '2010';
	tabGroupesIn(2).Refimplan := 'INPS';
	tabGroupesIn(4).Refgroupe := '2103';
	tabGroupesIn(4).Refformdet := 'ECO-INF0';
	tabGroupesIn(4).Annetud := 1;
	tabGroupesIn(4).Ansco := '2011';
	tabGroupesIn(4).Refimplan := 'INPS';
	tabGroupesIn(9).Refgroupe := '2104';
	tabGroupesIn(9).Refformdet := 'ECO-INF0';
	tabGroupesIn(9).Annetud := 1;
	tabGroupesIn(9).Ansco := '2015';
	tabGroupesIn(9).Refimplan := 'INPS';
	
	GestionParcoursHe.Ajouter(tabGroupesIn, tabGroupesOut, tabGroupesErreurs);
	
	IF(tabGroupesOut.COUNT > 0) THEN
		DBMS_OUTPUT.PUT_LINE('Liste des groupes ajoutes');
		FOR i IN tabGroupesOut.FIRST .. tabGroupesOut.LAST LOOP
			DBMS_OUTPUT.PUT_LINE(tabGroupesOut(i).Refgroupe || ' ' || tabGroupesOut(i).Annetud || ' ' || tabGroupesOut(i).Ansco || ' ' || tabGroupesOut(i).Refimplan || ' ' || tabGroupesOut(i).Refformdet);
		END LOOP;
	END IF;
	
	IF(tabGroupesErreurs.COUNT > 0) THEN
		DBMS_OUTPUT.PUT_LINE('Liste des groupes ayant generes une erreur');
		FOR i IN tabGroupesErreurs.FIRST .. tabGroupesErreurs.LAST LOOP
			DBMS_OUTPUT.PUT_LINE('Le tuple : Groupe(' || tabGroupesErreurs(i).Groupe || '), Annee d''etude (' || tabGroupesErreurs(i).Annetud || '), Annee scolaire (' || tabGroupesErreurs(i).Ansco || '), Implantation (' || tabGroupesErreurs(i).Implantation || '), formation (' || tabGroupesErreurs(i).Formation || ') a genere le code d''erreur suivant: ' || tabGroupesErreurs(i).CodeErreur);
		END LOOP;
	END IF;
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

/*
Liste des groupes ajoutes
2106 1 2010 INPS ECO-INF0
Liste des groupes ayant generes une erreur
Le tuple : Groupe(2106), Annee d'etude (1), Annee scolaire (2010), Implantation (INPS), formation (ECO-INF0) a genere le code d'erreur suivant: 1
Le tuple : Groupe(2103), Annee d'etude (1), Annee scolaire (2011), Implantation (INPS), formation (ECO-INF0) a genere le code d'erreur suivant: 2291
Le tuple : Groupe(2104), Annee d'etude (1), Annee scolaire (2015), Implantation (INPS), formation (ECO-INF0) a genere le code d'erreur suivant: 2291
*/

-----------------------------------------------------------------------------------------------------------------------

-- Test fonctionnel (tuples ajoutés)

DECLARE
	tabGroupesIn GestionParcoursHe.T_Groupes;
	tabGroupesOut GestionParcoursHe.T_Groupes;
	tabGroupesErreurs GestionParcoursHe.T_GroupesErreurs;
BEGIN
	tabGroupesIn(-1).Refgroupe := '2107';
	tabGroupesIn(-1).Refformdet := 'ECO-INF0';
	tabGroupesIn(-1).Annetud := 1;
	tabGroupesIn(-1).Ansco := '2010';
	tabGroupesIn(-1).Refimplan := 'INPS';
	tabGroupesIn(2).Refgroupe := '2108';
	tabGroupesIn(2).Refformdet := 'ECO-INF0';
	tabGroupesIn(2).Annetud := 1;
	tabGroupesIn(2).Ansco := '2010';
	tabGroupesIn(2).Refimplan := 'INPS';
	tabGroupesIn(4).Refgroupe := '2109';
	tabGroupesIn(4).Refformdet := 'ECO-INF0';
	tabGroupesIn(4).Annetud := 1;
	tabGroupesIn(4).Ansco := '2010';
	tabGroupesIn(4).Refimplan := 'INPS';
	
	GestionParcoursHe.Ajouter(tabGroupesIn, tabGroupesOut, tabGroupesErreurs);
	
	IF(tabGroupesOut.COUNT > 0) THEN
		DBMS_OUTPUT.PUT_LINE('Liste des groupes ajoutes');
		FOR i IN tabGroupesOut.FIRST .. tabGroupesOut.LAST LOOP
			DBMS_OUTPUT.PUT_LINE(tabGroupesOut(i).Refgroupe || ' ' || tabGroupesOut(i).Annetud || ' ' || tabGroupesOut(i).Ansco || ' ' || tabGroupesOut(i).Refimplan || ' ' || tabGroupesOut(i).Refformdet);
		END LOOP;
	END IF;
	
	IF(tabGroupesErreurs.COUNT > 0) THEN
		DBMS_OUTPUT.PUT_LINE('Liste des groupes ayant generes une erreur');
		FOR i IN tabGroupesErreurs.FIRST .. tabGroupesErreurs.LAST LOOP
			DBMS_OUTPUT.PUT_LINE('Le tuple : Groupe(' || tabGroupesErreurs(i).Groupe || '), Annee d''etude (' || tabGroupesErreurs(i).Annetud || '), Annee scolaire (' || tabGroupesErreurs(i).Ansco || '), Implantation (' || tabGroupesErreurs(i).Implantation || '), formation (' || tabGroupesErreurs(i).Formation || ') a genere le code d''erreur suivant: ' || tabGroupesErreurs(i).CodeErreur);
		END LOOP;
	END IF;
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

/*
	Liste des groupes ajoutes
	2107 1 2010 INPS ECO-INF0
	2108 1 2010 INPS ECO-INF0
	2109 1 2010 INPS ECO-INF0
*/

-----------------------------------------------------------------------------------------------------------------------

-- Test fonctionnel (tuples non-ajoutés)

DECLARE
	tabGroupesIn GestionParcoursHe.T_Groupes;
	tabGroupesOut GestionParcoursHe.T_Groupes;
	tabGroupesErreurs GestionParcoursHe.T_GroupesErreurs;
BEGIN
	tabGroupesIn(-1).Refgroupe := '2201';
	tabGroupesIn(-1).Refformdet := 'ECO-INF0';
	tabGroupesIn(-1).Annetud := 4;
	tabGroupesIn(-1).Ansco := '2010';
	tabGroupesIn(-1).Refimplan := 'INPS';
	tabGroupesIn(2).Refgroupe := '2202';
	tabGroupesIn(2).Refformdet := 'ECO-INF0';
	tabGroupesIn(2).Annetud := 2;
	tabGroupesIn(2).Ansco := '2009';
	tabGroupesIn(2).Refimplan := 'INPS';
	tabGroupesIn(4).Refgroupe := '2102';
	tabGroupesIn(4).Refformdet := 'ECO-INF0';
	tabGroupesIn(4).Annetud := 1;
	tabGroupesIn(4).Ansco := '2010';
	tabGroupesIn(4).Refimplan := 'INPS';
	
	GestionParcoursHe.Ajouter(tabGroupesIn, tabGroupesOut, tabGroupesErreurs);
	
	IF(tabGroupesOut.COUNT > 0) THEN
		DBMS_OUTPUT.PUT_LINE('Liste des groupes ajoutes');
		FOR i IN tabGroupesOut.FIRST .. tabGroupesOut.LAST LOOP
			DBMS_OUTPUT.PUT_LINE(tabGroupesOut(i).Refgroupe || ' ' || tabGroupesOut(i).Annetud || ' ' || tabGroupesOut(i).Ansco || ' ' || tabGroupesOut(i).Refimplan || ' ' || tabGroupesOut(i).Refformdet);
		END LOOP;
	END IF;
	
	IF(tabGroupesErreurs.COUNT > 0) THEN
		DBMS_OUTPUT.PUT_LINE('Liste des groupes ayant generes une erreur');
		FOR i IN tabGroupesErreurs.FIRST .. tabGroupesErreurs.LAST LOOP
			DBMS_OUTPUT.PUT_LINE('Le tuple : Groupe(' || tabGroupesErreurs(i).Groupe || '), Annee d''etude (' || tabGroupesErreurs(i).Annetud || '), Annee scolaire (' || tabGroupesErreurs(i).Ansco || '), Implantation (' || tabGroupesErreurs(i).Implantation || '), formation (' || tabGroupesErreurs(i).Formation || ') a genere le code d''erreur suivant: ' || tabGroupesErreurs(i).CodeErreur);
		END LOOP;
	END IF;
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

/*
Liste des groupes ayant generes une erreur
Le tuple : Groupe(2202), Annee d'etude (2), Annee scolaire (2009), Implantation (INPS), formation (ECO-INF0) a genere le code d'erreur suivant: 1
Le tuple : Groupe(2102), Annee d'etude (1), Annee scolaire (2010), Implantation (INPS), formation (ECO-INF0) a genere le code d'erreur suivant: 1
*/

/* *************************** TESTS PROCEDURE MODIFIER *************************** */

-- Test exception E_IdentifiantDifferent

DECLARE
	unParcours Parcours_he_sess%ROWTYPE;
	unNouveauParcours Parcours_he_sess%ROWTYPE;
BEGIN
	SELECT * INTO unParcours
	FROM Parcours_he_sess
	WHERE Matricule = '1920506GUIJUL'
	AND Ansco = '2009'
	AND Sess = 1;

	SELECT * INTO unNouveauParcours
	FROM Parcours_he_sess
	WHERE Matricule = '1920506GUIJUL'
	AND Ansco = '2008'
	AND Sess = 1;
	
	GestionParcoursHe.Modifier(unParcours, unNouveauParcours);
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

-- Résultat : ORA-20240: Il faut que les 2 parcours correspondent. Le matricule et/ou l'année scolaire et/ou la session ne sont pas les mêmes.

-----------------------------------------------------------------------------------------------------------------------

-- Test exception E_ResourceBusy

--------------------- Session 1 ---------------------

DECLARE
	v_ParcoursHeSess Parcours_he_sess%ROWTYPE;
BEGIN
	SELECT * INTO v_ParcoursHeSess
	FROM Parcours_he_sess
	WHERE Matricule = '1920506GUIJUL'
	AND Ansco = '2009'
	AND Sess = 1
	FOR UPDATE NOWAIT;
	DBMS_LOCK.SLEEP(20);
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

--------------------- Session 2 ---------------------

DECLARE
	unParcours Parcours_he_sess%ROWTYPE;
	unNouveauParcours Parcours_he_sess%ROWTYPE;
BEGIN
	SELECT * INTO unParcours
	FROM Parcours_he_sess
	WHERE Matricule = '1920506GUIJUL'
	AND Ansco = '2009'
	AND Sess = 1;

	SELECT * INTO unNouveauParcours
	FROM Parcours_he_sess
	WHERE Matricule = '1920506GUIJUL'
	AND Ansco = '2009'
	AND Sess = 1;

	GestionParcoursHe.Modifier(unParcours, unNouveauParcours);
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

-- Résultat : ORA-20241: Un autre utilisateur est entrain de modifier le total et/ou la mention de cet etudiant.

-----------------------------------------------------------------------------------------------------------------------

-- Test exception E_DejaModif

--------------------- Session 1 ---------------------

DECLARE
	unParcours Parcours_he_sess%ROWTYPE;
	unNouveauParcours Parcours_he_sess%ROWTYPE;
BEGIN
	SELECT * INTO unParcours
	FROM Parcours_he_sess
	WHERE Matricule = '1920506GUIJUL'
	AND Ansco = '2009'
	AND Sess = 1;

	SELECT * INTO unNouveauParcours
	FROM Parcours_he_sess
	WHERE Matricule = '1920506GUIJUL'
	AND Ansco = '2009'
	AND Sess = 1;
	
	DBMS_LOCK.SLEEP(10);
	
	GestionParcoursHe.Modifier(unParcours, unNouveauParcours);
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

--------------------- Session 2 ---------------------

DECLARE
	unParcours Parcours_he_sess%ROWTYPE;
	unNouveauParcours Parcours_he_sess%ROWTYPE;
BEGIN
	SELECT * INTO unParcours
	FROM Parcours_he_sess
	WHERE Matricule = '1920506GUIJUL'
	AND Ansco = '2009'
	AND Sess = 1;

	SELECT * INTO unNouveauParcours
	FROM Parcours_he_sess
	WHERE Matricule = '1920506GUIJUL'
	AND Ansco = '2009'
	AND Sess = 1;
	
	unNouveauParcours.Total := 450;
	GestionParcoursHe.Modifier(unParcours, unNouveauParcours);
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

-- Résultat : ORA-20242: Un autre utilisateur vient de modifier ce parcours.

-----------------------------------------------------------------------------------------------------------------------

-- Test exception NO_DATA_FOUND

--------------------- Session 1 ---------------------
DECLARE
	unParcours Parcours_he_sess%ROWTYPE;
	unNouveauParcours Parcours_he_sess%ROWTYPE;
BEGIN
	SELECT * INTO unParcours
	FROM Parcours_he_sess
	WHERE Matricule = '1920506GUIJUL'
	AND Ansco = '2009'
	AND Sess = 2;

	SELECT * INTO unNouveauParcours
	FROM Parcours_he_sess
	WHERE Matricule = '1920506GUIJUL'
	AND Ansco = '2009'
	AND Sess = 2;
	
	unNouveauParcours.Total := 450;
	DBMS_LOCK.SLEEP(15);
	GestionParcoursHe.Modifier(unParcours, unNouveauParcours);
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

--------------------- Session 2 ---------------------

DELETE FROM Parcours_he_sess
WHERE Matricule = '1920506GUIJUL'
AND Ansco = '2009'
AND Sess = 2;
COMMIT;

-- Résultat : ORA-20244: Ce parcours vient d'etre supprime.

-----------------------------------------------------------------------------------------------------------------------

-- Test exception PARCOURS_HE_SESS_MENTIONS_FK

DECLARE
	unParcours Parcours_he_sess%ROWTYPE;
	unNouveauParcours Parcours_he_sess%ROWTYPE;
BEGIN
	SELECT * INTO unParcours
	FROM Parcours_he_sess
	WHERE Matricule = '1920506GUIJUL'
	AND Ansco = '2009'
	AND Sess = 1;

	SELECT * INTO unNouveauParcours
	FROM Parcours_he_sess
	WHERE Matricule = '1920506GUIJUL'
	AND Ansco = '2009'
	AND Sess = 1;
	
	unNouveauParcours.Mention := 'AAA';
	GestionParcoursHe.Modifier(unParcours, unNouveauParcours);
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

-- Résultat : ORA-20243: La mention AAA ou la session 1 n'existe pas.

-----------------------------------------------------------------------------------------------------------------------

-- Test E_TotalNull

DECLARE
	unParcours Parcours_he_sess%ROWTYPE;
	unNouveauParcours Parcours_he_sess%ROWTYPE;
BEGIN
	SELECT * INTO unParcours
	FROM Parcours_he_sess
	WHERE Matricule = '1920506GUIJUL'
	AND Ansco = '2009'
	AND Sess = 1;

	SELECT * INTO unNouveauParcours
	FROM Parcours_he_sess
	WHERE Matricule = '1920506GUIJUL'
	AND Ansco = '2009'
	AND Sess = 1;
	
	unNouveauParcours.Mention := 'AJO';
	unNouveauParcours.Total := NULL;
	GestionParcoursHe.Modifier(unParcours, unNouveauParcours);
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

-- Résultat : ORA-20245: Le total est obligatoire.

-----------------------------------------------------------------------------------------------------------------------

-- Test E_MentionNull

DECLARE
	unParcours Parcours_he_sess%ROWTYPE;
	unNouveauParcours Parcours_he_sess%ROWTYPE;
BEGIN
	SELECT * INTO unParcours
	FROM Parcours_he_sess
	WHERE Matricule = '1920506GUIJUL'
	AND Ansco = '2009'
	AND Sess = 1;

	SELECT * INTO unNouveauParcours
	FROM Parcours_he_sess
	WHERE Matricule = '1920506GUIJUL'
	AND Ansco = '2009'
	AND Sess = 1;
	
	unNouveauParcours.Mention := NULL;
	unNouveauParcours.Total := 680;
	GestionParcoursHe.Modifier(unParcours, unNouveauParcours);
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

-- Résultat : ORA-20246: La mention est obligatoire.

-----------------------------------------------------------------------------------------------------------------------

-- Test exception GUISSAJU_CK_TOTAL

DECLARE
	unParcours Parcours_he_sess%ROWTYPE;
	unNouveauParcours Parcours_he_sess%ROWTYPE;
BEGIN
	SELECT * INTO unParcours
	FROM Parcours_he_sess
	WHERE Matricule = '1920506GUIJUL'
	AND Ansco = '2009'
	AND Sess = 1;

	SELECT * INTO unNouveauParcours
	FROM Parcours_he_sess
	WHERE Matricule = '1920506GUIJUL'
	AND Ansco = '2009'
	AND Sess = 1;
	
	unNouveauParcours.Total := -25;
	GestionParcoursHe.Modifier(unParcours, unNouveauParcours);
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

-- Résultat : ORA-20247: Le total doit être supérieur ou égal à 0.

-----------------------------------------------------------------------------------------------------------------------

-- Test fonctionnel

SELECT *
FROM Parcours_he_sess
WHERE Matricule = '1920506GUIJUL';

/*
	MATRICULE     ANSCO SESS TOTAL MENTION
	------------- ----- ---- ----- -------
	1920506GUIJUL 2008     1   500 PGD     
	1920506GUIJUL 2008     2   850 PGD     
	1920506GUIJUL 2009     1   400 AJO 
*/

DECLARE
	unParcours Parcours_he_sess%ROWTYPE;
	unNouveauParcours Parcours_he_sess%ROWTYPE;
BEGIN
	SELECT * INTO unParcours
	FROM Parcours_he_sess
	WHERE Matricule = '1920506GUIJUL'
	AND Ansco = '2009'
	AND Sess = 1;

	SELECT * INTO unNouveauParcours
	FROM Parcours_he_sess
	WHERE Matricule = '1920506GUIJUL'
	AND Ansco = '2009'
	AND Sess = 1;
  
	unNouveauParcours.Mention := 'SAT';
	unNouveauParcours.Total := '675';
	PackageInterroModifier.Modifier(unParcours, unNouveauParcours);
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

SELECT *
FROM Parcours_he_sess
WHERE Matricule = '1920506GUIJUL';

/*
	MATRICULE     ANSCO SESS TOTAL MENTION
	------------- ----- ---- ----- -------
	1920506GUIJUL 2008     1   500 PGD     
	1920506GUIJUL 2008     2   850 PGD     
	1920506GUIJUL 2009     1   675 SAT  
*/
  
/* *************************** TESTS FONCTION LISTER ***************************** */

-- Test exception E_AnscoInvalid

DECLARE
	tab GestionParcoursHe.T_Etudiants;
BEGIN
	tab := GestionParcoursHe.Lister('2016', 2, 'ECO-INF0');
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

-- Résultat: ORA-20252: L'année scolaire passée en paramètre (2016) doit être inferieure à l'année actuelle (2015).

-----------------------------------------------------------------------------------------------------------------------

-- Test exception E_RefformdetInvalid

DECLARE
	tab GestionParcoursHe.T_Etudiants;
BEGIN
	tab := GestionParcoursHe.Lister('2008', 2, 'COUCOU');
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

-- Résultat: ORA-20253: La formation COUCOU n'est pas organisée en 2008. pour l'année d'étude 2.

-----------------------------------------------------------------------------------------------------------------------

-- Test fonctionnel (paramètres par défaut)

DECLARE
	tab GestionParcoursHe.T_Etudiants;
BEGIN
	tab := GestionParcoursHe.Lister();
	DBMS_OUTPUT.PUT_LINE('Nombre d''étudiants récupérés : ' || tab.COUNT);
  FOR i IN tab.FIRST .. tab.LAST LOOP
    DBMS_OUTPUT.PUT_LINE(tab(i).Matricule || ' ' || tab(i).Nom || ' ' || tab(i).Prenom || ' ' || tab(i).Groupe);
  END LOOP;
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

/*
	Nombre d'étudiants récupérés : 20
	1910510ANDHUM Andrew Humberto 2101
	1880320APPWIL Appiah Willi 2101
	1900702BOMRAM Bombardier Rambert 2101
	1890708BOUAIM Bourgoin Aimeric 2101
	1900127COLHAM Colombo Hamdi 2101
	2911119CONIMA Connors Imane 2101
	1891205DIFJAN Difiore Jantinus 2101
	1880906DIGJEN Digenova Jent 2101
	1910826DODROM Dodge Romee 2101
	1890503DONLAM Donovan Lambrecht 2101
	2820819FLYIMA Flynn Imane 2101
	1890316INKATM Inkel Atmane 2101
	1870418IP WIL Ip Willy 2101
	1880623LORHEL Lorrain Helory 2101
	1890228MONHEL Monchamp Heleazar 2101
	1910501PIEYAN Piette Yanni 2101
	1870713ROYSAL Royer Salman 2101
	1890220VIGBEN Vignola Benoist 2101
	1890511BOICAM Boiteau Camilien 2102
	1920408BORTIM Borsellino Timothee 2102

	Nombre d'étudiants récupérés : 20
	1900212BOUOSM Bouvier Osmane 2102
	1891117CLOMON Clouston Monty 2102
	1910523COOSAM Cooncome Samy 2102
	1911129DORYAM Dorval Yamine 2102
	1900923FOLROM Foley Romul 2102
	1891026FONRAM Fong Ramon 2102
	1910418GORKIL Gordon Killyan 2102
	1910925GOUJUL Gour Juliann 2102
	2910315LOMIMA Lombardi Imane 2102
	1900921OLEPON Oleary Pons 2102
	2910521OLIIMA Oliver Imane 2102
	1880904ROUTAL Rouleau Tale 2102
	1871120SILNIN Silver Nin 2102
	1900725SMAAYM Small Aymerik 2102
	1890420TRAGRI Tran Grigori 2102
	1890421WOOJOL Woodward Jolan 2102
	1900613ANGJAM Anglade Jamal 2103
	1911102ANTAIM Antonio Aimad 2103
	1920308CONTIM Connor Timotei 2103
	1910226CONSYM Constantin Symeon 2103

	Nombre d'étudiants récupérés : 20
	1901206FOICYL Foisy Cylian 2103
	1900527FOUDIL Foucreault Dilhan 2103
	1920502GONMAL Gonneville Malory 2103
	1910120GOUKYL Goudreau Kyle 2103
	1910809MONVAL Montmigny Valeric 2103
	1910921MORSIL Morris Silas 2103
	1871214NOVYUL Novak Yuli 2103
	1910331PINXAN Pinette Xantha 2103
	1901208ROBROL Roberge Rolando 2103
	1890802ROBPEL Robidoux Pelegrin 2103
	1861013SIDRAN Siddiqui Rankin 2103
	1900224ST-ELI St-Vincent Elijah 2103
	1900720ASHAKI Ashini Akiles 2104
	1891218BOIDOM Boisjoli Dominix 2104
	1900702BOIDAM Boissonneault Damien 2104
	1910226BOICAM Boisvenue Camel 2104
	1901017CLENAN Clerge Nani 2104
	1901219COLHOM Collin Homere 2104
	1901213COOSAM Coon Samson 2104
	1920304DOUTIM Doutre Timote 2104

	Nombre d'étudiants récupérés : 20
	1910323FLISAN Flibotte Sanso 2104
	1920318FOUDEL Foucault Delphin 2104
	1900327GLUREN Gluck Renaldo 2104
	1910224GOUKYL Gouge Kyliann 2104
	2890603HO IMA Ho Imane 2104
	1900604LONMAL Long Malo 2104
	1890907MONWAL Moniere Wali 2104
	1880303PRIGUI Primeau Guiseppe 2104
	1890727VIGBEN Vigneux Benji 2104
	1860801BOIDOM Boily Domien 2105
	1910514BOUSYM Boucher Symmaque 2105
	1890624CHALEO Chateauvert Leocadie 2105
	1911101COLHAM Colpron Hamid 2105
	1910406CONSIM Conway Simson 2105
	1890724COORUM Cook Rumwald 2105
	1900616DICANN Dicaire Annibal 2105
	1890911ELELAN elemond Lancelot 2105
	1910117ELMKON Elmaleh Konstantin 2105
	1900123ENGAYM Engel Ayman 2105
	1910623GOUJUL Goupil Jules 2105

	Nombre d'étudiants récupérés : 7
	1920918MONHIL Monarque Hilarion 2105
	1910928MORSIL Morse Silvestre 2105
	1901218OLMNIN Olmstead Nin 2105
	1891027PICMEN Piche Menahem 2105
	1891029PLECAM Pleau Camil 2105
	1891006PONNOL Pontbriand Nolan 2105
	1881210ROWSAL Rowley Salah-Eddine 2105

	ORA-20255: Il n'y a pas/plus de résultat pour l'année scolaire 2009, l'année d'étude 1 et la formation ECO-INF0.
*/

-----------------------------------------------------------------------------------------------------------------------

-- Test fonctionnel (ansco NULL)

DECLARE
	tab GestionParcoursHe.T_Etudiants;
BEGIN
	tab := GestionParcoursHe.Lister(NULL, 3, 'ECO-INF0');
	DBMS_OUTPUT.PUT_LINE('Nombre d''étudiants récupérés : ' || tab.COUNT);
  FOR i IN tab.FIRST .. tab.LAST LOOP
    DBMS_OUTPUT.PUT_LINE(tab(i).Matricule || ' ' || tab(i).Nom || ' ' || tab(i).Prenom || ' ' || tab(i).Groupe);
  END LOOP;
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

/*
	Nombre d'étudiants récupérés : 3
	1860527ADDHAR Addison Harold 2301
	1880310SHALEO Shattler Leonar 2301
	1840304PROABI Provencher Abiona 2302

	ORA-20255: Il n'y a pas/plus de résultat pour l'année scolaire , l'année d'étude 3 et la formation ECO-INF0.
*/

-----------------------------------------------------------------------------------------------------------------------

-- Test fonctionnel (annetud NULL)

DECLARE
	tab GestionParcoursHe.T_Etudiants;
BEGIN
	tab := GestionParcoursHe.Lister('2005', NULL, 'ECO-INF0');
	DBMS_OUTPUT.PUT_LINE('Nombre d''étudiants récupérés : ' || tab.COUNT);
  FOR i IN tab.FIRST .. tab.LAST LOOP
    DBMS_OUTPUT.PUT_LINE(tab(i).Matricule || ' ' || tab(i).Nom || ' ' || tab(i).Prenom || ' ' || tab(i).Groupe);
  END LOOP;
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

/*
	Nombre d'étudiants récupérés : 20
	1870707DESSAR Desputeau Sarouane 2101
	1871208GASLIV Gaston Livio 2101
	1840103HAMFOU Hammoud Fouhad 2101
	1870114LAGFET Lagace Fethi 2101
	1840219LEGDOR Legros Doran 2101
	1860212LEGDOR Leguerrier Doriand 2101
	1871228MAGOCT Magny Octave 2101
	1870625MARMAT Marra Matthew 2101
	1850328MATMAT Matheson Mattias 2101
	1850607MCDMAR McDonald Marc-Andre 2101
	1870310MCNKOR McNamara Korioun 2101
	1870110NADHAS Nadeau Hassan 2101
	1870727NAUBAS Nault Basileus 2101
	1880310SHALEO Shattler Leonar 2101
	1840926VADJOS Vadnais Josias 2101
	1860803BARDAY Barbin Daylan 2102
	1860829BARBAY Barclay Bay 2102
	1860924BLUZEN Blum Zenais 2102
	1840427DAOELW Daoust Elwin 2102
	1860209GALDAV Galbraith Davis 2102

	Nombre d'étudiants récupérés : 20
	1870306GARSAV Gariepy Savie 2102
	1860313MALMAT Malepart Matthias 2102
	1870630MAYANT Mayette Antonio 2102
	1870108MCLGER McLure Geraldy 2102
	1861126MILVIN Milord Vincente 2102
	1861220MIVSEN Miville Seny 2102
	1851017OFAAMO Ofarrell Amos 2102
	1850420PAIFOS Painchaud Foster 2102
	2850307PARIMA Paradis Imane 2102
	1861008SAGTYS Sagala Tyson 2102
	1800615TRAAKI Tranchemontagne Akilino 2102
	1860122VACJOS Vaccaro Joseph 2102
	1860201BARMAZ Barbeau Mazhe 2103
	1860128BARZIY Bariteau Ziyad 2103
	1850716BISDIN Bisson Dinh 2103
	1850221CARCLY Carvalho Clyde 2103
	1860213GASMAV Gaspard Mavrick 2103
	1861024HAZAQU Hazen Aquilles 2103
	1850826JOLJOL Jolette Jolan 2103
	1850218LAFGAT Lafricain Gatian 2103

	Nombre d'étudiants récupérés : 20
	1860309LALLAU Lalonge Laurentino 2103
	1850121MCAKAR McAulay Karim 2103
	1851121NADHAS Nader Hassen 2103
	2851127NATIMA Natachequan Imane 2103
	1840223ST-CRI St-Amour Cristiano 2103
	2870203VERIMA Versailles Imane 2103
	1850504WAPBAR Wapachee Baran 2103
	1850625ZAKCOR Zakaria Corantin 2103
	1861128BRUJEK Bruneau Jekel 2104
	1850815COFDOM Coffin Dom 2104
	1850205GATLAV Gatien Lavrendios 2104
	1860810GINLON Gince Long 2104
	1860121HACHOU Hackett Houcine 2104
	1850929JARNOU Jarry Noureddine 2104
	1851102LARMAU Larouche Maur 2104
	1850723MALMAT Malenfant Mattheus 2104
	1860804MARMAT Marcoux Mathys 2104
	1861114MINTAN Minier Tan 2104
	1861211NARCOS Narcisse Costa 2104
	1860628OCHFER Ochoa Fernand 2104

	Nombre d'étudiants récupérés : 18
	1840903SABOUS Sabra Ousama 2104
	1870621THEEDO Thellend edouard 2104
	1850810TRAALI Trapper Alistair 2104
	1860527ADDHAR Addison Harold 2105
	1870308BAYRAZ Bayard Razi 2105
	1851031CROMIK Croisetiere Mikelo 2105
	1871119GARPAV Garneau Pavel 2105
	1850806KANJAU Kanaan Jaufret 2105
	1870506LAMSOU Lampron Soufien 2105
	1830630LOILYL Loiseau Lylian 2105
	1860226MAGPAT Mageau Patryk 2105
	1831113MAINAT Mainguy Nathel 2105
	1861214MARMAT Marks Mathurin 2105
	1880203MARVIT Martial Vittorio 2105
	1830516MASOTT Masi Ottman 2105
	2810720SQUIMA Squires Imane 2105
	1860810VASMUS Vasquez Mustapha 2105
	1871127WAWDER Wawatie Derrick 2105

	ORA-20255: Il n'y a pas/plus de résultat pour l'année scolaire 2005, l'année d'étude  et la formation ECO-INF0.
*/

-----------------------------------------------------------------------------------------------------------------------

-- Test fonctionnel (Refformdet NULL)

DECLARE
	tab GestionParcoursHe.T_Etudiants;
BEGIN
	tab := GestionParcoursHe.Lister('2005', 2, NULL);
	DBMS_OUTPUT.PUT_LINE('Nombre d''étudiants récupérés : ' || tab.COUNT);
  FOR i IN tab.FIRST .. tab.LAST LOOP
    DBMS_OUTPUT.PUT_LINE(tab(i).Matricule || ' ' || tab(i).Nom || ' ' || tab(i).Prenom || ' ' || tab(i).Groupe);
  END LOOP;
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

/*
	Nombre d'étudiants récupérés : 20
	1830105ARIKIL Arial Kiliann 2201
	1850926BECAVR Beck Avraham 2201
	1870211BELJOR Bellefeuille Jory 2201
	1840925BLAJUN Blaney Junien 2201
	1851116BOURAM Bourdua Ramzy 2201
	1840927DENJER Denicourt Jerry 2201
	1841021LAUSOU Lauzier Soufian 2201
	1780118MAINAT Maiorano Naty 2201
	1850608MCDMAR McDuff Marcelin 2201
	1850702MCSKER McSween Kerop 2201
	1841122NESKAR Ness Karel 2201
	1860526PANJUS Pan Just 2201
	1850121VANOUS Vandette Ousman 2201
	1851101GAGLAU Gagliano Laurentin 2202
	1821217GENMAR Genesse Martik 2202
	1840125GRODRI Grondines Drice 2202
	1831128JONCOL Joncas Coleman 2202
	1850618KARYOU Kara Youenn 2202
	1840426LAUYOU Lauriault Younous 2202
	1850126LEBCYR Leboeuf Cyrus  2202

	Nombre d'étudiants récupérés : 19
	1840905PAMJOS Pampena Josuah 2202
	1840925PETMAR Petitpas Marien 2202
	1840510SHEFLO Sheehy Floris 2202
	1850307TALJES Taleb Jesse 2202
	1840430YANDAR Yang Darin 2202
	1851120YE EDO Ye Edouardo 2202
	2851225CHAIMA Chaloux Imane 2203
	1861226CROMIK Croft Mikel 2203
	1840715DEPIMR Depot Imran 2203
	1850119GEDHER Gedeon Herle 2203
	1840112HARLAU Harton Lauridas 2203
	1851108LATDOU Latourelle Doumenge 2203
	1860626LECBER Lecours Berty 2203
	1850709LECCAR Lecouteur Carim 2203
	1851031MANNAT Manseau Nathael 2203
	1841005ODOHER Odonnell Heribert 2203
	1841210PAPDUS Papadakis Dustin 2203
	1860522PAPJOS Papadopoulos Josserand 2203
	1840304PROABI Provencher Abiona 2203

	ORA-20255: Il n'y a pas/plus de résultat pour l'année scolaire 2005, l'année d'étude 2 et la formation.
*/

-----------------------------------------------------------------------------------------------------------------------

-- Test fonctionnel + exception E_TabOutVide

DECLARE
	tab GestionParcoursHe.T_Etudiants;
BEGIN
	tab := GestionParcoursHe.Lister('2009', 2, 'ECO-INF0');
	DBMS_OUTPUT.PUT_LINE('Nombre d''étudiants récupérés : ' || tab.COUNT);
  FOR i IN tab.FIRST .. tab.LAST LOOP
    DBMS_OUTPUT.PUT_LINE(tab(i).Matricule || ' ' || tab(i).Nom || ' ' || tab(i).Prenom || ' ' || tab(i).Groupe);
  END LOOP;
EXCEPTION
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

/*
	1880629BRONOL Brochu Nolwenn 2201
	1900612CADELY Cadrin Elyes 2201
	1891226CAOTAY Caouette Taylor 2201
	1880320COXEMM Cox Emmanuel 2201
	1891011FAFKEV Fafard Kevan 2201
	1900122FILAVN Filsaime Avner 2201
	1880104FINARN Finkelstein Arnaut 2201
	1920506GUIJUL Guissart Julien 2201
	1881018HINCON Hinton Conan 2201
	1870429LARPAU Larche Paulus 2201
	1880406LARMAU Larose Maudez 2201
	1900816LIAGON Liard Gonzalo 2201
	1840622ROCWAL Rochefort Walfroy 2201
	1890316ROSBEL Rosati Beltz 2201
	1890228SCHFER Schiavone Ferrando 2201
	1900609SENBAP Senez Baptiste 2201
	1880709WEEFLO Weekes Florestan 2201
	1860815BARILY Barnes Ilyass 2202
	1850619BRAVIK Brasseur Viktor 2202
	1880611CASJAY Castilloux Jay 2202

	1881114COYEMM Coyle Emmery 2202
	1891030DESNOR Desforges Norredine 2202
	1900512DIGJAN Digiacomo Jan 2202
	1891221DIOKEN Diodati Kentigern 2202
	1900105DISARN Distefano Arnaut 2202
	1900124FILADN Fillion Adnan 2202
	2880622HOUIMA House Imane 2202
	1880727LAVSOU Lavergne Soufian 2202
	1870629LO CEL Lo Celin 2202
	1860408MAINAT Mailhot Nathalien 2202
	1880423MATMAT Mathis Matvey 2202
	1870325PREGUI Presse Guilen 2202
	1880929PRIMAI Primard Maius 2202
	1880819TRAARI Trachy Ariston 2202

	ORA-20255: Il n'y a pas/plus de résultat pour l'année scolaire 2009, l'année d'étude 2 et la formation ECO-INF0.
*/
