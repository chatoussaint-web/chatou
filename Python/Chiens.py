nom_chien = "Falkor"
nb_chiens = 3

print(f"J'ai {nb_chiens} chiens. Le premier s'appelle {nom_chien}.")

age = 40

if age < 18:
    print("Mineur")
elif age < 65:
    print("Adulte")
else:
    print("Sénior")

if nb_chiens > 2:
    print("Meute de chiens!")
elif 1 <= nb_chiens <= 2:
    print("Quelques chiens")
else:
    print("Pas de chien")

compteur = 1

while compteur < 6:
    print(compteur)
    compteur = compteur + 1

chiens = ["Falkor", "Pamina", "Mikado"]

for chien in chiens:
    print(f"Bonjour {chien} !")

def saluer_chien(nom):
    print(f"Salut {nom} !")

for chien in chiens:
    saluer_chien(chien)

def calculer_age_chien(age_humain):
    age_chien = age_humain // 7
    return age_chien

age_humain = 119
age_chien = calculer_age_chien(age_humain)
print(f"Mon chien a {age_chien} ans.")

def décrire_chien(nom, race):
    return f"{nom} est un {race}"
print(décrire_chien("Falkor", "Bichon Frisé"))
print(décrire_chien("Pamina", "Jack Russell Terrier mix Bouledogue Français"))
print(décrire_chien("Mikado", "Jack Russell Terrier mix Bouledogue Français")) 

chiens = ["Falkor", "Pamina", "Mikado"]
print(chiens[1])
chiens.append("Rouky")
chiens.remove("Falkor")
print(len(chiens))
print("Pamina" in chiens)
print (chiens)

falkor = {"nom" : "Falkor",
         "race" : "Bichon Frisé",
         "age" : 17}

print(falkor["race"])
falkor["couleur"] = "blanc"

for clé, valeur in falkor.items():
    print(f"{clé}: {valeur}")

chiens = ["Falkor", "Pamina", "Mikado"]
majuscules = []

for i in chiens:
    majuscules.append(i.upper())
print(majuscules)

plus_de_5_lettres = []
for i in range(len(chiens)):
    if len(chiens[i]) > 5:
        plus_de_5_lettres.append(chiens[i])
print(plus_de_5_lettres)

chiens = ["Falkor", "Pamina", "Mikado", "Rouky"]

majuscules = [chien.upper() for chien in chiens]
print(majuscules)

plus_de_5 = [chien for chien in chiens if len(chien) > 5]
print(plus_de_5)

def diviser(a, b): 
    try:   
        return a / b 
    except ZeroDivisionError:
        return("Division impossible")

print(diviser(10, 2))
print(diviser(10, 0))
