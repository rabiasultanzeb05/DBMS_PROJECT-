# This is a sample Python script.

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.




# See PyCharm help at https://www.jetbrains.com/help/pycharm/

import mysql.connector

import streamlit as st
import mysql.connector
import pandas as pd
import os

# ---------------- PAGE CONFIG ---------------- #

st.set_page_config(
    page_title="Delivery Management System",
    layout="wide"
)

# ---------------- DATABASE CONNECTION ---------------- #

@st.cache_resource
def get_connection():
    return mysql.connector.connect(
        host=os.getenv("DB_HOST", "localhost"),
        user=os.getenv("DB_USER", "root"),
        password=os.getenv("DB_PASSWORD", ""),
        database=os.getenv("DB_NAME", "delivery_db")
    )

def run_query(query):
    """Run a SQL query and return a DataFrame. Reconnects if connection was lost."""
    conn = get_connection()
    try:
        conn.ping(reconnect=True)  # re-establish connection if dropped
        return pd.read_sql(query, conn)
    except mysql.connector.Error as e:
        st.error(f"Database error: {e}")
        return pd.DataFrame()

# ---------------- HEADER ---------------- #

st.markdown("""
    <style>
        .main-title {
            font-size: 30px;
            font-weight: 700;
            margin-bottom: 5px;
        }
        .subtitle {
            font-size: 16px;
            color: #444;
            margin-bottom: 10px;
        }
        .purpose {
            font-size: 13px;
            color: #666;
            margin-bottom: 25px;
            line-height: 1.5;
        }
        .box {
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #fafafa;
        }
    </style>
""", unsafe_allow_html=True)

st.markdown('<div class="main-title">Delivery Management System</div>', unsafe_allow_html=True)

st.markdown(
    '<div class="subtitle">Delivery Performance Optimization System Using Data Analytics</div>',
    unsafe_allow_html=True
)

st.markdown(
    '<div class="purpose">A database-driven system designed to analyze delivery performance, detect delays, and evaluate driver and zone efficiency using SQL queries, views, and functions.</div>',
    unsafe_allow_html=True
)

# ---------------- SIDEBAR ---------------- #

st.sidebar.title("Navigation")

page = st.sidebar.radio(
    "Select Page",
    ["Dashboard", "Deliveries", "Drivers", "Zones", "Risk Analysis", "Insights"]
)

# ---------------- DASHBOARD ---------------- #

if page == "Dashboard":

    st.header("System Overview")

    col1, col2, col3, col4 = st.columns(4)

    total_orders = run_query("SELECT COUNT(*) AS c FROM ORDER_V2")
    total_deliveries = run_query("SELECT COUNT(*) AS c FROM DELIVERY_V2")
    late_deliveries = run_query("SELECT COUNT(*) AS c FROM DELIVERY_V2 WHERE delivered_time > estimated_time")
    total_drivers = run_query("SELECT COUNT(*) AS c FROM DRIVER_V2")

    col1.metric("Total Orders", int(total_orders["c"][0]) if not total_orders.empty else 0)
    col2.metric("Total Deliveries", int(total_deliveries["c"][0]) if not total_deliveries.empty else 0)
    col3.metric("Late Deliveries", int(late_deliveries["c"][0]) if not late_deliveries.empty else 0)
    col4.metric("Drivers", int(total_drivers["c"][0]) if not total_drivers.empty else 0)

    st.divider()

    st.subheader("Key System Insight")

    st.write("""
    The system analyzes delivery efficiency using SQL-based computations.
    It identifies delays, driver performance variations, and zone congestion impact on delivery time.
    """)

# ---------------- DELIVERIES ---------------- #

elif page == "Deliveries":

    st.header("Delivery Records")

    df = run_query("""
        SELECT delivery_id, order_id, driver_id, zone_id,
               pickup_time, estimated_time, delivered_time,
               delivery_status, distance_km, delay_reason
        FROM DELIVERY_V2
    """)

    st.dataframe(df, use_container_width=True)

# ---------------- DRIVERS ---------------- #

elif page == "Drivers":

    st.header("Driver Performance Analysis")

    st.subheader("Driver Details")

    drivers = run_query("""
        SELECT driver_id, full_name, avg_rating, is_available
        FROM DRIVER_V2
    """)

    st.dataframe(drivers, use_container_width=True)

    st.subheader("Performance Summary (SQL-based)")

    performance = run_query("""
        SELECT driver_id,
               COUNT(*) AS total_deliveries,
               AVG(TIMESTAMPDIFF(MINUTE, pickup_time, delivered_time)) AS avg_delivery_time
        FROM DELIVERY_V2
        GROUP BY driver_id
        ORDER BY avg_delivery_time ASC
    """)

    st.dataframe(performance, use_container_width=True)

# ---------------- ZONES ---------------- #

elif page == "Zones":

    st.header("Zone Performance Analysis")

    zones = run_query("""
        SELECT z.zone_name,
               z.city,
               z.congestion_index,
               COUNT(d.delivery_id) AS total_deliveries,
               AVG(TIMESTAMPDIFF(MINUTE, d.estimated_time, d.delivered_time)) AS avg_delay
        FROM ZONE_V2 z
        LEFT JOIN DELIVERY_V2 d ON z.zone_id = d.zone_id
        GROUP BY z.zone_id
    """)

    st.dataframe(zones, use_container_width=True)

# ---------------- RISK ANALYSIS ---------------- #

elif page == "Risk Analysis":

    st.header("Risk-Based Delivery Classification")

    st.subheader("Risk Analysis (From SQL View)")

    risk = run_query("SELECT * FROM RiskyDeliveries_V2")

    st.dataframe(risk, use_container_width=True)

    st.subheader("Risk Summary")

    risk_summary = run_query("""
        SELECT risk_level, COUNT(*) AS total
        FROM RiskyDeliveries_V2
        GROUP BY risk_level
    """)

    st.dataframe(risk_summary, use_container_width=True)

# ---------------- INSIGHTS ---------------- #

elif page == "Insights":

    st.header("Business Insights (SQL Analysis)")

    st.subheader("Zones with Highest Delay")

    delays = run_query("""
        SELECT z.zone_name,
               COUNT(*) AS delayed_orders
        FROM DELIVERY_V2 d
        JOIN ZONE_V2 z ON d.zone_id = z.zone_id
        WHERE d.delivered_time > d.estimated_time
        GROUP BY z.zone_name
        ORDER BY delayed_orders DESC
    """)

    st.dataframe(delays, use_container_width=True)

    st.subheader("Peak Order Hours")

    peak = run_query("""
        SELECT HOUR(placed_at) AS hour,
               COUNT(*) AS total_orders
        FROM ORDER_V2
        GROUP BY HOUR(placed_at)
        ORDER BY hour
    """)

    st.dataframe(peak, use_container_width=True)

    st.subheader("Key Insight")

    st.write("""
    Peak demand occurs during specific hours and congestion in certain zones directly impacts delivery delays.
    This helps businesses allocate drivers efficiently and reduce late deliveries.
    """)


