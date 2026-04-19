# =====================================================
# 🌿 Plant Disease Detection - Hugging Face API (FIXED)
# =====================================================

# pip install requests Pillow

import requests

# =====================================================
# CONFIGURATION
# =====================================================

# 🔑 Get FREE token from: https://huggingface.co/settings/tokens
HF_API_TOKEN = ""   # <-- paste your token here

# ✅ VERIFIED working model
MODEL_ID = "linkanjarad/mobilenet_v2_1.0_224-plant-disease-identification"

# ✅ CORRECT API URL (fixed format)
API_URL = f"https://router.huggingface.co/hf-inference/models/{MODEL_ID}"

HEADERS = {
    "Authorization": f"Bearer {HF_API_TOKEN}",
    "Content-Type": "application/octet-stream"
}

# =====================================================
# LOAD YOUR IMAGE
# =====================================================
IMAGE_PATH = "image.png"   # <-- change to your image filename

with open(IMAGE_PATH, "rb") as f:
    image_bytes = f.read()

print(f"📷 Image loaded: {IMAGE_PATH}")
print(f"⏳ Sending to Hugging Face API...\n")

# =====================================================
# CALL API & SHOW RESULTS
# =====================================================
response = requests.post(API_URL, headers=HEADERS, data=image_bytes)

if response.status_code == 200:
    predictions = response.json()

    print("=" * 55)
    print("🔍 TOP PREDICTIONS:")
    print("=" * 55)

    for i, pred in enumerate(predictions[:5]):
        label = pred['label']
        score = pred['score'] * 100
        emoji = ["🥇","🥈","🥉","4️⃣","5️⃣"][i]
        bar = "█" * int(score // 5)
        print(f"{emoji}  {label}")
        print(f"    {bar} {score:.2f}%\n")

    top = predictions[0]
    print("=" * 55)
    print(f"✅ FINAL RESULT : {top['label']}")
    print(f"   Confidence   : {top['score']*100:.2f}%")
    print("=" * 55)

elif response.status_code == 503:
    print("⏳ Model is loading on Hugging Face server.")
    print("   Wait 30 seconds and run again.")

elif response.status_code == 401:
    print("❌ Invalid token! Get your free token from:")
    print("   https://huggingface.co/settings/tokens")

else:
    print(f"❌ Error {response.status_code}: {response.text}")