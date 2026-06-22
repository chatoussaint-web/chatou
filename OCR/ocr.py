from PIL import ImageGrab
import pytesseract

image = ImageGrab.grabclipboard()

if image:
    text = pytesseract.image_to_string(image, lang="eng+fra+deu+chi_sim+chi_tra+spa+nld")
    print(text)
else:
    print("Aucune image dans le presse-papiers.")