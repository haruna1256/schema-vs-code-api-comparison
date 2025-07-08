CREATE TABLE books (
    id CHAR(36) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(100) NOT NULL,
    memo TEXT,
    status ENUM('unread', 'reading', 'done') NOT NULL,
    started_at DATE,
    finished_at DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tags (
    id CHAR(36) PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE book_tags (
    book_id CHAR(36),
    tag_id CHAR(36),
    PRIMARY KEY (book_id, tag_id),
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE
);

-- books テーブルへの仮データ挿入
INSERT INTO books (id, title, author, memo, status, started_at, finished_at, created_at) VALUES
('book1', '君たちはどう生きるか', '吉野源三郎', '人生の指針になる一冊', 'done', '2024-04-01', '2024-04-20', CURRENT_TIMESTAMP),
('book2', '人は話し方が9割', '永松茂久', NULL, 'reading', '2025-06-20', NULL, CURRENT_TIMESTAMP),
('book3', 'ノルウェイの森', '村上春樹', '淡く切ない青春の記憶。', 'unread', NULL, NULL, CURRENT_TIMESTAMP);

-- tags テーブルへの仮データ挿入
INSERT INTO tags (id, name) VALUES
('tag1', '小説'),
('tag2', '自己啓発'),
('tag3', 'ベストセラー'),
('tag4', '文学');

-- book_tags 中間テーブルへの仮データ挿入
INSERT INTO book_tags (book_id, tag_id) VALUES
-- 君たちはどう生きるか → 自己啓発, 文学
('book1', 'tag2'),
('book1', 'tag4'),

-- 人は話し方が9割 → 自己啓発, ベストセラー
('book2', 'tag2'),
('book2', 'tag3'),

-- ノルウェイの森 → 小説, 文学
('book3', 'tag1'),
('book3', 'tag4');
