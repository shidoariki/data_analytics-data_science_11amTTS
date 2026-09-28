import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.patches as patches

# ----------------- 1. GENERATE SAMPLE DATASET (Flipkart E-Commerce) -----------------
np.random.seed(42)

categories = ['Mobiles', 'Fashion', 'Electronics', 'Home & Kitchen', 'Beauty & Personal Care']
cities = ['Bengaluru', 'Mumbai', 'Delhi NCR', 'Ahmedabad', 'Hyderabad', 'Pune']
payment_methods = ['UPI', 'Credit Card', 'Debit Card', 'Cash on Delivery (COD)', 'Net Banking']
return_reasons = ['Defective/Damaged', 'Size/Fit Issue', 'Different from Image', 'Delayed Delivery', 'Customer Changed Mind']

data = []
for i in range(250):
    order_id = f"OD{100200 + i}"
    cust_id = f"CUST_{np.random.randint(1000, 1080)}"
    cat = np.random.choice(categories, p=[0.25, 0.30, 0.15, 0.18, 0.12])
    city = np.random.choice(cities)
    pay = np.random.choice(payment_methods, p=[0.40, 0.20, 0.10, 0.25, 0.05])
    
    if cat == 'Mobiles':
        order_val = int(np.random.uniform(9999, 65000))
        discount = int(np.random.uniform(500, 5000))
        return_prob = 0.08 if pay != 'Cash on Delivery (COD)' else 0.18
    elif cat == 'Fashion':
        order_val = int(np.random.uniform(599, 4500))
        discount = int(np.random.uniform(100, 1200))
        return_prob = 0.28 if pay != 'Cash on Delivery (COD)' else 0.42
    elif cat == 'Electronics':
        order_val = int(np.random.uniform(1500, 28000))
        discount = int(np.random.uniform(200, 3000))
        return_prob = 0.12 if pay != 'Cash on Delivery (COD)' else 0.22
    elif cat == 'Home & Kitchen':
        order_val = int(np.random.uniform(800, 9500))
        discount = int(np.random.uniform(100, 1500))
        return_prob = 0.14 if pay != 'Cash on Delivery (COD)' else 0.20
    else:
        order_val = int(np.random.uniform(350, 3500))
        discount = int(np.random.uniform(50, 600))
        return_prob = 0.06 if pay != 'Cash on Delivery (COD)' else 0.10
        
    is_returned = 1 if np.random.rand() < return_prob else 0
    ret_reason = np.random.choice(return_reasons) if is_returned == 1 else 'N/A (Retained)'
    rating = int(np.random.choice([1, 2, 3, 4, 5], p=[0.35, 0.25, 0.20, 0.12, 0.08])) if is_returned == 1 else int(np.random.choice([3, 4, 5], p=[0.15, 0.45, 0.40]))
    
    data.append({
        'Order_ID': order_id,
        'Customer_ID': cust_id,
        'Category': cat,
        'City': city,
        'Order_Value_INR': order_val,
        'Discount_Applied_INR': discount,
        'Payment_Method': pay,
        'Is_Returned': is_returned,
        'Return_Reason': ret_reason,
        'Customer_Rating': rating
    })

df = pd.DataFrame(data)

# Export to CSV and Excel
csv_path = 'Flipkart_Orders_Returns_Dataset.csv'
excel_path = 'Flipkart_Orders_Returns_Dataset.xlsx'
df.to_csv(csv_path, index=False)
df.to_excel(excel_path, index=False, sheet_name='Orders & Returns')
print(f"Dataset generated: {csv_path} and {excel_path}")
print(f"Total Records: {len(df)}, Total Returns: {df['Is_Returned'].sum()} ({df['Is_Returned'].mean()*100:.1f}%)")

# ----------------- 2. DRAW FLOW DIAGRAM (Data Movement Flow) -----------------
fig, ax = plt.subplots(figsize=(14, 7), dpi=300)
ax.set_facecolor('#F8FAFC')
fig.patch.set_facecolor('#F8FAFC')

plt.text(0.5, 0.94, "END-TO-END DATASET MOVEMENT FLOW IN ANALYTICS PROJECTS", transform=fig.transFigure,
         ha='center', va='top', fontsize=16, fontweight='bold', color='#0F172A')
plt.text(0.5, 0.88, "Architectural Pipeline: From Raw Event Capture to Executive Business Decision",
         transform=fig.transFigure, ha='center', va='top', fontsize=11, color='#64748B')

flow_stages = [
    {
        "title": "1. Data Ingestion\n& Collection",
        "tools": "• PostgreSQL / MySQL DBs\n• Clickstream Kafka Logs\n• Third-Party APIs\n• Mobile App SDKs",
        "color": "#2563EB",
        "bg": "#EFF6FF"
    },
    {
        "title": "2. Raw Storage\n& Data Lake",
        "tools": "• AWS S3 / Google Cloud\n• Parquet / JSON Landing\n• Raw Untransformed Data\n• Immutable Audit Logs",
        "color": "#0284C7",
        "bg": "#F0F9FF"
    },
    {
        "title": "3. Data Cleaning\n& Validation",
        "tools": "• Remove duplicates & nulls\n• Type casting & regex\n• Business rule validation\n• Python (Pandas) / PySpark",
        "color": "#0D9488",
        "bg": "#F0FDFA"
    },
    {
        "title": "4. Modeling &\nTransformation",
        "tools": "• Snowflake / BigQuery\n• Star Schema & Fact Tables\n• dbt Dimensional Models\n• Aggregation & Cohorts",
        "color": "#D97706",
        "bg": "#FFFBEB"
    },
    {
        "title": "5. Analytics &\nVisualization",
        "tools": "• Power BI & Tableau\n• Executive KPI Dashboards\n• Anomaly & Trend Charts\n• Interactive Drill-downs",
        "color": "#7C3AED",
        "bg": "#F5F3FF"
    },
    {
        "title": "6. Business Insights\n& Actions",
        "tools": "• Root-Cause Discovery\n• Strategy Re-engineering\n• Automated Alert Triggers\n• Measurable ROI Growth",
        "color": "#DC2626",
        "bg": "#FEF2F2"
    }
]

box_w = 0.135
box_h = 0.58
spacing = 0.160
start_x = 0.030
box_y = 0.16

for idx, stage in enumerate(flow_stages):
    x = start_x + (idx * spacing)
    
    # Outer box
    rect = patches.FancyBboxPatch((x, box_y), box_w, box_h,
                                  boxstyle="round,pad=0.015,rounding_size=0.025",
                                  facecolor='#FFFFFF', edgecolor='#CBD5E1', linewidth=1.5, zorder=2)
    ax.add_patch(rect)
    
    # Header badge
    hdr = patches.FancyBboxPatch((x + 0.008, box_y + box_h - 0.10), box_w - 0.016, 0.08,
                                 boxstyle="round,pad=0.005,rounding_size=0.015",
                                 facecolor=stage['color'], edgecolor='none', zorder=3)
    ax.add_patch(hdr)
    
    ax.text(x + box_w/2, box_y + box_h - 0.06, stage['title'],
            ha='center', va='center', fontsize=9.5, fontweight='bold', color='#FFFFFF', zorder=4, linespacing=1.2)
    
    # Tools / bullets
    ax.text(x + 0.012, box_y + box_h - 0.32, stage['tools'],
            ha='left', va='center', fontsize=8.5, color='#334155', zorder=4, linespacing=1.45)
    
    # Bottom container badge
    bot_box = patches.FancyBboxPatch((x + 0.008, box_y + 0.02), box_w - 0.016, 0.07,
                                     boxstyle="round,pad=0.005,rounding_size=0.010",
                                     facecolor=stage['bg'], edgecolor=stage['color'], linewidth=0.8, zorder=3)
    ax.add_patch(bot_box)
    step_num = f"STAGE {idx + 1}"
    ax.text(x + box_w/2, box_y + 0.055, step_num,
            ha='center', va='center', fontsize=8.5, fontweight='heavy', color=stage['color'], zorder=4)
    
    # Flow arrow to next
    if idx < len(flow_stages) - 1:
        ax.annotate('', xy=(x + box_w + 0.020, box_y + box_h / 2),
                    xytext=(x + box_w + 0.004, box_y + box_h / 2),
                    arrowprops=dict(arrowstyle="-|>", color="#64748B", lw=2, mutation_scale=14),
                    zorder=5)

ax.set_xlim(0, 1)
ax.set_ylim(0, 1)
ax.axis('off')

flow_chart_path = 'Data_Pipeline_Flow_Diagram.png'
plt.savefig(flow_chart_path, dpi=300, bbox_inches='tight')
plt.close()
print(f"Saved: {flow_chart_path}")

# ----------------- 3. DRAW CASE STUDIES PORTFOLIO OVERVIEW -----------------
fig, ax = plt.subplots(figsize=(14, 6.5), dpi=300)
ax.set_facecolor('#F8FAFC')
fig.patch.set_facecolor('#F8FAFC')

plt.text(0.5, 0.94, "CURRICULUM ORIGINAL CASE STUDIES PORTFOLIO", transform=fig.transFigure,
         ha='center', va='top', fontsize=16, fontweight='bold', color='#0F172A')
plt.text(0.5, 0.88, "Cross-Domain Real-World Datasets & Business Question Mapping",
         transform=fig.transFigure, ha='center', va='top', fontsize=11, color='#64748B')

case_studies = [
    {
        "name": "Case Study 1: Zomato",
        "domain": "Food Delivery & Logistics",
        "core_q": "Why do late-night cart drop-offs surge by 41%?",
        "dataset": "Orders, Riders, GPS, Prep Times",
        "outcome": "ETA dynamic buffer & surge capping",
        "color": "#E11D48"
    },
    {
        "name": "Case Study 2: Flipkart",
        "domain": "E-Commerce Retail",
        "core_q": "How can we cut Cash-on-Delivery return rates?",
        "dataset": "Transactions, Returns, Logistics, Reviews",
        "outcome": "COD risk scoring & size-guide revamp",
        "color": "#2563EB"
    },
    {
        "name": "Case Study 3: IPL Cricket",
        "domain": "Sports Analytics & Bidding",
        "core_q": "Which death-over specialists maximize win rate?",
        "dataset": "Ball-by-ball, Matches, Auction Prices",
        "outcome": "Moneyball player valuation model",
        "color": "#D97706"
    },
    {
        "name": "Case Study 4: Paytm",
        "domain": "FinTech & Digital Payments",
        "core_q": "What causes merchant QR payment fallouts?",
        "dataset": "UPI logs, Bank Gateways, Merchant Txns",
        "outcome": "Smart bank routing to lift success by 4.2%",
        "color": "#0D9488"
    }
]

cw = 0.22
ch = 0.65
c_spacing = 0.245
c_start_x = 0.035
c_y = 0.14

for idx, cs in enumerate(case_studies):
    x = c_start_x + (idx * c_spacing)
    
    rect = patches.FancyBboxPatch((x, c_y), cw, ch,
                                  boxstyle="round,pad=0.015,rounding_size=0.025",
                                  facecolor='#FFFFFF', edgecolor='#CBD5E1', linewidth=1.5, zorder=2)
    ax.add_patch(rect)
    
    hdr = patches.FancyBboxPatch((x + 0.008, c_y + ch - 0.09), cw - 0.016, 0.075,
                                 boxstyle="round,pad=0.005,rounding_size=0.015",
                                 facecolor=cs['color'], edgecolor='none', zorder=3)
    ax.add_patch(hdr)
    
    ax.text(x + cw/2, c_y + ch - 0.052, cs['name'].upper(),
            ha='center', va='center', fontsize=9.5, fontweight='bold', color='#FFFFFF', zorder=4)
    
    ax.text(x + cw/2, c_y + ch - 0.14, f"Domain: {cs['domain']}",
            ha='center', va='center', fontsize=9, fontweight='semibold', color=cs['color'], zorder=4)
    
    ax.plot([x + 0.02, x + cw - 0.02], [c_y + ch - 0.18, c_y + ch - 0.18], color='#E2E8F0', lw=1.2, zorder=3)
    
    content_text = f"Primary Question:\n\"{cs['core_q']}\"\n\nUnderlying Data:\n{cs['dataset']}\n\nStrategic Outcome:\n{cs['outcome']}"
    ax.text(x + 0.015, c_y + 0.20, content_text,
            ha='left', va='center', fontsize=8.5, color='#334155', zorder=4, linespacing=1.35)

ax.set_xlim(0, 1)
ax.set_ylim(0, 1)
ax.axis('off')

cs_chart_path = 'Case_Studies_Portfolio_Overview.png'
plt.savefig(cs_chart_path, dpi=300, bbox_inches='tight')
plt.close()
print(f"Saved: {cs_chart_path}")
