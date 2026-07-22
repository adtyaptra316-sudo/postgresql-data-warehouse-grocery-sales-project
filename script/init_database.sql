/*
========================================
CREATE DATABASE AND SCHEMAS
========================================
Script Purpose:
	Script ini membuat database baru bernama "datawarehouse_grocery" setelah melakukan cek apakah sudah
	ada sebelumnya. Jika database tersebut sudah ada, maka akan dihapus dan dibuat ulang. Selain itu,
	script ini menyiapkan tiga schema dalam database: 'bronze', 'silver', 'gold'.
	
Warning:
	Menjalankan script ini akan menghapus seluruh database "datawarehouse_grocery". Semua database
	di database tersebut akan dihapus secara permanen. Hati-hati dan pastikan kamu punya cadangan
	sebelum menjalankan skrip ini
*/

-- Drop and recreate "datawarehouse_grocery"
drop database if exists datawarehouse_grocery with (force);
create database datawarehouse_grocery;

-- create schemas
create schema bronze;
create schema silver;
create schema gold;
