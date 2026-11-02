import openpyxl
from openpyxl.chart import BarChart, Reference
from openpyxl.styles import Font, PatternFill, Alignment, Border, Side
import sqlite3
import os

current_dir = os.path.dirname(os.path.abspath(__file__))
db_path = os.path.join(current_dir, "session_21_restaurants.db")
excel_file = os.path.join(current_dir, "restaurants_dashboard.xlsx")

# 1. Initialize SQLite Database
conn = sqlite3.connect(db_path)
cursor = conn.cursor()

with open(os.path.join(current_dir, "setup_tables.sql"), "r", encoding="utf-8") as f:
    setup_sql = f.read()
cursor.executescript(setup_sql)

# Fetch all rows
cursor.execute("SELECT name, cuisine, rating, cost_for_two, city FROM Restaurants ORDER BY rating DESC")
all_rows = cursor.fetchall()

# Fetch rating > 4.0 rows for Dashboard
cursor.execute("SELECT name, cuisine, rating, cost_for_two, city FROM Restaurants WHERE rating > 4.0 ORDER BY rating DESC")
high_rated_rows = cursor.fetchall()

# 2. Create Workbook
wb = openpyxl.Workbook()

# Sheet 1: Dashboard
ws_dash = wb.active
ws_dash.title = "Executive_Dashboard"
ws_dash.views.sheetView[0].showGridLines = True

# Title Styling
ws_dash.merge_cells("A1:F1")
title_cell = ws_dash["A1"]
title_cell.value = "Zomato Bangalore: High-Rated Restaurants Dashboard (> 4.0)"
title_cell.font = Font(name="Calibri", size=16, bold=True, color="FFFFFF")
title_cell.fill = PatternFill(start_color="1E3A8A", end_color="1E3A8A", fill_type="solid")
title_cell.alignment = Alignment(horizontal="center", vertical="center")
ws_dash.row_dimensions[1].height = 40

# Add headers
headers = ["Restaurant Name", "Cuisine", "Rating", "Cost for Two (INR)", "City"]
for col_num, header in enumerate(headers, 1):
    cell = ws_dash.cell(row=3, column=col_num, value=header)
    cell.font = Font(bold=True, color="FFFFFF")
    cell.fill = PatternFill(start_color="2563EB", end_color="2563EB", fill_type="solid")
    cell.alignment = Alignment(horizontal="center")

# Add data rows
for row_idx, row_data in enumerate(high_rated_rows, 4):
    for col_idx, val in enumerate(row_data, 1):
        cell = ws_dash.cell(row=row_idx, column=col_idx, value=val)
        cell.alignment = Alignment(horizontal="left" if col_idx <= 2 or col_idx == 5 else "center")

# Add Bar Chart
chart = BarChart()
chart.type = "col"
chart.style = 10
chart.title = "Top Restaurants by Rating (> 4.0)"
chart.y_axis.title = "Rating (out of 5.0)"
chart.x_axis.title = "Restaurant"

data_ref = Reference(ws_dash, min_col=3, min_row=3, max_row=3 + len(high_rated_rows))
cats_ref = Reference(ws_dash, min_col=1, min_row=4, max_row=3 + len(high_rated_rows))
chart.add_data(data_ref, titles_from_data=True)
chart.set_categories(cats_ref)
chart.width = 18
chart.height = 12

ws_dash.add_chart(chart, "H3")

# Auto-adjust column widths
for col in ws_dash.columns:
    max_len = max(len(str(cell.value or '')) for cell in col)
    col_letter = openpyxl.utils.get_column_letter(col[0].column)
    ws_dash.column_dimensions[col_letter].width = max(max_len + 3, 12)

# Sheet 2: Raw Table
ws_raw = wb.create_sheet(title="All_Restaurants_Raw")
for col_num, header in enumerate(headers, 1):
    c = ws_raw.cell(row=1, column=col_num, value=header)
    c.font = Font(bold=True)
for r_idx, r_data in enumerate(all_rows, 2):
    for c_idx, val in enumerate(r_data, 1):
        ws_raw.cell(row=r_idx, column=c_idx, value=val)

wb.save(excel_file)
conn.close()
print(f"Generated Excel Dashboard: {excel_file}")
