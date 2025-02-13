# 📊 Football Data Analysis: Event Data and Pitch Visualization

This project focuses on the analysis of football event data using JSON files and visualizes the data on a football pitch. 
The scripts perform data loading, transformation, and visualization, including the creation of bar charts for event types 
and the plotting of a football pitch with event data.

## 🚀 Introduction

# These scripts perform the following steps:
- Load and flatten JSON files containing football event data.
- Visualize the most dominant event types using bar charts.
- Compare event types between two teams (Ajax and NEC).
- Plot a football pitch with markings and visualize event data on the pitch.

## 📁 Contents

- **Ajax - NEC - Events analyse - Wyscout.R**: R script for loading and analyzing JSON event data, including visualization of event types and team comparisons.
- **Fodboldbane – Kode.R**: R script for plotting a football pitch using the `ggsoccer` package.
- **annotate_pitch.R**: R script containing the `annotate_pitch` function for adding pitch markings to a ggplot plot.
- **dimensions.R**: R script containing pitch dimension specifications for different data providers.
- **direction_label.R**: R script for adding a direction of play arrow to a ggplot plot.
- **rescale_coordinates.R**: R script for rescaling coordinates between different pitch dimensions.
- **theme_pitch.R**: R script for customizing the theme of a ggplot plot to remove background and axes details.

## 📊 Data Analysis

### Ajax - NEC - Events analyse - Wyscout.R

- **Loading JSON Data**:
- Loads JSON data from the file `evt_5360157.json` and flattens it into a data frame.
  
- **Visualization of Dominant Event Types**:
- Creates a bar chart showing the most dominant event types in the dataset.
  
- **Comparison of Event Types Between Teams**:
- Filters data for specific event types (`duel`, `pass`, `shot`, `touch`) and teams (`Ajax`, `NEC`).
- Creates a bar chart comparing the frequency of these event types between the two teams.

### Fodboldbane – Kode.R

- **Plotting a Football Pitch**:
- Uses the `ggsoccer` package to plot a football pitch with markings.
- Customizes the pitch appearance with specific colors and dimensions.

### annotate_pitch.R

- **Adding Pitch Markings**:
- Provides the `annotate_pitch` function to add pitch markings (e.g., penalty box, six-yard box, center circle) to a ggplot plot.
- Allows customization of pitch appearance, including color, fill, and line type.

### dimensions.R

- **Pitch Dimension Specifications**:
- Contains predefined pitch dimension specifications for various data providers (e.g., Opta, StatsBomb, Wyscout).
- Includes a function `make_pitch_tracab` to create custom pitch dimensions based on known length and width.

### direction_label.R

- **Adding Direction of Play Arrow**:
- Provides the `direction_label` function to add an arrow indicating the direction of play to a ggplot plot.
- Customizable in terms of position, length, color, and line type.

### rescale_coordinates.R

- **Rescaling Coordinates**:
- Provides functions to rescale coordinates between different pitch dimension specifications.
- Useful for converting event data from one coordinate system to another.

### theme_pitch.R

- **Customizing Plot Theme**:
- Provides the `theme_pitch` function to remove background and axes details from a ggplot plot.
- Allows customization of the plot's aspect ratio.

## 🛠️ Technologies

- **R**: The primary environment for data analysis and visualization.
- **ggplot2**: Library for data visualization.
- **jsonlite**: Library for handling JSON data.
- **ggsoccer**: Library for plotting football pitches and visualizing event data.

## 📌 Requirements

- R and RStudio must be installed on your machine.
- The following packages should be installed:

    ```r
    install.packages(c("ggplot2", "jsonlite", "ggsoccer"))
    ```

## 🤝 Contributing

Contributions are welcome! If you have suggestions or improvements, feel free to fork the repository and submit a pull request.