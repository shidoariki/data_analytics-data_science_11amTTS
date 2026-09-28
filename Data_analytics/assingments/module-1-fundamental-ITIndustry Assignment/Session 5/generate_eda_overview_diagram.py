import matplotlib.pyplot as plt
import matplotlib.patches as patches

fig, ax = plt.subplots(figsize=(13, 6.5), dpi=300)
ax.set_facecolor('#F8FAFC')
fig.patch.set_facecolor('#F8FAFC')

# Title
plt.text(0.5, 0.94, "EXPLORATORY DATA ANALYSIS (EDA) TAXONOMY & TYPES", transform=fig.transFigure,
         ha='center', va='top', fontsize=17, fontweight='bold', color='#0F172A')
plt.text(0.5, 0.88, "Understanding Variables, Patterns, Distributions & Anomaly Detection",
         transform=fig.transFigure, ha='center', va='top', fontsize=11, color='#64748B')

cards = [
    {
        "type": "Univariate Analysis",
        "focus": "Single Variable in Isolation",
        "question": "What is the distribution, central tendency, and spread?",
        "techniques": "• Summary Stats (Mean, Median, Mode)\n• Dispersion (Std Dev, Range, IQR)\n• Visuals (Histograms, KDE, Boxplots)\n• Frequency counts & proportions",
        "ipl_example": "Runs Scored per innings:\nMean = 33.4 | Median = 31.0 | Max = 122",
        "color": "#2563EB",
        "light_color": "#EFF6FF"
    },
    {
        "type": "Bivariate Analysis",
        "focus": "Two Variables Simultaneously",
        "question": "Is there a relationship, correlation, or dependency?",
        "techniques": "• Scatter Plots & Trendlines\n• Pearson / Spearman Correlation (r)\n• Cross-tabulation / 2-way tables\n• Linear / Non-linear association",
        "ipl_example": "Balls Faced vs. Runs Scored:\nCorrelation r = 0.92 (Strong Positive)",
        "color": "#0D9488",
        "light_color": "#F0FDFA"
    },
    {
        "type": "Multivariate Analysis",
        "focus": "Three or More Variables",
        "question": "How do multiple factors interact to influence outcomes?",
        "techniques": "• Excel Pivot Tables (Row + Col + Filter)\n• Correlation Heatmaps\n• Grouped / Faceted Visualizations\n• Dimensionality Reduction (PCA)",
        "ipl_example": "Player Performance across:\nTeam × Venue × Strike Rate",
        "color": "#7C3AED",
        "light_color": "#F5F3FF"
    }
]

card_w = 0.285
card_h = 0.68
spacing = 0.315
start_x = 0.045
card_y = 0.12

for idx, c in enumerate(cards):
    x = start_x + (idx * spacing)
    
    # Outer box
    rect = patches.FancyBboxPatch((x, card_y), card_w, card_h,
                                  boxstyle="round,pad=0.015,rounding_size=0.025",
                                  facecolor='#FFFFFF', edgecolor='#CBD5E1', linewidth=1.5, zorder=2)
    ax.add_patch(rect)
    
    # Header badge
    hdr = patches.FancyBboxPatch((x + 0.01, card_y + card_h - 0.09), card_w - 0.02, 0.075,
                                 boxstyle="round,pad=0.005,rounding_size=0.015",
                                 facecolor=c['color'], edgecolor='none', zorder=3)
    ax.add_patch(hdr)
    
    ax.text(x + card_w/2, card_y + card_h - 0.052, c['type'].upper(),
            ha='center', va='center', fontsize=11, fontweight='bold', color='#FFFFFF', zorder=4)
    
    # Sub-focus
    ax.text(x + card_w/2, card_y + card_h - 0.14, c['focus'],
            ha='center', va='center', fontsize=10, fontweight='bold', color='#0F172A', zorder=4)
    
    # Question
    ax.text(x + card_w/2, card_y + card_h - 0.21, f'"{c["question"]}"',
            ha='center', va='center', fontsize=8.5, fontstyle='italic', color='#64748B', zorder=4)
    
    # Divider
    ax.plot([x + 0.02, x + card_w - 0.02], [card_y + card_h - 0.26, card_y + card_h - 0.26],
            color='#E2E8F0', lw=1.2, zorder=3)
    
    # Techniques
    ax.text(x + 0.02, card_y + 0.22, "Core Analytical Methods:\n" + c['techniques'],
            ha='left', va='center', fontsize=8.5, color='#334155', zorder=4, linespacing=1.35)
    
    # IPL Example Box
    ex_box = patches.FancyBboxPatch((x + 0.015, card_y + 0.025), card_w - 0.03, 0.12,
                                    boxstyle="round,pad=0.005,rounding_size=0.012",
                                    facecolor=c['light_color'], edgecolor=c['color'], linewidth=1, zorder=3)
    ax.add_patch(ex_box)
    ax.text(x + card_w/2, card_y + 0.085, "IPL Real-World Application:\n" + c['ipl_example'],
            ha='center', va='center', fontsize=8.5, fontweight='semibold', color=c['color'], zorder=4, linespacing=1.25)

ax.set_xlim(0, 1)
ax.set_ylim(0, 1)
ax.axis('off')

plt.savefig("EDA_Concepts_Framework.png", dpi=300, bbox_inches='tight')
plt.close()
print("Saved EDA_Concepts_Framework.png")
