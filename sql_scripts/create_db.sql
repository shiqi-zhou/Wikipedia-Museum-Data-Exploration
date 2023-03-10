IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = 'WorldMuseumsDB')
BEGIN
    CREATE DATABASE WorldMuseumsDB;
END