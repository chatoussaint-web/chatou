from PIL import ImageGrab
import pytesseract
from langdetect import detect, DetectorFactory

DetectorFactory.seed = 0

image = ImageGrab.grabclipboard()

if image is None:
    print("Aucune image dans le presse-papiers.")
    exit()

rough_text = pytesseract.image_to_string(image, lang="chi_sim+chi_tra", config="--psm 3")

try:
    detected = detect(rough_text)
except:
    detected = "unknown"

lang_map = {
    "zh-cn": "chi_sim",
    "zh-tw": "chi_tra"
}

final_lang = lang_map.get(detected, "chi_sim+chi_tra")
final_text = pytesseract.image_to_string(image, lang=final_lang, config="--psm 3")

print("Langue détectée :", detected)
print("Langue OCR retenue :", final_lang)
print("Texte détecté :")
print(final_text)
