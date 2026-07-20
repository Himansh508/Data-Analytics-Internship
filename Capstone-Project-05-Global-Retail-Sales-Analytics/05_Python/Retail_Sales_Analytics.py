
"""
Capstone Project 05
Global Retail Sales Analytics
Phase 3 - Python Exploratory Data Analysis (EDA)
"""

import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("superstore_cleaned.csv", parse_dates=["order_date","ship_date"])

print("="*50)
print("Dataset Shape:", df.shape)
print(df.info())
print(df.describe())
print("Missing Values")
print(df.isnull().sum())
print("Duplicate Rows:", df.duplicated().sum())

print("\nTotal Sales:", round(df["sales"].sum(),2))
print("Total Profit:", round(df["profit"].sum(),2))
print("Total Orders:", df["order_id"].nunique())
print("Total Customers:", df["customer_id"].nunique())

category_sales=df.groupby("category")["sales"].sum().sort_values(ascending=False)
category_profit=df.groupby("category")["profit"].sum().sort_values(ascending=False)
region_sales=df.groupby("region")["sales"].sum().sort_values(ascending=False)

category_sales.plot(kind="bar",figsize=(8,4),title="Sales by Category")
plt.tight_layout()
plt.savefig("category_sales.png")
plt.close()

region_sales.plot(kind="bar",figsize=(8,4),title="Sales by Region")
plt.tight_layout()
plt.savefig("region_sales.png")
plt.close()

top_customers=df.groupby("customer_name")["sales"].sum().sort_values(ascending=False).head(10)
top_customers.plot(kind="bar",figsize=(10,4),title="Top Customers")
plt.tight_layout()
plt.savefig("top_customers.png")
plt.close()

top_products=df.groupby("product_name")["sales"].sum().sort_values(ascending=False).head(10)
top_products.plot(kind="bar",figsize=(10,4),title="Top Products")
plt.tight_layout()
plt.savefig("top_products.png")
plt.close()

df["month"]=df["order_date"].dt.to_period("M").astype(str)
monthly=df.groupby("month")["sales"].sum()
monthly.plot(figsize=(10,4),title="Monthly Sales Trend")
plt.tight_layout()
plt.savefig("monthly_sales.png")
plt.close()

plt.figure(figsize=(7,5))
plt.scatter(df["discount"],df["profit"],s=10)
plt.xlabel("Discount")
plt.ylabel("Profit")
plt.title("Discount vs Profit")
plt.tight_layout()
plt.savefig("discount_vs_profit.png")
plt.close()

print("\nCorrelation Matrix")
print(df[["sales","profit","quantity","discount","shipping_cost"]].corr())

print("\nBusiness Insights")
print("Highest Sales Category:",category_sales.idxmax())
print("Highest Profit Category:",category_profit.idxmax())
print("Best Region:",region_sales.idxmax())
print("Top Customer:",top_customers.idxmax())
print("Top Product:",top_products.idxmax())
