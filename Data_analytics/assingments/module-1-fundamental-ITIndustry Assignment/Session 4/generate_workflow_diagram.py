import matplotlib.pyplot as plt
import matplotlib.patches as patches

# Set up canvas
fig, ax = plt.subplots(figsize=(14, 7), dpi=300)
ax.set_facecolor('#F8FAFC')
fig.patch.set_facecolor('#F8FAFC')

# Stages data
stages = [
    {
        "step": "Step 1",
        "title": "Requirement\nGathering",
        "desc": "Define business problem\nIdentify core KPIs\nStakeholder alignment",
        "color": "#3B82F6"
    },
    {
        "step": "Step 2",
        "title": "Data\nCollection",
        "desc": "Extract transactional DBs\nAPIs & webhooks\nApp clickstream logs",
        "color": "#06B6D4"
    },
    {
        "step": "Step 3",
        "title": "Data\nCleaning",
        "desc": "Handle missing values\nTrim whitespaces\nCast data types & dedup",
        "color": "#10B981"
    },
    {
        "step": "Step 4",
        "title": "Data\nTransformation",
        "desc": "Aggregations & joins\nMetric calculations\nFeature engineering",
        "color": "#F59E0B"
    },
    {
        "step": "Step 5",
        "title": "Data\nModeling",
        "desc": "Cohort segmentation\nStatistical correlation\nPredictive scoring",
        "color": "#8B5CF6"
    },
    {
        "step": "Step 6",
        "title": "Reporting &\nDashboards",
        "desc": "Interactive BI visuals\nAutomated reports\nExecutive scorecards",
        "color": "#EC4899"
    },
    {
        "step": "Step 7",
        "title": "Insights &\nAction",
        "desc": "Root-cause findings\nStrategic decisions\nMeasurable business ROI",
        "color": "#E11D48"
    }
]

# Title and subtitle
plt.text(0.5, 0.94, "END-TO-END DATA ANALYTICS WORKFLOW", transform=fig.transFigure,
         ha='center', va='top', fontsize=18, fontweight='bold', color='#0F172A')
plt.text(0.5, 0.89, "The Industry-Standard 7-Stage Pipeline: From Raw Problem to Strategic Business Action",
         transform=fig.transFigure, ha='center', va='top', fontsize=11, color='#64748B')

card_width = 0.115
card_height = 0.58
spacing = 0.138
start_x = 0.035
card_y = 0.18

for idx, stage in enumerate(stages):
    x = start_x + (idx * spacing)
    
    # Background card with rounded box
    rect = patches.FancyBboxPatch((x, card_y), card_width, card_height,
                                  boxstyle="round,pad=0.015,rounding_size=0.025",
                                  facecolor='#FFFFFF', edgecolor='#E2E8F0',
                                  linewidth=1.5, zorder=2)
    ax.add_patch(rect)
    
    # Step header pill
    pill = patches.FancyBboxPatch((x + 0.01, card_y + card_height - 0.08), card_width - 0.02, 0.06,
                                  boxstyle="round,pad=0.005,rounding_size=0.015",
                                  facecolor=stage['color'], edgecolor='none', zorder=3)
    ax.add_patch(pill)
    
    # Step Number text
    ax.text(x + card_width/2, card_y + card_height - 0.05, stage['step'].upper(),
            ha='center', va='center', fontsize=9, fontweight='heavy', color='#FFFFFF', zorder=4)
    
    # Stage Title
    ax.text(x + card_width/2, card_y + card_height - 0.18, stage['title'],
            ha='center', va='center', fontsize=11, fontweight='bold', color='#1E293B', zorder=4, linespacing=1.2)
    
    # Horizontal divider
    ax.plot([x + 0.02, x + card_width - 0.02], [card_y + card_height - 0.28, card_y + card_height - 0.28],
            color='#E2E8F0', lw=1.2, zorder=3)
    
    # Bullets / Description
    ax.text(x + card_width/2, card_y + 0.14, stage['desc'],
            ha='center', va='center', fontsize=8.5, color='#475569', zorder=4, linespacing=1.4)
    
    # Connector Arrow to next stage
    if idx < len(stages) - 1:
        arrow_start_x = x + card_width + 0.003
        arrow_end_x = arrow_start_x + 0.017
        arrow_y = card_y + card_height / 2
        ax.annotate('', xy=(arrow_end_x, arrow_y), xytext=(arrow_start_x, arrow_y),
                    arrowprops=dict(arrowstyle="-|>", color="#94A3B8", lw=2, mutation_scale=14),
                    zorder=5)

# Bottom case study note
plt.text(0.5, 0.08, "Original Case Study: Zomato Late-Night Order Optimization | Applied across Product, Analytics & Operations",
         transform=fig.transFigure, ha='center', va='center', fontsize=9.5, fontweight='semibold',
         color='#475569', bbox=dict(boxstyle='round,pad=0.6', facecolor='#F1F5F9', edgecolor='#CBD5E1', lw=1))

ax.set_xlim(0, 1)
ax.set_ylim(0, 1)
ax.axis('off')

output_path = 'Data_Analytics_Workflow_Visual.png'
plt.savefig(output_path, dpi=300, bbox_inches='tight')
plt.close()
print(f"Workflow visual generated successfully: {output_path}")
