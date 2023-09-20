CREATE DATABASE QuanLyVT
ON Primary
(Name=QuanLyVT_data,
FileName="E:\DATA\QuanLyVT_data.MDF",
size=2MB, maxsize=5MB, FileGrowth=1MB)

LOG ON
(Name=QuanLyVT_log,
FileName="E:\DATA\QuanLyVT_log.LDF",
size=2MB, maxsize=5MB, FileGrowth=1MB)