# 🛍️ Retail ELT Pipeline — dbt + Snowflake + GitHub Actions

![dbt](https://img.shields.io/badge/dbt-FF694B?style=flat&logo=dbt&logoColor=white)
![Snowflake](https://img.shields.io/badge/Snowflake-29B5E8?style=flat&logo=snowflake&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=flat&logo=github-actions&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)

## 📌 Project Overview

An end-to-end **Retail ELT Pipeline** that ingests raw retail order data, loads it into **Snowflake**, and transforms it using **dbt** with staging, intermediate, and mart layers. CI/CD is automated via **GitHub Actions** to validate dbt models on every push.

## 🏗️ Architecture

```
CSV / Raw Data Source
        │
        ▼
  Snowflake (Raw Layer)
        │
        ▼
   dbt Staging Models
   (stg_orders, stg_customers, stg_products)
        │
        ▼
   dbt Intermediate Models
   (int_order_items, int_customer_orders)
        │
        ▼
   dbt Mart Models
   (mart_daily_revenue, mart_customer_lifetime_value, mart_product_performance)
        │
        ▼
  Analytics-Ready Tables → BI Dashboard / Reports
```

## 🧰 Tech Stack

| Layer | Tool |
|---|---|
| Data Warehouse | Snowflake |
| Transformation | dbt Core |
| Orchestration / CI | GitHub Actions |
| Language | Python, SQL |
| Data Quality | dbt tests (not_null, unique, accepted_values) |
| Version Control | Git + GitHub |

## 📁 Project Structure

```
retail-elt-dbt-snowflake/
├── models/
│   ├── staging/
│   │   ├── stg_orders.sql
│   │   ├── stg_customers.sql
│   │   └── stg_products.sql
│   ├── intermediate/
│   │   ├── int_order_items.sql
│   │   └── int_customer_orders.sql
│   └── marts/
│       ├── mart_daily_revenue.sql
│       ├── mart_customer_lifetime_value.sql
│       └── mart_product_performance.sql
├── tests/
│   ├── assert_positive_revenue.sql
│   └── assert_no_duplicate_orders.sql
├── seeds/
│   └── raw_orders.csv
├── macros/
│   └── generate_schema_name.sql
├── .github/
│   └── workflows/
│       └── dbt_ci.yml
├── dbt_project.yml
├── profiles.yml.example
└── README.md
```

## 🚀 Key Features

- **Multi-layer dbt modeling**: Staging → Intermediate → Mart
- **Data quality tests**: Not null, unique, referential integrity
- **CI/CD**: GitHub Actions runs `dbt compile` and `dbt test` on every PR
- **Snowflake integration**: Optimized warehouse with role-based access
- **Seed data**: Sample retail CSV data loaded directly via dbt seed
- **Custom macros**: Dynamic schema naming for dev/prod environments

## 📊 Business Outputs

| Mart Table | Description |
|---|---|
| `mart_daily_revenue` | Daily revenue trends, order counts, avg order value |
| `mart_customer_lifetime_value` | Total spend, order frequency, customer segments |
| `mart_product_performance` | Top products by revenue, units sold, return rate |

## ⚙️ Setup & Run

### Prerequisites
- Snowflake account
- Python 3.9+
- dbt-snowflake installed

```bash
# Clone the repo
git clone https://github.com/Ashok98765vvs/retail-elt-dbt-snowflake.git
cd retail-elt-dbt-snowflake

# Install dbt
pip install dbt-snowflake

# Configure Snowflake credentials
cp profiles.yml.example ~/.dbt/profiles.yml
# Edit ~/.dbt/profiles.yml with your Snowflake credentials

# Load seed data
dbt seed

# Run all models
dbt run

# Run tests
dbt test

# Generate docs
dbt docs generate
dbt docs serve
```

## 🔁 CI/CD Pipeline

Every push to `main` triggers GitHub Actions to:
1. Install dbt dependencies
2. Run `dbt compile` to validate SQL
3. Run `dbt test` to check data quality
4. Post results as PR status check

## 📈 Impact

- Reduced manual reporting time by automating daily revenue aggregation
- Ensured 100% data quality coverage across all mart tables via dbt tests
- Enabled self-serve analytics for business stakeholders via mart layer

## 👤 Author

**Ashok** — Data Engineer  
📧 [LinkedIn](https://www.linkedin.com/in/ashok-vvs) | 🐙 [GitHub](https://github.com/Ashok98765vvs)

---
⭐ Star this repo if you find it useful!
