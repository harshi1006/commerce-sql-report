import analysis as anls
import database as db
import matplotlib.pyplot as plt
import seaborn as sns

db.setup_database()
conn = db.get_connection()

df_total_summary=anls.get_total_summary(conn)
df_total_summary.to_csv('reports/total_summary.csv', index=False)

df_monthly_revenue=anls.get_monthly_revenue(conn)
df_monthly_revenue.to_csv('reports/monthly_revenue.csv', index=False)

df_top_customers=anls.get_top_customers(conn)
df_top_customers.to_csv('reports/top_customers.csv', index=False)

df_category_revenue=anls.get_category_revenue(conn)
df_category_revenue.to_csv('reports/category_revenue.csv', index=False)

df_top_products=anls.get_top_products(conn)
df_top_products.to_csv('reports/top_products.csv', index=False)

df_average_order_value=anls.get_average_order_value(conn)
df_average_order_value.to_csv('reports/average_order_value.csv', index=False)

df_order_count=anls.get_order_count(conn)
df_order_count.to_csv('reports/order_count.csv', index=False)

df_revenue_growth=anls.get_revenue_growth(conn)
df_revenue_growth.to_csv('reports/revenue_growth.csv', index=False)

df_customer_value=anls.get_customer_value(conn)
df_customer_value.to_csv('reports/customer_value.csv', index=False)

df_top_categorywise_products=anls.get_top_categorywise_products(conn)
df_top_categorywise_products.to_csv('reports/top_categorywise_products.csv', index=False)

df_inactive_customers=anls.get_inactive_customers(conn)
df_inactive_customers.to_csv('reports/inactive_customers.csv', index=False)

df_city_revenue=anls.get_city_revenue(conn)
df_city_revenue.to_csv('reports/city_revenue.csv', index=False)


plt.figure(figsize=(12,6))
bar_plot = sns.barplot(data=df_category_revenue, x='category', y='Total Revenue')
bar_plot.set_title('Revenue by Product Category')
bar_plot.set_xlabel('Product Category')
bar_plot.set_ylabel('Total Revenue')
plt.savefig('reports/revenue_by_category.png')
plt.show()
plt.close()

plt.figure(figsize=(12,6))
line_plot = sns.lineplot(data=df_monthly_revenue, x='month', y='Total Revenue', marker='o')
line_plot.set_title('Monthly Revenue Trend')
line_plot.set_xlabel('Month')
line_plot.set_ylabel('Total Revenue')
plt.savefig('reports/monthly_revenue_trend.png')
plt.show()  
plt.close()

plt.figure(figsize=(12,8))
horizontal_bar_plot = sns.barplot(data=df_top_customers, x='Total Revenue', y='name', orient='h')
horizontal_bar_plot.set_title('Top 10 Customers')
horizontal_bar_plot.set_xlabel('Total Revenue')
horizontal_bar_plot.set_ylabel('Customer Name')
plt.savefig('reports/top_customers.png')
plt.show()
plt.close()

conn.close()
