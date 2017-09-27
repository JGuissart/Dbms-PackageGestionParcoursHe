/* ********************************* PACKAGE SPECIFICATION ********************************* */

CREATE OR REPLACE PACKAGE GestionParcoursHe AS  
	TYPE R_MeilleursResultats IS RECORD
	(
		Matricule Etudiants.Matricule%TYPE,
		Nom Etudiants.Nom%TYPE,
		Prenom Etudiants.Prenom%TYPE,
		Annetud Parcours_he.Annetud%TYPE,
		Formation Parcours_he.Refformdet%TYPE,
		Total Parcours_he_sess.Total%TYPE
	);
	
	TYPE R_EtudiantsSupprimes IS RECORD
	(
		Matricule Etudiants.Matricule%TYPE,
		Nom Etudiants.Nom%TYPE,
		Prenom Etudiants.Nom%TYPE
	);
	
	TYPE R_Etudiants IS RECORD
	(
		Matricule Etudiants.Matricule%TYPE,
		Nom Etudiants.Nom%TYPE,
		Prenom Etudiants.Nom%TYPE,
		Groupe Parcours_he.Refgroupe%TYPE
	);
	
	TYPE R_GroupesErreurs IS RECORD
	(
		Groupe Groupes.Refgroupe%TYPE,
		Formation Groupes.Refformdet%TYPE,
		Annetud Groupes.Annetud%TYPE,
		Ansco Groupes.Ansco%TYPE,
		Implantation Groupes.Refimplan%TYPE,
		CodeErreur NUMBER
	);
  
	TYPE T_MeilleursResultats IS TABLE OF R_MeilleursResultats INDEX BY PLS_INTEGER;
	TYPE T_EtudiantsSupprimes IS TABLE OF R_EtudiantsSupprimes INDEX BY PLS_INTEGER;
	TYPE T_Matricules IS TABLE OF Etudiants.Matricule%TYPE INDEX BY PLS_INTEGER;
	TYPE T_Etudiants IS TABLE OF R_Etudiants INDEX BY PLS_INTEGER;
	TYPE T_Groupes IS TABLE OF Groupes%ROWTYPE INDEX BY PLS_INTEGER;
	TYPE T_GroupesErreurs IS TABLE OF R_GroupesErreurs INDEX BY PLS_INTEGER;
	
	FUNCTION Rechercher(P_ANSCO IN Parcours_he.Ansco%TYPE DEFAULT '2009') RETURN T_MeilleursResultats;
	PROCEDURE Supprimer(P_TABETUDIANTSSUPPRIMES OUT T_EtudiantsSupprimes);
	PROCEDURE Supprimer(P_TABMATRICULE IN T_Matricules, P_TABETUDIANTSUPPRIMES OUT T_EtudiantsSupprimes, P_TABETUDIANTSNONSUPPRIMES OUT T_Matricules);
	PROCEDURE Ajouter(P_REFFORMDET IN Groupes.Refformdet%TYPE, P_ANNETUD IN Groupes.Annetud%TYPE, P_ANSCO IN Groupes.Ansco%TYPE, P_NBREGROUPE IN NUMBER, P_PREMIERGROUPE IN NUMBER, P_TABGROUPESINSERES OUT T_Groupes);
	PROCEDURE Ajouter(P_TABGROUPES IN T_Groupes, P_TABGROUPESINSERERS OUT T_Groupes, P_TABGROUPESERREURS OUT T_GroupesErreurs);
	PROCEDURE Modifier(P_OLD IN Parcours_he_sess%ROWTYPE, P_NEW IN Parcours_he_sess%ROWTYPE);
	FUNCTION Lister(P_ANSCO IN Parcours_he.Ansco%TYPE DEFAULT '2009', P_ANNETUD IN Parcours_he.Annetud%TYPE DEFAULT 1, P_REFFORMDET IN Parcours_he.Refformdet%TYPE DEFAULT 'ECO-INF0') RETURN T_Etudiants;
END GestionParcoursHe;

/* ********************************* PACKAGE BODY ********************************* */

CREATE OR REPLACE PACKAGE BODY GestionParcoursHE AS
	E_AnscoNull EXCEPTION;
	E_AnscoInvalid EXCEPTION;
	E_RefformdetNull EXCEPTION;
	E_AnnetudNull EXCEPTION;
	E_RefformdetInvalid EXCEPTION;
	E_AnnetudInvalid EXCEPTION;
	E_TabInVide EXCEPTION;
	E_TabOutVide EXCEPTION;
	E_ContrainteApp EXCEPTION;
	E_ContrainteRef EXCEPTION;
	E_ResourceBusy EXCEPTION;
	PRAGMA EXCEPTION_INIT(E_ContrainteApp, -2290);
	PRAGMA EXCEPTION_INIT(E_ContrainteRef, -2291);
	PRAGMA EXCEPTION_INIT(E_ResourceBusy, -54);
	
	V_CurrentAnsco Parcours_he.Ansco%TYPE;
	V_CurrentAnnetud Parcours_he.Annetud%TYPE;
	V_CurrentRefformdet Parcours_he.Refformdet%TYPE;
	
	CURSOR C_Etudiants(P_ANSCO IN Parcours_he.Ansco%TYPE, P_ANNETUD IN Parcours_he.Annetud%TYPE, P_REFFORMDET IN Parcours_he.Refformdet%TYPE) IS
		SELECT Matricule, Nom, Prenom, Refgroupe
		FROM Etudiants NATURAL JOIN Parcours_he
		WHERE Ansco = P_ANSCO
		AND Annetud = P_ANNETUD
		AND Refformdet = P_REFFORMDET
		ORDER BY Refgroupe, Nom, Prenom;
	
	FUNCTION Rechercher(P_ANSCO IN Parcours_he.Ansco%TYPE DEFAULT '2009') RETURN T_MeilleursResultats AS
		CURSOR C_MeilleursResultats(P_ANSCO IN Parcours_he.Ansco%TYPE) IS
			SELECT t1.Matricule, Nom, Prenom, Annetud, Refformdet, Total
			FROM Etudiants t1 INNER JOIN Parcours_he t2 ON (t1.Matricule = t2.Matricule)
			INNER JOIN Parcours_he_sess t3 ON (t2.Matricule = t3.Matricule AND t2.Ansco = Rechercher.P_ANSCO AND t2.Ansco = t3.Ansco)
			WHERE Total =
			(
				SELECT MAX(Total)
				FROM Parcours_he t4 INNER JOIN Parcours_he_sess t5 ON (t4.Matricule = t5.Matricule AND t4.Ansco = t5.Ansco)
				WHERE Refformdet = t2.Refformdet
				AND t4.Ansco = t2.Ansco
				AND Annetud = t2.Annetud
				GROUP BY Refformdet, Annetud
			)
			ORDER BY Refformdet, Annetud;
		v_TabMeilleursResultats T_MeilleursResultats;
		BEGIN
			IF(P_ANSCO IS NULL) THEN
				RAISE E_AnscoNull;
			END IF;
			
			IF(P_ANSCO > EXTRACT(YEAR FROM CURRENT_DATE)) THEN
				RAISE E_AnscoInvalid;
			END IF;
			
			OPEN C_MeilleursResultats(P_ANSCO);
			FETCH C_MeilleursResultats BULK COLLECT INTO v_TabMeilleursResultats;
			CLOSE C_MeilleursResultats;
			
			IF(v_TabMeilleursResultats.COUNT = 0) THEN
				RAISE E_TabOutVide;
			END IF;
			
			RETURN v_TabMeilleursResultats;
		EXCEPTION
			WHEN INVALID_CURSOR THEN
				RAISE_APPLICATION_ERROR(-20200, 'Erreur lors de la manipulation du curseur. (Fermeture ou FETCH d''un curseur fermé ?)');
			WHEN CURSOR_ALREADY_OPEN THEN
				RAISE_APPLICATION_ERROR(-20201, 'Le curseur est déjà ouvert.');
			WHEN E_AnscoNull THEN
				RAISE_APPLICATION_ERROR(-20202, 'L''année scolaire passée en paramètre est obligatoire.');
			WHEN E_AnscoInvalid THEN
				RAISE_APPLICATION_ERROR(-20203, 'L''année scolaire passée en paramètre (' || P_ANSCO || ') doit etre inferieure a l''année actuelle (' || EXTRACT(YEAR FROM CURRENT_DATE) || ').');
			WHEN E_TabOutVide THEN
				RAISE_APPLICATION_ERROR(-20204, 'Il n''y a pas de résultat pour l''année scolaire ' || P_ANSCO || '.');
			WHEN OTHERS THEN
				IF(C_MeilleursResultats%ISOPEN) THEN
					CLOSE C_MeilleursResultats;
				END IF;
	END Rechercher;
	
	PROCEDURE Supprimer(P_TABETUDIANTSSUPPRIMES OUT T_EtudiantsSupprimes) AS
		BEGIN
			DELETE FROM Etudiants
			WHERE Matricule IN
			(
				SELECT Matricule
				FROM Parcours_he t1
				WHERE datesortie IS NOT NULL
				AND Ansco =
				(
					SELECT MAX(Ansco)
					FROM Parcours_he t2
					WHERE t1.Matricule = t2.Matricule
				)
			)
			RETURNING Matricule, Nom, Prenom BULK COLLECT INTO P_TABETUDIANTSSUPPRIMES;
			
			IF(P_TABETUDIANTSSUPPRIMES.COUNT = 0) THEN
				RAISE E_TabOutVide;
			END IF;
			
			COMMIT;
		EXCEPTION
			WHEN E_TabOutVide THEN
				RAISE_APPLICATION_ERROR(-20210, 'Il n''y a aucun étudiant qui a fini son parcours scolaire.');
			WHEN OTHERS THEN RAISE;
	END Supprimer;
	
	PROCEDURE Supprimer(P_TABMATRICULE IN T_Matricules, P_TABETUDIANTSUPPRIMES OUT T_EtudiantsSupprimes, P_TABETUDIANTSNONSUPPRIMES OUT T_Matricules) AS
		V_Indice NUMBER := 1;
		i NUMBER;
		BEGIN
			IF(P_TABMATRICULE.COUNT = 0) THEN
				RAISE E_TabInVide;
			END IF;
			FORALL i IN INDICES OF P_TABMATRICULE
				DELETE FROM Etudiants WHERE Matricule = P_TABMATRICULE(i)
				RETURNING Matricule, Nom, Prenom BULK COLLECT INTO P_TABETUDIANTSUPPRIMES;
			
			i := P_TABMATRICULE.FIRST;
			WHILE i IS NOT NULL LOOP
				IF(SQL%BULK_ROWCOUNT(i) = 0) THEN
					P_TABETUDIANTSNONSUPPRIMES(V_Indice) := P_TABMATRICULE(i);
					V_Indice := V_Indice + 1;
				END IF;
				i := P_TABMATRICULE.NEXT(i);
			END LOOP;
			COMMIT;
		EXCEPTION
			WHEN E_TabInVide THEN
				RAISE_APPLICATION_ERROR(-20211, 'La collection de matricules passée en paramètre doit comporter des matricules.');
			WHEN OTHERS THEN RAISE;
	END Supprimer;
	
	PROCEDURE Ajouter(P_REFFORMDET IN Groupes.Refformdet%TYPE, P_ANNETUD IN Groupes.Annetud%TYPE, P_ANSCO IN Groupes.Ansco%TYPE, P_NBREGROUPE IN NUMBER, P_PREMIERGROUPE IN NUMBER, P_TABGROUPESINSERES OUT T_Groupes) AS
		E_NbreGroupeNull EXCEPTION;
		E_PremierGroupeNull EXCEPTION;
		TYPE T_Refformdet IS TABLE OF Organise.Refformdet%TYPE;
		v_tabRefformdet T_Refformdet;
		v_MaxAnnetud NUMBER;
		v_tabGroupes T_Groupes;
		i NUMBER := 0;
		BEGIN
			IF(Ajouter.P_REFFORMDET IS NULL) THEN
				RAISE E_RefformdetNull;
			END IF;
			IF(Ajouter.P_ANNETUD IS NULL OR Ajouter.P_ANNETUD <= 0) THEN
				RAISE E_AnnetudNull;
			END IF;
			IF(Ajouter.P_ANSCO IS NULL) THEN
				RAISE E_AnscoNull;
			END IF;
			IF(Ajouter.P_NBREGROUPE IS NULL OR Ajouter.P_NBREGROUPE = 0) THEN
				RAISE E_NbreGroupeNull;
			END IF;
			IF(Ajouter.P_PREMIERGROUPE IS NULL OR Ajouter.P_PREMIERGROUPE = 0) THEN
				RAISE E_PremierGroupeNull;
			END IF;
			SELECT DISTINCT Refformdet BULK COLLECT INTO v_tabRefformdet
			FROM Organise
			WHERE Refimplan = 'INPS';
			IF(Ajouter.P_REFFORMDET NOT MEMBER OF v_tabRefformdet) THEN
				RAISE E_RefformdetInvalid;
			END IF;
			SELECT MaxAnnetud INTO v_MaxAnnetud
			FROM Formations NATURAL JOIN Formations_Det
			WHERE Refformdet = P_REFFORMDET;
			IF(Ajouter.P_ANNETUD > v_MaxAnnetud OR Ajouter.P_ANNETUD = 0) THEN
				RAISE E_AnnetudInvalid;
			END IF;
			IF(Ajouter.P_ANSCO > EXTRACT(YEAR FROM CURRENT_DATE)) THEN
				RAISE E_AnscoInvalid;
			END IF;
			WHILE(i < P_NBREGROUPE) LOOP
				v_tabGroupes(i + 1).Refformdet := P_REFFORMDET;
				v_tabGroupes(i + 1).Annetud := P_ANNETUD;
				v_tabGroupes(i + 1).Ansco := P_ANSCO;
				v_tabGroupes(i + 1).Refimplan := 'INPS';
				IF((P_PREMIERGROUPE + i) < 10) THEN
					v_tabGroupes(i + 1).Refgroupe := '2' || P_ANNETUD || '0' || (P_PREMIERGROUPE + i);
				ELSE
					v_tabGroupes(i + 1).Refgroupe := '2' || P_ANNETUD || (P_PREMIERGROUPE + i);
				END IF;
				i := i + 1;
			END LOOP;
			FORALL i IN INDICES OF v_tabGroupes
				INSERT INTO Groupes VALUES v_tabGroupes(i)
				RETURNING Refgroupe, Refformdet, Annetud, Ansco, Refimplan BULK COLLECT INTO P_TABGROUPESINSERES;

			COMMIT;
		EXCEPTION
			WHEN E_RefformdetNull THEN
				RAISE_APPLICATION_ERROR(-20220, 'La formation passée en paramètre est obligatoire.');
			WHEN E_AnnetudNull THEN
				RAISE_APPLICATION_ERROR(-20221, 'L''année d''étude passée en paramètre est obligatoire.');
			WHEN E_AnscoNull THEN
				RAISE_APPLICATION_ERROR(-20222, 'L''année scolaire passée en paramètre est obligatoire.');
			WHEN E_NbreGroupeNull THEN
				RAISE_APPLICATION_ERROR(-20223, 'Le nombre de groupe passé en paramètre est obligatoire.');
			WHEN E_PremierGroupeNull THEN
				RAISE_APPLICATION_ERROR(-20224, 'Le numéro du 1er groupe passé en paramètre est obligatoire.');
			WHEN E_RefformdetInvalid THEN
				RAISE_APPLICATION_ERROR(-20225, 'La formation ' || P_REFFORMDET || ' n''est pas organisée a l''INPRES.');
			WHEN E_AnnetudInvalid THEN
				RAISE_APPLICATION_ERROR(-20226, 'L''année d''étude passée en paramètre (' || P_ANNETUD || ') doit être plus petite ou égale au maximum d''années d''étude de la formation ' || P_REFFORMDET || ' (' || v_MaxAnnetud || ').');
			WHEN E_AnscoInvalid THEN
				RAISE_APPLICATION_ERROR(-20227, 'L''année scolaire passée en paramètre (' || P_ANSCO || ') doit être inferieure a l''année actuelle (' || EXTRACT(YEAR FROM CURRENT_DATE) || ').');
			WHEN E_ContrainteRef THEN
			CASE
				WHEN INSTR(SQLERRM, 'GROUPES_ORGANISE_FK') > 0 THEN
					ROLLBACK;
					RAISE_APPLICATION_ERROR(-20228, 'L''année d''étude ' || P_ANNETUD || ' pour la formation ' || P_REFFORMDET || ' de l''année scolaire ' || P_ANSCO || ' n''existe pas.');
			END CASE;
			WHEN DUP_VAL_ON_INDEX THEN
				ROLLBACK;
				RAISE_APPLICATION_ERROR(-20229, 'Le groupe que vous tentez d''inserer existe déjà pour l''année d''étude ' || P_ANNETUD || ', de la formation ' || P_REFFORMDET || ' de l''année scolaire ' || P_ANSCO || '.');
			WHEN OTHERS THEN
				ROLLBACK;
				RAISE;
	END Ajouter;
	
	PROCEDURE Ajouter(P_TABGROUPES IN T_Groupes, P_TABGROUPESINSERERS OUT T_Groupes, P_TABGROUPESERREURS OUT T_GroupesErreurs) AS
		j NUMBER := 0;
		BEGIN
			IF(P_TABGROUPES.COUNT = 0) THEN
				RAISE E_TabInVide;
			END IF;
			FORALL i IN INDICES OF P_TABGROUPES SAVE EXCEPTIONS
				INSERT INTO Groupes VALUES P_TABGROUPES(i)
				RETURNING Refgroupe, Refformdet, Annetud, Ansco, Refimplan BULK COLLECT INTO P_TABGROUPESINSERERS;
			COMMIT;
		EXCEPTION
			WHEN E_TabInVide THEN
				RAISE_APPLICATION_ERROR(-20230, 'La collection de groupes passée en paramètre ne doit pas être vide.');
			WHEN OTHERS THEN
				ROLLBACK;
				FOR i IN 1 .. SQL%BULK_EXCEPTIONS.COUNT LOOP
					j := P_TABGROUPES.NEXT(SQL%BULK_EXCEPTIONS(i).ERROR_INDEX);
					P_TABGROUPESERREURS(i).Groupe := P_TABGROUPES(j).Refgroupe;
					P_TABGROUPESERREURS(i).Formation := P_TABGROUPES(j).Refformdet;
					P_TABGROUPESERREURS(i).Annetud := P_TABGROUPES(j).Annetud;
					P_TABGROUPESERREURS(i).Ansco := P_TABGROUPES(j).Ansco;
					P_TABGROUPESERREURS(i).Implantation := P_TABGROUPES(j).Refimplan;
					P_TABGROUPESERREURS(i).CodeErreur := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
				END LOOP;
	END Ajouter;
	
	PROCEDURE Modifier(P_OLD IN Parcours_he_sess%ROWTYPE, P_NEW IN Parcours_he_sess%ROWTYPE) AS
		E_IdentifiantDifferent EXCEPTION;
		E_DejaModif EXCEPTION;
		E_TotalNull EXCEPTION;
		E_MentionNull EXCEPTION;
		V_Verif Parcours_he_sess%ROWTYPE;
		V_OldTuple VARCHAR2(256);
		V_VerifTuple VARCHAR2(256);
		V_Boucle INTEGER := 0;
		V_Rowid ROWID;
	BEGIN
		IF(P_OLD.Matricule <> P_NEW.Matricule OR P_OLD.Ansco <> P_NEW.Ansco OR P_OLD.Sess <> P_NEW.Sess) THEN
			RAISE E_IdentifiantDifferent;
		END IF;
		IF(P_NEW.Total IS NULL) THEN
			RAISE E_TotalNull;
		END IF;
		IF(P_NEW.Mention IS NULL) THEN
			RAISE E_MentionNull;
		END IF;
		
		SELECT ROWID INTO v_Rowid
		FROM Parcours_he_sess
		WHERE Matricule = P_OLD.Matricule
		AND Ansco = P_OLD.Ansco
		AND Sess = P_OLD.Sess;
		
		WHILE V_Boucle < 3 LOOP	
			BEGIN
				V_Boucle := (V_Boucle + 1);
				SELECT * INTO V_Verif
				FROM Parcours_he_sess
				WHERE Matricule = P_OLD.Matricule
				AND Ansco = P_OLD.Ansco
				AND Sess = P_OLD.Sess
				FOR UPDATE NOWAIT;
				V_Boucle := 3;
			EXCEPTION
				WHEN E_ResourceBusy THEN 
					IF(V_Boucle = 3) THEN
						RAISE;
					END IF;
					DBMS_LOCK.SLEEP(5);
				WHEN OTHERS THEN RAISE;
			END;
		END LOOP;
		
		V_OldTuple := P_OLD.Matricule || P_OLD.Ansco || P_OLD.Sess || P_OLD.Total || P_OLD.Mention;
		V_VerifTuple := V_Verif.Matricule || V_Verif.Ansco || V_Verif.Sess || V_Verif.Total || V_Verif.Mention;
		
		IF(OWA_OPT_LOCK.CHECKSUM(V_OldTuple) <> OWA_OPT_LOCK.CHECKSUM(V_VerifTuple)) THEN
			RAISE E_DejaModif;
		END IF;
		
		UPDATE Parcours_he_sess
		SET ROW = P_NEW
		WHERE ROWID = v_Rowid;
		COMMIT;
	EXCEPTION
		WHEN E_IdentifiantDifferent THEN
			RAISE_APPLICATION_ERROR(-20240, 'Il faut que les 2 parcours correspondent. Le matricule et/ou l''année scolaire et/ou la session ne sont pas les mêmes.');
		WHEN E_ResourceBusy THEN
			RAISE_APPLICATION_ERROR(-20241, 'Un autre utilisateur est entrain de modifier le total et/ou la mention de cet étudiant.');
		WHEN E_DejaModif THEN
			RAISE_APPLICATION_ERROR(-20242, 'Un autre utilisateur vient de modifier ce parcours.');
		WHEN E_ContrainteRef THEN
		CASE
			WHEN INSTR(SQLERRM, 'PARCOURS_HE_SESS_MENTIONS_FK') > 0 THEN
				RAISE_APPLICATION_ERROR(-20243, 'La mention ' || P_NEW.Mention || ' ou la session ' || P_NEW.Sess || ' n''existe pas.');
		END CASE;
		WHEN NO_DATA_FOUND THEN
			RAISE_APPLICATION_ERROR(-20244, 'Ce parcours vient d''être supprimé.');
		WHEN E_TotalNull THEN
			RAISE_APPLICATION_ERROR(-20245, 'Le total est obligatoire.');
		WHEN E_MentionNull THEN
			RAISE_APPLICATION_ERROR(-20246, 'La mention est obligatoire.');
		WHEN E_ContrainteApp THEN
			CASE
				WHEN INSTR(SQLERRM, 'GUISSAJU_CK_TOTAL') > 0 THEN RAISE_APPLICATION_ERROR(-20247, 'Le total doit être supérieur ou égal à 0.');
				WHEN INSTR(SQLERRM, 'PARCOURS_HE_SESS_SESS_CK') > 0 THEN RAISE_APPLICATION_ERROR(-20247, 'La session doit être égale à 1, 2 ou 3.'); -- Cette contrainte applicative est "englobée" dans la contrainte référentielle "PARCOURS_HE_SESS_MENTIONS_FK".
			END CASE;
		WHEN OTHERS THEN RAISE;
	END Modifier;
	
	FUNCTION Lister(P_ANSCO IN Parcours_he.Ansco%TYPE DEFAULT '2009', P_ANNETUD IN Parcours_he.Annetud%TYPE DEFAULT 1, P_REFFORMDET IN Parcours_he.Refformdet%TYPE DEFAULT 'ECO-INF0') RETURN T_Etudiants AS
		TYPE T_Refformdet IS TABLE OF Parcours_he.Refformdet%TYPE;
		v_tabRefformdet T_Refformdet;
		v_MaxAnnetud Formations.MaxAnnetud%TYPE;
		v_tabEtudiants T_Etudiants;
		BEGIN
			IF(COALESCE(P_ANSCO, '2009') > EXTRACT(YEAR FROM CURRENT_DATE)) THEN
				RAISE E_AnscoInvalid;
			END IF;
			
			SELECT DISTINCT Refformdet BULK COLLECT INTO v_tabRefformdet
			FROM Parcours_he
			WHERE Ansco = COALESCE(P_ANSCO, '2009')
			AND Annetud = COALESCE(P_ANNETUD, 1);
			IF(COALESCE(P_REFFORMDET, 'ECO-INF0') NOT MEMBER OF v_tabRefformdet) THEN
				RAISE E_RefformdetInvalid;
			END IF;
			
			SELECT MaxAnnEtud INTO v_MaxAnnetud
			FROM Formations NATURAL JOIN Formations_Det
			WHERE Refformdet = COALESCE(P_REFFORMDET, 'ECO-INF0');
			IF(COALESCE(P_ANNETUD, 1) > v_MaxAnnetud)
				THEN RAISE E_AnnetudInvalid;
			END IF;
			
			IF(V_CurrentAnsco <> COALESCE(P_ANSCO, '2009') OR V_CurrentAnnetud <> COALESCE(P_ANNETUD, 1) OR V_CurrentRefformdet <> COALESCE(P_REFFORMDET, 'ECO-INF0')) THEN
				IF(C_Etudiants%ISOPEN = TRUE) THEN
					CLOSE C_Etudiants;
				END IF;
			END IF;
			
			IF(C_Etudiants%ISOPEN = FALSE) THEN
				OPEN C_Etudiants(COALESCE(P_ANSCO, '2009'), COALESCE(P_ANNETUD, 1), COALESCE(P_REFFORMDET, 'ECO-INF0'));
				V_CurrentAnsco := COALESCE(P_ANSCO, '2009');
				V_CurrentAnnetud := COALESCE(P_ANNETUD, 1);
				V_CurrentRefformdet := COALESCE(P_REFFORMDET, 'ECO-INF0');
			END IF;
			
			FETCH C_Etudiants BULK COLLECT INTO v_tabEtudiants LIMIT 20;
			
			IF(v_tabEtudiants.COUNT = 0) THEN
				CLOSE C_Etudiants;
				RAISE E_TabOutVide;
			END IF;
			
			RETURN v_tabEtudiants;
		EXCEPTION
			WHEN INVALID_CURSOR THEN
				RAISE_APPLICATION_ERROR(-20250, 'Erreur lors de la manipulation du curseur. (Fermeture ou FETCH d''un curseur fermé ?)');
			WHEN CURSOR_ALREADY_OPEN THEN
				RAISE_APPLICATION_ERROR(-20251, 'Le curseur est déjà ouvert.');
			WHEN E_AnscoInvalid THEN
				RAISE_APPLICATION_ERROR(-20252, 'L''année scolaire passée en paramètre (' || P_ANSCO || ') doit être inferieure à l''année actuelle (' || EXTRACT(YEAR FROM CURRENT_DATE) || ').');
			WHEN E_RefformdetInvalid THEN
				RAISE_APPLICATION_ERROR(-20253, 'La formation ' || P_REFFORMDET || ' n''est pas organisée en ' || P_ANSCO || '. pour l''année d''étude ' || P_ANNETUD || '.');
			WHEN E_AnnetudInvalid THEN
				RAISE_APPLICATION_ERROR(-20254, 'L''année d''étude passée en paramètre (' || P_ANNETUD || ') doit être plus petite ou égale au maximum d''années d''étude de la formation ' || P_REFFORMDET || ' (' || v_MaxAnnetud || ').');
			WHEN E_TabOutVide THEN
				RAISE_APPLICATION_ERROR(-20255, 'Il n''y a pas/plus de résultat pour l''année scolaire ' || P_ANSCO || ', l''année d''étude ' || P_ANNETUD || ' et la formation ' || P_REFFORMDET || '.');
			WHEN OTHERS THEN RAISE;
	END Lister;
END GESTIONPARCOURSHE;