import pkg from "pg";
import dotenv from "dotenv";
dotenv.config();

const { Pool } = pkg;
console.log("Connecting to DB:", process.env.DB_ENDPOINT);
const pool = new Pool({
  host: process.env.DB_ENDPOINT,
  port: 5432,
  database: "mydb",
  user: process.env.DB_USERNAME,
  password: process.env.DB_PASSWORD,
  ssl: {
    rejectUnauthorized: false,
  },
  max: 10, // max connections in pool
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 10000,
});

export async function createTable() {
  const sql = `CREATE TABLE IF NOT EXISTS visitors (
        id SERIAL PRIMARY KEY,
        ip_address INET,
        visited_at TIMESTAMP DEFAULT NOW()
        );`;
  try {
    await pool.query(sql);
    console.log("table created successfully");
  } catch (error) {
    console.error(error);
  }
}

export default pool;
