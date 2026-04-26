# =====================================================
# Customer Segmentation Analysis (RFM + K-Means)
# Author: Javier Kangditya
# =====================================================

# -----------------------------
# 0. Load Libraries
# -----------------------------
library(tidyverse)
library(lubridate)
library(ggplot2)

# -----------------------------
# 1. Data Cleaning
# -----------------------------
data <- read.csv("Data/Raw/data.csv")

data <- data %>%
  distinct() %>%
  drop_na(CustomerID) %>%
  filter(Quantity > 0, UnitPrice > 0) %>%
  mutate(TotalPrice = Quantity * UnitPrice)

data$InvoiceDate <- as.POSIXct(data$InvoiceDate, format = "%m/%d/%Y %H:%M")

write.csv(data, "Data/Processed/retail_data_clean.csv", row.names = FALSE)

# -----------------------------
# 2. RFM Feature Engineering
# -----------------------------
snapshot_date <- max(data$InvoiceDate) + days(1)

rfm <- data %>%
  group_by(CustomerID) %>%
  summarise(
    Recency = as.numeric(snapshot_date - max(InvoiceDate)),
    Frequency = n_distinct(InvoiceNo),
    Monetary = sum(TotalPrice)
  )

write.csv(rfm, "Data/Processed/rfm_table.csv", row.names = FALSE)

# -----------------------------
# 3. EDA
# -----------------------------
summary(rfm)

p_recency <- ggplot(rfm, aes(Recency)) +
  geom_histogram(bins = 30) +
  theme_minimal()

p_frequency <- ggplot(rfm, aes(Frequency)) +
  geom_histogram(bins = 100) +
  theme_minimal()

p_monetary <- ggplot(rfm, aes(Monetary)) +
  geom_histogram(bins = 100) +
  theme_minimal()

# -----------------------------
# 4. Scaling
# -----------------------------
rfm_scaled <- scale(rfm[, c("Recency", "Frequency", "Monetary")])
rfm_scaled <- as.data.frame(rfm_scaled)

write.csv(rfm_scaled, "Data/Processed/rfm_scaled.csv", row.names = FALSE)

# -----------------------------
# 5. Elbow Method
# -----------------------------
set.seed(123)

wss <- vector()

for (k in 1:10) {
  kmeans_model <- kmeans(rfm_scaled, centers = k, nstart = 25)
  wss[k] <- kmeans_model$tot.withinss
}

elbow_data <- data.frame(k = 1:10, wss = wss)

ggplot(elbow_data, aes(k, wss)) +
  geom_line() +
  geom_point() +
  theme_minimal()

ggsave("Outputs/Figures/elbow_method.png")

# -----------------------------
# 6. K-Means Clustering
# -----------------------------
set.seed(123)

k_final <- 4

kmeans_model <- kmeans(rfm_scaled, centers = k_final, nstart = 25)

rfm$Cluster <- as.factor(kmeans_model$cluster)

write.csv(rfm, "Data/Processed/rfm_with_clusters.csv", row.names = FALSE)
saveRDS(kmeans_model, "Data/Processed/kmeans_model.rds")

# -----------------------------
# 7. Cluster Summary
# -----------------------------
cluster_summary <- rfm %>%
  group_by(Cluster) %>%
  summarise(
    avg_recency = mean(Recency),
    avg_frequency = mean(Frequency),
    avg_monetary = mean(Monetary),
    count = n()
  )

write.csv(cluster_summary,
          "Data/Processed/cluster_summary.csv",
          row.names = FALSE)

# -----------------------------
# 8. Visualization
# -----------------------------
cluster_plot <- ggplot(rfm, aes(Frequency, Monetary, color = Cluster)) +
  geom_point(alpha = 0.6) +
  theme_minimal()

ggsave("Outputs/Figures/kmeans_cluster_fm.png")