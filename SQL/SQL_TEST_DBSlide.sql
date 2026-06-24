--Exercice 1 — JOIN multi-tables
--Affiche le nom complet de chaque étudiant, le nom de sa section, et le nom du cours auquel il est inscrit.
SELECT CONCAT(first_name,' ',last_name) AS 'Nom',sn.section_name,c.course_name
FROM student s
LEFT JOIN section sn ON s.section_id=sn.section_id
LEFT JOIN course c ON s.course_id=c.course_id

--Exercice 2 — Agrégation + HAVING
--Liste les professeurs qui donnent plus d'un cours, avec le nombre total d'ECTS qu'ils dispensent. Trie par ECTS décroissant.
SELECT CONCAT(professor_surname,' ',professor_name) AS 'Nom',SUM(c.course_ects) AS 'Total ECTS'
FROM professor p
LEFT JOIN course c ON p.professor_id=c.professor_id
GROUP BY p.professor_id,professor_surname,professor_name
HAVING COUNT(c.course_id)>1
ORDER BY SUM(c.course_ects) DESC

--Exercice 3 — Subquery / EXISTS
--Trouve les sections qui n'ont pas de délégué assigné 
--(delegate_id est NULL ou ne correspond à aucun étudiant existant).
SELECT section_id
FROM section
WHERE delegate_id IS NULL
   OR NOT EXISTS (
       SELECT 1 FROM student 
       WHERE student.student_id = section.delegate_id
       )

--Exercice 4 — Self-join / jointure réflexive
--Affiche pour chaque section : le nom de la section, le nom complet de son délégué, et le nom du professeur responsable de cette section.
--Attention : professor et student sont deux tables distinctes, mais section fait le lien entre les deux.
SELECT s.section_name, st.first_name+' '+st.last_name AS delegue, p.professor_surname+' '+p.professor_name AS professor
FROM section s
LEFT JOIN student st ON s.delegate_id=st.student_id
LEFT JOIN professor p ON s.section_id=p.section_id

--Exercice 5 — Window function
--Pour chaque section, classe les étudiants par year_result décroissant et affiche leur rang. N'affiche que ceux classés 1er ou 2ème dans leur section.
WITH rangs AS (
    SELECT first_name, last_name, section_id, year_result,
           RANK() OVER (PARTITION BY section_id ORDER BY year_result DESC) AS rang
    FROM student
)
SELECT rangs.first_name, rangs.last_name, s.section_name, rangs.year_result, rangs.rang FROM rangs
JOIN section s ON s.section_id=rangs.section_id
WHERE rang <= 2

--Exercice 6 — CTE + agrégation imbriquée
--En utilisant une CTE, calcule le salaire moyen des professeurs par section, puis affiche uniquement les sections où ce salaire moyen dépasse le salaire moyen global de tous les professeurs.
WITH section_avg_salary AS (SELECT AVG(professor_wage) as average,section_id FROM professor GROUP BY section_id)
SELECT sas.section_id, s.section_name, sas.average
FROM section_avg_salary sas
JOIN section s ON s.section_id = sas.section_id
WHERE average>(SELECT AVG(professor_wage) as global_average FROM professor)