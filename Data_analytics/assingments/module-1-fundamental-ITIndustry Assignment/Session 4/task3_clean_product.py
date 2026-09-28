"""
SESSION 4: Data Analytics Workflow
TASK 3: Clean and standardize messy product data sample
Student: Rushikesh
"""

# Input messy data dictionary / string representation
messy_sample = {
    'product_id': '123',
    'name': 'iPhone 14 ',
    'price': '79999 ',
    'category': ' Mobiles',
    'rating': '4.5 ',
    'stock': 'Yes'
}

print("=" * 65)
print("TASK 3: DATA CLEANING & STANDARDIZATION")
print("=" * 65)
print("\n[BEFORE CLEANING] Raw Messy Data:")
for k, v in messy_sample.items():
    print(f"  {k:12} : {repr(v)} (type: {type(v).__name__})")

# Cleaning & Standardizing transformations
cleaned_data = {
    'product_id': int(str(messy_sample['product_id']).strip()),
    'name': messy_sample['name'].strip(),
    'price': int(str(messy_sample['price']).strip()),
    'category': messy_sample['category'].strip().lower(),
    'rating': float(str(messy_sample['rating']).strip()),
    'stock': True if messy_sample['stock'].strip().lower() in ['yes', 'true', '1'] else False
}

print("\n" + "-" * 65)
print("[AFTER CLEANING] Standardized Data Ready for Analysis:")
for k, v in cleaned_data.items():
    print(f"  {k:12} : {repr(v):<15} (standardized type: {type(v).__name__})")

print("=" * 65)
