-- =============================================
-- Author:      Shi Qi Zhou
-- Description: Create database WorldMuseumsDB
-- =============================================
IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = 'WorldMuseumsDB')
BEGIN
    CREATE DATABASE WorldMuseumsDB;
END