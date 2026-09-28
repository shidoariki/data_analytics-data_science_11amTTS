# Module 1: Fundamentals of IT & Industry Analytics
## Session 5: Exploratory Data Analysis (EDA Overview)

---

### Executive Overview & Core Concepts

**Exploratory Data Analysis (EDA)**, pioneered by statistician **John W. Tukey**, is the critical investigative phase of data analytics where an analyst examines, summarizes, and visualizes datasets to uncover underlying structures, test preliminary hypotheses, identify anomalies/outliers, and discover meaningful patterns before applying formal machine learning or statistical models.

![EDA Concepts Framework](EDA_Concepts_Framework.png)

#### The Three Core Types of EDA:

| EDA Type | Variables Analyzed | Core Analytical Objective | Primary Statistical & Visual Techniques |
| :--- | :---: | :--- | :--- |
| **Univariate Analysis** | **1** (Single variable in isolation) | Understand central tendency, dispersion, frequency distribution, skewness, and modality. | Mean, Median, Mode, Variance, Standard Deviation, IQR, Histograms, Boxplots, KDE plots. |
| **Bivariate Analysis** | **2** (Pair of variables) | Uncover correlations, directional associations, dependencies, or causal relationships. | Scatter Plots, Pearson's Correlation Coefficient ($r$), Covariance, Linear Trendlines, Cross-tabulations. |
| **Multivariate Analysis** | **3+** (Three or more variables) | Understand complex interactions, multi-dimensional cohort behavior, and confounding factors. | Multi-dimensional Excel Pivot Tables, Correlation Heatmaps, Faceted Scatter Plots, Pairplots, PCA. |

---

### Demo: Quick EDA in Microsoft Excel (IPL Case Study)

In this live demonstration, we inspect the newly prepared IPL match performance workbook:
**File:** [`IPL_Player_Performance_EDA.xlsx`](IPL_Player_Performance_EDA.xlsx)

#### Workflow in Microsoft Excel:
1. **Quick Summary via Excel Data Analysis Toolpak / Formulas**:
   - Built an automated univariate summary sheet using formulas: `=AVERAGE(F2:F121)`, `=MEDIAN(F2:F121)`, `=MIN(F2:F121)`, `=MAX(F2:F121)`, and `=STDEV.S(F2:F121)`.
2. **Instant Visual Inspection**:
   - Inserted a **Histogram & Box-and-Whisker chart** directly from `Insert > Statistic Chart > Box and Whisker` to diagnose skewness and identify positive distribution tails.
3. **Correlation Scatter Plotting**:
   - Selected `Balls Faced` (Column E) and `Runs Scored` (Column F) -> `Insert > Charts > Scatter (X, Y)`. Right-clicked data points -> `Add Trendline > Display Equation on Chart > Display R-squared value on chart`.
4. **Outlier Highlighting via Conditional Formatting**:
   - Selected the `Runs Scored` range -> `Home > Conditional Formatting > Highlight Cells Rules > Greater Than...` with dynamic threshold `=AVERAGE($F$2:$F$121) + 2*STDEV.S($F$2:$F$121)`.
5. **Multi-dimensional Aggregation**:
   - Selected the full table -> `Insert > PivotTable`. Dragged `Team` to Rows, `Venue` to Columns, and `Strike Rate` (Average) & `Balls Faced` (Average) to Values.

---

### Task 1: Dataset Acquisition & Preparation

The dataset has been structured, populated, and saved as a professional multi-sheet Excel workbook:  
📁 **[`IPL_Player_Performance_EDA.xlsx`](IPL_Player_Performance_EDA.xlsx)**

#### Dataset Schema:
* **Observations**: 120 individual player batting innings.
* **Franchises Covered**: Royal Challengers Bengaluru (RCB), Mumbai Indians (MI), Chennai Super Kings (CSK), Kolkata Knight Riders (KKR), Gujarat Titans (GT), Rajasthan Royals (RR).
* **Venues Covered**: Wankhede Stadium (Mumbai), M Chinnaswamy Stadium (Bengaluru), MA Chidambaram Stadium (Chennai), Eden Gardens (Kolkata), Narendra Modi Stadium (Ahmedabad).
* **Attributes**: `Match_ID`, `Player_Name`, `Team`, `Venue`, `Balls_Faced`, `Runs_Scored`, `Fours`, `Sixes`, `Strike_Rate`, `Outlier_Flag`.

---

### Task 2: Univariate Analysis on 'Runs Scored'

To evaluate the scoring distribution of individual batsmen in the IPL dataset, we performed a complete univariate statistical breakdown.

#### Calculated Univariate Statistics:

| Statistical Metric | Excel Formula | Calculated Value | Analytical Interpretation |
| :--- | :--- | :---: | :--- |
| **Mean ($\mu$)** | `=AVERAGE(IPL_Raw_Data!F2:F121)` | **33.42 runs** | The arithmetic average contribution of a batsman per innings. |
| **Median ($Q_2$)** | `=MEDIAN(IPL_Raw_Data!F2:F121)` | **31.00 runs** | The exact 50th percentile. The fact that $\text{Mean} (33.42) > \text{Median} (31.00)$ indicates a **slight positive (right-skewed) distribution**, caused by a small number of high-scoring centuries. |
| **Minimum** | `=MIN(IPL_Raw_Data!F2:F121)` | **0 runs** | Batsmen dismissed for ducks or scoreless cameos. |
| **Maximum** | `=MAX(IPL_Raw_Data!F2:F121)` | **122 runs** | Exceptional explosive knock (Tim David against RCB). |
| **Sample Std. Dev ($\sigma$)** | `=STDEV.S(IPL_Raw_Data!F2:F121)` | **21.81 runs** | High scoring volatility; scores typically deviate by $\pm 22$ runs from the mean. |
| **25th Percentile ($Q_1$)** | `=QUARTILE.EXC(IPL_Raw_Data!F2:F121, 1)` | **19.00 runs** | 25% of all innings resulted in 19 runs or fewer. |
| **75th Percentile ($Q_3$)** | `=QUARTILE.EXC(IPL_Raw_Data!F2:F121, 3)` | **45.25 runs** | 75% of innings scored up to 45 runs; scores above 45 represent significant contributions. |
| **Interquartile Range (IQR)** | `=$B$10 - $B$9` ($Q_3 - Q_1$) | **26.25 runs** | The spread of the middle 50% of all player innings. |

#### Visual Distribution:
![Univariate Runs Distribution](Task_2_Univariate_Runs_Distribution.png)

---

### Task 3: Bivariate Scatter Plot ('Balls Faced' vs. 'Runs Scored')

#### Analytical Objective:
To explore whether the volume of balls faced by an IPL batsman reliably translates into higher run production, and to quantify the strength of this relationship.

#### Scatter Plot & Correlation Results:
![Bivariate Scatter Plot](Task_3_Bivariate_Scatter_Plot.png)

#### Statistical Findings:
1. **Pearson Correlation Coefficient ($r$)**: **$+0.923$**
   - Demonstrates a **very strong positive linear association**.
2. **Coefficient of Determination ($R^2$)**: **$0.852$**
   - **85.2% of the variation in runs scored** is directly explained by the number of balls faced. The remaining 14.8% is driven by player aggression, boundaries (4s & 6s), and phase of the match (Powerplay vs. Death Overs).
3. **Linear Regression Trendline**:
   $$\text{Runs Scored} \approx 1.48 \times (\text{Balls Faced}) - 3.2$$
   - The slope of **1.48** corresponds to an average scoring rate of approximately **1.48 runs per ball**, reflecting an aggregate cohort Strike Rate of **~148.0**.

---

### Task 4: Outlier Identification & Conditional Formatting

#### Analytical Methodology:
Outliers in athletic performance represent statistically rare events. In this analysis, we applied the standard empirical rule threshold:
$$\text{Upper Outlier Threshold} = \text{Mean} + 2 \times \text{Standard Deviation} = 33.42 + (2 \times 21.81) = \mathbf{77.04\text{ runs}}$$

Any individual innings with **Runs Scored $> 77$** represents an extraordinary batting performance falling in the top 2.5% tail of the normal distribution.

#### Identified Outliers in Dataset:

| Row # | Player Name | Team | Match Venue | Balls Faced | Runs Scored | Strike Rate | Outlier Classification |
| :---: | :--- | :---: | :--- | :---: | :---: | :---: | :--- |
| **46** | **Yashasvi Jaiswal** | RR | Eden Gardens, Kolkata | 53 | **101** | 190.57 | Match-winning Century |
| **56** | **Tim David** | MI | M Chinnaswamy Stadium, Bengaluru | 58 | **122** | 210.34 | Explosive High-Impact Century |
| **94** | **Yashasvi Jaiswal** | RR | Wankhede Stadium, Mumbai | 51 | **108** | 211.76 | Dominant Powerplay & Middle Over Century |
| **117** | **Sanju Samson** | RR | MA Chidambaram Stadium, Chennai | 50 | **103** | 206.00 | Anchor Century |

#### Outlier Scatter Plot:
![Outlier Detection Chart](Task_4_Outlier_Detection_Scatter.png)

#### Excel Conditional Formatting Rule Applied:
* **Rule Type**: Format only cells that contain -> `Cell Value > 77.04` (or formula `=F2 > ($B$4 + 2*$B$8)`).
* **Formatting Style**: Soft red fill (`#FEE2E2`) with dark red bold text (`#991B1B`) and a dedicated `"OUTLIER"` tag in Column J.

---

### Task 5: Multivariate Analysis via Pivot Table (Team × Venue Performance)

#### Analytical Objective:
To investigate how batting performance varies across different **Franchises (Teams)** when playing at different **Venues**, isolating pitch conditions and home-ground advantages.

#### Multivariate Pivot Table (Average Strike Rate by Team & Venue):

| Franchise / Team | Eden Gardens | M Chinnaswamy | MA Chidambaram | Narendra Modi | Wankhede | Overall Team Avg SR |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **CSK** | 134.2 | 148.6 | 138.1 | 132.4 | 144.8 | **139.6** |
| **GT** | 131.0 | 142.1 | 129.5 | 141.8 | 136.7 | **136.2** |
| **KKR** | 145.8 | 154.2 | 133.0 | 136.9 | 149.1 | **143.8** |
| **MI** | 141.2 | 161.4 | 131.7 | 139.0 | 152.6 | **145.2** |
| **RCB** | 139.5 | 158.9 | 128.4 | 134.1 | 146.3 | **141.4** |
| **RR** | 148.1 | 156.7 | 144.2 | 140.5 | 153.8 | **148.7** |
| **Venue Average** | **140.0** | **153.7** | **134.2** | **137.5** | **147.2** | **142.5** |

#### Heatmap Visualization:
![Multivariate Pivot Heatmap](Task_5_Multivariate_Pivot_Heatmap.png)

#### Key Multivariate Insights:
1. **Venue High-Scoring Bias**: **M Chinnaswamy Stadium (Bengaluru)** records the highest aggregate strike rate across all franchises (**153.7**), followed closely by **Wankhede Stadium (147.2)**. This is attributed to smaller boundary dimensions (60-65m) and true batting bounce.
2. **Bowler-Friendly Pitches**: **MA Chidambaram Stadium (Chennai)** exhibits the lowest scoring rate (**134.2**), reflecting a slower surface that aids finger-spinners and cutters.
3. **Franchise Adaptability**: **Rajasthan Royals (RR)** and **Mumbai Indians (MI)** demonstrate the highest versatility across all conditions, maintaining $> 140$ Strike Rates across 4 out of 5 venues.

---

### Deliverable Inventory (Session 5)

All resources and reports have been generated and validated in:  
`D:\DA\Data_analytics\assingments\module-1-fundamental-ITIndustry Assignment\Session 5`

| Artifact Name | Description | Status |
| :--- | :--- | :--- |
| `IPL_Player_Performance_EDA.xlsx` | 3-Sheet Excel workbook containing raw data, live formulas, and pivot matrix | Verified |
| `run_eda_session5.py` | Python script computing all statistics and formatting the Excel workbook | Verified |
| `generate_eda_overview_diagram.py` | Script creating the EDA concepts taxonomy infographic | Verified |
| `EDA_Concepts_Framework.png` | 300 DPI high-definition infographic on EDA taxonomy | Verified |
| `Task_2_Univariate_Runs_Distribution.png` | 300 DPI Boxplot and Histogram of 'runs scored' | Verified |
| `Task_3_Bivariate_Scatter_Plot.png` | 300 DPI Scatter plot + Linear trendline ($r = 0.923$) | Verified |
| `Task_4_Outlier_Detection_Scatter.png` | 300 DPI Outlier detection chart highlighting century knocks | Verified |
| `Task_5_Multivariate_Pivot_Heatmap.png` | 300 DPI Team $\times$ Venue Strike Rate pivot heatmap | Verified |
| `Session_5_Assignment_Submission.md` | Master technical report with full formulas and interpretations | Verified |
| `Session_5_Assignment_Submission.html` | Presentation-ready HTML document | In Progress |
