print("welcome to the serpent game")
nom = input("what is your name? ")
print("Pleased to meet you,", nom)
choix = input("You see a serpent, do you choose to flee or to attack?")
if choix == "to flee":
    print("You flee and the serpent chases you, you are faster than it and you escape")
elif choix == "to attack":
    print("You attack the serpent, but it is too strong and it bites you, you die")
else:
    print("You hesitate and the serpent leaves you alone, you survive")