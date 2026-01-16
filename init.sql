CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;

CREATE TABLE IF NOT EXISTS news (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    category VARCHAR(50),
    published_date DATETIME NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO news (title, content, category, published_date) VALUES
('新製品のお知らせ', '新しい製品をリリースしました。詳細はこちらをご覧ください。', 'プレスリリース', '2025-01-15 10:00:00'),
('システムメンテナンスのお知らせ', '1月20日にシステムメンテナンスを実施します。', 'お知らせ', '2025-01-14 15:30:00'),
('年末年始休業のご案内', '年末年始の営業日についてお知らせします。', 'お知らせ', '2025-01-10 09:00:00'),
('セキュリティアップデートのご案内', 'セキュリティアップデートを実施しました。', '重要', '2025-01-12 14:00:00'),
('新機能追加のお知らせ', '便利な新機能を追加しました。ぜひお試しください。', 'プレスリリース', '2025-01-08 11:30:00');
