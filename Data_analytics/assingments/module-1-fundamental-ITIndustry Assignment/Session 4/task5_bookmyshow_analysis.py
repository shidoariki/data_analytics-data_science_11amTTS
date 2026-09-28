import matplotlib.pyplot as plt
import pandas as pd

# 1. Dataset definition
movies_data = {
    'Movie Title': ['Dune: Part Two', 'Oppenheimer', 'Inception (Special)'],
    'Tickets Sold': [42600, 31500, 18400],
    'Genre': ['Sci-Fi / Adventure', 'Biographical Drama', 'Sci-Fi / Action'],
    'Avg Ticket Price (INR)': [380, 420, 350]
}

df = pd.DataFrame(movies_data)
df['Total Revenue (INR)'] = df['Tickets Sold'] * df['Avg Ticket Price (INR)']

# 2. Export to Excel
excel_path = 'BookMyShow_Ticket_Sales.xlsx'
df.to_excel(excel_path, index=False, sheet_name='Ticket Sales')
print(f"Excel file created: {excel_path}")

# 3. Create high-resolution Matplotlib Bar Chart
plt.style.use('seaborn-v0_8-whitegrid' if 'seaborn-v0_8-whitegrid' in plt.style.available else 'default')
fig, ax = plt.subplots(figsize=(8, 5), dpi=300)

colors = ['#E50914', '#0071EB', '#F59E0B']
bars = ax.bar(df['Movie Title'], df['Tickets Sold'], color=colors, width=0.55, edgecolor='#1E293B', linewidth=1.2)

# Value labels on top of bars
for bar in bars:
    height = bar.get_height()
    ax.annotate(f'{height:,}',
                xy=(bar.get_x() + bar.get_width() / 2, height),
                xytext=(0, 6),
                textcoords="offset points",
                ha='center', va='bottom',
                fontsize=11, fontweight='bold', color='#1E293B')

ax.set_title('BookMyShow: Opening Weekend Ticket Sales Analysis', fontsize=14, fontweight='bold', pad=18, color='#0F172A')
ax.set_xlabel('Movie Title', fontsize=11, fontweight='bold', labelpad=10, color='#334155')
ax.set_ylabel('Total Tickets Sold', fontsize=11, fontweight='bold', labelpad=10, color='#334155')
ax.set_ylim(0, 50000)
ax.yaxis.set_major_formatter('{x:,.0f}')

# Customizing grid and borders
ax.grid(axis='y', linestyle='--', alpha=0.6)
ax.set_axisbelow(True)
for spine in ['top', 'right', 'left', 'bottom']:
    ax.spines[spine].set_color('#CBD5E1')

plt.tight_layout()
chart_path = 'Task_5_BookMyShow_Tickets_BarChart.png'
plt.savefig(chart_path, dpi=300)
plt.close()
print(f"Chart saved: {chart_path}")
print("\n--- Summary Data ---")
print(df.to_string(index=False))
