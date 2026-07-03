# Python & SQL — Exercices & Projets

Travaux réalisés dans le cadre d'une reconversion vers les métiers
de l'intégration IA et de la data (2026).

## Structure du repo

```
chatou/
├── Notebooks/
│   ├── Claude_pandas.ipynb
│   └── Exercices.ipynb
├── Python/
│   ├── OCR/
│   │   ├── ocr_zh.py
│   │   └── ocr.py
│   ├── Chiens.py
│   └── Serpent.py
└── SQL/
    ├── SQL_TEST_DBSlide.sql
    ├── SQLExos_Adventure Works2025_1.sql
    └── SQLQuery_TEST_Librairie.sql
```

---

## Notebooks

### `Exercices.ipynb` — Algorithmique & logique
Série d'exercices progressifs couvrant les fondamentaux de l'algorithmique :
filtrage de listes, comptage de caractères, détection de palindrome, FizzBuzz,
nombres premiers, somme des chiffres, suppression de doublons, recherche de
maximum sans `max()`, comptage d'occurrences sans `.count()`, inversion de liste.

### `Claude_pandas.ipynb` — Manipulation de données avec pandas
Série d'exercices générés par Claude  et réalisés à la main sur un dataset fictif de chiens et propriétaires (deux DataFrames liés).
Opérations couvertes : exploration (`head`, `shape`, `info`), sélection par position (`iloc`), filtrage, création de colonnes calculées, gestion des valeurs manquantes (`isna`, `fillna`), tri, `groupby`, et jointures entre tables (`merge` avec clés de noms différents).

---

## Python

### `OCR/` — Extraction de texte par OCR
Scripts d'extraction de texte depuis le presse-papiers, avec support du chinois
(`ocr_zh.py`) et traitement général (`ocr.py`).

### `Chiens.py` — Premier script Python
Script d'initiation couvrant les bases du langage : variables, f-strings,
conditions, boucles `while` et `for`, fonctions, listes, dictionnaires,
list comprehensions et gestion d'exceptions. Réalisé avec un dataset personnel
(mes trois chiens).

### `Serpent.py` — Mini jeu textuel
Petit jeu d'aventure en anglais basé sur des `input()` et des conditions —
tout premier projet ludique autonome.

---

## SQL

### `SQL_TEST_DBSlide.sql` — Base de données personnelle DBSlide
Requêtes et tests sur une base de données reçue en formation SQL (DBSlide).

### `SQLExos_Adventure Works2025_1.sql` — Exercices Adventure Works
Exercices sur la base de données Adventure Works 2025 (dataset Microsoft standard).

### `SQLQuery_TEST_Librairie.sql` — Base de données Librairie
Requêtes et tests sur un dataset personnel Librairie.

---

## Contexte

Reconversion depuis la gestion de projets de traduction multilingue
(post-édition de traduction automatique, contrôle qualité, 6 langues)
vers l'intégration IA et la data.

Formations complétées :
- Les fondamentaux de SQL (Bruxelles Formation, avril 2026)
- Python pour la data science (Bruxelles Formation, mai 2026)
