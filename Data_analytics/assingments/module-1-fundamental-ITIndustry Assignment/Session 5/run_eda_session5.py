import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import openpyxl
from openpyxl.styles import Font, PatternFill, Alignment, Border, Side
from openpyxl.utils import get_column_letter

# Set seed for reproducible realistic IPL data
np.random.seed(42)

players = [
    ("Virat Kohli", "RCB"), ("Faf du Plessis", "RCB"), ("Glenn Maxwell", "RCB"), ("Dinesh Karthik", "RCB"),
    ("Rohit Sharma", "MI"), ("Suryakumar Yadav", "MI"), ("Tilak Varma", "MI"), ("Tim David", "MI"),
    ("Ruturaj Gaikwad", "CSK"), ("Shivam Dube", "CSK"), ("MS Dhoni", "CSK"), ("Ravindra Jadeja", "CSK"),
    ("Shreyas Iyer", "KKR"), ("Rinku Singh", "KKR"), ("Andre Russell", "KKR"), ("Sunil Narine", "KKR"),
    ("Shubman Gill", "GT"), ("Sai Sudharsan", "GT"), ("David Miller", "GT"), ("Rahul Tewatia", "GT"),
    ("Sanju Samson", "RR"), ("Yashasvi Jaiswal", "RR"), ("Jos Buttler", "RR"), ("Shimron Hetmyer", "RR")
]

venues = [
    "Wankhede Stadium, Mumbai",
    "M Chinnaswamy Stadium, Bengaluru",
    "MA Chidambaram Stadium, Chennai",
    "Eden Gardens, Kolkata",
    "Narendra Modi Stadium, Ahmedabad"
]

rows = []
match_id = 101

for i in range(120):
    player, team = players[i % len(players)]
    venue = np.random.choice(venues)
    
    # Generate balls faced (log-normal/exponential realistic spread)
    # Most innings are between 8 and 35 balls, but some long innings up to 60 balls
    if np.random.rand() < 0.05:
        # Outlier innings (blitz century or marathon knock)
        balls = int(np.random.randint(48, 62))
        runs = int(balls * np.random.uniform(1.8, 2.2)) # 90 - 130 runs!
    elif np.random.rand() < 0.15:
        # Quick dismissal
        balls = int(np.random.randint(2, 8))
        runs = int(np.random.randint(0, 10))
    else:
        # Standard innings
        balls = int(np.random.randint(10, 42))
        sr = np.random.normal(138, 28)
        sr = max(70, min(240, sr))
        runs = int(round(balls * (sr / 100.0)))
    
    fours = int(max(0, np.random.binomial(runs // 4, 0.45)))
    sixes = int(max(0, np.random.binomial(runs // 6, 0.35)))
    strike_rate = round((runs / balls) * 100.0, 2) if balls > 0 else 0.0
    
    rows.append({
        "Match_ID": f"IPL2024_{match_id + (i // 6)}",
        "Player_Name": player,
        "Team": team,
        "Venue": venue,
        "Balls_Faced": balls,
        "Runs_Scored": runs,
        "Fours": fours,
        "Sixes": sixes,
        "Strike_Rate": strike_rate
    })

df = pd.DataFrame(rows)

# Save basic csv and prepare excel workbook
excel_path = "IPL_Player_Performance_EDA.xlsx"

# Compute stats with Python for verification
mean_runs = df["Runs_Scored"].mean()
median_runs = df["Runs_Scored"].median()
min_runs = df["Runs_Scored"].min()
max_runs = df["Runs_Scored"].max()
std_runs = df["Runs_Scored"].std()
q1 = df["Runs_Scored"].quantile(0.25)
q3 = df["Runs_Scored"].quantile(0.75)
iqr = q3 - q1
upper_outlier_bound = mean_runs + 2 * std_runs

print(f"--- Task 2 Stats ---")
print(f"Mean: {mean_runs:.2f}")
print(f"Median: {median_runs:.2f}")
print(f"Min: {min_runs}")
print(f"Max: {max_runs}")
print(f"Std Dev: {std_runs:.2f}")
print(f"IQR: {iqr:.2f} (Q1: {q1}, Q3: {q3})")
print(f"Outlier Threshold (Mean + 2*Std): {upper_outlier_bound:.2f}")

outliers = df[df["Runs_Scored"] > upper_outlier_bound]
print(f"\n--- Task 4 Outliers Identified: {len(outliers)} rows ---")
print(outliers[["Player_Name", "Team", "Venue", "Balls_Faced", "Runs_Scored", "Strike_Rate"]])

# ----------------- PLOT 1: Task 2 Univariate Distribution -----------------
plt.style.use('seaborn-v0_8-whitegrid' if 'seaborn-v0_8-whitegrid' in plt.style.available else 'default')
fig, (ax_box, ax_hist) = plt.subplots(2, 1, figsize=(10, 7), sharex=True, gridspec_kw={'height_ratios': [0.25, 0.75]}, dpi=300)

# Boxplot
sns.boxplot(x=df["Runs_Scored"], ax=ax_box, color="#3B82F6", fliersize=6, flierprops=dict(markerfacecolor='#EF4444', markeredgecolor='#B91C1C'))
ax_box.set(xlabel='')
ax_box.set_title("Univariate Analysis of 'Runs Scored' in IPL Dataset", fontsize=14, fontweight='bold', pad=12, color='#0F172A')

# Histogram + KDE
sns.histplot(df["Runs_Scored"], kde=True, ax=ax_hist, color="#2563EB", bins=20, edgecolor='#1E293B', alpha=0.6)
ax_hist.axvline(mean_runs, color='#DC2626', linestyle='--', linewidth=2, label=f'Mean ({mean_runs:.1f})')
ax_hist.axvline(median_runs, color='#16A34A', linestyle='-', linewidth=2, label=f'Median ({median_runs:.1f})')
ax_hist.axvline(upper_outlier_bound, color='#D97706', linestyle=':', linewidth=2, label=f'Outlier Threshold ({upper_outlier_bound:.1f})')

ax_hist.set_xlabel("Runs Scored in an Innings", fontsize=11, fontweight='bold', color='#334155')
ax_hist.set_ylabel("Frequency (Count of Innings)", fontsize=11, fontweight='bold', color='#334155')
ax_hist.legend(frameon=True, facecolor='#FFFFFF', edgecolor='#CBD5E1', fontsize=10)

plt.tight_layout()
plt.savefig("Task_2_Univariate_Runs_Distribution.png", dpi=300)
plt.close()
print("Saved Task_2_Univariate_Runs_Distribution.png")

# ----------------- PLOT 2: Task 3 Bivariate Scatter Plot -----------------
fig, ax = plt.subplots(figsize=(9, 6), dpi=300)

sns.regplot(data=df, x="Balls_Faced", y="Runs_Scored", ax=ax,
            scatter_kws={'alpha': 0.7, 'color': '#0284C7', 'edgecolor': '#0369A1', 's': 55},
            line_kws={'color': '#DC2626', 'linewidth': 2.2, 'label': 'Linear Regression Fit'})

correlation = df["Balls_Faced"].corr(df["Runs_Scored"])
ax.set_title("Bivariate Analysis: Balls Faced vs. Runs Scored", fontsize=14, fontweight='bold', pad=15, color='#0F172A')
ax.set_xlabel("Balls Faced", fontsize=11, fontweight='bold', color='#334155')
ax.set_ylabel("Runs Scored", fontsize=11, fontweight='bold', color='#334155')

# Annotation box for Pearson Correlation & R^2
ax.text(0.05, 0.90, f"Pearson Correlation (r): {correlation:.3f}\nStrong Positive Linear Association\nR² = {correlation**2:.3f}",
        transform=ax.transAxes, fontsize=10.5, verticalalignment='top',
        bbox=dict(boxstyle='round,pad=0.5', facecolor='#F1F5F9', edgecolor='#94A3B8', alpha=0.9))

ax.legend(loc='lower right', frameon=True, facecolor='#FFFFFF')
plt.tight_layout()
plt.savefig("Task_3_Bivariate_Scatter_Plot.png", dpi=300)
plt.close()
print("Saved Task_3_Bivariate_Scatter_Plot.png")

# ----------------- PLOT 3: Task 4 Outlier Identification -----------------
fig, ax = plt.subplots(figsize=(10, 5), dpi=300)

colors = ['#EF4444' if r > upper_outlier_bound else '#3B82F6' for r in df["Runs_Scored"]]
scatter = ax.scatter(df.index, df["Runs_Scored"], c=colors, s=50, alpha=0.85, edgecolors='#1E293B', linewidths=0.5)

ax.axhline(mean_runs, color='#2563EB', linestyle='-', linewidth=1.5, label=f'Mean = {mean_runs:.1f}')
ax.axhline(upper_outlier_bound, color='#DC2626', linestyle='--', linewidth=2, label=f'Upper Outlier Bound (Mean + 2σ = {upper_outlier_bound:.1f})')

# Annotate outliers
for idx, row in outliers.iterrows():
    ax.annotate(f"{row['Player_Name']}\n({row['Runs_Scored']} runs / {row['Balls_Faced']}b)",
                xy=(idx, row['Runs_Scored']), xytext=(idx + 1.5, row['Runs_Scored'] + 3),
                fontsize=8.5, fontweight='bold', color='#991B1B',
                arrowprops=dict(arrowstyle="->", color="#DC2626", lw=1))

ax.set_title("Outlier Detection in 'Runs Scored' (Conditional Formatting Visualization)", fontsize=13, fontweight='bold', pad=15, color='#0F172A')
ax.set_xlabel("Innings Index", fontsize=11, fontweight='bold', color='#334155')
ax.set_ylabel("Runs Scored", fontsize=11, fontweight='bold', color='#334155')
ax.set_ylim(-5, max_runs + 18)
ax.legend(loc='upper left', frameon=True, facecolor='#FFFFFF')

plt.tight_layout()
plt.savefig("Task_4_Outlier_Detection_Scatter.png", dpi=300)
plt.close()
print("Saved Task_4_Outlier_Detection_Scatter.png")

# ----------------- PLOT 4: Task 5 Multivariate Pivot Heatmap -----------------
# Pivot: Average Strike Rate and Average Balls by Team & Venue
pivot_sr = df.pivot_table(index='Team', columns='Venue', values='Strike_Rate', aggfunc='mean')
pivot_balls = df.pivot_table(index='Team', columns='Venue', values='Balls_Faced', aggfunc='mean')

fig, ax = plt.subplots(figsize=(11, 6), dpi=300)
short_venues = ["Eden Gardens", "M Chinnaswamy", "MA Chidambaram", "Narendra Modi", "Wankhede"]
pivot_sr_display = pivot_sr.copy()
pivot_sr_display.columns = short_venues

sns.heatmap(pivot_sr_display, annot=True, fmt=".1f", cmap="YlGnBu", cbar_kws={'label': 'Average Strike Rate (%)'},
            linewidths=1, linecolor='#E2E8F0', ax=ax)
ax.set_title("Multivariate Analysis: Average Strike Rate by Team & Venue", fontsize=13, fontweight='bold', pad=15, color='#0F172A')
ax.set_xlabel("Match Venue", fontsize=11, fontweight='bold', color='#334155')
ax.set_ylabel("IPL Franchise / Team", fontsize=11, fontweight='bold', color='#334155')

plt.tight_layout()
plt.savefig("Task_5_Multivariate_Pivot_Heatmap.png", dpi=300)
plt.close()
print("Saved Task_5_Multivariate_Pivot_Heatmap.png")

# ----------------- EXCEL WORKBOOK GENERATION -----------------
wb = openpyxl.Workbook()

# Sheet 1: Raw IPL Performance Data
ws_raw = wb.active
ws_raw.title = "IPL_Raw_Data"
ws_raw.views.sheetView[0].showGridLines = True

headers = ["Match ID", "Player Name", "Team", "Venue", "Balls Faced", "Runs Scored", "Fours", "Sixes", "Strike Rate", "Outlier Flag"]
ws_raw.append(headers)

header_fill = PatternFill(start_color="1E3A8A", end_color="1E3A8A", fill_type="solid")
header_font = Font(name="Calibri", size=11, bold=True, color="FFFFFF")
border_thin = Border(left=Side(style='thin', color='E2E8F0'),
                     right=Side(style='thin', color='E2E8F0'),
                     top=Side(style='thin', color='E2E8F0'),
                     bottom=Side(style='thin', color='E2E8F0'))

for col_num, header in enumerate(headers, 1):
    cell = ws_raw.cell(row=1, column=col_num)
    cell.fill = header_fill
    cell.font = header_font
    cell.alignment = Alignment(horizontal="center", vertical="center")

outlier_fill = PatternFill(start_color="FEE2E2", end_color="FEE2E2", fill_type="solid")
outlier_font = Font(name="Calibri", size=11, bold=True, color="991B1B")

for r_idx, row in df.iterrows():
    row_num = r_idx + 2
    is_outlier = row["Runs_Scored"] > upper_outlier_bound
    ws_raw.append([
        row["Match_ID"],
        row["Player_Name"],
        row["Team"],
        row["Venue"],
        row["Balls_Faced"],
        row["Runs_Scored"],
        row["Fours"],
        row["Sixes"],
        row["Strike_Rate"],
        "OUTLIER" if is_outlier else "NORMAL"
    ])
    
    # Conditional formatting applied to row/runs cell
    if is_outlier:
        runs_cell = ws_raw.cell(row=row_num, column=6)
        runs_cell.fill = outlier_fill
        runs_cell.font = outlier_font
        flag_cell = ws_raw.cell(row=row_num, column=10)
        flag_cell.fill = outlier_fill
        flag_cell.font = outlier_font

# Sheet 2: Univariate Analysis with Live Formulas
ws_uni = wb.create_sheet(title="Univariate_Analysis")
ws_uni.views.sheetView[0].showGridLines = True

uni_headers = ["Statistical Metric", "Excel Formula Used", "Calculated Value", "Interpretation"]
ws_uni.append(["UNIVARIATE ANALYSIS: 'RUNS SCORED' COLUMN IN IPL DATASET"])
ws_uni.merge_cells("A1:D1")
ws_uni.cell(row=1, column=1).font = Font(size=14, bold=True, color="1E3A8A")
ws_uni.append([])
ws_uni.append(uni_headers)

for col_num in range(1, 5):
    cell = ws_uni.cell(row=3, column=col_num)
    cell.fill = PatternFill(start_color="2563EB", end_color="2563EB", fill_type="solid")
    cell.font = Font(bold=True, color="FFFFFF")

metrics_data = [
    ("Mean (Average Runs)", "=AVERAGE(IPL_Raw_Data!F2:F121)", f"{mean_runs:.2f}", "Typical scoring contribution per batting innings"),
    ("Median (Middle Value)", "=MEDIAN(IPL_Raw_Data!F2:F121)", f"{median_runs:.2f}", "Robust 50th percentile, unaffected by extreme centuries"),
    ("Minimum Runs", "=MIN(IPL_Raw_Data!F2:F121)", f"{min_runs}", "Lowest individual score (early duck or single)"),
    ("Maximum Runs", "=MAX(IPL_Raw_Data!F2:F121)", f"{max_runs}", "Highest peak score (exceptional high-impact knock)"),
    ("Standard Deviation (Sample)", "=STDEV.S(IPL_Raw_Data!F2:F121)", f"{std_runs:.2f}", "Measures scoring volatility and player inconsistency"),
    ("25th Percentile (Q1)", "=QUARTILE.EXC(IPL_Raw_Data!F2:F121, 1)", f"{q1:.2f}", "Lower quartile boundary of batting contributions"),
    ("75th Percentile (Q3)", "=QUARTILE.EXC(IPL_Raw_Data!F2:F121, 3)", f"{q3:.2f}", "Upper quartile threshold for impactful top-order innings"),
    ("Interquartile Range (IQR)", "=B10-B9", f"{iqr:.2f}", "Spread of the middle 50% of batting innings"),
    ("Upper Outlier Threshold (Mean + 2*Std)", "=B4+(2*B8)", f"{upper_outlier_bound:.2f}", "Statistical ceiling beyond which scores are classified as statistical outliers")
]

for row_data in metrics_data:
    ws_uni.append([row_data[0], row_data[1], row_data[2], row_data[3]])

# Sheet 3: Multivariate Pivot Table (Team vs Venue)
ws_piv = wb.create_sheet(title="Multivariate_Pivot_Table")
ws_piv.views.sheetView[0].showGridLines = True

ws_piv.append(["MULTIVARIATE ANALYSIS: TEAM PERFORMANCE BY VENUE (AVERAGE STRIKE RATE & BALLS FACED)"])
ws_piv.merge_cells("A1:G1")
ws_piv.cell(row=1, column=1).font = Font(size=13, bold=True, color="1E3A8A")
ws_piv.append([])

# Write pivot table header
piv_header = ["Team / Franchise"] + short_venues + ["Overall Average"]
ws_piv.append(piv_header)
for col_num in range(1, len(piv_header) + 1):
    cell = ws_piv.cell(row=3, column=col_num)
    cell.fill = PatternFill(start_color="0D9488", end_color="0D9488", fill_type="solid")
    cell.font = Font(bold=True, color="FFFFFF")

for team, row in pivot_sr.iterrows():
    row_vals = [team] + [round(val, 1) if not np.isnan(val) else "-" for val in row.values] + [round(df[df["Team"]==team]["Strike_Rate"].mean(), 1)]
    ws_piv.append(row_vals)

# Adjust column widths
for ws in [ws_raw, ws_uni, ws_piv]:
    for col in ws.columns:
        max_len = max(len(str(cell.value or '')) for cell in col)
        col_letter = get_column_letter(col[0].column)
        ws.column_dimensions[col_letter].width = max(max_len + 4, 12)

wb.save(excel_path)
print(f"Excel workbook created successfully: {excel_path}")
