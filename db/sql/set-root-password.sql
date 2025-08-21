--
-- Creates a root user that can connect from any host and sets the password for all root users in Mariadb
--
USE mysql;

-- Tạo user root kết nối từ mọi host
CREATE OR REPLACE USER 'root'@'%' IDENTIFIED BY 'Re:Start!9';

-- Cấp toàn bộ quyền
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;

-- Áp dụng thay đổi
FLUSH PRIVILEGES;