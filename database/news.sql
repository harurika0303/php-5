CREATE TABLE IF NOT EXISTS news (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    category VARCHAR(50),
    published_date DATETIME NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- サンプルデータ
INSERT INTO news (title, content, category, published_date) VALUES
('新製品のお知らせ', '新しい製品をリリースしました。詳細はこちらをご覧ください。', 'プレスリリース', '2025-01-15 10:00:00'),
('システムメンテナンスのお知らせ', '1月20日にシステムメンテナンスを実施します。', 'お知らせ', '2025-01-14 15:30:00'),
('年末年始休業のご案内', '年末年始の営業日についてお知らせします。', 'お知らせ', '2025-01-10 09:00:00');